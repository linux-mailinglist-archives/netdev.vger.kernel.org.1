Return-Path: <netdev+bounces-282115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IGALyI48Wm/egEAu9opvQ
	(envelope-from <netdev+bounces-282115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16648CB87
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D29CB3014BB6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F9E3A380A;
	Tue, 28 Apr 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agfP/yo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3F39EF04
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416143; cv=none; b=l3FaeMRjYHojCYTRhNL+y5yRBFAPjjqf74L6z/Ll7f9fDI4HC/VlvuRX8MLQfTz2VG58BZD2arX6q8tCCEFtJ9J6UjFlzlJ3UmtNGJL0KqI3wNh1GDJm++cLKgTlx6H+NSIEwKDSGte1cq8KaDOllrAsoq5ZUw5lrvdqisSc/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416143; c=relaxed/simple;
	bh=zYSlCV11KjpG4V7rBJ4YDIrmSJ+VzUpMc8q4YN/iHxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kU3exYQGPgWJRGuYn57YgkKF8M7JLzOjoJ8v+t4hTFUyq4bDzgRrYNF8ZGitFd/Ff5h4lpXFP8rXglSEkDAmajiJYM7bQcD5S5w+ZXFdlR9z/lXNU7IT/0svZmu5FvWNbOz5KMUzqHc6iaH5P3bIG8uenRlRLKqbtt6u7ceO73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agfP/yo+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ea611d1a4so4348041fac.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416141; x=1778020941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keNbfrUPGw0zb/nvkdVaa+m9kY/292t4JsgfRNz/uIE=;
        b=agfP/yo+IIR8zY+emHNrrqmTKLNzmz7UvzMFONKZ+j+Tx3E+/rGSdT37nxLqkDpa0G
         F8z9dwiedtTn9aa3zjSC5NNv497bXYM63FwXPWF0PTy6gC5KOD4E6BDsFiihD7/KNmcI
         UDrRZ9AIiM4/CMkvF5m4zeIB3l1PfJSRQCFZPevh7v+R2uyIs1Id0hSBPwjT07fiOZY5
         jxiacjMXB8LYBkwLISRqWKZkKMOEL3yBj2Uff4a+9m7gHcUqfOkeZ2zLgocV6eOGJ42z
         49Y04PQmyHJj/ifiERs1SbS37VEtZmmqgCufMcFQOZbs5EJbJv8tp9lQXifRw832scsT
         2/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416141; x=1778020941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=keNbfrUPGw0zb/nvkdVaa+m9kY/292t4JsgfRNz/uIE=;
        b=VHMDZLZc7OnD2IHXHmrKiMaq+yWEXQtDscwXV1g04/6UeuhSDCsK2HNKNohC6cJc4w
         qAK6gaM7utwLMsuMKS977mkA0KSquizOUNVgf3ZCsXAiqmF2rlbNuJga+VAKCePuIuqf
         U/PFezZtYt3seKJNL3k5gXu4eaxK06SdUC1N/wBOLkIebfzhhGFs2Ow4+1XjjTR+RuZi
         AVy7tpOQ/bcGPMLE7xV5bwBiItRgX1g32maiLd3HEuzlyrk97DQ4buiYA3rO3imEbEJA
         omPiuhskVv38h0jkNaijjoq7F3h1Hb1rJPg00KjV2PzGsUwyTMqzBFClNoRCiE85P+sg
         xG8Q==
X-Gm-Message-State: AOJu0YyhbIC5muhZlaWhB8Wqw1P76uMS3ZmsE0EzOyPK2gluzoZafGmI
	a3WeB4sjhndUYZSwNmiDXZfp76dURiglSUdgmiXd8eO2TGuDbYktJn3G
X-Gm-Gg: AeBDietSPCscDWZ7qjV1s10871DLzZyMsdHecp3G4QGQHwWXK+J6KfNN2d7aQrQKiJ5
	qN/GTfXf03Q8Cn0/AZn4cfCrH3UWKORkke+3StJM/4xsac/Wr1reAAsdqViS711ajz3hmCVpNSs
	wUa/3SMZvJVuvrsloKnJXuIaZAteUNSlqEsWQiHEkJAKMLpYSe9Cm1g1NJe57HFluwpc2hBv3+3
	KhsEBr+GLtiZkyAlKzEUUT0PXesHeAvjluBmhlhS7D4PbJ2WFHd66tSj1kgpW+cmzhVsASv58hT
	OfXZ6g5NeGO+sYLz72BgBGZfvPFHbEhe6wX0aDhkfc9DdbONz58p4M+QMoT+nFcuHtczzT0vjOt
	HiCorlfANvlIXbzCqxGbjDyuLEkT9GLafxRfl9gK4rDQNBsq96+bW7pENFSTkeXLeRJVPaMVQ+7
	FtgbMRcex+LWfnccQmvMVgjB31+V7N5fFoBAYRPqaWwl0=
X-Received: by 2002:a05:6870:b202:b0:42c:5ca:e7f8 with SMTP id 586e51a60fabf-433f3affc8fmr3047588fac.26.1777416141010;
        Tue, 28 Apr 2026 15:42:21 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:32::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4340e6b1441sm474082fac.3.2026.04.28.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:04 -0700
Subject: [PATCH net-next 07/11] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 8B16648CB87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282115-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

When a netkit virtual device leases queues from a physical NIC, devmem
TX bindings created on the netkit device must still result in the dmabuf
being mapped for dma by the physical device. This patch accomplishes
this by teaching the bind handler to search for the underlying
DMA-capable device by looking it up via leased rx queues. The function
netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
devices in the future if needed.

Additionally, this patch extends validate_xmit_unreadable_skb() to
support the netkit case, where the skb is validated twice: once on the
netkit guest device and again on the physical NIC after BPF redirect or
ip forwarding.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/dev.c         | 24 ++++++++++++++++-------
 net/core/devmem.c      |  6 ++++--
 net/core/devmem.h      |  9 +++++++--
 net/core/netdev-genl.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..f6575cf48287 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3990,22 +3990,32 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
+	struct net_devmem_dmabuf_binding *binding;
 	struct skb_shared_info *shinfo;
 	struct net_iov *niov;
 
 	if (likely(skb_frags_readable(skb)))
 		goto out;
 
-	if (!dev->netmem_tx)
-		goto out_free;
-
 	shinfo = skb_shinfo(skb);
+	if (shinfo->nr_frags == 0)
+		goto out;
 
-	if (shinfo->nr_frags > 0) {
-		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
-		if (net_is_devmem_iov(niov) &&
-		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
+	niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
+	if (!net_is_devmem_iov(niov))
+		goto out;
+
+	binding = net_devmem_iov_binding(niov);
+
+	switch (dev->netmem_tx) {
+	case NETMEM_TX_DMA:
+		if (READ_ONCE(binding->dev) != dev)
 			goto out_free;
+		break;
+	case NETMEM_TX_NO_DMA:
+		break;
+	default: /* NETMEM_TX_NONE */
+		goto out_free;
 	}
 
 out:
diff --git a/net/core/devmem.c b/net/core/devmem.c
index cde4c89bc146..644c286b778f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -181,7 +181,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 }
 
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	binding->dev = dev;
+	binding->vdev = vdev;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -397,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 */
 	dst_dev = dst_dev_rcu(dst);
 	if (unlikely(!dst_dev) ||
-	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
+	    unlikely(dst_dev != READ_ONCE(binding->dev) &&
+		     dst_dev != READ_ONCE(binding->vdev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 1c5c18581fcb..f399632b3c4b 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -19,7 +19,12 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
+	/* Physical NIC that does the actual DMA for this binding. */
 	struct net_device *dev;
+	/* Virtual device (e.g. netkit) the user called bind-tx on. Must be
+	 * NETMEM_TX_NO_DMA.
+	 */
+	struct net_device *vdev;
 	struct gen_pool *chunk_pool;
 	/* Protect dev */
 	struct mutex lock;
@@ -84,7 +89,7 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -165,7 +170,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8f6076d8007..bc6057aee98e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1077,7 +1077,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rxq_bitmap;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
+	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
@@ -1119,9 +1119,42 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* Find the DMA-capable device for netmem TX binding.
+ * For NETMEM_TX_DMA devices, returns the device itself.
+ * For NETMEM_TX_NO_DMA devices (e.g. netkit), walks leased queues
+ * to find the underlying physical device.
+ * Returns NULL if no suitable device is found.
+ */
+static struct net_device *netdev_find_netmem_tx_dev(struct net_device *dev)
+{
+	struct netdev_rx_queue *lease_rxq;
+	struct net_device *phys_dev;
+	int i;
+
+	if (dev->netmem_tx == NETMEM_TX_DMA)
+		return dev;
+
+	if (dev->netmem_tx != NETMEM_TX_NO_DMA)
+		return NULL;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		lease_rxq = READ_ONCE(__netif_get_rx_queue(dev, i)->lease);
+		if (!lease_rxq)
+			continue;
+
+		phys_dev = lease_rxq->dev;
+		if (netif_device_present(phys_dev) &&
+		    phys_dev->netmem_tx == NETMEM_TX_DMA)
+			return phys_dev;
+	}
+
+	return NULL;
+}
+
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	struct net_device *bind_dev;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
 	struct device *dma_dev;
@@ -1164,16 +1197,26 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	if (!netdev->netmem_tx) {
+	if (netdev->netmem_tx == NETMEM_TX_NONE) {
 		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(info->extack,
 			       "Driver does not support netmem TX");
 		goto err_unlock_netdev;
 	}
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0, NETDEV_QUEUE_TYPE_TX);
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+	bind_dev = netdev_find_netmem_tx_dev(netdev);
+	if (!bind_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "No DMA-capable device found for netmem TX");
+		goto err_unlock_netdev;
+	}
+
+	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
+	binding = net_devmem_bind_dmabuf(bind_dev,
+					 bind_dev != netdev ? netdev : NULL,
+					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
+					 priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;

-- 
2.52.0


