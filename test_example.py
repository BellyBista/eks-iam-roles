import os
import tftest
import pytest


tfvars = ["./example.tfvars"]


@pytest.fixture(params=tfvars)
def plan(request, directory="./examples", module_name="complete"):
    tfvars_file = request.param
    tf = tftest.TerraformTest(module_name, directory)
    tf.setup()
    plan = tf.plan(
        output=True, use_cache=True, tf_var_file=tfvars_file
    ) 
    return plan

def test_variables(plan):
    tf_vars = plan.variables
    assert "region" in tf_vars
    assert "pgp_key" in tf_vars
    assert "developer" in tf_vars
    assert "admin" in tf_vars

def test_outputs(plan):
    assert "node_role" in plan.outputs
    assert "cluster_role" in plan.outputs
    assert "developer_password" in plan.outputs
    assert "admin_password" in plan.outputs

@pytest.fixture(params=tfvars)
def apply_output(request, directory="./examples", module_name="complete"):
    tfvars_file = request.param
    tf = tftest.TerraformTest(module_name, directory)
    tf.setup()
    tf.apply(output=True, use_cache=True, tf_var_file=tfvars_file)
    output = tf.output()
    yield output
    tf.destroy(auto_approve=True, use_cache=True, tf_var_file=tfvars_file)


def test_apply(apply_output):
    admin_password = apply_output["admin_password"]
    cluster_role = apply_output["cluster_role"]
    developer_password = apply_output["developer_password"]
    node_role = apply_output["node_role"]

    assert isinstance(admin_password, dict)
    assert isinstance(cluster_role, str)
    assert isinstance(developer_password, dict)
    assert isinstance(node_role, str)

    expected_admin_users = ["admin1"]
    for user in expected_admin_users:
        assert user in admin_password

    expected_developer_users = ["developer1", "developer2"]
    for user in expected_developer_users:
        assert user in developer_password