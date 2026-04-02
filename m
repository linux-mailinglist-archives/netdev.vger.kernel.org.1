Return-Path: <netdev+bounces-274749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFYJEx/5zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E6538F1C4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19CE302C90B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CB3F8E10;
	Thu,  2 Apr 2026 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H8jsTT6g"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988E3F87EF;
	Thu,  2 Apr 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171462; cv=none; b=HaRfHydNxrMi79b30otQDb97b2tsFz8+5QmJTA7KqLqnDXS1/gDPvEIRxgTaFxt2uItncbyk7m2KHhA0uEetNw6uPKFg/vwWgs1ZWqL/co2svgNqhsl4mDLKVrHro+dGfuwrlo4JUTcFmtZojeS3vNYrDWUscTMItRZfA2wfxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171462; c=relaxed/simple;
	bh=hNDu3eJ4J7O/zcV2mpuFyhWssq7kjxPzuSQo9lj8y/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfwo8kZtOx7/v8qL64pGyOpd5xKPWgFmLi4RpaLzN3JTySceKxvlk4FVr0wz4wmjqiuunL620gkz2o/eW03MMwxrI8Eu2GMewxPrMUKos6xfEHgewXI5VA31zCD8iZRgANiPiX3R/D9j5vvnogGMKOXZXzY/ZsMmdm/fIDILbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H8jsTT6g; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=f0rSvfzaM9Ky6M3d2ODGghwhrbH2a94DluTNSokhUz8=; b=H8jsTT6gdLX7l6fxRVrU6LPcdR
	0PclgVMmLaOACvMDEeG+UYWBpRpnsWjLZAW9fR98JHHaj0FoKIJD3kVa8SPoh/Qbq2uMXRhmdosTK
	cHuUTYnBQTN0FhrIwLnsKTe1XI1di2lcuE8xt0OKKxvI1PpCAcs2pQDOhn9UB+Rx76rHhbAF9HHD0
	hFeVBD5IEBWf71nlEzBa3cWpPB9yzrC4qXRras3oTi7Zsleerx33RNsfuYRaFL/QAHOmNjoqMKDFh
	JNfv7QrmtVAG98aloxG1q2+20PCZTaGa2vAVhqY1+4Jm2zgH+eEDBNhboj3PBztTYzNrBpptfa6EA
	uZLoXUeQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBP-0000me-1B;
	Fri, 03 Apr 2026 01:10:39 +0200
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
Subject: [PATCH net-next v11 05/14] net: Slightly simplify net_mp_{open,close}_rxq
Date: Fri,  3 Apr 2026 01:10:22 +0200
Message-ID: <20260402231031.447597-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27959/Thu Apr  2 08:25:45 2026)
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
	TAGGED_FROM(0.00)[bounces-274749-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,davidwei.uk:email]
X-Rspamd-Queue-Id: A4E6538F1C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_mp_open_rxq is currently not used in the tree as all callers are
using __net_mp_open_rxq directly, and net_mp_close_rxq is only used
once while all other locations use __net_mp_close_rxq.

Consolidate into a single API, netif_mp_{open,close}_rxq, using the
netif_ prefix to indicate that the caller is responsible for locking.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/page_pool/memory_provider.h |  8 ++------
 io_uring/zcrx.c                         |  9 ++++++---
 net/core/devmem.c                       |  6 +++---
 net/core/netdev_rx_queue.c              | 23 ++---------------------
 4 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index ada4f968960a..255ce4cfd975 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -23,14 +23,10 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
-int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
-		    struct pp_memory_provider_params *p);
-int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack);
-void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
-		      struct pp_memory_provider_params *old_p);
-void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p);
 
 /**
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 62d693287457..d3ec63c83d0c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -552,8 +552,11 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
-		if (ifq->if_rxq != -1)
-			net_mp_close_rxq(netdev, ifq->if_rxq, &p);
+		if (ifq->if_rxq != -1) {
+			netdev_lock(netdev);
+			netif_mp_close_rxq(netdev, ifq->if_rxq, &p);
+			netdev_unlock(netdev);
+		}
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -841,7 +844,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		mp_param.rx_page_size = 1U << ifq->niov_shift;
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
-	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
+	ret = netif_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
 	if (ret)
 		goto netdev_put_unlock;
 	netdev_unlock(ifq->netdev);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 69d79aee07ef..cde4c89bc146 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -145,7 +145,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
+		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
 	percpu_ref_kill(&binding->ref);
@@ -163,7 +163,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	u32 xa_idx;
 	int err;
 
-	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
+	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
 	if (err)
 		return err;
 
@@ -176,7 +176,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return 0;
 
 err_close_rxq:
-	__net_mp_close_rxq(dev, rxq_idx, &mp_params);
+	netif_mp_close_rxq(dev, rxq_idx, &mp_params);
 	return err;
 }
 
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a4d8cad6db74..06ac3bd5507f 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -200,7 +200,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack)
 {
@@ -264,18 +264,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
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
+void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
@@ -305,11 +294,3 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
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


