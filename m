Return-Path: <netdev+bounces-57887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A581467A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC6E1F23A5E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC011F61E;
	Fri, 15 Dec 2023 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0UHQ4N8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82424B22
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so6585005e9.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702638711; x=1703243511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j91cSi+rNBLY3Viw9+Qvz67/gW9U2FBjJCUBysLvsao=;
        b=0UHQ4N8GBR9x/LFWZ8sWcygObX2QWeXYKCkr9tPcn6JLmoOY7ZvJCCDYywGfM4VFaO
         69dIrsHD17jWKBxBRW6WWeDE9hBrwTSby3iDbhVM4AkHl9cKB/lMg7bUAKTDUesNKlq2
         9Pc19iX2FegJiyG/x9+j/HYmNIeTOM4Hiu0Rt+rlicatiqml7YIBX9n1wNiBfI4fXIFP
         ZLbpfnO14FZQT1pmGTx/3p50kPX3WomY9BvZrGeL0GgS+8LzzQ179G67FNO3LuAJms7S
         5k5VDRd8TDxeVp64YafrxM2aYyVj02qvuuLS9Iluynog71hm2xW/Ka9iff2cSCh57WTn
         wBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638711; x=1703243511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j91cSi+rNBLY3Viw9+Qvz67/gW9U2FBjJCUBysLvsao=;
        b=rijKI1ZzjogvxnM5AVdoFkogklrdSFX0sZ5BWwlmFMpoKSjFbqM3PwQoTyuhFDIRCS
         13L+137KdEqfAyOyM+amEtZbWfkXn6Yl9lqcE7RXxGWJ46RZuX2LA3Tf2DeNfnuFZKth
         FwaVfIv7onmJuEl8hcouXKlq1b5ZCC5KAvyo4u/U7Wesj61JzNqfiHoBxu2ZUT1WWSmF
         mZv7SZC34MkOyGH7RVIfnF5tSV4SdTXS6Nul0KfIzWpxElypAKpdeMsye9BZahHDP8BK
         ABVF8mChHXyzHZ4PEInkQRX7pei0yag3c88gyQw28JZEqJCr6BQTP+C7FsFDm2icWd9r
         ATAQ==
X-Gm-Message-State: AOJu0YzVeoJ/mgcPbAxHCM1u7hJUj71X1iAXGX5KqlIsIT3wG7FxvPv8
	Hawnf5S6ddK2z0O0qKQjK7PV0w==
X-Google-Smtp-Source: AGHT+IGol7L5Svz8a6XXyQH/JL5uZT+Ine/P7WvOnyC+ERNYH11uJsl3lG8YbsWO5Jfh0B1hTLTS1Q==
X-Received: by 2002:a05:600c:458d:b0:40c:6e31:765c with SMTP id r13-20020a05600c458d00b0040c6e31765cmr36893wmo.64.1702638711185;
        Fri, 15 Dec 2023 03:11:51 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040b2a52ecaasm30833578wms.2.2023.12.15.03.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:11:50 -0800 (PST)
Date: Fri, 15 Dec 2023 12:11:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <ZXw0dWbPKs1e_2eJ@nanopsycho>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214212443.3638210-2-dw@davidwei.uk>

Thu, Dec 14, 2023 at 10:24:40PM CET, dw@davidwei.uk wrote:
>Add a debugfs file in
>/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>
>Writing "M B" to this file will link port A of netdevsim N with port B of
>netdevsim M.
>
>Reading this file will return the linked netdevsim id and port, if any.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/bus.c       | 17 ++++++
> drivers/net/netdevsim/dev.c       | 88 +++++++++++++++++++++++++++++++
> drivers/net/netdevsim/netdev.c    |  6 +++
> drivers/net/netdevsim/netdevsim.h |  3 ++
> 4 files changed, 114 insertions(+)
>
>diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>index bcbc1e19edde..1ef95661a3f5 100644
>--- a/drivers/net/netdevsim/bus.c
>+++ b/drivers/net/netdevsim/bus.c
>@@ -323,6 +323,23 @@ static struct device_driver nsim_driver = {
> 	.owner		= THIS_MODULE,
> };
> 
>+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)

This sounds definitelly incorrect. You should not need to touch bus.c
code. It arranges the bus and devices on it. The fact that a device is
probed or not is parallel to this.

I think you need to maintain a separate list/xarray of netdevsim devices
probed by nsim_drv_probe()


>+{
>+	struct nsim_bus_dev *nsim_bus_dev;
>+
>+	mutex_lock(&nsim_bus_dev_list_lock);
>+	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>+		if (nsim_bus_dev->dev.id == id) {
>+			get_device(&nsim_bus_dev->dev);
>+			mutex_unlock(&nsim_bus_dev_list_lock);
>+			return nsim_bus_dev;
>+		}
>+	}
>+	mutex_unlock(&nsim_bus_dev_list_lock);
>+
>+	return NULL;
>+}
>+
> int nsim_bus_init(void)
> {
> 	int err;
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index b4d3b9cde8bd..034145ba1861 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -388,6 +388,91 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
> 	.owner = THIS_MODULE,
> };
> 
>+static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>+				  size_t count, loff_t *ppos)
>+{
>+	struct nsim_dev_port *nsim_dev_port;
>+	struct netdevsim *peer;
>+	unsigned int id, port;
>+	char buf[23];
>+	ssize_t len;
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
>+	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>+
>+	rcu_read_unlock();
>+	return simple_read_from_buffer(data, count, ppos, buf, len);
>+}
>+
>+static ssize_t nsim_dev_peer_write(struct file *file,
>+				   const char __user *data,
>+				   size_t count, loff_t *ppos)
>+{
>+	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>+	struct nsim_bus_dev *peer_bus_dev;
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
>+	/* invalid netdevsim id */
>+	peer_bus_dev = nsim_bus_dev_get(id);
>+	if (!peer_bus_dev)
>+		return -EINVAL;
>+
>+	ret = -EINVAL;
>+	/* cannot link to self */
>+	nsim_dev_port = file->private_data;
>+	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
>+	    nsim_dev_port->port_index == port)
>+		goto out;
>+
>+	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);

Again, no bus touching should be needed. (btw, this could be null is dev
is not probed)


>+	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
>+		if (peer_dev_port->port_index != port)
>+			continue;
>+		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>+		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);

What is stopping another cpu from setting different peer for the same
port here, making a mess?


>+		ret = count;
>+		goto out;
>+	}
>+
>+out:
>+	put_device(&peer_bus_dev->dev);
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
>@@ -418,6 +503,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
> 	}
> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
> 
>+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>+			    nsim_dev_port, &nsim_dev_peer_fops);
>+
> 	return 0;
> }
> 
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index aecaf5f44374..e290c54b0e70 100644
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
>@@ -407,9 +408,14 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
> void nsim_destroy(struct netdevsim *ns)
> {
> 	struct net_device *dev = ns->netdev;
>+	struct netdevsim *peer;
> 
> 	rtnl_lock();
>+	peer = rtnl_dereference(ns->peer);
>+	RCU_INIT_POINTER(ns->peer, NULL);
> 	unregister_netdevice(dev);
>+	if (peer)
>+		RCU_INIT_POINTER(peer->peer, NULL);

What is stopping the another CPU from setting this back to this "ns"?
Or what is stopping another netdevsim port from setting this ns while
going away?

Do you rely on RTNL_LOCK in any way (other then synchronize_net() in
unlock())? If yes, looks wrong.

This ns->peer update locking looks very broken to me :/




> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
> 		nsim_macsec_teardown(ns);
> 		nsim_ipsec_teardown(ns);
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index 028c825b86db..61ac3a80cf9a 100644
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
>@@ -415,5 +416,7 @@ struct nsim_bus_dev {
> 	bool init;
> };
> 
>+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
>+
> int nsim_bus_init(void);
> void nsim_bus_exit(void);
>-- 
>2.39.3
>

