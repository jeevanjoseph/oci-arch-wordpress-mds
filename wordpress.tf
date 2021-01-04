module "wordpress" {
  source                = "./modules/wordpress"
  availability_domain   = "${data.template_file.ad_names.*.rendered[0]}"
  compartment_ocid      = "${var.compartment_ocid}"
  image_id              = var.node_image_id == "" ? "${data.oci_core_images.images_for_shape.images[0].id}" : "${var.node_image_id}"
  shape                 = "${var.node_shape}"
  label_prefix          = "${var.label_prefix}"
  subnet_id             = "${oci_core_subnet.public.id}"
  ssh_authorized_keys   = tls_private_key.public_private_key_pair.public_key_openssh 
  ssh_private_key       = tls_private_key.public_private_key_pair.private_key_pem
  mds_ip                = "${module.mds-instance.private_ip}"
  admin_password        = var.admin_password
  admin_username        = var.admin_username
  wp_schema             = var.wp_schema
  wp_name               = var.wp_name
  wp_password           = var.wp_password
}