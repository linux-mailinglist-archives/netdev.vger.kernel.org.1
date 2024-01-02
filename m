Return-Path: <netdev+bounces-60835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC66821A92
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0908E28127D
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80569D52D;
	Tue,  2 Jan 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mF0mJ25N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC8DDA6
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so52571305e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704192982; x=1704797782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRrRZgqarPJfdbWhxUGk0YMe7Fj5ruf3jZZeuvYqNGY=;
        b=mF0mJ25NyK8Fp5dIbo7uO682iFZL2b2jb2NA/jeEzOFWg7zYJ8uXHJQyEeXVorP0Oc
         Qbt23+1/OCt6eKTkkaXIlCU1bHGSIAYeNpy3c30LofO/tqOM+9G9FpLNLOCOD+qJpGN3
         uBsn+8MKlmo2Bc77HxT/rDnz5z/gLlOWOrxCNY4DUB09vFp1vNGVvSMPYjx0w3RDDtLg
         tOzmS2wm7aOpCw40dmaJfM3cXMtmI4P+xAHbZGM2QWX+wVvTa6yJjgKNQBxRSsPlX+sE
         6Ss8CxtzVU/sGJV+VhPgdUSiGW/IB/rIUQY2jBAYn7VggrlK1Vqqp75f/WxsZp/I7wLg
         NF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192982; x=1704797782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRrRZgqarPJfdbWhxUGk0YMe7Fj5ruf3jZZeuvYqNGY=;
        b=JFafvlv68jHNP2jXENZ4FEZLlrxebM++Naf5Hkg/jw5wns8teuj/2LVwJ77xz8Fsjh
         gibI3ALRxwRsuPVWuhFUk1go3og0W1GS+362JItoqCbIYj/zcs2YmaEPckAc8+bONlPa
         HjpCcWR4tVXQL9Bitvw7LXDhbo1gQgfw7I+e3NvpfQ+haD+KIbfjp0uaTmN5p1AIlCx9
         dFPiJwcyx75ww7cCnrTo6Y3mDDXN+50Bar+lS8APUEyuzsVVgel/DLckvWvcqyLZtfhJ
         BEhQkXOPgB4FwGclSDM3k6OEvBDPAxnEf5p+cBfqzRXk0gG2fJoIA+VOft5DUqcaO6M+
         H5QQ==
X-Gm-Message-State: AOJu0YwOVFLMlv3igUun3VNPYL7TsKQ3Noi3w3JwV3F6W4WH1sgiZu7r
	UvEPb8lcLOlUZLe+IVNvYRZW07Y3n5CBCg==
X-Google-Smtp-Source: AGHT+IHs//xrwEt/GnM4n/jin236wh3k9yWrQwjUSaN+8ZLvx+0C+bEWaPkgWCISVaYGOzu2AHd4dg==
X-Received: by 2002:a05:600c:63d9:b0:40d:590c:eb05 with SMTP id dx25-20020a05600c63d900b0040d590ceb05mr6226716wmb.49.1704192982226;
        Tue, 02 Jan 2024 02:56:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d6744000000b00336710ddea0sm28160059wrw.59.2024.01.02.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:56:21 -0800 (PST)
Date: Tue, 2 Jan 2024 11:56:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZZPr1HJ8Yt8SOi-R@nanopsycho>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-3-dw@davidwei.uk>
 <ZYKvMxvEkE3Kq425@nanopsycho>
 <df202c29-a9e0-4806-a30c-8d20453bf397@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df202c29-a9e0-4806-a30c-8d20453bf397@davidwei.uk>

Fri, Dec 22, 2023 at 01:47:59AM CET, dw@davidwei.uk wrote:
>On 2023-12-20 01:09, Jiri Pirko wrote:
>> Wed, Dec 20, 2023 at 02:47:44AM CET, dw@davidwei.uk wrote:
>>> Add a debugfs file in
>>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>>
>>> Writing "M B" to this file will link port A of netdevsim N with port B
>>> of netdevsim M. Reading this file will return the linked netdevsim id
>>> and port, if any.
>>>
>>> nsim_dev_list_lock and rtnl_lock are held during read/write of peer to
>>> prevent concurrent modification of netdevsims or their ports.
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/dev.c       | 127 +++++++++++++++++++++++++++---
>>> drivers/net/netdevsim/netdev.c    |   6 ++
>>> drivers/net/netdevsim/netdevsim.h |   1 +
>>> 3 files changed, 121 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index e30a12130e07..e4621861c70b 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -391,6 +391,117 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
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
>>> +	char buf[23];
>>> +	ssize_t ret;
>>> +
>>> +	mutex_lock(&nsim_dev_list_lock);
>>> +	rtnl_lock();
>>> +	nsim_dev_port = file->private_data;
>>> +	peer = rtnl_dereference(nsim_dev_port->ns->peer);
>>> +	if (!peer)
>>> +		goto out;
>>> +
>>> +	id = peer->nsim_bus_dev->dev.id;
>>> +	port = peer->nsim_dev_port->port_index;
>>> +	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>>> +	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>>> +
>>> +out:
>>> +	rtnl_unlock();
>>> +	mutex_unlock(&nsim_dev_list_lock);
>>> +
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
>>> +		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = -EINVAL;
>>> +	mutex_lock(&nsim_dev_list_lock);
>>> +	rtnl_lock();
>>> +	peer_dev = nsim_dev_find_by_id(id);
>>> +	if (!peer_dev)
>>> +		goto out;
>> 
>> Tell the user what's wrong please.
>
>Okay.
>
>> 
>>> +
>>> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>>> +					       port);
>>> +	if (!peer_dev_port)
>>> +		goto out;
>> 
>> Tell the user what's wrong please.
>
>Ditto.
>
>> 
>> 
>>> +
>>> +	nsim_dev_port = file->private_data;
>>> +	if (nsim_dev_port == peer_dev_port)
>> 
>> Why fail here? IDK, success sounds better to me.
>
>I don't want to link a port to itself. In my mental model a port is e.g.
>a port on a switch. It doesn't make sense to connect it to itself.

Okay, I misread.


>
>> 
>> 
>>> +		goto out;
>>> +
>>> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>>> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>>> +	ret = count;
>>> +
>>> +out:
>>> +	rtnl_unlock();
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
>>> @@ -421,6 +532,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>>> 	}
>>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>>
>>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>>> +
>>> 	return 0;
>>> }
>>>
>>> @@ -1702,19 +1816,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
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

