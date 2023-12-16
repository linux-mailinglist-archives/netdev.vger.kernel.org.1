Return-Path: <netdev+bounces-58207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEB815883
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805D21F24F3A
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AF14016;
	Sat, 16 Dec 2023 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yqbNzSrS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA313FEA
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3365f1326e4so184854f8f.1
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702718481; x=1703323281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeroNPveGj5Bm2udwZDTevUQG0N97sSTVVrllokPwjc=;
        b=yqbNzSrS21P9Ry5XHNZIkTJx9djNCfU357tJMhI819qJSnf0xiZ6ZLIRIqV3TPvtFS
         vIk54zWjlR1wFee4+igjRAz3k7+3Yvk4d7fBHPkfv16Wa47HIiD9s6npHJFtcxIDMqo7
         kYhqBr05jRFowdWnDrIoLibug4vsWq+2XoFkjnocykfXVStzO8hycFwZBI/h6a8n7MTZ
         ODhGZABw5aIq4hYQtWIUWp38gOOw0ZHS2nztpJ8WjFUUz7TJPKj4eXIFLiuWoNjG3qea
         DZyZ6fNwz1i1rudgO1rK4HQDjsABJws+Ggu36pmzq+pSpuDSwoVvSdCzv1gE48zfwX1o
         UJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702718481; x=1703323281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeroNPveGj5Bm2udwZDTevUQG0N97sSTVVrllokPwjc=;
        b=w1C0CjTgpTIN1oC7gFUusvBsLGkNtxkdLViCOCyCqaVDdHnPHza7yb6GyOhVo1Awp+
         RYP70zu1bs879SNoLBTsOfPid9ItuLp5N1Z6ezb/ElcnVD+0Xu3a/8QVmNHni9UWy2Hl
         lnUJ+BKfs74S+/TLORBqhHF2/TOy01ubhcNUDHtsrYsdPPJUleYcU4951e2sn09Zbmi/
         03HwtCX+VEFXqNQ+y/PGe0IHEUKK/VQ1TxkdFYtCUfZOFZ2RPdWUMMCe0Od5JSrEYala
         9lvJGh3pbeW2aPf8m3PBCv27el1mHmcmZn/6Lp9u3G19foBtQmbVsszUf98gPzcvqUua
         edpA==
X-Gm-Message-State: AOJu0YwTRlu4ZvtLyWN6oKvmiyhKWq9k+OdHkw9JXv/tJ+b+lesugvA2
	AY0Nm6oO+FXHKhr0tNInGP0NSA==
X-Google-Smtp-Source: AGHT+IE9Ovr8tywpdG6E9H9Xv8tuxOGm+0GoKDdqzOfKttFbJDS5MO9PSwKgauo0JGjbgfh9ScRS4A==
X-Received: by 2002:a05:6000:8c:b0:333:4b44:c9f0 with SMTP id m12-20020a056000008c00b003334b44c9f0mr7100218wrx.84.1702718481027;
        Sat, 16 Dec 2023 01:21:21 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4d01000000b003365aa39d30sm2531490wrt.11.2023.12.16.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 01:21:20 -0800 (PST)
Date: Sat, 16 Dec 2023 10:21:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZX1sD3Eki_NQ0kC7@nanopsycho>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-2-dw@davidwei.uk>
 <ZXw0dWbPKs1e_2eJ@nanopsycho>
 <1cbbc046-3b41-4518-95f3-9a4d2315ff92@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbbc046-3b41-4518-95f3-9a4d2315ff92@davidwei.uk>

Fri, Dec 15, 2023 at 08:13:45PM CET, dw@davidwei.uk wrote:
>On 2023-12-15 03:11, Jiri Pirko wrote:
>> Thu, Dec 14, 2023 at 10:24:40PM CET, dw@davidwei.uk wrote:
>>> Add a debugfs file in
>>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>>
>>> Writing "M B" to this file will link port A of netdevsim N with port B of
>>> netdevsim M.
>>>
>>> Reading this file will return the linked netdevsim id and port, if any.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/bus.c       | 17 ++++++
>>> drivers/net/netdevsim/dev.c       | 88 +++++++++++++++++++++++++++++++
>>> drivers/net/netdevsim/netdev.c    |  6 +++
>>> drivers/net/netdevsim/netdevsim.h |  3 ++
>>> 4 files changed, 114 insertions(+)
>>>
>>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>>> index bcbc1e19edde..1ef95661a3f5 100644
>>> --- a/drivers/net/netdevsim/bus.c
>>> +++ b/drivers/net/netdevsim/bus.c
>>> @@ -323,6 +323,23 @@ static struct device_driver nsim_driver = {
>>> 	.owner		= THIS_MODULE,
>>> };
>>>
>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
>> 
>> This sounds definitelly incorrect. You should not need to touch bus.c
>> code. It arranges the bus and devices on it. The fact that a device is
>> probed or not is parallel to this.
>> 
>> I think you need to maintain a separate list/xarray of netdevsim devices
>> probed by nsim_drv_probe()
>
>There is a 1:1 relationship between bus devices (nsim_bus_dev) and nsim devices

Of course it is not. I thought I exaplained that. If you unbind (or not
bind at all), it is still in this list, however not probed.


>(nsim_dev). Adding a separate list for nsim devices seemed redundant to me when
>there is already a list for bus devices.

Again, please don't call into bus.c here.


>
>> 
>> 
>>> +{
>>> +	struct nsim_bus_dev *nsim_bus_dev;
>>> +
>>> +	mutex_lock(&nsim_bus_dev_list_lock);
>>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>>> +		if (nsim_bus_dev->dev.id == id) {
>>> +			get_device(&nsim_bus_dev->dev);
>>> +			mutex_unlock(&nsim_bus_dev_list_lock);
>>> +			return nsim_bus_dev;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&nsim_bus_dev_list_lock);
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> int nsim_bus_init(void)
>>> {
>>> 	int err;
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index b4d3b9cde8bd..034145ba1861 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -388,6 +388,91 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>>> 	.owner = THIS_MODULE,
>>> };
>>>
>>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>>> +				  size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port;
>>> +	struct netdevsim *peer;
>>> +	unsigned int id, port;
>>> +	char buf[23];
>>> +	ssize_t len;
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
>>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>>> +
>>> +	rcu_read_unlock();
>>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>>> +}
>>> +
>>> +static ssize_t nsim_dev_peer_write(struct file *file,
>>> +				   const char __user *data,
>>> +				   size_t count, loff_t *ppos)
>>> +{
>>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>>> +	struct nsim_bus_dev *peer_bus_dev;
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
>>> +		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* invalid netdevsim id */
>>> +	peer_bus_dev = nsim_bus_dev_get(id);
>>> +	if (!peer_bus_dev)
>>> +		return -EINVAL;
>>> +
>>> +	ret = -EINVAL;
>>> +	/* cannot link to self */
>>> +	nsim_dev_port = file->private_data;
>>> +	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
>>> +	    nsim_dev_port->port_index == port)
>>> +		goto out;
>>> +
>>> +	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
>> 
>> Again, no bus touching should be needed. (btw, this could be null is dev
>> is not probed)
>
>That's fair, I can do a null check.
>
>> 
>> 
>>> +	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>>> +		if (peer_dev_port->port_index != port)
>>> +			continue;
>>> +		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>>> +		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>> 
>> What is stopping another cpu from setting different peer for the same
>> port here, making a mess?
>
>Looking into RCU a bit more, you're right that it does not protect from
>multiple writers. Would adding a lock (spinlock?) to nsim_dev and taking that
>be sufficient here?
>
>Or what if I took rtnl_lock()?

You have multiple choices how to handle this.

>
>> 
>> 
>>> +		ret = count;
>>> +		goto out;
>>> +	}
>>> +
>>> +out:
>>> +	put_device(&peer_bus_dev->dev);
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
>>> @@ -418,6 +503,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 	}
>>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>>
>>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>>> +
>>> 	return 0;
>>> }
>>>
>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>> index aecaf5f44374..e290c54b0e70 100644
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
>>> @@ -407,9 +408,14 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>> void nsim_destroy(struct netdevsim *ns)
>>> {
>>> 	struct net_device *dev = ns->netdev;
>>> +	struct netdevsim *peer;
>>>
>>> 	rtnl_lock();
>>> +	peer = rtnl_dereference(ns->peer);
>>> +	RCU_INIT_POINTER(ns->peer, NULL);
>>> 	unregister_netdevice(dev);
>>> +	if (peer)
>>> +		RCU_INIT_POINTER(peer->peer, NULL);
>> 
>> What is stopping the another CPU from setting this back to this "ns"?
>> Or what is stopping another netdevsim port from setting this ns while
>> going away?
>> 
>> Do you rely on RTNL_LOCK in any way (other then synchronize_net() in
>> unlock())? If yes, looks wrong.
>> 
>> This ns->peer update locking looks very broken to me :/
>
>As above, would a spinlock on nsim_dev or taking rtnl_lock() in
>nsim_dev_peer_write() resolve this?
>
>> 
>> 
>> 
>> 
>>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>>> 		nsim_macsec_teardown(ns);
>>> 		nsim_ipsec_teardown(ns);
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index 028c825b86db..61ac3a80cf9a 100644
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
>>> @@ -415,5 +416,7 @@ struct nsim_bus_dev {
>>> 	bool init;
>>> };
>>>
>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>>> +
>>> int nsim_bus_init(void);
>>> void nsim_bus_exit(void);
>>> -- 
>>> 2.39.3
>>>

