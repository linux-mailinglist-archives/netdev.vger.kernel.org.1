Return-Path: <netdev+bounces-58298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9AE815BC3
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A57B1C215F9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE41E48F;
	Sat, 16 Dec 2023 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ddXFpbf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203BA34542
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3a64698b3so2501525ad.0
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702759954; x=1703364754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eR4jAfCyy7cK0cs43QLfZ7CGd0uEz7tHN3E3H3Zsuo=;
        b=ddXFpbf6nzE39d0TyVwUZt85wCyXDxVpCCkH8UB516DQzFTRn/XSJznJpD9JF7CgTa
         a/HOcJQoBa7RW+v8LljpA54muePal5yG8+d6s+aj/lc0bu7Kfw5DgWmL49QhGosro8aW
         Ahyn6w13/HaESRsAfpZ84KjkwynmgaeE1zfA1bXiFRiSXPZN+WT827NtiuLooh+D+vXA
         7UFVyLHG6EgUOGLwNJQ+j8hIAoK2dPML75hEDnW/Lb28OuSWjErpEcDf6CZxMKHRZ+R2
         1lA3oLBKzGbM+JqFhxDzq5SnK840Yx2OnqY0nACKZL/wUDtsA1OY1yfJ0KQZOsYZQ3P3
         ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759954; x=1703364754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eR4jAfCyy7cK0cs43QLfZ7CGd0uEz7tHN3E3H3Zsuo=;
        b=ggx9eN+GbNOQ8zGgdy7HN2ZdVcvecH8yVJGXXpjd38keEmAlZ3rxZSletIWQ+xNnc/
         KpAOZwv6rhWH4m+15rkxMQVcfKIPEMQY7LM9lAIqaQHGkLWaAWqD0JHgjT6JS6b7tHFQ
         JZWlnHKQ1EQBomXnglE5VYQqtn1TsIFjVLx2FpnfU0HyRUF3cjBdHSzQAEbp8eFwtJ3I
         TmIsBt9GDMz64lOdBwX8nsP8p0X/CEd86xtYlEtXeOXeoP1NyjUB9AA+cjJHCGP+mOWR
         sXpscPmUfgEzz+cNURNUFVQEUFrCTUe6uQXe8NdhVK2mIybdsTHg6+wlFppQ/w1M4jrA
         bFmw==
X-Gm-Message-State: AOJu0Yzw5DeRrok7+OPo8tKw+mumvfZsAZxHkpluVZbdR28CRcM9Q59x
	rcQl4274PQv2uTZ0Gc7wrjKGYA==
X-Google-Smtp-Source: AGHT+IEhoMofyutEXa1odG9+/wGvNh12/6CFSpvD3SZfwJASrVtTye6lByb9UuvS9bl+XTYXX+D46A==
X-Received: by 2002:a17:903:11c7:b0:1d0:b9f4:800f with SMTP id q7-20020a17090311c700b001d0b9f4800fmr15484035plh.109.1702759954312;
        Sat, 16 Dec 2023 12:52:34 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:2103:835:39e6:facb:229b? ([2620:10d:c090:400::4:4cf3])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b001d07ebef623sm1870880pla.69.2023.12.16.12.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 12:52:33 -0800 (PST)
Message-ID: <428eae59-83f1-4937-b376-0167521f107f@davidwei.uk>
Date: Sat, 16 Dec 2023 12:52:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] netdevsim: allow two netdevsim ports to
 be connected
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-2-dw@davidwei.uk> <ZXw0dWbPKs1e_2eJ@nanopsycho>
 <1cbbc046-3b41-4518-95f3-9a4d2315ff92@davidwei.uk>
 <ZX1sD3Eki_NQ0kC7@nanopsycho>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZX1sD3Eki_NQ0kC7@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-16 01:21, Jiri Pirko wrote:
> Fri, Dec 15, 2023 at 08:13:45PM CET, dw@davidwei.uk wrote:
>> On 2023-12-15 03:11, Jiri Pirko wrote:
>>> Thu, Dec 14, 2023 at 10:24:40PM CET, dw@davidwei.uk wrote:
>>>> Add a debugfs file in
>>>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>>>
>>>> Writing "M B" to this file will link port A of netdevsim N with port B of
>>>> netdevsim M.
>>>>
>>>> Reading this file will return the linked netdevsim id and port, if any.
>>>>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>> drivers/net/netdevsim/bus.c       | 17 ++++++
>>>> drivers/net/netdevsim/dev.c       | 88 +++++++++++++++++++++++++++++++
>>>> drivers/net/netdevsim/netdev.c    |  6 +++
>>>> drivers/net/netdevsim/netdevsim.h |  3 ++
>>>> 4 files changed, 114 insertions(+)
>>>>
>>>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>>>> index bcbc1e19edde..1ef95661a3f5 100644
>>>> --- a/drivers/net/netdevsim/bus.c
>>>> +++ b/drivers/net/netdevsim/bus.c
>>>> @@ -323,6 +323,23 @@ static struct device_driver nsim_driver = {
>>>> 	.owner		= THIS_MODULE,
>>>> };
>>>>
>>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
>>>
>>> This sounds definitelly incorrect. You should not need to touch bus.c
>>> code. It arranges the bus and devices on it. The fact that a device is
>>> probed or not is parallel to this.
>>>
>>> I think you need to maintain a separate list/xarray of netdevsim devices
>>> probed by nsim_drv_probe()
>>
>> There is a 1:1 relationship between bus devices (nsim_bus_dev) and nsim devices
> 
> Of course it is not. I thought I exaplained that. If you unbind (or not
> bind at all), it is still in this list, however not probed.

Right, I understand now thanks. The 1:1 relationship is initially true, but
devices can be removed by unbinding their drivers. I tried manually unbinding
using /sys/bus/netdevsim/drivers/netdevsim/unbind which removes a device but
keeps the bus device.

The current implementation is not resilient to this and I can trigger crashes
e.g. by unbinding then trying to add a port.

> 
> 
>> (nsim_dev). Adding a separate list for nsim devices seemed redundant to me when
>> there is already a list for bus devices.
> 
> Again, please don't call into bus.c here.

Got it, I will maintain a separate list of bound devices.

> 
> 
>>
>>>
>>>
>>>> +{
>>>> +	struct nsim_bus_dev *nsim_bus_dev;
>>>> +
>>>> +	mutex_lock(&nsim_bus_dev_list_lock);
>>>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>>>> +		if (nsim_bus_dev->dev.id == id) {
>>>> +			get_device(&nsim_bus_dev->dev);
>>>> +			mutex_unlock(&nsim_bus_dev_list_lock);
>>>> +			return nsim_bus_dev;
>>>> +		}
>>>> +	}
>>>> +	mutex_unlock(&nsim_bus_dev_list_lock);
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> int nsim_bus_init(void)
>>>> {
>>>> 	int err;
>>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>>> index b4d3b9cde8bd..034145ba1861 100644
>>>> --- a/drivers/net/netdevsim/dev.c
>>>> +++ b/drivers/net/netdevsim/dev.c
>>>> @@ -388,6 +388,91 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>>>> 	.owner = THIS_MODULE,
>>>> };
>>>>
>>>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>>>> +				  size_t count, loff_t *ppos)
>>>> +{
>>>> +	struct nsim_dev_port *nsim_dev_port;
>>>> +	struct netdevsim *peer;
>>>> +	unsigned int id, port;
>>>> +	char buf[23];
>>>> +	ssize_t len;
>>>> +
>>>> +	nsim_dev_port = file->private_data;
>>>> +	rcu_read_lock();
>>>> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
>>>> +	if (!peer) {
>>>> +		rcu_read_unlock();
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	id = peer->nsim_bus_dev->dev.id;
>>>> +	port = peer->nsim_dev_port->port_index;
>>>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>>>> +
>>>> +	rcu_read_unlock();
>>>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>>>> +}
>>>> +
>>>> +static ssize_t nsim_dev_peer_write(struct file *file,
>>>> +				   const char __user *data,
>>>> +				   size_t count, loff_t *ppos)
>>>> +{
>>>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>>>> +	struct nsim_bus_dev *peer_bus_dev;
>>>> +	struct nsim_dev *peer_dev;
>>>> +	unsigned int id, port;
>>>> +	char buf[22];
>>>> +	ssize_t ret;
>>>> +
>>>> +	if (count >= sizeof(buf))
>>>> +		return -ENOSPC;
>>>> +
>>>> +	ret = copy_from_user(buf, data, count);
>>>> +	if (ret)
>>>> +		return -EFAULT;
>>>> +	buf[count] = '\0';
>>>> +
>>>> +	ret = sscanf(buf, "%u %u", &id, &port);
>>>> +	if (ret != 2) {
>>>> +		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* invalid netdevsim id */
>>>> +	peer_bus_dev = nsim_bus_dev_get(id);
>>>> +	if (!peer_bus_dev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = -EINVAL;
>>>> +	/* cannot link to self */
>>>> +	nsim_dev_port = file->private_data;
>>>> +	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
>>>> +	    nsim_dev_port->port_index == port)
>>>> +		goto out;
>>>> +
>>>> +	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
>>>
>>> Again, no bus touching should be needed. (btw, this could be null is dev
>>> is not probed)
>>
>> That's fair, I can do a null check.
>>
>>>
>>>
>>>> +	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>>>> +		if (peer_dev_port->port_index != port)
>>>> +			continue;
>>>> +		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>>>> +		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>>>
>>> What is stopping another cpu from setting different peer for the same
>>> port here, making a mess?
>>
>> Looking into RCU a bit more, you're right that it does not protect from
>> multiple writers. Would adding a lock (spinlock?) to nsim_dev and taking that
>> be sufficient here?
>>
>> Or what if I took rtnl_lock()?
> 
> You have multiple choices how to handle this.

I'll start with a spinlock but it would be good to know what the 'best' option
is in this case. I don't have a well calibrated sense for it yet.

> 
>>
>>>
>>>
>>>> +		ret = count;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +out:
>>>> +	put_device(&peer_bus_dev->dev);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct file_operations nsim_dev_peer_fops = {
>>>> +	.open = simple_open,
>>>> +	.read = nsim_dev_peer_read,
>>>> +	.write = nsim_dev_peer_write,
>>>> +	.llseek = generic_file_llseek,
>>>> +	.owner = THIS_MODULE,
>>>> +};
>>>> +
>>>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>>> 				      struct nsim_dev_port *nsim_dev_port)
>>>> {
>>>> @@ -418,6 +503,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>>> 	}
>>>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>>>
>>>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>>>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>>>> +
>>>> 	return 0;
>>>> }
>>>>
>>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>> index aecaf5f44374..e290c54b0e70 100644
>>>> --- a/drivers/net/netdevsim/netdev.c
>>>> +++ b/drivers/net/netdevsim/netdev.c
>>>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>>> 	ns->nsim_dev = nsim_dev;
>>>> 	ns->nsim_dev_port = nsim_dev_port;
>>>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>>>> +	RCU_INIT_POINTER(ns->peer, NULL);
>>>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>>>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>>>> 	nsim_ethtool_init(ns);
>>>> @@ -407,9 +408,14 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>>>> void nsim_destroy(struct netdevsim *ns)
>>>> {
>>>> 	struct net_device *dev = ns->netdev;
>>>> +	struct netdevsim *peer;
>>>>
>>>> 	rtnl_lock();
>>>> +	peer = rtnl_dereference(ns->peer);
>>>> +	RCU_INIT_POINTER(ns->peer, NULL);
>>>> 	unregister_netdevice(dev);
>>>> +	if (peer)
>>>> +		RCU_INIT_POINTER(peer->peer, NULL);
>>>
>>> What is stopping the another CPU from setting this back to this "ns"?
>>> Or what is stopping another netdevsim port from setting this ns while
>>> going away?
>>>
>>> Do you rely on RTNL_LOCK in any way (other then synchronize_net() in
>>> unlock())? If yes, looks wrong.
>>>
>>> This ns->peer update locking looks very broken to me :/
>>
>> As above, would a spinlock on nsim_dev or taking rtnl_lock() in
>> nsim_dev_peer_write() resolve this?
>>
>>>
>>>
>>>
>>>
>>>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>>>> 		nsim_macsec_teardown(ns);
>>>> 		nsim_ipsec_teardown(ns);
>>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>>> index 028c825b86db..61ac3a80cf9a 100644
>>>> --- a/drivers/net/netdevsim/netdevsim.h
>>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>>> @@ -125,6 +125,7 @@ struct netdevsim {
>>>> 	} udp_ports;
>>>>
>>>> 	struct nsim_ethtool ethtool;
>>>> +	struct netdevsim __rcu *peer;
>>>> };
>>>>
>>>> struct netdevsim *
>>>> @@ -415,5 +416,7 @@ struct nsim_bus_dev {
>>>> 	bool init;
>>>> };
>>>>
>>>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>>>> +
>>>> int nsim_bus_init(void);
>>>> void nsim_bus_exit(void);
>>>> -- 
>>>> 2.39.3
>>>>

