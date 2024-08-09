Return-Path: <netdev+bounces-117177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AC94CF8E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99772856E1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87320193062;
	Fri,  9 Aug 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWvRHwZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243617BBF
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204302; cv=none; b=SWB4JFsOCDZ18EyJHLasWd7BVdSplOzzqtKkGDAnGMEn1E3ErNyViZZkzycOvqVxerFPp3GKiNY0qXU+AF4VxVzsHS0WSe5myzR99bPL3CQhid5YRfoHdhVDcOx/yQLk9syxjkg+euDG4tu+Iu551MymQ8Z2SLV/jhleCOK9qQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204302; c=relaxed/simple;
	bh=qHWBZiuuds5skGMJo9WmtO3NBsM8WwN+X2E1+q+WAFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU3ygE1zp7D6ICHmZW1+TlQZuiNItPF6yAK/QOk5PuRgCBApSCILVgQk+ZWOYxqYPfY786aR7ThMu7HWSLYsUH2PFwIR6GiDxzpSOiFV92LjFMpitEqtZN2tvJPwGcjvsx+q9xjDo3tttPheCiDaP1ERhOVrGiVxFEO1T/zcvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWvRHwZ+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204301; x=1754740301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHWBZiuuds5skGMJo9WmtO3NBsM8WwN+X2E1+q+WAFs=;
  b=aWvRHwZ+qddysbmITmS3T2nook/wnRsQ+wlbezgSaMUbrFcaR983saAW
   ajmRnGi1D5s8JNLvwZ2V0w1NyQ+q8QORz7Vaw29FO27ZJMbgaxYX+tvoU
   JfeIQtmvgvyHh+WxrMt4gnV5S3j5IGDert6UIzrd7+Vpo91IEl8V6YKdM
   x/P07l6dLsMTQYgtjn5ThFsg7STumGKAc9zq550IpD0DmztUz5xNSBLTM
   8phb1uXjdsvHkB3ZO5SMeVFl30UYkOuRSif84vbmAvmr9zJur2Tb52qhu
   qAw44FsEmbd7UnTLR4c85RdwtJaI07kOP0GUmAGRUjZEMRIrfeMPVSTo+
   w==;
X-CSE-ConnectionGUID: zeIEI8M+Q0WoI5qAD3/CEw==
X-CSE-MsgGUID: Fp/9ZHsFROaG3uacGJAqgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280665"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:51:40 -0700
X-CSE-ConnectionGUID: wuX61UPaQqG1kFQDynsByA==
X-CSE-MsgGUID: QSa5UPW7TA+pPyvrN7V+bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57424291"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:51:35 -0700
Date: Fri, 9 Aug 2024 13:49:54 +0200
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
Subject: Re: [PATCH net-next v3 15/15] ice: allow to activate and deactivate
 subfunction
Message-ID: <ZrYCYvv37HGv7NnO@mev-dev.igk.intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-16-anthony.l.nguyen@intel.com>
 <ZrX89AVg5o9lzSEA@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX89AVg5o9lzSEA@nanopsycho.orion>

On Fri, Aug 09, 2024 at 01:26:44PM +0200, Jiri Pirko wrote:
> Thu, Aug 08, 2024 at 07:31:01PM CEST, anthony.l.nguyen@intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Use previously implemented SF aux driver. It is probe during SF
> >activation and remove after deactivation.
> >
> >Reviewed-by: Simon Horman <horms@kernel.org>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> >Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >---
> > .../ethernet/intel/ice/devlink/devlink_port.c | 176 ++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |   7 +
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 103 ++++++++++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
> > 4 files changed, 289 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >index 4cfd90581d92..675a2b60892b 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >@@ -530,6 +530,48 @@ void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> > 	devl_port_unregister(&sf_dev->priv->devlink_port);
> > }
> > 
> >+/**
> >+ * ice_activate_dynamic_port - Activate a dynamic port
> >+ * @dyn_port: dynamic port instance to activate
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Activate the dynamic port based on its flavour.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
> >+			  struct netlink_ext_ack *extack)
> >+{
> >+	int err;
> >+
> >+	if (dyn_port->active)
> >+		return 0;
> >+
> >+	err = ice_sf_eth_activate(dyn_port, extack);
> >+	if (err)
> >+		return err;
> >+
> >+	dyn_port->active = true;
> >+
> >+	return 0;
> >+}
> >+
> >+/**
> >+ * ice_deactivate_dynamic_port - Deactivate a dynamic port
> >+ * @dyn_port: dynamic port instance to deactivate
> >+ *
> >+ * Undo activation of a dynamic port.
> >+ */
> >+static void ice_deactivate_dynamic_port(struct ice_dynamic_port *dyn_port)
> >+{
> >+	if (!dyn_port->active)
> >+		return;
> >+
> >+	ice_sf_eth_deactivate(dyn_port);
> >+	dyn_port->active = false;
> >+}
> >+
> > /**
> >  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
> >  * @dyn_port: dynamic port instance to deallocate
> >@@ -542,6 +584,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
> > 	struct devlink_port *devlink_port = &dyn_port->devlink_port;
> > 	struct ice_pf *pf = dyn_port->pf;
> > 
> >+	ice_deactivate_dynamic_port(dyn_port);
> >+
> > 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
> > 	ice_eswitch_detach_sf(pf, dyn_port);
> > 	ice_vsi_free(dyn_port->vsi);
> >@@ -629,8 +673,140 @@ ice_devlink_port_del(struct devlink *devlink, struct devlink_port *port,
> > 	return 0;
> > }
> > 
> >+/**
> >+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
> >+ * @port: pointer to devlink port
> >+ * @hw_addr: hw address to set
> >+ * @hw_addr_len: hw address length
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Sets mac address for the port, verifies arguments and copies address
> >+ * to the subfunction structure.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
> 
> Interesting. The patch subject and description talks about "activation"
> yet you also set/get hw address here. Either split to 2 patches of
> adjust the patch subject and desctiption.
> 

I will adjust.

> 
> 
> 
> >+				int hw_addr_len,
> >+				struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_dynamic_port *dyn_port;
> >+
> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >+
> >+	if (dyn_port->attached) {
> >+		NL_SET_ERR_MSG_MOD(extack,
> >+				   "Ethernet address can be change only in detached state");
> >+		return -EBUSY;
> >+	}
> >+
> >+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
> >+		return -EADDRNOTAVAIL;
> >+	}
> >+
> >+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
> >+
> >+	return 0;
> >+}
> >+
> >+/**
> >+ * ice_devlink_port_fn_hw_addr_get - devlink handler for mac address get
> >+ * @port: pointer to devlink port
> >+ * @hw_addr: hw address to set
> >+ * @hw_addr_len: hw address length
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Returns mac address for the port.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_devlink_port_fn_hw_addr_get(struct devlink_port *port, u8 *hw_addr,
> >+				int *hw_addr_len,
> >+				struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_dynamic_port *dyn_port;
> >+
> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >+
> >+	ether_addr_copy(hw_addr, dyn_port->hw_addr);
> >+	*hw_addr_len = ETH_ALEN;
> >+
> >+	return 0;
> >+}
> >+
> >+/**
> >+ * ice_devlink_port_fn_state_set - devlink handler for port state set
> >+ * @port: pointer to devlink port
> >+ * @state: state to set
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Activates or deactivates the port.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_devlink_port_fn_state_set(struct devlink_port *port,
> >+			      enum devlink_port_fn_state state,
> >+			      struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_dynamic_port *dyn_port;
> >+
> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >+
> >+	switch (state) {
> >+	case DEVLINK_PORT_FN_STATE_ACTIVE:
> >+		return ice_activate_dynamic_port(dyn_port, extack);
> >+
> >+	case DEVLINK_PORT_FN_STATE_INACTIVE:
> >+		ice_deactivate_dynamic_port(dyn_port);
> >+		break;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+/**
> >+ * ice_devlink_port_fn_state_get - devlink handler for port state get
> >+ * @port: pointer to devlink port
> >+ * @state: admin configured state of the port
> >+ * @opstate: current port operational state
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Gets port state.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_devlink_port_fn_state_get(struct devlink_port *port,
> >+			      enum devlink_port_fn_state *state,
> >+			      enum devlink_port_fn_opstate *opstate,
> >+			      struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_dynamic_port *dyn_port;
> >+
> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >+
> >+	if (dyn_port->active)
> >+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
> >+	else
> >+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
> >+
> >+	if (dyn_port->attached)
> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> >+	else
> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> >+
> >+	return 0;
> >+}
> >+
> > static const struct devlink_port_ops ice_devlink_port_sf_ops = {
> > 	.port_del = ice_devlink_port_del,
> >+	.port_fn_hw_addr_get = ice_devlink_port_fn_hw_addr_get,
> >+	.port_fn_hw_addr_set = ice_devlink_port_fn_hw_addr_set,
> >+	.port_fn_state_get = ice_devlink_port_fn_state_get,
> >+	.port_fn_state_set = ice_devlink_port_fn_state_set,
> > };
> > 
> > /**
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >index 479d2b976745..d60efc340945 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >@@ -11,22 +11,29 @@
> >  * struct ice_dynamic_port - Track dynamically added devlink port instance
> >  * @hw_addr: the HW address for this port
> >  * @active: true if the port has been activated
> >+ * @attached: true it the prot is attached
> >  * @devlink_port: the associated devlink port structure
> >  * @pf: pointer to the PF private structure
> >  * @vsi: the VSI associated with this port
> >  * @repr_id: the representor ID
> >  * @sfnum: the subfunction ID
> >+ * @sf_dev: pointer to the subfunction device
> >  *
> >  * An instance of a dynamically added devlink port. Each port flavour
> >  */
> > struct ice_dynamic_port {
> > 	u8 hw_addr[ETH_ALEN];
> > 	u8 active: 1;
> >+	u8 attached: 1;
> > 	struct devlink_port devlink_port;
> > 	struct ice_pf *pf;
> > 	struct ice_vsi *vsi;
> > 	unsigned long repr_id;
> > 	u32 sfnum;
> >+	/* Flavour-specific implementation data */
> >+	union {
> >+		struct ice_sf_dev *sf_dev;
> >+	};
> > };
> > 
> > void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >index 9eb8993df25a..27a5baee7880 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >@@ -150,6 +150,7 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
> > 	devl_unlock(devlink);
> > 
> > 	devlink_register(devlink);
> >+	dyn_port->attached = true;
> > 
> > 	return 0;
> > 
> >@@ -189,6 +190,8 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
> > 	devl_unlock(devlink);
> > 	devlink_free(devlink);
> > 	ice_vsi_decfg(vsi);
> >+
> >+	dyn_port->attached = false;
> > }
> > 
> > static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
> >@@ -205,6 +208,8 @@ static struct auxiliary_driver ice_sf_driver = {
> > 	.id_table = ice_sf_dev_id_table
> > };
> > 
> >+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
> >+
> > /**
> >  * ice_sf_driver_register - Register new auxiliary subfunction driver
> >  *
> >@@ -223,3 +228,101 @@ void ice_sf_driver_unregister(void)
> > {
> > 	auxiliary_driver_unregister(&ice_sf_driver);
> > }
> >+
> >+/**
> >+ * ice_sf_dev_release - Release device associated with auxiliary device
> >+ * @device: pointer to the device
> >+ *
> >+ * Since most of the code for subfunction deactivation is handled in
> >+ * the remove handler, here just free tracking resources.
> >+ */
> >+static void ice_sf_dev_release(struct device *device)
> >+{
> >+	struct auxiliary_device *adev = to_auxiliary_dev(device);
> >+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
> >+
> >+	xa_erase(&ice_sf_aux_id, adev->id);
> >+	kfree(sf_dev);
> >+}
> >+
> >+/**
> >+ * ice_sf_eth_activate - Activate Ethernet subfunction port
> >+ * @dyn_port: the dynamic port instance for this subfunction
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Activate the dynamic port as an Ethernet subfunction. Setup the netdev
> >+ * resources associated and initialize the auxiliary device.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+int
> >+ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
> >+		    struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_pf *pf = dyn_port->pf;
> >+	struct ice_sf_dev *sf_dev;
> >+	struct pci_dev *pdev;
> >+	int err;
> >+	u32 id;
> >+
> >+	err = xa_alloc(&ice_sf_aux_id, &id, NULL, xa_limit_32b,
> >+		       GFP_KERNEL);
> >+	if (err) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF ID");
> >+		return err;
> >+	}
> >+
> >+	sf_dev = kzalloc(sizeof(*sf_dev), GFP_KERNEL);
> >+	if (!sf_dev) {
> >+		err = -ENOMEM;
> >+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF memory");
> >+		goto xa_erase;
> >+	}
> >+	pdev = pf->pdev;
> >+
> >+	sf_dev->dyn_port = dyn_port;
> >+	sf_dev->adev.id = id;
> >+	sf_dev->adev.name = "sf";
> >+	sf_dev->adev.dev.release = ice_sf_dev_release;
> >+	sf_dev->adev.dev.parent = &pdev->dev;
> >+
> >+	err = auxiliary_device_init(&sf_dev->adev);
> >+	if (err) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Failed to initialize SF device");
> >+		goto sf_dev_free;
> >+	}
> >+
> >+	err = auxiliary_device_add(&sf_dev->adev);
> >+	if (err) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Failed to add SF device");
> >+		goto aux_dev_uninit;
> >+	}
> >+
> >+	dyn_port->sf_dev = sf_dev;
> >+
> >+	return 0;
> >+
> >+aux_dev_uninit:
> >+	auxiliary_device_uninit(&sf_dev->adev);
> >+sf_dev_free:
> >+	kfree(sf_dev);
> >+xa_erase:
> >+	xa_erase(&ice_sf_aux_id, id);
> >+
> >+	return err;
> >+}
> >+
> >+/**
> >+ * ice_sf_eth_deactivate - Deactivate Ethernet subfunction port
> >+ * @dyn_port: the dynamic port instance for this subfunction
> >+ *
> >+ * Deactivate the Ethernet subfunction, removing its auxiliary device and the
> >+ * associated resources.
> >+ */
> >+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port)
> >+{
> >+	struct ice_sf_dev *sf_dev = dyn_port->sf_dev;
> >+
> >+	auxiliary_device_delete(&sf_dev->adev);
> >+	auxiliary_device_uninit(&sf_dev->adev);
> >+}
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >index e972c50f96c9..c558cad0a183 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >@@ -27,4 +27,7 @@ ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
> > int ice_sf_driver_register(void);
> > void ice_sf_driver_unregister(void);
> > 
> >+int ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
> >+			struct netlink_ext_ack *extack);
> >+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port);
> > #endif /* _ICE_SF_ETH_H_ */
> >-- 
> >2.42.0
> >
> >

