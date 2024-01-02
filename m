Return-Path: <netdev+bounces-60844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DB821AB0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83B4282CEF
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E6DDC3;
	Tue,  2 Jan 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ppmo64iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8032DDBA
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33678156e27so8618865f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 03:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704193875; x=1704798675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=060tGdntFULaXA5XhHA32T9m9MMx8Mcb3tE7dF1ZQjA=;
        b=ppmo64iACUa1rvBdCwfOiLwMP/Rtd+3rUG3IXO4Pb/Yf6YlgAVgQ7QDKU+Nfev+MMw
         ms0sX7AQAAQgiT6PS+boaUFr1WrX7367R+sK7iY0YrVAsbrklIdT8u3VU8is5Q/Gw5yR
         EoRhJfbA9iC48rQOj9i5dZ/yHnoo0q2UX2Xdh/tRVsWmRGwea9pcvr5ElDbkPqNi7XXI
         fWQeUR9DW49RTxUDXwVLbvxLyx7a6RDVbkf+iDkhqHn1rc8syabomZpRRiiTaF/1Y/Wy
         H2btKanGhIcD/vFyLDKde/jD3ZEOhh5gf8wWiOI+oQKWuo9SioIlQI+/aITRsyQ+bqDa
         VnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704193875; x=1704798675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=060tGdntFULaXA5XhHA32T9m9MMx8Mcb3tE7dF1ZQjA=;
        b=lQIGU34Cy3BQOytYh3xVCl+4swK+DmTtBnjyteCAsYDBHnek5Qd/fCJNUwlOekyru6
         ZYedfB9ORPP1NpiRXulwvB853o/TCjfkIxCyta4SNK0SN7/E0KpsH7wuVXgpVMZOIQnf
         bKtz/3hXKo50uaUO46F/bZQWu7niZyZD+0nOahrhLGbrBeqA/wlmff+hMQVwfmgi/2dJ
         avNUwVNVP6OqHfClgnELapt0sbJjeSXjV7bDXLXYQ9hyNj9Mhm77GpnwHk7FRVeBhOTd
         spK9VFAiC2uMOmfHMShW/XOos8TRQ0PLhGqx+fDS2y6nfXIajrb/+BZl248O20mZIdUs
         lg3A==
X-Gm-Message-State: AOJu0YxVz0Xzeuqe4mcx7ufCCG4265GgSKi8fumBqOY3oIkgIisb6iDs
	U8uwqtSrbAEDfUQmHVUWyqwqsI724P2nqQ==
X-Google-Smtp-Source: AGHT+IEvc5w/lScCIkXd0+M0dPEK5iiDXVn0YjLfv6vXqdkxFroJlnZFeJV4DyBY7T+Xdc4fFZmp2A==
X-Received: by 2002:adf:eb4d:0:b0:337:33a:c86a with SMTP id u13-20020adfeb4d000000b00337033ac86amr5187567wrn.46.1704193874706;
        Tue, 02 Jan 2024 03:11:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b0033725783839sm10019056wrr.110.2024.01.02.03.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:11:06 -0800 (PST)
Date: Tue, 2 Jan 2024 12:11:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZZPvST-nAaBMPKet@nanopsycho>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014633.3256862-3-dw@davidwei.uk>

Thu, Dec 28, 2023 at 02:46:30AM CET, dw@davidwei.uk wrote:
>Add a debugfs file in
>/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>
>Writing "M B" to this file will link port A of netdevsim N with port B
>of netdevsim M. Reading this file will return the linked netdevsim id
>and port, if any.
>
>During nsim_dev_peer_write(), nsim_dev_list_lock prevents concurrent
>modifications to nsim_dev and peer's devlink->lock prevents concurrent
>modifications to the peer's port_list. rtnl_lock ensures netdevices do
>not change during the critical section where a link is established.
>
>The lock order is consistent with other parts that touch netdevsim and
>should not deadlock.
>
>During nsim_dev_peer_read(), RCU read critical section ensures valid
>values even if stale.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/dev.c       | 134 +++++++++++++++++++++++++++---
> drivers/net/netdevsim/netdev.c    |   6 ++
> drivers/net/netdevsim/netdevsim.h |   1 +
> 3 files changed, 128 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index 8d477aa99f94..6d5e4ce08dfd 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -391,6 +391,124 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
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
>+	ssize_t ret = 0;
>+	char buf[23];
>+
>+	nsim_dev_port = file->private_data;
>+	rcu_read_lock();
>+	peer = rcu_dereference(nsim_dev_port->ns->peer);
>+	if (!peer) {
>+		rcu_read_unlock();
>+		return 0;
>+	}
>+
>+	id = peer->nsim_bus_dev->dev.id;
>+	port = peer->nsim_dev_port->port_index;
>+	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>+	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>+
>+	rcu_read_unlock();
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
>+		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");
>+		return -EINVAL;
>+	}
>+
>+	ret = -EINVAL;
>+	mutex_lock(&nsim_dev_list_lock);
>+	peer_dev = nsim_dev_find_by_id(id);
>+	if (!peer_dev) {
>+		pr_err("Peer netdevsim %u does not exist\n", id);
>+		goto out_mutex;
>+	}
>+
>+	devl_lock(priv_to_devlink(peer_dev));

Why exactly do you take devlink instance mutex of the peer here?


>+	rtnl_lock();
>+	nsim_dev_port = file->private_data;
>+	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>+					       port);
>+	if (!peer_dev_port) {
>+		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
>+		goto out_devl;
>+	}
>+
>+	if (nsim_dev_port == peer_dev_port) {
>+		pr_err("Cannot link netdevsim to itself\n");
>+		goto out_devl;
>+	}
>+
>+	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>+	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>+	ret = count;
>+
>+out_devl:
>+	rtnl_unlock();
>+	devl_unlock(priv_to_devlink(peer_dev));
>+out_mutex:
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
>@@ -421,6 +539,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
> 	}
> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
> 
>+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>+			    nsim_dev_port, &nsim_dev_peer_fops);
>+
> 	return 0;
> }
> 
>@@ -1704,19 +1825,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
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

