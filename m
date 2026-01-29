Return-Path: <netdev+bounces-254925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AplBW3fe2llJAIAu9opvQ
	(envelope-from <netdev+bounces-254925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AAB54FA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0673038174
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892236BCCB;
	Thu, 29 Jan 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZQSYUjnE"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78636AB62;
	Thu, 29 Jan 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725736; cv=none; b=lmo/pVWLuIr57rC64bNstaA7LVi5mQ35uEN9oILEwNv2ZD/8nMs59PgFlRqoPuxWWWe9XGCEdlazGXcDPFFz5hUO9F616lWAKeGEsllVXHZXJ+H38DudZUNCbUL++eHE+YATSLaSVmMlMWUkq7yx3njojN1PsnIfVw4u6m9exvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725736; c=relaxed/simple;
	bh=tCvEJqPPRL7GYzgMn0RHhIaTG4ngjsVvpq4l/MTe+Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWt0UsB70QF89VrFZ6wH94af7FUFWSA8AIUdTpV1e5n9sJ2/PGuc3jArPZXlag7phsYw5coGwMFfS2JLVU0iSMiuYd7+uokxzkupA5wWNjpibjImS/mO08kPI3xoZ8lJP43UefMOoAsizx57b9QmC9Q3KvZqn1fyzcvAZipm1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZQSYUjnE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LaHv4DoCDm/HiMvtVTiFyHclXG5EZtnKLXNRnEj5X1g=; b=ZQSYUjnEE+J0uM4NcdOgZ3kvOj
	fVlpabQRW8wZjNp6JOQ8w62ybO9dtv3wnZFFjU82jTa3B4oUcF9cFijSzXusrA3JsBchrr7ay3wqQ
	HgimEqDN2KwMuEmVRHY7Dadh/sv0bTlmC4EnX0fWLiFQMJeTbkWC8UA3wpXdssN7qZd2N2e8x+pp+
	Ao41XN2D5gYL0agkLD3MOMGvjeDacNxfWw5hZD4zmDFlCHySupgtSM7bm2MCPzyZmIpIAVRvCaL/P
	NH9SfAnrhVQl8D20ibIvA8hIAxvL4o20bJZvX72O+ygnDo5HiIN3cjS43Ld5PwmGhVthPjIUUY4Tp
	8Cwon1BA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVB-0008os-2k;
	Thu, 29 Jan 2026 23:28:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v8 05/16] net: Slightly simplify net_mp_{open,close}_rxq
Date: Thu, 29 Jan 2026 23:28:19 +0100
Message-ID: <20260129222830.439687-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254925-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: 815AAB54FA
X-Rspamd-Action: no action

net_mp_open_rxq is currently not used in the tree as all callers are
using __net_mp_open_rxq directly, and net_mp_close_rxq is only used
once while all other locations use __net_mp_close_rxq. Simplify this
into a single API into __net_mp_{open,close}_rxq and rename the
latter into net_mp_{open,close}_rxq given the __ prefix then becomes
unnecessary.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h | 14 +++++-------
 io_uring/zcrx.c                         |  4 +++-
 net/core/devmem.c                       |  6 ++---
 net/core/netdev_rx_queue.c              | 29 +++++--------------------
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index ada4f968960a..03ffec4e5331 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -23,15 +23,11 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
-int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
-		    struct pp_memory_provider_params *p);
-int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		      const struct pp_memory_provider_params *p,
-		      struct netlink_ext_ack *extack);
-void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
-		      struct pp_memory_provider_params *old_p);
-void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
-			const struct pp_memory_provider_params *old_p);
+int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		    const struct pp_memory_provider_params *p,
+		    struct netlink_ext_ack *extack);
+void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *old_p);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b99cf2c6670a..adefa34acac0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -521,7 +521,9 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
+		netdev_lock(netdev);
 		net_mp_close_rxq(netdev, ifq->if_rxq, &p);
+		netdev_unlock(netdev);
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -806,7 +808,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
-	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
+	ret = net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
 	if (ret)
 		goto netdev_put_unlock;
 	netdev_unlock(ifq->netdev);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 63f093f7d2b2..d508df34cbed 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -145,7 +145,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
+		net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
 	percpu_ref_kill(&binding->ref);
@@ -163,7 +163,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	u32 xa_idx;
 	int err;
 
-	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
+	err = net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
 	if (err)
 		return err;
 
@@ -176,7 +176,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return 0;
 
 err_close_rxq:
-	__net_mp_close_rxq(dev, rxq_idx, &mp_params);
+	net_mp_close_rxq(dev, rxq_idx, &mp_params);
 	return err;
 }
 
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 7319de3ced2b..f30fe7550455 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -191,9 +191,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		      const struct pp_memory_provider_params *p,
-		      struct netlink_ext_ack *extack)
+int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		    const struct pp_memory_provider_params *p,
+		    struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
 	struct netdev_queue_config qcfg[2];
@@ -255,19 +255,8 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		    struct pp_memory_provider_params *p)
-{
-	int ret;
-
-	netdev_lock(dev);
-	ret = __net_mp_open_rxq(dev, rxq_idx, p, NULL);
-	netdev_unlock(dev);
-	return ret;
-}
-
-void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
-			const struct pp_memory_provider_params *old_p)
+void net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+		      const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
@@ -296,11 +285,3 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
-
-void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
-		      struct pp_memory_provider_params *old_p)
-{
-	netdev_lock(dev);
-	__net_mp_close_rxq(dev, ifq_idx, old_p);
-	netdev_unlock(dev);
-}
-- 
2.43.0


