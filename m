Return-Path: <netdev+bounces-128142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4097845A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03C1280D4A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BC199EB2;
	Fri, 13 Sep 2024 15:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7018BC08
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240161; cv=none; b=iegyO+IJASF+BhaBI0ZbKrZ8KZ+JVoVrb+WNjmRiaSNdAIGQKJFLLKyS6B7vu+jha6FNWTLggXBPRj35mK64S15JmJwd93SrdfdkmVmTOQLouixdPIp1hWdcdCrMGHv0sAOJiiFzpnWa23/O64p5Z+zFiH0v6JZtUweNf30IS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240161; c=relaxed/simple;
	bh=B8s5TDUjPz1QijcqON/eyiNEO5pTqLwh9iiJxr3ivIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa83q2yw3Jn+j+CkFyxrH+1bUrB5jpFHK633GmQ+anj2DzlvFtq8at9HfRoBuxlx+SOnCEg0knGM1Cky8gjgGdbXhepBr8zoOGz03mcP6Bl/RZ79C7QNAZbUB3JYHqh0hOAey1062vZ86kpoBK4LjujD7zsjOGta5btifPHRCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so979184a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240158; x=1726844958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVKbC+oSU//bL604yqDum0SAnVJvD1/dTmD1quLpO74=;
        b=LmvacGw6Ar95K5X5OLPANCWCXJ060/uqdNulJvi24A09NdCUhJAyK5QYktGweqG+Hk
         tiQRfHNzmOIEmIlfZGuuVTF9FmrdOl31yv31qf9pxVo3BTZ5soIQX2fEh4oO8kcaf7mK
         qyd20KCz+OmOlFLGaqI5Zs+Z3OpfJBSbyr09cBRza4RzRsrLc9+2JznVytCcXtdR56BV
         6YZMMsOksUQow/LlqWcojhQsnWNL5ZjcrxiCXYP4qEvdG8qy5mg9Ahhu6FOcC+R6tYAO
         OykQz1NHkawsv0ymcUT0MVRkNCKm01hzKlQZr9EaQ4ZuIgZds6jpBzxrf4Y/logwhAna
         WLVA==
X-Gm-Message-State: AOJu0YyA/1vRQh0Z5VavSykQC58Qva3L1VDrD113xU7PVRPhDiLqTNGn
	jthOKS3o+2oh6h1ZvktjMilusuFS6ZaYCGYHbfOWyy6E7tu8FP+9rzGs
X-Google-Smtp-Source: AGHT+IEOhE6KOhjhpO+o2MHEiv5l+5HbwrCRkTfYtVyhZHHqgApbB/exYCZ5lW43qFW9S2BkU5mn7g==
X-Received: by 2002:a17:90a:fd05:b0:2c7:700e:e2b7 with SMTP id 98e67ed59e1d1-2dbb9fbc3cfmr4298381a91.39.1726240157389;
        Fri, 13 Sep 2024 08:09:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d3a81dsm1872302a91.54.2024.09.13.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH net-next v1 1/4] net: devmem: Implement TX path
Date: Fri, 13 Sep 2024 08:09:10 -0700
Message-ID: <20240913150913.1280238-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913150913.1280238-1-sdf@fomichev.me>
References: <20240913150913.1280238-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preliminary implementation of the TX path. The API is as follows:

1. bind-tx netlink call to attach dmabuf for TX; queue is not
   required, only netdev for dmabuf attachment
2. a set of iovs where iov_base is the offset in the dmabuf and iov_len
   is the size of the chunk to send; multiple iovs are supported
3. SCM_DEVMEM_DMABUF cmsg with the dmabuf id from bind-tx
4. MSG_SOCK_DEVMEM sendmsg flag to mirror receive path

In sendmsg, lookup binding by id and refcnt it for every frag in the
skb. None of the drivers are implemented, but skb_frag_dma_unmap
should return proper DMA address. Extra care (TODO) must be taken in the
drivers to not dma_unmap those mappings on completions.

The changes in the kernel/dma/mapping.c are only required to make
devmem work with virtual networking devices (and they expose 1:1
identity mapping) and to enable 'loopback' mode. Loopback mode
lets us test TCP and UAPI paths without having real HW. Not sure
whether it should be a part of a real upstream submission, but it
was useful during the development.

TODO:
- skb_page_unref and __skb_frag_ref seem out of place; unref paths
  in general need more care
- potentially something better than tx_iter/tx_vec with its
  O(len/PAGE_SIZE) lookups
- move xa_alloc_cyclic to the end
- potentially better separate bind-rx and bind-tx;
  direction == DMA_TO_DEVICE feels hacky
- rename skb_add_rx_frag_netmem to skb_add_frag_netmem

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/specs/netdev.yaml | 13 +++++
 include/linux/skbuff.h                  | 16 ++++--
 include/linux/skbuff_ref.h              | 17 ++++++
 include/net/devmem.h                    |  1 +
 include/net/sock.h                      |  1 +
 include/uapi/linux/netdev.h             |  1 +
 kernel/dma/mapping.c                    | 18 +++++-
 net/core/datagram.c                     | 52 +++++++++++++++++-
 net/core/devmem.c                       | 73 +++++++++++++++++++++++--
 net/core/devmem.h                       | 28 +++++++++-
 net/core/netdev-genl-gen.c              | 13 +++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 65 +++++++++++++++++++++-
 net/core/skbuff.c                       | 21 ++++---
 net/core/sock.c                         |  5 ++
 net/ipv4/tcp.c                          | 38 ++++++++++++-
 net/vmw_vsock/virtio_transport_common.c |  2 +-
 tools/include/uapi/linux/netdev.h       |  1 +
 18 files changed, 339 insertions(+), 27 deletions(-)
 create mode 120000 include/net/devmem.h

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 08412c279297..da8e63f45ab9 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -676,6 +676,19 @@ name: netdev
         reply:
           attributes:
             - id
+    -
+      name: bind-tx
+      doc: Bind dmabuf to netdev for TX
+      attribute-set: dmabuf
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+        reply:
+          attributes:
+            - id
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..eaa4dcee7699 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1702,9 +1702,11 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
 
+struct net_devmem_dmabuf_binding;
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length);
+			    size_t length,
+			    struct net_devmem_dmabuf_binding *binding);
 
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length);
@@ -1712,12 +1714,12 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
 					  struct msghdr *msg, int len)
 {
-	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
+	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len, NULL);
 }
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
-			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg);
+			     struct msghdr *msg, int len, struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding);
 
 /* Internal */
 #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
@@ -3651,6 +3653,12 @@ static inline dma_addr_t skb_frag_dma_map(struct device *dev,
 					  size_t offset, size_t size,
 					  enum dma_data_direction dir)
 {
+	struct net_iov *niov;
+
+	if (unlikely(skb_frag_is_net_iov(frag))) {
+		niov = netmem_to_net_iov(frag->netmem);
+		return niov->dma_addr + offset + frag->offset;
+	}
 	return dma_map_page(dev, skb_frag_page(frag),
 			    skb_frag_off(frag) + offset, size, dir);
 }
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 0f3c58007488..2e621c6572f2 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -8,6 +8,7 @@
 #define _LINUX_SKBUFF_REF_H
 
 #include <linux/skbuff.h>
+#include <net/devmem.h> /* this is a hack */
 
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
@@ -17,6 +18,13 @@
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
+	if (netmem_is_net_iov(frag->netmem)) {
+		struct net_iov *niov = netmem_to_net_iov(frag->netmem);
+
+		net_devmem_dmabuf_binding_get(niov->owner->binding);
+		return;
+	}
+
 	get_page(skb_frag_page(frag));
 }
 
@@ -36,6 +44,15 @@ bool napi_pp_put_page(netmem_ref netmem);
 
 static inline void skb_page_unref(netmem_ref netmem, bool recycle)
 {
+	/* TODO: find a better place to deref TX binding */
+	if (netmem_is_net_iov(netmem)) {
+		struct net_iov *niov = netmem_to_net_iov(netmem);
+
+		if (niov->owner->binding->tx_vec) {
+			net_devmem_dmabuf_binding_put(niov->owner->binding);
+			return;
+		}
+	}
 #ifdef CONFIG_PAGE_POOL
 	if (recycle && napi_pp_put_page(netmem))
 		return;
diff --git a/include/net/devmem.h b/include/net/devmem.h
new file mode 120000
index 000000000000..55d6d7361245
--- /dev/null
+++ b/include/net/devmem.h
@@ -0,0 +1 @@
+../../net/core/devmem.h
\ No newline at end of file
diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..964ce7cf9a4f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1796,6 +1796,7 @@ struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
 	u32 tsflags;
+	u32 devmem_id;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7c308f04e7a0..56f7b87f8bd0 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -199,6 +199,7 @@ enum {
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..e7fc06695358 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -183,6 +183,19 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
+static int dma_map_dummy(struct scatterlist *sgl, int nents)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg->dma_address = (dma_addr_t)sg_page(sg);
+		sg_dma_len(sg) = sg->length;
+	}
+
+	return nents;
+}
+
 static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	 int nents, enum dma_data_direction dir, unsigned long attrs)
 {
@@ -191,8 +204,9 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 
-	if (WARN_ON_ONCE(!dev->dma_mask))
-		return 0;
+	/* TODO: this is here only for loopback mode to have a DMA addr */
+	if (!dev->dma_mask)
+		return dma_map_dummy(sg, nents);
 
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_map_sg_direct(dev, sg, nents))
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece..aa352f017634 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -61,6 +61,7 @@
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
+#include <net/devmem.h> /* this is a hack */
 #include <crypto/hash.h>
 
 /*
@@ -692,9 +693,54 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	return 0;
 }
 
+static int zerocopy_fill_skb_from_devmem(struct sk_buff *skb,
+					 struct iov_iter *from, int length,
+					 struct net_devmem_dmabuf_binding *binding)
+{
+	struct iov_iter niov_iter = binding->tx_iter;
+	int i = skb_shinfo(skb)->nr_frags;
+	struct net_iov *niov;
+	ssize_t prev_off = 0;
+	size_t size;
+
+	while (length && iov_iter_count(from)) {
+		ssize_t delta;
+
+		if (unlikely(i == MAX_SKB_FRAGS))
+			return -EMSGSIZE;
+
+		delta = (ssize_t)iter_iov_addr(from) - prev_off;
+		prev_off = (ssize_t)iter_iov_addr(from);
+
+		if (likely(delta >= 0))
+			iov_iter_advance(&niov_iter, delta);
+		else
+			iov_iter_revert(&niov_iter, -delta);
+
+		size = min_t(size_t, iter_iov_len(from), length);
+		size = min_t(size_t, iter_iov_len(&niov_iter), size);
+		if (!size)
+			return -EFAULT;
+
+		if (!net_devmem_dmabuf_binding_get(binding))
+			return -EFAULT;
+
+		niov = iter_iov(&niov_iter)->iov_base;
+		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov),
+				       niov_iter.iov_offset, size, PAGE_SIZE);
+
+		iov_iter_advance(from, size);
+		length -= size;
+		i++;
+	}
+
+	return 0;
+}
+
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length)
+			    size_t length,
+			    struct net_devmem_dmabuf_binding *binding)
 {
 	unsigned long orig_size = skb->truesize;
 	unsigned long truesize;
@@ -702,6 +748,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		ret = msg->sg_from_iter(skb, from, length);
+	else if (unlikely(binding))
+		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
 	else
 		ret = zerocopy_fill_skb_from_iter(skb, from, length);
 
@@ -735,7 +783,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
 		return -EFAULT;
 
-	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
+	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..f19fdf9634d5 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -23,7 +23,7 @@
 
 /* Device memory support */
 
-/* Protected by rtnl_lock() */
+static DEFINE_MUTEX(net_devmem_dmabuf_lock);
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -63,8 +63,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
-	kfree(binding);
+	kfree(binding->tx_vec);
+	kfree_rcu(binding, rcu);
 }
+EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
 
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -122,7 +124,9 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
 	}
 
+	mutex_lock(&net_devmem_dmabuf_lock);
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	mutex_unlock(&net_devmem_dmabuf_lock);
 
 	net_devmem_dmabuf_binding_put(binding);
 }
@@ -173,9 +177,10 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return err;
 }
 
-struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
-		       struct netlink_ext_ack *extack)
+struct net_devmem_dmabuf_binding *net_devmem_bind_dmabuf(struct net_device *dev,
+							 enum dma_data_direction direction,
+							 unsigned int dmabuf_fd,
+							 struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
@@ -183,6 +188,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
+	struct iovec *iov;
 	int err;
 
 	dmabuf = dma_buf_get(dmabuf_fd);
@@ -198,9 +204,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 	binding->dev = dev;
 
+	/* TODO: move xa_alloc_cyclic as the last step to make sure binding
+	 * lookups get consistent object
+	 */
+	mutex_lock(&net_devmem_dmabuf_lock);
 	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
 			      binding, xa_limit_32b, &id_alloc_next,
 			      GFP_KERNEL);
+	mutex_unlock(&net_devmem_dmabuf_lock);
 	if (err < 0)
 		goto err_free_binding;
 
@@ -218,13 +229,22 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
-						       DMA_FROM_DEVICE);
+						       direction);
 	if (IS_ERR(binding->sgt)) {
 		err = PTR_ERR(binding->sgt);
 		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
 		goto err_detach;
 	}
 
+	/* dma_buf_map_attachment_unlocked can return non-zero sgt with
+	 * zero entries
+	 */
+	if (!binding->sgt || binding->sgt->nents == 0) {
+		err = -EINVAL;
+		NL_SET_ERR_MSG(extack, "Empty dmabuf attachment");
+		goto err_detach;
+	}
+
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
 	 * binding can be much more flexible than that. We may be able to
 	 * allocate MTU sized chunks here. Leave that for future work...
@@ -236,6 +256,20 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		goto err_unmap;
 	}
 
+	if (direction == DMA_TO_DEVICE) {
+		virtual = 0;
+		for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx)
+			virtual += sg_dma_len(sg);
+
+		/* TODO: clearly separate RX and TX paths? */
+		binding->tx_vec =
+			kcalloc(virtual / PAGE_SIZE + 1, sizeof(struct iovec), GFP_KERNEL);
+		if (!binding->tx_vec) {
+			err = -ENOMEM;
+			goto err_unmap;
+		}
+	}
+
 	virtual = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
@@ -277,11 +311,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			niov->owner = owner;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
+
+			if (direction == DMA_TO_DEVICE) {
+				iov = &binding->tx_vec[virtual / PAGE_SIZE + i];
+				iov->iov_base = niov;
+				iov->iov_len = PAGE_SIZE;
+			}
 		}
 
 		virtual += len;
 	}
 
+	if (direction == DMA_TO_DEVICE)
+		iov_iter_init(&binding->tx_iter, WRITE, binding->tx_vec, virtual / PAGE_SIZE + 1,
+			      virtual);
+
 	return binding;
 
 err_free_chunks:
@@ -294,7 +338,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
 err_free_id:
+	mutex_lock(&net_devmem_dmabuf_lock);
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	mutex_unlock(&net_devmem_dmabuf_lock);
 err_free_binding:
 	kfree(binding);
 err_put_dmabuf:
@@ -302,6 +348,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return ERR_PTR(err);
 }
 
+struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
+{
+	struct net_devmem_dmabuf_binding *binding;
+
+	rcu_read_lock();
+	binding = xa_load(&net_devmem_dmabuf_bindings, id);
+	if (binding) {
+		if (!net_devmem_dmabuf_binding_get(binding))
+			binding = NULL;
+	}
+	rcu_read_unlock();
+
+	return binding;
+}
+
 void dev_dmabuf_uninstall(struct net_device *dev)
 {
 	struct net_devmem_dmabuf_binding *binding;
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 76099ef9c482..a3d97fb7d2d2 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -11,6 +11,7 @@
 #define _NET_DEVMEM_H
 
 struct netlink_ext_ack;
+#include <linux/dma-direction.h>
 
 struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
@@ -27,9 +28,16 @@ struct net_devmem_dmabuf_binding {
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use.
+	 *
+	 * For TX, each skb frag holds a reference.
 	 */
 	refcount_t ref;
 
+	/* XArray lookups happen under RCU lock so we need to keep the dead
+	 * bindings around until next grace period.
+	 */
+	struct rcu_head rcu;
+
 	/* The list of bindings currently active. Used for netlink to notify us
 	 * of the user dropping the bind.
 	 */
@@ -42,6 +50,10 @@ struct net_devmem_dmabuf_binding {
 	 * active.
 	 */
 	u32 id;
+
+	/* iov_iter representing all possible net_iov chunks in the dmabuf. */
+	struct iov_iter tx_iter;
+	struct iovec *tx_vec;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -66,8 +78,10 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+net_devmem_bind_dmabuf(struct net_device *dev, enum dma_data_direction direction,
+		       unsigned int dmabuf_fd,
 		       struct netlink_ext_ack *extack);
+struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
@@ -104,15 +118,18 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
 	return net_iov_owner(niov)->binding->id;
 }
 
-static inline void
+static inline int
 net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
 {
-	refcount_inc(&binding->ref);
+	return refcount_inc_not_zero(&binding->ref);
 }
 
 static inline void
 net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 {
+	if (!binding)
+		return;
+
 	if (!refcount_dec_and_test(&binding->ref))
 		return;
 
@@ -133,11 +150,16 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       enum dma_data_direction direction,
 		       struct netlink_ext_ack *extack)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
+{
+	return NULL;
+}
 static inline void
 net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b28424ae06d5..db2060f2bcd0 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -87,6 +87,12 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
 };
 
+/* NETDEV_CMD_BIND_TX - do */
+static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -171,6 +177,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_DMABUF_FD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_TX,
+		.doit		= netdev_nl_bind_tx_doit,
+		.policy		= netdev_bind_tx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 8cda334fd042..dc742b6410e9 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -33,6 +33,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..cd4e4b283ae1 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -780,7 +780,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -837,6 +837,69 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	struct list_head *sock_binding_list;
+	struct net_device *netdev;
+	u32 ifindex, dmabuf_fd;
+	struct sk_buff *rsp;
+	int err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
+	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
+
+	sock_binding_list =
+		genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(sock_binding_list))
+		return PTR_ERR(sock_binding_list);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (!netdev || !netif_device_present(netdev)) {
+		err = -ENODEV;
+		goto err_unlock;
+	}
+
+	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd, info->extack);
+	if (IS_ERR(binding)) {
+		err = PTR_ERR(binding);
+		goto err_unlock;
+	}
+
+	list_add(&binding->list, sock_binding_list);
+
+	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	genlmsg_end(rsp, hdr);
+
+	rtnl_unlock();
+
+	return genlmsg_reply(rsp, info);
+
+	net_devmem_unbind_dmabuf(binding);
+err_unlock:
+	rtnl_unlock();
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
+}
+
 void netdev_nl_sock_priv_init(struct list_head *priv)
 {
 	INIT_LIST_HEAD(priv);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..7472c16553c6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1021,6 +1021,8 @@ EXPORT_SYMBOL(skb_cow_data_for_xdp);
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(netmem_ref netmem)
 {
+	struct net_iov *niov;
+
 	netmem = netmem_compound_head(netmem);
 
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
@@ -1030,8 +1032,13 @@ bool napi_pp_put_page(netmem_ref netmem)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely(!is_pp_netmem(netmem)))
+	if (unlikely(!is_pp_netmem(netmem))) {
+		/* avoid triggering WARN_ON's for loopback mode */
+		niov = netmem_to_net_iov(netmem);
+		if (niov && niov->owner && niov->owner->binding->tx_vec)
+			return true;
 		return false;
+	}
 
 	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
 
@@ -1880,8 +1887,8 @@ const struct ubuf_info_ops msg_zerocopy_ubuf_ops = {
 EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
-			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg)
+			     struct msghdr *msg, int len, struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding)
 {
 	int err, orig_len = skb->len;
 
@@ -1900,7 +1907,7 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			return -EEXIST;
 	}
 
-	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
+	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len, binding);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
@@ -1969,12 +1976,12 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	int i, order, psize, new_frags;
 	u32 d_off;
 
+	if (!skb_frags_readable(skb))
+		return 0;
+
 	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
 		return -EINVAL;
 
-	if (!skb_frags_readable(skb))
-		return -EFAULT;
-
 	if (!num_frags)
 		goto release;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index bbb57b5af0b1..195ce15ab047 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2931,6 +2931,11 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_DEVMEM_DMABUF:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		sockc->devmem_id = *(u32 *)CMSG_DATA(cmsg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..d48c30a7ef36 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1050,6 +1050,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct ubuf_info *uarg = NULL;
 	struct sk_buff *skb;
@@ -1079,6 +1080,21 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			else
 				uarg_to_msgzc(uarg)->zerocopy = 0;
 		}
+	} else if (flags & MSG_SOCK_DEVMEM) {
+		if (!(sk->sk_route_caps & NETIF_F_SG) || msg->msg_ubuf ||
+		    !sock_flag(sk, SOCK_ZEROCOPY)) {
+			err = -EINVAL;
+			goto out_err;
+		}
+
+		skb = tcp_write_queue_tail(sk);
+		uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
+		if (!uarg) {
+			err = -ENOBUFS;
+			goto out_err;
+		}
+
+		zc = MSG_ZEROCOPY;
 	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
 		if (sk->sk_route_caps & NETIF_F_SG)
 			zc = MSG_SPLICE_PAGES;
@@ -1131,6 +1147,24 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 	}
 
+	if (unlikely(flags & MSG_SOCK_DEVMEM)) {
+		if (sockc.devmem_id == 0) {
+			err = -EINVAL;
+			goto out_err;
+		}
+
+		binding = net_devmem_lookup_dmabuf(sockc.devmem_id);
+		if (!binding || !binding->tx_vec) {
+			err = -EINVAL;
+			goto out_err;
+		}
+
+		if (sock_net(sk) != dev_net(binding->dev)) {
+			err = -EINVAL;
+			goto out_err;
+		}
+	}
+
 	/* This should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
@@ -1247,7 +1281,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 					goto wait_for_space;
 			}
 
-			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg);
+			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg, binding);
 			if (err == -EMSGSIZE || err == -EEXIST) {
 				tcp_mark_push(tp, skb);
 				goto new_segment;
@@ -1328,6 +1362,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	/* msg->msg_ubuf is pinned by the caller so we don't take extra refs */
 	if (uarg && !msg->msg_ubuf)
 		net_zcopy_put(uarg);
+	net_devmem_dmabuf_binding_put(binding);
 	return copied + copied_syn;
 
 do_error:
@@ -1345,6 +1380,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		sk->sk_write_space(sk);
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 	}
+	net_devmem_dmabuf_binding_put(binding);
 	return err;
 }
 EXPORT_SYMBOL_GPL(tcp_sendmsg_locked);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 884ee128851e..d6942111645a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -105,7 +105,7 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 	if (zcopy)
 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
 					       &info->msg->msg_iter,
-					       len);
+					       len, NULL);
 
 	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7c308f04e7a0..56f7b87f8bd0 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -199,6 +199,7 @@ enum {
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
+	NETDEV_CMD_BIND_TX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.46.0


