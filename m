Return-Path: <netdev+bounces-61338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88374823759
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC0A1F25E65
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729F1DA26;
	Wed,  3 Jan 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AYxNBTbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBF1DA23
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso80522425ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704318998; x=1704923798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhPZidgOOJ0s/OvB0jIwGL8dQzJRxsHCwkFTnBBhLEE=;
        b=AYxNBTbDoaD1tE6c2X5ZEP8NbgExTmaQbIcpj6G+d9O8TqwCpR4In53uv/JyeVF/Ja
         Ieni/C8Y8l959g9B/5SC2quh2OVouEUOGbLrOzHFmMnTipg40Kfr69Qb1o5/w+0YBrRx
         j0hq9NotqebdF2nxjBJoP0/mKk1H0IEYDjo6CpVVL2FmuZHEHl9hCtZOp8VGw8HzHBmV
         +OTbn3tq93fgnSsBGcGeLf32y/nHiOt7x1hZUbNqPkCNFOH/IxQI7806FxvJA4JSQso8
         phAu+e8SGU1X5179SFTnxcZnt5L7VYXx96gfwPLPvLCkDOfZjkxMN5u5rLC8pHwicRuv
         9IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318998; x=1704923798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhPZidgOOJ0s/OvB0jIwGL8dQzJRxsHCwkFTnBBhLEE=;
        b=k3bISq7lvmTm0GRDHiR0LuIfQNiGNUqC1k8mqdUjv8fFs9rtQinLgbwaTEUdBFj7qF
         obk1hIxbIp/ms/8pn7j4D/W4Gykj/Gbug+PcCv+YY9KBNPHzgOpOcy0MnnVNn2yanmHm
         qk9W2OOilN3SzktpQFaLKFjrWhPwgl6iYgnzMVt0s+2mLfDReJa7IcCg8IX14mTDX1TO
         WE3Su0OY8k2YcUDiLS0nRTGnKlNVOpAM3coO+0Q1MyaZWHK/lbJ/fC8ZAFmVfnnEytD5
         fZUtFLY6ClrkxxP1POBngDWzmon2qixfmFbhLnXVLzMqzX58H0mPEuz36ZEXrNAXg7l9
         esaw==
X-Gm-Message-State: AOJu0YwtQn6brEXYDvezWfWQ0uYKlNHNvSaQHo08T0bxAu1goEDKincs
	awTMRYe+yE1P44RTo7pxjXxf4ANwo7Z+PD4YwaNjkn317aK7nI1+Eds=
X-Google-Smtp-Source: AGHT+IHbq40xdXK04Ib5OpvK25TAeG7A0sLUXw/IMo2AzufNgcFGGBP0iL1e+oUCpaV40bCBJPjpOg==
X-Received: by 2002:a17:902:ceca:b0:1d3:e582:fa60 with SMTP id d10-20020a170902ceca00b001d3e582fa60mr21278690plg.28.1704318998504;
        Wed, 03 Jan 2024 13:56:38 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:a:897:c73b:17c6:3432? ([2620:10d:c090:500::4:9b01])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001cf658f20ecsm24120912plf.96.2024.01.03.13.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:56:38 -0800 (PST)
Message-ID: <29ff3b51-4e51-4f2d-81e5-fd2d6c6869b3@davidwei.uk>
Date: Wed, 3 Jan 2024 13:56:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-3-dw@davidwei.uk> <ZZPvST-nAaBMPKet@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZZPvST-nAaBMPKet@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-02 03:11, Jiri Pirko wrote:
> Thu, Dec 28, 2023 at 02:46:30AM CET, dw@davidwei.uk wrote:
>> Add a debugfs file in
>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>
>> Writing "M B" to this file will link port A of netdevsim N with port B
>> of netdevsim M. Reading this file will return the linked netdevsim id
>> and port, if any.
>>
>> During nsim_dev_peer_write(), nsim_dev_list_lock prevents concurrent
>> modifications to nsim_dev and peer's devlink->lock prevents concurrent
>> modifications to the peer's port_list. rtnl_lock ensures netdevices do
>> not change during the critical section where a link is established.
>>
>> The lock order is consistent with other parts that touch netdevsim and
>> should not deadlock.
>>
>> During nsim_dev_peer_read(), RCU read critical section ensures valid
>> values even if stale.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/dev.c       | 134 +++++++++++++++++++++++++++---
>> drivers/net/netdevsim/netdev.c    |   6 ++
>> drivers/net/netdevsim/netdevsim.h |   1 +
>> 3 files changed, 128 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index 8d477aa99f94..6d5e4ce08dfd 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -391,6 +391,124 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>> 	.owner = THIS_MODULE,
>> };
>>
>> +static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
>> +{
>> +	struct nsim_dev *dev;
>> +
>> +	list_for_each_entry(dev, &nsim_dev_list, list)
>> +		if (dev->nsim_bus_dev->dev.id == id)
>> +			return dev;
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct nsim_dev_port *
>> +__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>> +		       unsigned int port_index)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +
>> +	port_index = nsim_dev_port_index(type, port_index);
>> +	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>> +		if (nsim_dev_port->port_index == port_index)
>> +			return nsim_dev_port;
>> +	return NULL;
>> +}
>> +
>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +	struct netdevsim *peer;
>> +	unsigned int id, port;
>> +	ssize_t ret = 0;
>> +	char buf[23];
>> +
>> +	nsim_dev_port = file->private_data;
>> +	rcu_read_lock();
>> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
>> +	if (!peer) {
>> +		rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +	id = peer->nsim_bus_dev->dev.id;
>> +	port = peer->nsim_dev_port->port_index;
>> +	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>> +	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>> +
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>> +static ssize_t nsim_dev_peer_write(struct file *file,
>> +				   const char __user *data,
>> +				   size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>> +	struct nsim_dev *peer_dev;
>> +	unsigned int id, port;
>> +	char buf[22];
>> +	ssize_t ret;
>> +
>> +	if (count >= sizeof(buf))
>> +		return -ENOSPC;
>> +
>> +	ret = copy_from_user(buf, data, count);
>> +	if (ret)
>> +		return -EFAULT;
>> +	buf[count] = '\0';
>> +
>> +	ret = sscanf(buf, "%u %u", &id, &port);
>> +	if (ret != 2) {
>> +		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = -EINVAL;
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	peer_dev = nsim_dev_find_by_id(id);
>> +	if (!peer_dev) {
>> +		pr_err("Peer netdevsim %u does not exist\n", id);
>> +		goto out_mutex;
>> +	}
>> +
>> +	devl_lock(priv_to_devlink(peer_dev));
> 
> Why exactly do you take devlink instance mutex of the peer here?

To make sure that port list do not change. Ports can be added or removed
at will from nsim_drv_port_add() and nsim_drv_port_del() which both take
the devlink lock.

> 
> 
>> +	rtnl_lock();
>> +	nsim_dev_port = file->private_data;
>> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>> +					       port);
>> +	if (!peer_dev_port) {
>> +		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
>> +		goto out_devl;
>> +	}
>> +
>> +	if (nsim_dev_port == peer_dev_port) {
>> +		pr_err("Cannot link netdevsim to itself\n");
>> +		goto out_devl;
>> +	}
>> +
>> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>> +	ret = count;
>> +
>> +out_devl:
>> +	rtnl_unlock();
>> +	devl_unlock(priv_to_devlink(peer_dev));
>> +out_mutex:
>> +	mutex_unlock(&nsim_dev_list_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations nsim_dev_peer_fops = {
>> +	.open = simple_open,
>> +	.read = nsim_dev_peer_read,
>> +	.write = nsim_dev_peer_write,
>> +	.llseek = generic_file_llseek,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 				      struct nsim_dev_port *nsim_dev_port)
>> {
>> @@ -421,6 +539,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 	}
>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>
>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>> +
>> 	return 0;
>> }
>>
>> @@ -1704,19 +1825,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
>> }
>>
>> -static struct nsim_dev_port *
>> -__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>> -		       unsigned int port_index)
>> -{
>> -	struct nsim_dev_port *nsim_dev_port;
>> -
>> -	port_index = nsim_dev_port_index(type, port_index);
>> -	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>> -		if (nsim_dev_port->port_index == port_index)
>> -			return nsim_dev_port;
>> -	return NULL;
>> -}
>> -
>> int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
>> 		      unsigned int port_index)
>> {
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index aecaf5f44374..434322f6a565 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> 	ns->nsim_dev = nsim_dev;
>> 	ns->nsim_dev_port = nsim_dev_port;
>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>> 	nsim_ethtool_init(ns);
>> @@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> void nsim_destroy(struct netdevsim *ns)
>> {
>> 	struct net_device *dev = ns->netdev;
>> +	struct netdevsim *peer;
>>
>> 	rtnl_lock();
>> +	peer = rtnl_dereference(ns->peer);
>> +	if (peer)
>> +		RCU_INIT_POINTER(peer->peer, NULL);
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	unregister_netdevice(dev);
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>> 		nsim_macsec_teardown(ns);
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index babb61d7790b..24fc3fbda791 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -125,6 +125,7 @@ struct netdevsim {
>> 	} udp_ports;
>>
>> 	struct nsim_ethtool ethtool;
>> +	struct netdevsim __rcu *peer;
>> };
>>
>> struct netdevsim *
>> -- 
>> 2.39.3
>>

