Return-Path: <netdev+bounces-153305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1E9F7914
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205971894A6E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E2221D8B;
	Thu, 19 Dec 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPKVoK6i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDF1FAC26;
	Thu, 19 Dec 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602453; cv=none; b=Gexi4xSuavELWN2e0qN1mfsdx+SdVEZ5H4dJ1gFwOOc+mbAi9mElVT1g+7ZN2p7d3zXoKr4URC+y2q0mHnwbBfOyr3UQf+Sw1uBs8Lh1lQXwdibGNb1b99q2PsEKMEZfGYJJHUi5RjXkeJaKdB3ufhHuqUvsi/ZV48FwPPPo/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602453; c=relaxed/simple;
	bh=MvsQMKQ+7oNsyvqYjPT967sLWqGyuQ128Ftn0RLMetc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZZS0NgL9Mv2vup13wYhqLsayLmk7kcUqlrfwxQZGSokkQyKDNB/dYeeuvhHM7ob7ZsC/Q7Gv7uSycJht/fJ2NyK3g0kMPqwTRzaUelXwE6n3lOKQFRRz+tQovmBpPOb8WpYsOPBCxGF/8gYK4Q6BMxoZFEvN+hospsdCRwuqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPKVoK6i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734602452; x=1766138452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvsQMKQ+7oNsyvqYjPT967sLWqGyuQ128Ftn0RLMetc=;
  b=gPKVoK6iLlWLCbuHWW+GZ67IG8Q/7OtOIoqUzqkPGBfo3gObjx08LKn6
   tEgOzspk8nU7Ydj9v8SRiuZvuaQX6C/lv4HWEvyZ2Y2gQXj43XJ/NFCxT
   SnVffkWx/dZrhvJCt6GPzJ7MUAwhATaGZ7Q941fdpSucPHx6Mhu/pT95n
   6+FOcGp7SY1nv41vsoOqMqWwisMe3ixu2g7hZnIG2w7TtdB4Ng3sAXyWH
   6nqBzHlwQ8e0OXZoMvAxNB5ixlXk5ePPu2iQnYtLlwVq61Y1KOJfwEobu
   XczRXQVGQZM9aLcyzHe038ZiCxRpku6H16ekRxOLcNPuIKMA8aMvRwI2e
   A==;
X-CSE-ConnectionGUID: MPb9Y71oRPi5UhVi+FvWXw==
X-CSE-MsgGUID: yGJjxRafT9iMV4L+U89J8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35005111"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35005111"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:00:50 -0800
X-CSE-ConnectionGUID: kQMo8r5eQJuTTAGnMCjq4Q==
X-CSE-MsgGUID: NqfPAXFITlG2s4xID+um2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103227165"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:00:46 -0800
Date: Thu, 19 Dec 2024 10:57:30 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: aleksander.lobakin@intel.com, lukma@denx.de, m-malladi@ti.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org,
	schnelle@linux.ibm.com, vladimir.oltean@nxp.com, horms@kernel.org,
	rogerq@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 3/4] net: ti: icssg-prueth: Add Multicast
 Filtering support for VLAN in MAC mode
Message-ID: <Z2PuCmGDGpqvc0bp@mev-dev.igk.intel.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-4-danishanwar@ti.com>
 <Z2PLDqqrLdXhLtAF@mev-dev.igk.intel.com>
 <cb319ffd-ac67-42b3-9786-e8c9970086d2@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb319ffd-ac67-42b3-9786-e8c9970086d2@ti.com>

On Thu, Dec 19, 2024 at 03:06:18PM +0530, MD Danish Anwar wrote:
> 
> 
> On 19/12/24 12:58 pm, Michal Swiatkowski wrote:
> > On Mon, Dec 16, 2024 at 03:30:43PM +0530, MD Danish Anwar wrote:
> >> Add multicast filtering support for VLAN interfaces in dual EMAC mode
> >> for ICSSG driver.
> >>
> >> The driver uses vlan_for_each() API to get the list of available
> >> vlans. The driver then sync mc addr of vlan interface with a locally
> >> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
> >> API.
> >>
> >> The driver then calls the sync / unsync callbacks and based on whether
> >> the ndev is vlan or not, driver passes appropriate vid to FDB helper
> >> functions.
> >>
> >> This commit also exports __hw_addr_sync_multiple() in order to use it
> >> from the ICSSG driver.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 69 ++++++++++++++++----
> >>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
> >>  include/linux/netdevice.h                    |  3 +
> >>  net/core/dev_addr_lists.c                    |  7 +-
> >>  4 files changed, 68 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> >> index e031bccf31dc..a18773ef6eab 100644
> >> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> >> @@ -472,30 +472,43 @@ const struct icss_iep_clockops prueth_iep_clockops = {
> >>  
> >>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
> >>  {
> >> -	struct prueth_emac *emac = netdev_priv(ndev);
> >> -	int port_mask = BIT(emac->port_id);
> >> +	struct net_device *real_dev;
> >> +	struct prueth_emac *emac;
> >> +	int port_mask;
> >> +	u8 vlan_id;
> >>  
> >> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
> >> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
> >> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
> >> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
> >> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> > Looks like a helper for that can be nice to have.
> >
> 
> I don't think that's neccessary. vlan_dev_real_dev() itself is a helper
> function to give the real dev, only down side is vlan_dev_real_dev()
> assumes that the dev is vlan only.
> 
> In this function, we don't know if ndev is vlan or not, hence the check.
> Most drivers are using vlan_dev_real_dev() the same way.
> 

I meant to not repeat the
is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
(it is also used in next patch)

But as you think, I don't have strong opinion on that.

> 
> >> +	emac = netdev_priv(real_dev);
> >> +
> >> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
> >> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
> >> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
> >>  
> >>  	return 0;
> >>  }
> >>  
> >>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
> >>  {
> >> -	struct prueth_emac *emac = netdev_priv(ndev);
> >> -	int port_mask = BIT(emac->port_id);
> >> +	struct net_device *real_dev;
> >> +	struct prueth_emac *emac;
> >>  	int other_port_mask;
> >> +	int port_mask;
> >> +	u8 vlan_id;
> >> +
> >> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
> >> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> >> +	emac = netdev_priv(real_dev);
> >>  
> >> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
> >> +	port_mask = BIT(emac->port_id);
> >> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
> >>  
> >> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
> >> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
> >> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
> >> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
> >>  
> >>  	if (other_port_mask) {
> >> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
> >> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
> >> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
> >> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask, other_port_mask, true);
> >>  	}
> >>  
> >>  	return 0;
> >> @@ -531,6 +544,28 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
> >>  	return 0;
> >>  }
> >>  
> >> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
> >> +				   void *args)
> >> +{
> >> +	struct net_device *vport_ndev;
> >> +	struct prueth_emac *emac;
> >> +
> >> +	if (!vdev || !vid)
> >> +		return 0;
> >> +
> >> +	vport_ndev = vlan_dev_real_dev(vdev);
> >> +	emac = netdev_priv(vport_ndev);
> >> +
> >> +	netif_addr_lock_bh(vdev);
> >> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc, vdev->addr_len);
> > Only question, why dev_mc_sync_multiple can't be used here?
> > 
> 
> dev_mc_sync_multiple() doesn't work here.
> 
> Let's say we call dev_mc_sync_multiple() with emac->ndev (the netdevice
> for current port say eth1) and vdev (the netdevice for the vlan
> interface say eth1.x with x being the vid).
> 
> Now dev_mc_sync_multiple() will sync the mc list from vdev to ndev. And
> ndev will have the address added to vdev. After this set_rx_mode() gets
> called for ndev. Which eventually calls sync / unsync APIs
> icssg_prueth_add/del_mcast.
> 
> Now in this API, we will have the address to add but we won't have the vid.
> 
> The sync/unsync API will be called for the emac->ndev (the *to* device)
> and emac->ndev will have no information about vid. Since it is not a
> vlan dev and is_vlan_dev() will be false for it as a result we will
> fallback to default vid.
> 
> 	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) :
> PRUETH_DFLT_VLAN_HSR;
> 
> We don't want this. We want to capture the correct vid. Hence sync /
> unsync needs to get called for the vlan device i.e. vdev.
> 
> Due to this dev_mc_sync_multiple() doesn't work and we need to call
> __hw_addr_sync_multiple and __hw_addr_sync_dev on vdev so that our sync
> / unsync APIs are called for vdev.
> 
>

Ok, I understand, thank for explanation.

> >> +	netif_addr_unlock_bh(vdev);
> >> +
> >> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
> >> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /**
> >>   * emac_ndo_open - EMAC device open
> >>   * @ndev: network adapter device
> >> @@ -772,12 +807,17 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
> >>  		return;
> >>  	}
> >>  
> >> -	if (emac->prueth->is_hsr_offload_mode)
> >> +	if (emac->prueth->is_hsr_offload_mode) {
> >>  		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
> >>  			      icssg_prueth_hsr_del_mcast);
> >> -	else
> >> +	} else {
> >>  		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
> >>  			      icssg_prueth_del_mcast);
> >> +		if (rtnl_trylock()) {
> >> +			vlan_for_each(ndev, icssg_update_vlan_mcast, NULL);
> >> +			rtnl_unlock();
> >> +		}
> >> +	}
> >>  }
> >>  
> >>  /**
> >> @@ -828,6 +868,7 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
> >>  	if (prueth->is_hsr_offload_mode)
> >>  		port_mask |= BIT(PRUETH_PORT_HOST);
> >>  
> >> +	__hw_addr_init(&emac->vlan_mcast_list[vid]);
> >>  	netdev_err(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
> >>  		   vid, port_mask, untag_mask);
> >>  
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> index f5c1d473e9f9..4da8b87408b5 100644
> >> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> @@ -83,6 +83,10 @@
> >>  #define ICSS_CMD_ADD_FILTER 0x7
> >>  #define ICSS_CMD_ADD_MAC 0x8
> >>  
> >> +/* VLAN Filtering Related MACROs */
> >> +#define PRUETH_DFLT_VLAN_MAC	0
> >> +#define MAX_VLAN_ID		256
> >> +
> >>  /* In switch mode there are 3 real ports i.e. 3 mac addrs.
> >>   * however Linux sees only the host side port. The other 2 ports
> >>   * are the switch ports.
> >> @@ -201,6 +205,8 @@ struct prueth_emac {
> >>  	/* RX IRQ Coalescing Related */
> >>  	struct hrtimer rx_hrtimer;
> >>  	unsigned long rx_pace_timeout_ns;
> >> +
> >> +	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
> >>  };
> >>  
> >>  /**
> >> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >> index d917949bba03..a5c169b19543 100644
> >> --- a/include/linux/netdevice.h
> >> +++ b/include/linux/netdevice.h
> >> @@ -4685,6 +4685,9 @@ int devm_register_netdev(struct device *dev, struct net_device *ndev);
> >>  /* General hardware address lists handling functions */
> >>  int __hw_addr_sync(struct netdev_hw_addr_list *to_list,
> >>  		   struct netdev_hw_addr_list *from_list, int addr_len);
> >> +int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> >> +			    struct netdev_hw_addr_list *from_list,
> >> +			    int addr_len);
> >>  void __hw_addr_unsync(struct netdev_hw_addr_list *to_list,
> >>  		      struct netdev_hw_addr_list *from_list, int addr_len);
> >>  int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
> >> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> >> index 166e404f7c03..90716bd736f3 100644
> >> --- a/net/core/dev_addr_lists.c
> >> +++ b/net/core/dev_addr_lists.c
> >> @@ -242,9 +242,9 @@ static void __hw_addr_unsync_one(struct netdev_hw_addr_list *to_list,
> >>  	__hw_addr_del_entry(from_list, ha, false, false);
> >>  }
> >>  
> >> -static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> >> -				   struct netdev_hw_addr_list *from_list,
> >> -				   int addr_len)
> >> +int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> >> +			    struct netdev_hw_addr_list *from_list,
> >> +			    int addr_len)
> >>  {
> >>  	int err = 0;
> >>  	struct netdev_hw_addr *ha, *tmp;
> >> @@ -260,6 +260,7 @@ static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> >>  	}
> >>  	return err;
> >>  }
> >> +EXPORT_SYMBOL(__hw_addr_sync_multiple);
> >>  
> >>  /* This function only works where there is a strict 1-1 relationship
> >>   * between source and destination of they synch. If you ever need to
> >> -- 
> >> 2.34.1
> 
> -- 
> Thanks and Regards,
> Danish

