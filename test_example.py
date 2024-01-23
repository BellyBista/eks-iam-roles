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