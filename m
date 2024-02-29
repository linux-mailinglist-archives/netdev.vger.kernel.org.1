Return-Path: <netdev+bounces-76256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84A86D042
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6F22843BD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9B5B1E7;
	Thu, 29 Feb 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="SO+UJZ1S"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7304AEFE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226732; cv=pass; b=jNHs5cNhqxBq+UWlXt7C/yTQdhJft18czZFNxdY9SSkgG6AO6OZclpNSRTCNSv/1M/pQBoPQYWkoft/lHBeq8WlLpTNHV5qLAM4RM3vXE4sKPCqsn6ucu+NEP3Vagrl9Yw/yazGeswtTI232EF4ILZztLoDGhbyTNc7iI3oDkaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226732; c=relaxed/simple;
	bh=tG4YaaPxND5K3iWlE+k8QNX5V8rC9uMEdxTTyWqj0NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acCHG41nD2ni9CyGvGufK4445AcQMLbV6D+aEDO+LVNJHo3A7pdPlNR9GuFxeIsXC0N/NeU8trreHKygXFPGrcUqgyVk/icmnhMZI4BlWyTW65GNdajxPNIXr0Ou5KpS/7IwKsC7ExpaFJMTiynp/jYbeea04MLYZYGwl0LB1hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=SO+UJZ1S; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1709226720; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kAy0KK/O5ewzmJ6KlG8fjGQIdZhyH+I4HFkxvIAtktuw35HdACnaxUpzc/SUk3DBkpu84TugPTdwlPgOWL2UOPaUrusYQUV+hijrFSqTNUV3y7SCCmn6FWpIwolbqKg7ET3NTcz4ibVjYLgnoRbIv2+lCrEvXQsYjgK2FgJGMEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1709226720; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SWzJLheDLhxr5qms7sm8z+sFqnKieuMiW57bGM6d79k=; 
	b=I1mYoZ3ZdSVLusKDz7bJeMOa4nK/u48e6ZBFtH0mwCV3Nxx1MTVvONYLycaTdv+ZV4j0GDuiriCaSl92v4lEvOhxkhCiPtoRy0t/NKCE6n7LnlGA5AQeKI6pAChPJIdHJgmNxk/O5YwG5tQuLJgrvAhGpkvA8qk1bzT9gxnMZlM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709226720;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SWzJLheDLhxr5qms7sm8z+sFqnKieuMiW57bGM6d79k=;
	b=SO+UJZ1SPH4bSAQscDEd2POcPJLLakZDEFRGuPtJ3RMmsvdBh1T//FAsitf0zyRx
	OisFOEYfDatO84HP6O6b6osYqiqnutS8nyLo7tSRfq2HcavcaOW1u91bJ4cEEGV7J/N
	dpTmcltOdQJWFkqxYd5CnLErRJ5JigfgMLoK1vmpVkqO0B5PxK15dKNFlYW+F2PgFap
	7EVaaaYVRTg1p+5xk/exolysNybY/MalSsve5IGuHRfmXurJ++lT8loMGxRs1KDPeif
	iH7i1qIY0Xc+BZKveJIMgSSA7fZ2YtUuqdeCmxHB/Y0ke+v1pZrmvylR3toUT8eL3C1
	vnmYQVAO/w==
Received: from [192.168.5.82] (public-gprs530213.centertel.pl [31.61.190.102]) by mx.zohomail.com
	with SMTPS id 1709226718459455.0042794914734; Thu, 29 Feb 2024 09:11:58 -0800 (PST)
Message-ID: <ac3d9c05-402f-435c-a5d2-29ab4f274bf5@machnikowski.net>
Date: Thu, 29 Feb 2024 18:11:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/5] netdevsim: allow two netdevsim ports to be
 connected
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 horms@kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240228232253.2875900-1-dw@davidwei.uk>
 <20240228232253.2875900-2-dw@davidwei.uk>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240228232253.2875900-2-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 29/02/2024 00:22, David Wei wrote:
> Add two netdevsim bus attribute to sysfs:
> /sys/bus/netdevsim/link_device
> /sys/bus/netdevsim/unlink_device
> 
> Writing "A M B N" to link_device will link netdevsim M in netnsid A with
> netdevsim N in netnsid B.
> 
> Writing "A M" to unlink_device will unlink netdevsim M in netnsid A from
> its peer, if any.
> 
> rtnl_lock is taken to ensure nothing changes during the linking.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/bus.c       | 145 ++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdev.c    |  10 +++
>  drivers/net/netdevsim/netdevsim.h |   2 +
>  3 files changed, 157 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 0c5aff63d242..64c0cdd31bf8 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -232,9 +232,154 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
>  }
>  static BUS_ATTR_WO(del_device);
>  
> +static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
> +{
> +	struct netdevsim *nsim_a, *nsim_b, *peer;
> +	struct net_device *dev_a, *dev_b;
> +	unsigned int ifidx_a, ifidx_b;
> +	int netnsfd_a, netnsfd_b, err;
> +	struct net *ns_a, *ns_b;
> +
> +	err = sscanf(buf, "%d:%u %d:%u", &netnsfd_a, &ifidx_a, &netnsfd_b,
> +		     &ifidx_b);
> +	if (err != 4) {
> +		pr_err("Format for linking two devices is \"netnsfd_a:ifidx_a netnsfd_b:ifidx_b\" (int uint int uint).\n");
> +		return -EINVAL;
> +	}
> +
> +	ns_a = get_net_ns_by_fd(netnsfd_a);
> +	if (IS_ERR(ns_a)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_a);
> +		return -EINVAL;
> +	}
> +
> +	ns_b = get_net_ns_by_fd(netnsfd_b);
> +	if (IS_ERR(ns_b)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_b);
> +		put_net(ns_a);
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	dev_a = __dev_get_by_index(ns_a, ifidx_a);
> +	if (!dev_a) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
> +		       ifidx_a, netnsfd_a);
> +		goto out_err;
> +	}
> +
> +	if (!netdev_is_nsim(dev_a)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
> +		       ifidx_a, netnsfd_a);
> +		goto out_err;
> +	}
> +
> +	dev_b = __dev_get_by_index(ns_b, ifidx_b);
> +	if (!dev_b) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
> +		       ifidx_b, netnsfd_b);
> +		goto out_err;
> +	}
> +
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
> +		       ifidx_b, netnsfd_b);
> +		goto out_err;
> +	}
> +
> +	if (dev_a == dev_b) {
> +		pr_err("Cannot link a netdevsim to itself\n");
> +		goto out_err;
> +	}
> +
> +	err = -EBUSY;
> +	nsim_a = netdev_priv(dev_a);
> +	peer = rtnl_dereference(nsim_a->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a,
> +		       ifidx_a);
> +		goto out_err;
> +	}
> +
> +	nsim_b = netdev_priv(dev_b);
> +	peer = rtnl_dereference(nsim_b->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b,
> +		       ifidx_b);
> +		goto out_err;
> +	}
> +
> +	err = 0;
> +	rcu_assign_pointer(nsim_a->peer, nsim_b);
> +	rcu_assign_pointer(nsim_b->peer, nsim_a);
> +
> +out_err:
> +	put_net(ns_b);
> +	put_net(ns_a);
> +	rtnl_unlock();
> +
> +	return !err ? count : err;
> +}
> +static BUS_ATTR_WO(link_device);
> +
> +static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
> +{
> +	struct netdevsim *nsim, *peer;
> +	struct net_device *dev;
> +	unsigned int ifidx;
> +	int netnsfd, err;
> +	struct net *ns;
> +
> +	err = sscanf(buf, "%u:%u", &netnsfd, &ifidx);
> +	if (err != 2) {
> +		pr_err("Format for unlinking a device is \"netnsfd:ifidx\" (int uint).\n");
> +		return -EINVAL;
> +	}
> +
> +	ns = get_net_ns_by_fd(netnsfd);
> +	if (IS_ERR(ns)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd);
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	dev = __dev_get_by_index(ns, ifidx);
> +	if (!dev) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
> +		       ifidx, netnsfd);
> +		goto out_put_netns;
> +	}
> +
> +	if (!netdev_is_nsim(dev)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
> +		       ifidx, netnsfd);
> +		goto out_put_netns;
> +	}
> +
> +	nsim = netdev_priv(dev);
> +	peer = rtnl_dereference(nsim->peer);
> +	if (!peer)
> +		goto out_put_netns;
> +
> +	err = 0;
> +	RCU_INIT_POINTER(nsim->peer, NULL);
> +	RCU_INIT_POINTER(peer->peer, NULL);
> +
> +out_put_netns:
> +	put_net(ns);
> +	rtnl_unlock();
> +
> +	return !err ? count : err;
> +}
> +static BUS_ATTR_WO(unlink_device);
> +
>  static struct attribute *nsim_bus_attrs[] = {
>  	&bus_attr_new_device.attr,
>  	&bus_attr_del_device.attr,
> +	&bus_attr_link_device.attr,
> +	&bus_attr_unlink_device.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(nsim_bus);
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 77e8250282a5..9063f4f2971b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -413,8 +413,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>  void nsim_destroy(struct netdevsim *ns)
>  {
>  	struct net_device *dev = ns->netdev;
> +	struct netdevsim *peer;
>  
>  	rtnl_lock();
> +	peer = rtnl_dereference(ns->peer);
> +	if (peer)
> +		RCU_INIT_POINTER(peer->peer, NULL);
> +	RCU_INIT_POINTER(ns->peer, NULL);
>  	unregister_netdevice(dev);
>  	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>  		nsim_macsec_teardown(ns);
> @@ -427,6 +432,11 @@ void nsim_destroy(struct netdevsim *ns)
>  	free_netdev(dev);
>  }
>  
> +bool netdev_is_nsim(struct net_device *dev)
> +{
> +	return dev->netdev_ops == &nsim_netdev_ops;
> +}
> +
>  static int nsim_validate(struct nlattr *tb[], struct nlattr *data[],
>  			 struct netlink_ext_ack *extack)
>  {
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index 028c825b86db..c8b45b0d955e 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -125,11 +125,13 @@ struct netdevsim {
>  	} udp_ports;
>  
>  	struct nsim_ethtool ethtool;
> +	struct netdevsim __rcu *peer;
>  };
>  
>  struct netdevsim *
>  nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port);
>  void nsim_destroy(struct netdevsim *ns);
> +bool netdev_is_nsim(struct net_device *dev);
>  
>  void nsim_ethtool_init(struct netdevsim *ns);
>  


Reviewed-by: Maciek Machnikowski <maciek@machnikowski.net>

