Return-Path: <netdev+bounces-117176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A824D94CF8A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C768B1C21924
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5B192B98;
	Fri,  9 Aug 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+V04XN8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940A193074
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204250; cv=none; b=WB2vbri6z65LkaHWlIv3h7LoxKejqpny7cPX3JDnV0rki/VI11sLThvZoEAdFdr+BLvhgFIeKwyR9UjXLASUnShJ0uxoVxxi2DQd7o7zhpQK+zQZ3b450+i7MjYcU59qKfBDQ6HObhiu1rtC/NqYvWDCv8i7XzaWDVnb81wgCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204250; c=relaxed/simple;
	bh=0tJdRLRsyxuqp6/A3tiUVFZlCEJu10HVqRx/eTUR9Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7tPN9pWTjPqcWbYcCaZg7KD1Gb/SFIrHQZ4TEO/ER1jbppyrUKayRn/0rkhNEmf/cHCehFXzc8KjC9gAf0gvDbp0Xz8M1IjxUvPgBHt/Z8rPcTo8dPVY8Ajo1irljogyh2LV8cHhsLlzGXCAvLshdGvFws1kqc/ah1PJC/gWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+V04XN8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204249; x=1754740249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tJdRLRsyxuqp6/A3tiUVFZlCEJu10HVqRx/eTUR9Rc=;
  b=S+V04XN8gJuRGaXcl8AC3hXqwbJC8ojpRjgeRX8dFGDvfh2vLfYJfPyq
   4EHP8d1l/XmnXWBNR901wY9qeQKohD7JU2QFstcnHcd2N0OfAs+1LHE6w
   pYeNf90IivdF0be9E5DDSTTstSkuG5wBQyT08vs96GTqwdbdyJXHUwk6j
   JpGb15a1fG+JeG9S6BCER602V8uY3YMKQXbAbwTwI7oYqY/IwBbSbTcqn
   nB1OhiuP5lwX5n15RET6y0/hMAOD6LGQou0hq2SvRJUGMd6UBS+M8pvQc
   B4YBn07grlW8LKcbXxlFzTItwyJr8AaDTzbe6UDSCz5puLMsZlKJ0pRYt
   A==;
X-CSE-ConnectionGUID: dstksR3rQoevJ3uFImzlQg==
X-CSE-MsgGUID: rwl4vEV/RqymdGolMP6xsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25244827"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25244827"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:50:48 -0700
X-CSE-ConnectionGUID: wcud2PrbRvKxk7f9+vZyyw==
X-CSE-MsgGUID: n7h5UxKkSlSqupzWLkKS5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62375549"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:50:42 -0700
Date: Fri, 9 Aug 2024 13:49:02 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Piotr Raczynski <piotr.raczynski@intel.com>,
	jiri@nvidia.com, shayd@nvidia.com, wojciech.drewek@intel.com,
	horms@kernel.org, sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com, kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com, pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 06/15] ice: base subfunction aux driver
Message-ID: <ZrYCLr368aBxJBfW@mev-dev.igk.intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-7-anthony.l.nguyen@intel.com>
 <ZrX8IDdyfCrXaDv0@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX8IDdyfCrXaDv0@nanopsycho.orion>

On Fri, Aug 09, 2024 at 01:23:12PM +0200, Jiri Pirko wrote:
> Thu, Aug 08, 2024 at 07:30:52PM CEST, anthony.l.nguyen@intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Implement subfunction driver. It is probe when subfunction port is
> >activated.
> >
> >VSI is already created. During the probe VSI is being configured.
> >MAC unicast and broadcast filter is added to allow traffic to pass.
> >
> >Store subfunction pointer in VSI struct. The same is done for VF
> >pointer. Make union of subfunction and VF pointer as only one of them
> >can be set with one VSI.
> >
> >Reviewed-by: Simon Horman <horms@kernel.org>
> >Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> >Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >---
> > drivers/net/ethernet/intel/ice/Makefile       |   1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c |  41 ++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |   3 +
> > drivers/net/ethernet/intel/ice/ice.h          |   7 +-
> > drivers/net/ethernet/intel/ice/ice_main.c     |  10 ++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 139 ++++++++++++++++++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  15 ++
> > 7 files changed, 215 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >
> >diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> >index 03500e28ac99..4d987f5dcdc1 100644
> >--- a/drivers/net/ethernet/intel/ice/Makefile
> >+++ b/drivers/net/ethernet/intel/ice/Makefile
> >@@ -31,6 +31,7 @@ ice-y := ice_main.o	\
> > 	 ice_idc.o	\
> > 	 devlink/devlink.o	\
> > 	 devlink/devlink_port.o \
> >+	 ice_sf_eth.o	\
> > 	 ice_ddp.o	\
> > 	 ice_fw_update.o \
> > 	 ice_lag.o	\
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >index 5d1fe08e4bab..f06baabd0112 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >@@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> > 	devl_port_unregister(&vf->devlink_port);
> > }
> > 
> >+/**
> >+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
> >+ * @sf_dev: the subfunction device to create a devlink port for
> >+ *
> >+ * Register virtual flavour devlink port for the subfunction auxiliary device
> >+ * created after activating a dynamically added devlink port.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
> >+{
> >+	struct devlink_port_attrs attrs = {};
> >+	struct ice_dynamic_port *dyn_port;
> >+	struct devlink_port *devlink_port;
> >+	struct devlink *devlink;
> >+	struct ice_vsi *vsi;
> >+
> >+	dyn_port = sf_dev->dyn_port;
> >+	vsi = dyn_port->vsi;
> >+
> >+	devlink_port = &sf_dev->priv->devlink_port;
> >+
> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
> >+
> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >+	devlink = priv_to_devlink(sf_dev->priv);
> >+
> >+	return devl_port_register(devlink, devlink_port, vsi->idx);
> >+}
> >+
> >+/**
> >+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
> >+ * @sf_dev: the subfunction device to create a devlink port for
> >+ *
> >+ * Unregisters the virtual port associated with this subfunction.
> >+ */
> >+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> >+{
> >+	devl_port_unregister(&sf_dev->priv->devlink_port);
> >+}
> >+
> > /**
> >  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
> >  * @dyn_port: dynamic port instance to deallocate
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >index 08ebf56664a5..97b21b58c300 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >@@ -5,6 +5,7 @@
> > #define _DEVLINK_PORT_H_
> > 
> > #include "../ice.h"
> >+#include "../ice_sf_eth.h"
> > 
> > /**
> >  * struct ice_dynamic_port - Track dynamically added devlink port instance
> >@@ -34,6 +35,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
> > void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> > int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
> > void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
> >+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> >+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> > 
> > #define ice_devlink_port_to_dyn(port) \
> > 	container_of(port, struct ice_dynamic_port, devlink_port)
> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> >index d61f8e602cac..0046684004ff 100644
> >--- a/drivers/net/ethernet/intel/ice/ice.h
> >+++ b/drivers/net/ethernet/intel/ice/ice.h
> >@@ -449,7 +449,12 @@ struct ice_vsi {
> > 	struct_group_tagged(ice_vsi_cfg_params, params,
> > 		struct ice_port_info *port_info; /* back pointer to port_info */
> > 		struct ice_channel *ch; /* VSI's channel structure, may be NULL */
> >-		struct ice_vf *vf; /* VF associated with this VSI, may be NULL */
> >+		union {
> >+			/* VF associated with this VSI, may be NULL */
> >+			struct ice_vf *vf;
> >+			/* SF associated with this VSI, may be NULL */
> >+			struct ice_dynamic_port *sf;
> >+		};
> > 		u32 flags; /* VSI flags used for rebuild and configuration */
> > 		enum ice_vsi_type type; /* the type of the VSI */
> > 	);
> >diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> >index e10f10a21c95..bdd88617ec9b 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_main.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_main.c
> >@@ -15,6 +15,7 @@
> > #include "ice_dcb_nl.h"
> > #include "devlink/devlink.h"
> > #include "devlink/devlink_port.h"
> >+#include "ice_sf_eth.h"
> > #include "ice_hwmon.h"
> > /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
> >  * ice tracepoint functions. This must be done exactly once across the
> >@@ -5908,8 +5909,16 @@ static int __init ice_module_init(void)
> > 		goto err_dest_lag_wq;
> > 	}
> > 
> >+	status = ice_sf_driver_register();
> >+	if (status) {
> >+		pr_err("Failed to register SF driver, err %d\n", status);
> >+		goto err_sf_driver;
> >+	}
> >+
> > 	return 0;
> > 
> >+err_sf_driver:
> >+	pci_unregister_driver(&ice_driver);
> > err_dest_lag_wq:
> > 	destroy_workqueue(ice_lag_wq);
> > 	ice_debugfs_exit();
> >@@ -5927,6 +5936,7 @@ module_init(ice_module_init);
> >  */
> > static void __exit ice_module_exit(void)
> > {
> >+	ice_sf_driver_unregister();
> > 	pci_unregister_driver(&ice_driver);
> > 	ice_debugfs_exit();
> > 	destroy_workqueue(ice_wq);
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >new file mode 100644
> >index 000000000000..abe495c2d033
> >--- /dev/null
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >@@ -0,0 +1,139 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/* Copyright (c) 2024, Intel Corporation. */
> >+#include "ice.h"
> >+#include "ice_lib.h"
> >+#include "ice_fltr.h"
> >+#include "ice_sf_eth.h"
> >+#include "devlink/devlink_port.h"
> >+#include "devlink/devlink.h"
> >+
> >+/**
> >+ * ice_sf_dev_probe - subfunction driver probe function
> >+ * @adev: pointer to the auxiliary device
> >+ * @id: pointer to the auxiliary_device id
> >+ *
> >+ * Configure VSI and netdev resources for the subfunction device.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int ice_sf_dev_probe(struct auxiliary_device *adev,
> >+			    const struct auxiliary_device_id *id)
> >+{
> >+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
> >+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
> >+	struct ice_vsi *vsi = dyn_port->vsi;
> >+	struct ice_pf *pf = dyn_port->pf;
> >+	struct device *dev = &adev->dev;
> >+	struct ice_sf_priv *priv;
> >+	struct devlink *devlink;
> >+	int err;
> >+
> >+	vsi->type = ICE_VSI_SF;
> >+	vsi->port_info = pf->hw.port_info;
> >+	vsi->flags = ICE_VSI_FLAG_INIT;
> >+
> >+	priv = ice_allocate_sf(&adev->dev, pf);
> >+	if (!priv) {
> >+		dev_err(dev, "Subfunction devlink alloc failed");
> >+		return -ENOMEM;
> >+	}
> >+
> >+	priv->dev = sf_dev;
> >+	sf_dev->priv = priv;
> >+	devlink = priv_to_devlink(priv);
> >+
> >+	devl_lock(devlink);
> >+
> >+	err = ice_vsi_cfg(vsi);
> >+	if (err) {
> >+		dev_err(dev, "Subfunction vsi config failed");
> >+		goto err_free_devlink;
> >+	}
> >+	vsi->sf = dyn_port;
> >+
> >+	err = ice_devlink_create_sf_dev_port(sf_dev);
> >+	if (err) {
> >+		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
> >+		goto err_vsi_decfg;
> >+	}
> >+
> >+	err = devl_port_fn_devlink_set(&dyn_port->devlink_port, devlink);
> >+	if (err) {
> >+		dev_err(dev, "Can't link devlink instance to SF devlink port");
> >+		goto err_devlink_destroy;
> >+	}
> >+
> >+	ice_napi_add(vsi);
> >+	devl_unlock(devlink);
> >+
> >+	devlink_register(devlink);
> 
> Use devl_register() and do it before you call devl_unlock() :)
> 

Ok, I will

> >+
> >+	return 0;
> >+
> >+err_devlink_destroy:
> >+	ice_devlink_destroy_sf_dev_port(sf_dev);
> >+err_vsi_decfg:
> >+	ice_vsi_decfg(vsi);
> >+err_free_devlink:
> >+	devl_unlock(devlink);
> >+	devlink_free(devlink);
> >+	return err;
> >+}
> >+
> >+/**
> >+ * ice_sf_dev_remove - subfunction driver remove function
> >+ * @adev: pointer to the auxiliary device
> >+ *
> >+ * Deinitalize VSI and netdev resources for the subfunction device.
> >+ */
> >+static void ice_sf_dev_remove(struct auxiliary_device *adev)
> >+{
> >+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
> >+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
> >+	struct ice_vsi *vsi = dyn_port->vsi;
> >+	struct devlink *devlink;
> >+
> >+	devlink = priv_to_devlink(sf_dev->priv);
> >+	devl_lock(devlink);
> >+
> >+	ice_vsi_close(vsi);
> >+
> >+	ice_devlink_destroy_sf_dev_port(sf_dev);
> >+	devl_unregister(devlink);
> 
> Interesting, you call devl_unregister() here...

I forgot to move and use devl_register in probe.
> 
> 
> >+	devl_unlock(devlink);
> >+	devlink_free(devlink);
> >+	ice_vsi_decfg(vsi);
> >+}
> >+
> >+static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
> >+	{ .name = "ice.sf", },
> >+	{ },
> >+};
> >+
> >+MODULE_DEVICE_TABLE(auxiliary, ice_sf_dev_id_table);
> >+
> >+static struct auxiliary_driver ice_sf_driver = {
> >+	.name = "sf",
> >+	.probe = ice_sf_dev_probe,
> >+	.remove = ice_sf_dev_remove,
> >+	.id_table = ice_sf_dev_id_table
> >+};
> >+
> >+/**
> >+ * ice_sf_driver_register - Register new auxiliary subfunction driver
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+int ice_sf_driver_register(void)
> >+{
> >+	return auxiliary_driver_register(&ice_sf_driver);
> >+}
> >+
> >+/**
> >+ * ice_sf_driver_unregister - Unregister new auxiliary subfunction driver
> >+ *
> >+ */
> >+void ice_sf_driver_unregister(void)
> >+{
> >+	auxiliary_driver_unregister(&ice_sf_driver);
> >+}
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >index 267da33a0135..e972c50f96c9 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >@@ -7,9 +7,24 @@
> > #include <linux/auxiliary_bus.h>
> > #include "ice.h"
> > 
> >+struct ice_sf_dev {
> >+	struct auxiliary_device adev;
> >+	struct ice_dynamic_port *dyn_port;
> >+	struct ice_sf_priv *priv;
> >+};
> >+
> > struct ice_sf_priv {
> > 	struct ice_sf_dev *dev;
> > 	struct devlink_port devlink_port;
> > };
> > 
> >+static inline struct
> >+ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
> >+{
> >+	return container_of(adev, struct ice_sf_dev, adev);
> >+}
> >+
> >+int ice_sf_driver_register(void);
> >+void ice_sf_driver_unregister(void);
> >+
> > #endif /* _ICE_SF_ETH_H_ */
> >-- 
> >2.42.0
> >
> >

