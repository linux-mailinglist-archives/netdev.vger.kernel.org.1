Return-Path: <netdev+bounces-61463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5B823EA8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9558A1C23938
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F92033F;
	Thu,  4 Jan 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xfYqrJWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B23208A8
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd053d5683so3451751fa.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 01:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704360645; x=1704965445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWM2CoUisXj6aGaNfYES7yww+5Ibs/vyCZDZtNY8OOo=;
        b=xfYqrJWRJrMhZC8/UOqJDDCvfFXpsFDPqr7VrsoXsTPyqvQs9A/Yidf62J/0pbb/cf
         caA0kbECgvVr/YywUJHAdcgx27TDGn8pSGoxHt7anf7SHZJAOy4gVr2MvXZJRHlMJUF9
         N57oZLkDQktjrUJBOK/ymZPH54T05Ws7ZXnr20qjHhFfyYGlNqWX3c7rB9j0MUcsf7Zz
         xNd1ZErHtN8NSdZR4TjBlZBlRSP/KeGsCDeWoLGEJFAAJL/WJSb9Yl/6E8T3j0DNf2eq
         wBC9uW/yzhOMW03zNXwI1MHxncuVazYR+1FrrXY1DkkHXez4Wm13fbeELo/gdMdIwwJn
         /e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360645; x=1704965445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWM2CoUisXj6aGaNfYES7yww+5Ibs/vyCZDZtNY8OOo=;
        b=E2ysvZ+JgH9k1YnwEy47vFI0y42idbK7cLZMziXt/TALRemf6iKDck2uP6yltVn7ny
         RCAEtIIIVGTQ2W0vxfId064K+OJiM8I7gJj77LxBe22E3f75JdwYtmsbfOvojqD+Sm0E
         blWhmQKYjZ2GJOJ04GuhRAGmtUye/oRtd2OEO0jC9Vo7xF0K75CxczOyuk4W7/R8QeQm
         dxTCLziyIbdbAz514tnnqWUAEglBTccrjwNAOHVYDSY4DBcEcW4DgzhWY/AMZcdZVTsu
         clH451vcJXdK6bZTdVPCQZZrOZQ/mm9b7CczaRFv1KSr3qLTc9HnuMINee003pVeiLUU
         VUJA==
X-Gm-Message-State: AOJu0YzCf3jhHw2uxIWBVHbWVGvhlv9fkpo9xKNg/1Q+LGPRU2xrtttL
	LvoiLRGvERLBx/gUT00OH3nPrQjp7NlcWg==
X-Google-Smtp-Source: AGHT+IFkz60cC+tWf2tXDCdehEswx+6RicbkhnnEMCXBvxIaGcFFd9VRGRrDMWfCdt+Y2iB+sjuoWw==
X-Received: by 2002:a2e:494a:0:b0:2cc:75c7:e7f4 with SMTP id b10-20020a2e494a000000b002cc75c7e7f4mr155402ljd.55.1704360644670;
        Thu, 04 Jan 2024 01:30:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id df15-20020a5d5b8f000000b00336c43b366fsm23901178wrb.12.2024.01.04.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:30:44 -0800 (PST)
Date: Thu, 4 Jan 2024 10:30:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZZZ6wl50USBm1iqQ@nanopsycho>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-3-dw@davidwei.uk>
 <ZZPvST-nAaBMPKet@nanopsycho>
 <29ff3b51-4e51-4f2d-81e5-fd2d6c6869b3@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ff3b51-4e51-4f2d-81e5-fd2d6c6869b3@davidwei.uk>

Wed, Jan 03, 2024 at 10:56:36PM CET, dw@davidwei.uk wrote:
>On 2024-01-02 03:11, Jiri Pirko wrote:
>> Thu, Dec 28, 2023 at 02:46:30AM CET, dw@davidwei.uk wrote:
>>> Add a debugfs file in
>>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>>
>>> Writing "M B" to this file will link port A of netdevsim N with port B
>>> of netdevsim M. Reading this file will return the linked netdevsim id
>>> and port, if any.
>>>
>>> During nsim_dev_peer_write(), nsim_dev_list_lock prevents concurrent
>>> modifications to nsim_dev and peer's devlink->lock prevents concurrent
>>> modifications to the peer's port_list. rtnl_lock ensures netdevices do
>>> not change during the critical section where a link is established.
>>>
>>> The lock order is consistent with other parts that touch netdevsim and
>>> should not deadlock.
>>>
>>> During nsim_dev_peer_read(), RCU read critical section ensures valid
>>> values even if stale.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/dev.c       | 134 +++++++++++++++++++++++++++---
>>> drivers/net/netdevsim/netdev.c    |   6 ++
>>> drivers/net/netdevsim/netdevsim.h |   1 +
>>> 3 files changed, 128 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index 8d477aa99f94..6d5e4ce08dfd 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -391,6 +391,124 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>>> 	.owner = THIS_MODULE,
>>> };
>>>
>>> +static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
>>> +{
>>> +	struct nsim_dev *dev;
>>> +
>>> +	list_for_each_entry(dev, &nsim_dev_list, list)
>>> +		if (dev->nsim_bus_dev->dev.id == id)
>>> +			return dev;
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static struct nsim_dev_port *
>>> +__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>>> +		       unsigned int port_index)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port;
>>> +
>>> +	port_index = nsim_dev_port_index(type, port_index);
>>> +	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>>> +		if (nsim_dev_port->port_index == port_index)
>>> +			return nsim_dev_port;
>>> +	return NULL;
>>> +}
>>> +
>>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>>> +				  size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port;
>>> +	struct netdevsim *peer;
>>> +	unsigned int id, port;
>>> +	ssize_t ret = 0;
>>> +	char buf[23];
>>> +
>>> +	nsim_dev_port = file->private_data;
>>> +	rcu_read_lock();
>>> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
>>> +	if (!peer) {
>>> +		rcu_read_unlock();
>>> +		return 0;
>>> +	}
>>> +
>>> +	id = peer->nsim_bus_dev->dev.id;
>>> +	port = peer->nsim_dev_port->port_index;
>>> +	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>>> +	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>>> +
>>> +	rcu_read_unlock();
>>> +	return ret;
>>> +}
>>> +
>>> +static ssize_t nsim_dev_peer_write(struct file *file,
>>> +				   const char __user *data,
>>> +				   size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>>> +	struct nsim_dev *peer_dev;
>>> +	unsigned int id, port;
>>> +	char buf[22];
>>> +	ssize_t ret;
>>> +
>>> +	if (count >= sizeof(buf))
>>> +		return -ENOSPC;
>>> +
>>> +	ret = copy_from_user(buf, data, count);
>>> +	if (ret)
>>> +		return -EFAULT;
>>> +	buf[count] = '\0';
>>> +
>>> +	ret = sscanf(buf, "%u %u", &id, &port);
>>> +	if (ret != 2) {
>>> +		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = -EINVAL;
>>> +	mutex_lock(&nsim_dev_list_lock);
>>> +	peer_dev = nsim_dev_find_by_id(id);
>>> +	if (!peer_dev) {
>>> +		pr_err("Peer netdevsim %u does not exist\n", id);
>>> +		goto out_mutex;
>>> +	}
>>> +
>>> +	devl_lock(priv_to_devlink(peer_dev));
>> 
>> Why exactly do you take devlink instance mutex of the peer here?
>
>To make sure that port list do not change. Ports can be added or removed
>at will from nsim_drv_port_add() and nsim_drv_port_del() which both take
>the devlink lock.

Ok.

>
>> 
>> 
>>> +	rtnl_lock();
>>> +	nsim_dev_port = file->private_data;
>>> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>>> +					       port);
>>> +	if (!peer_dev_port) {
>>> +		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
>>> +		goto out_devl;
>>> +	}
>>> +
>>> +	if (nsim_dev_port == peer_dev_port) {
>>> +		pr_err("Cannot link netdevsim to itself\n");
>>> +		goto out_devl;
>>> +	}
>>> +
>>> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>>> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>>> +	ret = count;
>>> +
>>> +out_devl:
>>> +	rtnl_unlock();
>>> +	devl_unlock(priv_to_devlink(peer_dev));
>>> +out_mutex:
>>> +	mutex_unlock(&nsim_dev_list_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct file_operations nsim_dev_peer_fops = {
>>> +	.open = simple_open,
>>> +	.read = nsim_dev_peer_read,
>>> +	.write = nsim_dev_peer_write,
>>> +	.llseek = generic_file_llseek,
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +
>>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 				      struct nsim_dev_port *nsim_dev_port)
>>> {
>>> @@ -421,6 +539,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 	}
>>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>>
>>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>>> +
>>> 	return 0;
>>> }
>>>
>>> @@ -1704,19 +1825,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>>> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
>>> }
>>>
>>> -static struct nsim_dev_port *
>>> -__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>>> -		       unsigned int port_index)
>>> -{
>>> -	struct nsim_dev_port *nsim_dev_port;
>>> -
>>> -	port_index = nsim_dev_port_index(type, port_index);
>>> -	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>>> -		if (nsim_dev_port->port_index == port_index)
>>> -			return nsim_dev_port;
>>> -	return NULL;
>>> -}
>>> -
>>> int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
>>> 		      unsigned int port_index)
>>> {
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index aecaf5f44374..434322f6a565 100644
>>> --- a/drivers/net/netdevsim/netdev.c
>>> +++ b/drivers/net/netdevsim/netdev.c
>>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>> 	ns->nsim_dev = nsim_dev;
>>> 	ns->nsim_dev_port = nsim_dev_port;
>>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>>> +	RCU_INIT_POINTER(ns->peer, NULL);
>>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>>> 	nsim_ethtool_init(ns);
>>> @@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>> void nsim_destroy(struct netdevsim *ns)
>>> {
>>> 	struct net_device *dev = ns->netdev;
>>> +	struct netdevsim *peer;
>>>
>>> 	rtnl_lock();
>>> +	peer = rtnl_dereference(ns->peer);
>>> +	if (peer)
>>> +		RCU_INIT_POINTER(peer->peer, NULL);
>>> +	RCU_INIT_POINTER(ns->peer, NULL);
>>> 	unregister_netdevice(dev);
>>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>>> 		nsim_macsec_teardown(ns);
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index babb61d7790b..24fc3fbda791 100644
>>> --- a/drivers/net/netdevsim/netdevsim.h
>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>> @@ -125,6 +125,7 @@ struct netdevsim {
>>> 	} udp_ports;
>>>
>>> 	struct nsim_ethtool ethtool;
>>> +	struct netdevsim __rcu *peer;
>>> };
>>>
>>> struct netdevsim *
>>> -- 
>>> 2.39.3
>>>

