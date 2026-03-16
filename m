Return-Path: <netdev+bounces-268297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IKyKoKEuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5562A17C9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DBE6302DE6B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19653750CB;
	Mon, 16 Mar 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7x2AqX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2A372B3A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700167; cv=none; b=k+N2VMalqZhGH2cRvg8r+q3sp90gI28PEKyNP+TF+Zl84bNA9M/ToveWymWtIoxTW4X/5FlLC7MiE5WJrDtq1Fg1e4v7NL+Av5HbZpRmmwPGKVGlLeaDxLLqBBuPl6aJvu63ufY7gwwUKCLRCpKMmUsaUXilTf8y9NiOuGe71lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700167; c=relaxed/simple;
	bh=KysKv+4UMfhnDnTvr6BO8IlevtyErd4SdDk4OwtDiUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ml9XN2ze6nmSN8VTrsymaGXMiEfeax11T69218bCd22s8m2sll7LWxA1agXsxDrBdPrfeBcNaT5z/QjBtKnxZKWFN99jL2O3naFrNM4IICJoWhWCawh6eL7M6ckJhXwiRh8ymTCcVPZHvqja9sB5qPVZAlJJtlXO0tXHuWOhRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7x2AqX1; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64aedd812baso5078062d50.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700162; x=1774304962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mhg1Y4Ej84+nsyH2qvB8M3otNVTGHX9lgToOwhjqhW4=;
        b=d7x2AqX1KCf2gCvxClxT7pQg8TYtC6zI88CvaFlV9h0wNBR52J0zPbkx1pUD9Ih8xD
         Ddi9IopD4EBbUGrXBgIucM6DgLnbrfJSgk84SJLOkFjT33hsSG1qj3v4xDhtEXibD7l+
         JX6lXmIMQLE0nCaYnwVQhIh+rBkaiNgYAk/XYi/WlA5fgA+Eo6xGWMP1bpJ5Rl/4zh6F
         aFQTrrI+SaDsTzeO6nU6ApCekP36+9+UWcbUWMVZYkwmX5fNt6JnXIHXaH176PTT3pQz
         9goHQWQ+k2u5t51hkqzNl4sIrYsCje9VT4QoTz/pyN+dgw7LbzEt91BH02I0UReCsI+U
         UX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700162; x=1774304962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mhg1Y4Ej84+nsyH2qvB8M3otNVTGHX9lgToOwhjqhW4=;
        b=EHMk+tNCwn/zwTQhzB5Vm38ifsP0b/V7iiuchDqX9GU8quIb+KEnMBShgCoy4RtiCE
         WVIKLrCt3SbLVA3qgumirLg5HB1JedC3xPm8CfVlH7nWt08fWuyjdAOGXAZ7xmVwluG5
         OIUs2vZ17uzrJVUOGLtUDjmR5warY0ESM3PyDGF87wWJLm7oq0aWDS+wAzvM/VHZQZFj
         adP2RZIaYnK1qku3NpcJVPXffULr9ee9Fks/zWD/Rnr/UzQiV+PcPh1clDYZcDt+Fqht
         /4b5qL7fAquSrTdCT0O3XoU2MTrz2Lkl51smuVYaf0FGzUvMIRobYVg2cZJOenw0Co4E
         xy6g==
X-Forwarded-Encrypted: i=1; AJvYcCWW8X7x5PP8E3JVd8eDsOnBpMvyuQpCHGG/mSuHt/ksT3pFld9NhAedkS7zrKw6iXFFdR3CLfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwokkKUsmBI/xUPYrAVk6V6CMAeookxMRw9Nhj6fbQk0t6L8Hwb
	8lPJiui7QICDknV5tQZKHL2A7EsBfqdFuo1wlNCDyCOW9y2RUEZlVyy1
X-Gm-Gg: ATEYQzwnEQPek50wOd2jIgh39rxUkJOjwGY1W0Hd78uKMb7tbyvFCu+IUqD4uDiLGqB
	OwJyrmxIXwzhga6fsjGRflVzv+ZxO+j97Skf/3onHNxt8GK4lGLQLtwNhloKUfiRsoQwT5CDrg5
	2XE24j3Ceu1hq+YHOAxYa0KDey97HUnzK4Nj7eP719pXjsHWNfQiV+51ixh0jVvbfS4JqseDGOq
	6pYAx9fKx3gxcRiD3oh/GiPYyAQfv5JQs8jh9bYgf95Wl/0+BU6csN/JFEhqS+yK2sj+rsbOAKd
	wd8MyM9P6qzOG4KJ48Kffr9Zr4BkAL66uX7Nu6W2bXoiDXkQSpljKJTVFzXZGSnKRyOM5lZQGBy
	/JVyMgiK1w1r3PnvcgdXYzAt7W9fKoupPInb9zfdCJkqVwrLbnyNp0sgw1xIsBUIU8B1Fxwsjrs
	pY4EV/vhWEwC9aBQU+4ICR4nAKaGnLoqVE
X-Received: by 2002:a05:690c:1c:b0:798:34a:52de with SMTP id 00721157ae682-79a1c1ddd0fmr149731677b3.51.1773700161934;
        Mon, 16 Mar 2026 15:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f08134sm92221467b3.36.2026.03.16.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:12 -0700
Subject: [PATCH net-next 1/6] net: devmem: support TX through netkit leased
 queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-1-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268297-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2B5562A17C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

When a netkit virtual device leases queues from a physical NIC, devmem
TX bindings created on the netkit device should use the physical NIC
for DMA operations rather than the virtual device, which has no DMA
capability.

In bind_tx_doit, walk the device's leased rx queues to discover the
underlying physical device that supports netmem_tx. Use this device
for DMA device lookup and pass it as the real_tx_dev in the binding.
When real_tx_dev is set, it is also used for NUMA-local allocations.

Extend validate_xmit_unreadable_skb() to support the netkit case, where
the skb is validated twice: once on the netkit guest device and again on
the physical NIC after BPF redirect or ip forwarding. Both invocations
must pass for the skb to be transmitted.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/dev.c         | 26 +++++++++++++++++++-------
 net/core/devmem.c      | 16 ++++++++++------
 net/core/devmem.h      |  6 ++++--
 net/core/netdev-genl.c | 38 +++++++++++++++++++++++++++++++++-----
 4 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ca4b26dfb1bd..105bd27be024 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3981,24 +3981,36 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
+	struct net_devmem_dmabuf_binding *binding;
 	struct skb_shared_info *shinfo;
+	struct net_device *real_tx_dev;
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
+	real_tx_dev = READ_ONCE(binding->real_tx_dev);
+
+	if (real_tx_dev) {
+		if (!real_tx_dev->netmem_tx)
+			goto out_free;
+		if (READ_ONCE(binding->dev) != dev && real_tx_dev != dev)
 			goto out_free;
+		goto out;
 	}
 
+	if (READ_ONCE(binding->dev) != dev || !dev->netmem_tx)
+		goto out_free;
+
 out:
 	return skb;
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7ede81509968..a4148cba5b5f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -181,12 +181,13 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 }
 
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *real_tx_dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
+	struct net_device *node_dev = real_tx_dev ?: dev;
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
@@ -205,13 +206,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		return ERR_CAST(dmabuf);
 
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
-			       dev_to_node(&dev->dev));
+			       dev_to_node(&node_dev->dev));
 	if (!binding) {
 		err = -ENOMEM;
 		goto err_put_dmabuf;
 	}
 
 	binding->dev = dev;
+	binding->real_tx_dev = real_tx_dev;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -254,7 +256,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	 * allocate MTU sized chunks here. Leave that for future work...
 	 */
 	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
-					      dev_to_node(&dev->dev));
+					      dev_to_node(&node_dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
 		goto err_tx_vec;
@@ -268,7 +270,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		struct net_iov *niov;
 
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
-				     dev_to_node(&dev->dev));
+				     dev_to_node(&node_dev->dev));
 		if (!owner) {
 			err = -ENOMEM;
 			goto err_free_chunks;
@@ -280,7 +282,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		owner->binding = binding;
 
 		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
-					 dma_addr, len, dev_to_node(&dev->dev),
+					 dma_addr, len,
+					 dev_to_node(&node_dev->dev),
 					 owner);
 		if (err) {
 			kfree(owner);
@@ -397,7 +400,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 */
 	dst_dev = dst_dev_rcu(dst);
 	if (unlikely(!dst_dev) ||
-	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
+	    unlikely(dst_dev != READ_ONCE(binding->dev) &&
+		     dst_dev != READ_ONCE(binding->real_tx_dev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 1c5c18581fcb..ffcf97a33633 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
 	struct net_device *dev;
+	/* Phys dev behind a virtual dev (e.g. netkit) with a queue lease. */
+	struct net_device *real_tx_dev;
 	struct gen_pool *chunk_pool;
 	/* Protect dev */
 	struct mutex lock;
@@ -84,7 +86,7 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *real_tx_dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -165,7 +167,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *real_tx_dev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7d073894ca74..2b34924dc30f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1037,7 +1037,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rxq_bitmap;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
+	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
@@ -1082,6 +1082,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	struct net_device *real_tx_dev = NULL;
+	struct netdev_rx_queue *lease_rxq;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
 	struct device *dma_dev;
@@ -1089,6 +1091,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *rsp;
 	int err = 0;
 	void *hdr;
+	int i;
 
 	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
 	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
@@ -1124,16 +1127,41 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	if (!netdev->netmem_tx) {
+	for (i = 0; i < netdev->real_num_rx_queues; i++) {
+		lease_rxq = READ_ONCE(__netif_get_rx_queue(netdev, i)->lease);
+
+		if (!lease_rxq)
+			continue;
+
+		real_tx_dev = lease_rxq->dev;
+		break;
+	}
+
+	if (real_tx_dev) {
+		if (!netif_device_present(real_tx_dev)) {
+			err = -ENODEV;
+			goto err_unlock_netdev;
+		}
+
+		if (!real_tx_dev->netmem_tx) {
+			err = -EOPNOTSUPP;
+			NL_SET_ERR_MSG(info->extack,
+				       "Driver for queue lease device does not support netmem TX");
+			goto err_unlock_netdev;
+		}
+	}
+
+	if (!real_tx_dev && !netdev->netmem_tx) {
 		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(info->extack,
 			       "Driver does not support netmem TX");
 		goto err_unlock_netdev;
 	}
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+	dma_dev = netdev_queue_get_dma_dev(real_tx_dev ?: netdev, 0);
+	binding = net_devmem_bind_dmabuf(netdev, real_tx_dev, dma_dev,
+					 DMA_TO_DEVICE, dmabuf_fd, priv,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;

-- 
2.52.0


