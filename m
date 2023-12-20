Return-Path: <netdev+bounces-59124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B114A819680
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E01F267A4
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2579D8;
	Wed, 20 Dec 2023 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xaFiK9Hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D398C02
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35f71436397so39318665ab.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036871; x=1703641671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbsSgVUnjr/AUF6wkufHvh4W3upHoBUCqZtKEqBoGTE=;
        b=xaFiK9HlEyPHVqnggHRUCmd/xij57YSqpDvEUt38N4FZkoI0DVnSreDuArggfqmUat
         H2OFCJ2j/Yhd+RlNW+jqadSHkRl2HVMYXphoaLku0N/aHzdhVLbG+4yIoi+bjcc5F5sI
         eTc1xMv/wpyUKjGyApiKalzkwhGNOvhspPUQoKupObAMzlN0SbIVRhK1ATA9sm/oqnjb
         1bxYxDW5EF9DTRx44zOrIm2xg2EoF0nZf5guOBKm8mW7QeB3YWBoyDh+7sOpgvkYIGXh
         GlnQf1mNAFDE5UEvGpDsUiIhEtpp60Y4VFFGbxpQyKY88VpdkmIIMNkL1AFeBts8vfPs
         dPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036871; x=1703641671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbsSgVUnjr/AUF6wkufHvh4W3upHoBUCqZtKEqBoGTE=;
        b=JZ1jWxriBrAdluZ/1rpbwxbAMmZoYZJrlPqGehMUUaLiYR6mMT8fYZACqvNVjN+d52
         pNp2/FUEigytf/OFgxhnxiZfaFqMKjGZ+pcnxHGdLJfkwnGHM9fegxA/4Noanfw9hrSH
         RbSZkWZ8pE4rzr5LI/I4Tz1KD27Kn1jaqYc/mtxpXsRYIPZ2+rX1xNjWiRcGjRrpXRSD
         6isGzHoKomRSrPyPFrv3YYGj7d1JgolQv8UGTAUMOyFmXtCTws6nE3Cbnq5rSkGjHhOb
         frL7+e0DfyL1XsLukUnOf9i/u4OtDu0wvVWMiOjtr/o15ROlCnyszWVKqYS1rb0K94k6
         ym3Q==
X-Gm-Message-State: AOJu0YwAx77m8NuRvG126Lh+eu9xRgO41MqyydxPbP1ArpBFsaAYte2m
	l+zSS7dR/eXdCq/ULZUELKnVNnQt1UQ1kZZUgfI=
X-Google-Smtp-Source: AGHT+IFZS0UuvTl1L9+2/C/JU98VI3pZO/eUpqxblD3BFPxzlZeerp4t0Hxv/JVTm5+g7sVxd9r26g==
X-Received: by 2002:a05:6e02:20c1:b0:35f:a119:8434 with SMTP id 1-20020a056e0220c100b0035fa1198434mr10440146ilq.46.1703036871395;
        Tue, 19 Dec 2023 17:47:51 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001d0b6ba60fdsm21693695plp.175.2023.12.19.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:51 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to be connected
Date: Tue, 19 Dec 2023 17:47:44 -0800
Message-Id: <20231220014747.1508581-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220014747.1508581-1-dw@davidwei.uk>
References: <20231220014747.1508581-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs file in
/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer

Writing "M B" to this file will link port A of netdevsim N with port B
of netdevsim M. Reading this file will return the linked netdevsim id
and port, if any.

nsim_dev_list_lock and rtnl_lock are held during read/write of peer to
prevent concurrent modification of netdevsims or their ports.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/dev.c       | 127 +++++++++++++++++++++++++++---
 drivers/net/netdevsim/netdev.c    |   6 ++
 drivers/net/netdevsim/netdevsim.h |   1 +
 3 files changed, 121 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index e30a12130e07..e4621861c70b 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -391,6 +391,117 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
 	.owner = THIS_MODULE,
 };
 
+static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
+{
+	struct nsim_dev *dev;
+
+	list_for_each_entry(dev, &nsim_dev_list, list)
+		if (dev->nsim_bus_dev->dev.id == id)
+			return dev;
+
+	return NULL;
+}
+
+static struct nsim_dev_port *
+__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
+		       unsigned int port_index)
+{
+	struct nsim_dev_port *nsim_dev_port;
+
+	port_index = nsim_dev_port_index(type, port_index);
+	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
+		if (nsim_dev_port->port_index == port_index)
+			return nsim_dev_port;
+	return NULL;
+}
+
+static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
+				  size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port;
+	struct netdevsim *peer;
+	unsigned int id, port;
+	char buf[23];
+	ssize_t ret;
+
+	mutex_lock(&nsim_dev_list_lock);
+	rtnl_lock();
+	nsim_dev_port = file->private_data;
+	peer = rtnl_dereference(nsim_dev_port->ns->peer);
+	if (!peer)
+		goto out;
+
+	id = peer->nsim_bus_dev->dev.id;
+	port = peer->nsim_dev_port->port_index;
+	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
+	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
+
+out:
+	rtnl_unlock();
+	mutex_unlock(&nsim_dev_list_lock);
+
+	return ret;
+}
+
+static ssize_t nsim_dev_peer_write(struct file *file,
+				   const char __user *data,
+				   size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
+	struct nsim_dev *peer_dev;
+	unsigned int id, port;
+	char buf[22];
+	ssize_t ret;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	ret = copy_from_user(buf, data, count);
+	if (ret)
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = sscanf(buf, "%u %u", &id, &port);
+	if (ret != 2) {
+		pr_err("Format for adding a peer is \"id port\" (uint uint)");
+		return -EINVAL;
+	}
+
+	ret = -EINVAL;
+	mutex_lock(&nsim_dev_list_lock);
+	rtnl_lock();
+	peer_dev = nsim_dev_find_by_id(id);
+	if (!peer_dev)
+		goto out;
+
+	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
+					       port);
+	if (!peer_dev_port)
+		goto out;
+
+	nsim_dev_port = file->private_data;
+	if (nsim_dev_port == peer_dev_port)
+		goto out;
+
+	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
+	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
+	ret = count;
+
+out:
+	rtnl_unlock();
+	mutex_unlock(&nsim_dev_list_lock);
+
+	return ret;
+}
+
+static const struct file_operations nsim_dev_peer_fops = {
+	.open = simple_open,
+	.read = nsim_dev_peer_read,
+	.write = nsim_dev_peer_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
 static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 				      struct nsim_dev_port *nsim_dev_port)
 {
@@ -421,6 +532,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 	}
 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
 
+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
+			    nsim_dev_port, &nsim_dev_peer_fops);
+
 	return 0;
 }
 
@@ -1702,19 +1816,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
 }
 
-static struct nsim_dev_port *
-__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
-		       unsigned int port_index)
-{
-	struct nsim_dev_port *nsim_dev_port;
-
-	port_index = nsim_dev_port_index(type, port_index);
-	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
-		if (nsim_dev_port->port_index == port_index)
-			return nsim_dev_port;
-	return NULL;
-}
-
 int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
 		      unsigned int port_index)
 {
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..434322f6a565 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
+	RCU_INIT_POINTER(ns->peer, NULL);
 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
 	nsim_ethtool_init(ns);
@@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 void nsim_destroy(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
+	struct netdevsim *peer;
 
 	rtnl_lock();
+	peer = rtnl_dereference(ns->peer);
+	if (peer)
+		RCU_INIT_POINTER(peer->peer, NULL);
+	RCU_INIT_POINTER(ns->peer, NULL);
 	unregister_netdevice(dev);
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
 		nsim_macsec_teardown(ns);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index babb61d7790b..24fc3fbda791 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,6 +125,7 @@ struct netdevsim {
 	} udp_ports;
 
 	struct nsim_ethtool ethtool;
+	struct netdevsim __rcu *peer;
 };
 
 struct netdevsim *
-- 
2.39.3


