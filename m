Return-Path: <netdev+bounces-59181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CA819B1E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5293287AC5
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74FF1D120;
	Wed, 20 Dec 2023 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vpaqhjjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C24200AA
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so972380a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1703063349; x=1703668149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=111mLLL+e37UU70n8NtioOWpOt8EWktl/mHF8Nys/y0=;
        b=Vpaqhjjnem+M6URxU6IU3gjsTAjVCguCqhZLe5km38zatsnm6Yqf8otvAqUehZOQ7x
         LbxbRrPKzVtV0WW1FZ2hPGjJbQWHKQcjivNMsa6AIquTxQAuYXmnsScxeWyBMC1/cuQw
         h+GdPzZy05Z6QtprRnRCy9oO5Pf2jlpmKfUg9BFYh1sq+bQhJlKUvVRcgD2D7F2tia9u
         16Z9JrJICa68kgqd/82M12mKJpY/GG0N0ypdc8I+XRCNwPfZQvqlwJZELjhzzm0KH68x
         mhr7xNUjq7ZhDzxGu+0jNxb+MiGJXuI231zq1dnfIm7gvfiZXGaTET9cCZbHMrfwad0J
         5akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063349; x=1703668149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=111mLLL+e37UU70n8NtioOWpOt8EWktl/mHF8Nys/y0=;
        b=XbF83sXOP2IK7bQQ2NMYVy+ZwKC3ncuqQYdHSkI63/i62mgAj+bz7CsTpFVLfUGD7U
         huHmdl8kCMG4Zu9rZEgPJeGh2NZ1yO3W+WAUt4ZorMKMfrCibB18ByGQ/bp1X0UQNqwo
         /IupbvuauG5aOYDyAKaZiWnW+X/m5ejQ1ZbnK4Qj9uuslELtunavCp69Wy0CPNCvaQGn
         bBWH4SHlD0uQ4lwLNNvBZRj8VfSSK6gnFag78rrBEu4so6OyWnOxXBlpf/8MGKSxqwKC
         RJGYWJ0l10h97pjXxiIPJ1Cr3BBkToPWU866tZ/eali2S9Bs4+SOntDPJOeCCC1D3LQa
         OO5A==
X-Gm-Message-State: AOJu0YzZIHFoUUgk9dPoIp6opFKz1pszDctljapdEee+NaWHcM3vs2N0
	tiPCmA9I7TRS2XMd+5eClx30sA==
X-Google-Smtp-Source: AGHT+IEIe4NGGj73KAysNO/5dQKSg0v2T1kEWeRsA6ZP/ihhHlc0ncXY4ZQBPRDsN4N3GD2vXUb3NQ==
X-Received: by 2002:a50:d698:0:b0:54c:bb9c:4b88 with SMTP id r24-20020a50d698000000b0054cbb9c4b88mr2564425edi.5.1703063348906;
        Wed, 20 Dec 2023 01:09:08 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id dj13-20020a05640231ad00b00553830eb2fcsm1917168edb.64.2023.12.20.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:09:08 -0800 (PST)
Date: Wed, 20 Dec 2023 10:09:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZYKvMxvEkE3Kq425@nanopsycho>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220014747.1508581-3-dw@davidwei.uk>

Wed, Dec 20, 2023 at 02:47:44AM CET, dw@davidwei.uk wrote:
>Add a debugfs file in
>/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>
>Writing "M B" to this file will link port A of netdevsim N with port B
>of netdevsim M. Reading this file will return the linked netdevsim id
>and port, if any.
>
>nsim_dev_list_lock and rtnl_lock are held during read/write of peer to
>prevent concurrent modification of netdevsims or their ports.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/dev.c       | 127 +++++++++++++++++++++++++++---
> drivers/net/netdevsim/netdev.c    |   6 ++
> drivers/net/netdevsim/netdevsim.h |   1 +
> 3 files changed, 121 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index e30a12130e07..e4621861c70b 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -391,6 +391,117 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
> 	.owner = THIS_MODULE,
> };
> 
>+static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
>+{
>+	struct nsim_dev *dev;
>+
>+	list_for_each_entry(dev, &nsim_dev_list, list)
>+		if (dev->nsim_bus_dev->dev.id == id)
>+			return dev;
>+
>+	return NULL;
>+}
>+
>+static struct nsim_dev_port *
>+__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>+		       unsigned int port_index)
>+{
>+	struct nsim_dev_port *nsim_dev_port;
>+
>+	port_index = nsim_dev_port_index(type, port_index);
>+	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>+		if (nsim_dev_port->port_index == port_index)
>+			return nsim_dev_port;
>+	return NULL;
>+}
>+
>+static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>+				  size_t count, loff_t *ppos)
>+{
>+	struct nsim_dev_port *nsim_dev_port;
>+	struct netdevsim *peer;
>+	unsigned int id, port;
>+	char buf[23];
>+	ssize_t ret;
>+
>+	mutex_lock(&nsim_dev_list_lock);
>+	rtnl_lock();
>+	nsim_dev_port = file->private_data;
>+	peer = rtnl_dereference(nsim_dev_port->ns->peer);
>+	if (!peer)
>+		goto out;
>+
>+	id = peer->nsim_bus_dev->dev.id;
>+	port = peer->nsim_dev_port->port_index;
>+	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>+	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>+
>+out:
>+	rtnl_unlock();
>+	mutex_unlock(&nsim_dev_list_lock);
>+
>+	return ret;
>+}
>+
>+static ssize_t nsim_dev_peer_write(struct file *file,
>+				   const char __user *data,
>+				   size_t count, loff_t *ppos)
>+{
>+	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>+	struct nsim_dev *peer_dev;
>+	unsigned int id, port;
>+	char buf[22];
>+	ssize_t ret;
>+
>+	if (count >= sizeof(buf))
>+		return -ENOSPC;
>+
>+	ret = copy_from_user(buf, data, count);
>+	if (ret)
>+		return -EFAULT;
>+	buf[count] = '\0';
>+
>+	ret = sscanf(buf, "%u %u", &id, &port);
>+	if (ret != 2) {
>+		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>+		return -EINVAL;
>+	}
>+
>+	ret = -EINVAL;
>+	mutex_lock(&nsim_dev_list_lock);
>+	rtnl_lock();
>+	peer_dev = nsim_dev_find_by_id(id);
>+	if (!peer_dev)
>+		goto out;

Tell the user what's wrong please.

>+
>+	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>+					       port);
>+	if (!peer_dev_port)
>+		goto out;

Tell the user what's wrong please.


>+
>+	nsim_dev_port = file->private_data;
>+	if (nsim_dev_port == peer_dev_port)

Why fail here? IDK, success sounds better to me.


>+		goto out;
>+
>+	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>+	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>+	ret = count;
>+
>+out:
>+	rtnl_unlock();
>+	mutex_unlock(&nsim_dev_list_lock);
>+
>+	return ret;
>+}
>+
>+static const struct file_operations nsim_dev_peer_fops = {
>+	.open = simple_open,
>+	.read = nsim_dev_peer_read,
>+	.write = nsim_dev_peer_write,
>+	.llseek = generic_file_llseek,
>+	.owner = THIS_MODULE,
>+};
>+
> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
> 				      struct nsim_dev_port *nsim_dev_port)
> {
>@@ -421,6 +532,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
> 	}
> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
> 
>+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>+			    nsim_dev_port, &nsim_dev_peer_fops);
>+
> 	return 0;
> }
> 
>@@ -1702,19 +1816,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
> }
> 
>-static struct nsim_dev_port *
>-__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>-		       unsigned int port_index)
>-{
>-	struct nsim_dev_port *nsim_dev_port;
>-
>-	port_index = nsim_dev_port_index(type, port_index);
>-	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>-		if (nsim_dev_port->port_index == port_index)
>-			return nsim_dev_port;
>-	return NULL;
>-}
>-
> int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
> 		      unsigned int port_index)
> {
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index aecaf5f44374..434322f6a565 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
> 	ns->nsim_dev = nsim_dev;
> 	ns->nsim_dev_port = nsim_dev_port;
> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>+	RCU_INIT_POINTER(ns->peer, NULL);
> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
> 	nsim_ethtool_init(ns);
>@@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
> void nsim_destroy(struct netdevsim *ns)
> {
> 	struct net_device *dev = ns->netdev;
>+	struct netdevsim *peer;
> 
> 	rtnl_lock();
>+	peer = rtnl_dereference(ns->peer);
>+	if (peer)
>+		RCU_INIT_POINTER(peer->peer, NULL);
>+	RCU_INIT_POINTER(ns->peer, NULL);
> 	unregister_netdevice(dev);
> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
> 		nsim_macsec_teardown(ns);
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index babb61d7790b..24fc3fbda791 100644
>--- a/drivers/net/netdevsim/netdevsim.h
>+++ b/drivers/net/netdevsim/netdevsim.h
>@@ -125,6 +125,7 @@ struct netdevsim {
> 	} udp_ports;
> 
> 	struct nsim_ethtool ethtool;
>+	struct netdevsim __rcu *peer;
> };
> 
> struct netdevsim *
>-- 
>2.39.3
>

