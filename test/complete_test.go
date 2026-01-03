package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCompleteExample(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../tftest/complete",
		NoColor:      true,
	})

	// Comment out destroy and apply for plan-only testing
	// defer terraform.Destroy(t, terraformOptions)

	// Initialize and validate Terraform configuration
	terraform.Init(t, terraformOptions)
	terraform.Validate(t, terraformOptions)

	// Run plan to validate configuration without applying
	planOutput := terraform.Plan(t, terraformOptions)
	assert.NotEmpty(t, planOutput, "Terraform plan should generate output")

	// Comment out apply and output testing
	// terraform.InitAndApply(t, terraformOptions)
	// resourceId := terraform.Output(t, terraformOptions, "resource_id")
	// assert.NotEmpty(t, resourceId, "Resource ID should not be empty")
	// resourceName := terraform.Output(t, terraformOptions, "resource_name")
	// assert.NotEmpty(t, resourceName, "Resource name should not be empty")

	// Add more assertions specific to complete example
	// For example, test that all features are enabled:
	// - Monitoring
	// - Security
	// - Backup
	// - etc.
}
