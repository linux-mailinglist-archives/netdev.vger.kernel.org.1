Return-Path: <netdev+bounces-272532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI2VM9V0xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:15:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9403440EB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3C731019D1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F93976AD;
	Fri, 27 Mar 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pFzNQMEz"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FD394786;
	Fri, 27 Mar 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613482; cv=none; b=eRZkkLuZjXu/D6OW+huysXLw0oHAVieUt7Kbyp/q5ZYCsHJoluBsUhCs9WPVN9W3hf/7BrsFtzIttwZpuCcJX+dFqdCqJnC1qi/eRdmtWFWc1spWqPeVm65uoT2n0y3zFQ/+JDYj519HNbV5n3xd5SSqlMET/q1P4PiH4Au+vE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613482; c=relaxed/simple;
	bh=tlKZvQG/sMt7+Xb9g9bbuoIiX4OlCsOkE7Yo+jWjw+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9+GC4dtdtlu0j19wzkCQ3o8jH1XQLb2RRd8ybhGRGP0k+G8U94Ex25F9ANdlwTRhfITa/+QJyZ4Tg/b/LVogad4VhebuEPUhOo0Kt7jYISnrP2bbx/cBnL9QTSdCVoY6u/0y3OKOrUFyORcN8BI6e4ZCbGTkttQwKPPdqJnv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pFzNQMEz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2am3NNVW8DOPB806oaMD9Q3zmCy2lp/U82EK4AImEdk=; b=pFzNQMEzVwyDT2JsONSnfhqbKu
	aKYCEoeGa3vzR7RjypHGLVUkeZcqK0HNgJkO1yDARbck0GMzozajqpoAfh0GRhs5eXxum/oY160F0
	WIqEqxrojJ/eq5h9OL06voFmN3elY/PxifyG+M2iGqxvkXGJrYah1pJvODdZkfCcksb0iRxRV2RGw
	HXnXKurmOeOODbC8PjAJIHdx3kS8hz7ES0hzR5m6/iVNxthawPTQ24Atno0+TezH1ydb1zJyPGhaM
	FTjo9QBj3IrqyrknLClGg591lcIuxgpdI7FB1cbOhyrtY3QUpxiSiDEWYX3kEIZ5z25d5gDrk8yqy
	7tK+t1Vg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661m-000AOU-0t;
	Fri, 27 Mar 2026 13:11:02 +0100
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
Subject: [PATCH net-next v10 09/14] xsk: Proxy pool management for leased queues
Date: Fri, 27 Mar 2026 13:10:44 +0100
Message-ID: <20260327121049.334562-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327121049.334562-1-daniel@iogearbox.net>
References: <20260327121049.334562-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272532-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,fomichev.me:email,blackwall.org:email,davidwei.uk:email]
X-Rspamd-Queue-Id: 2F9403440EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similarly to the netif_mp_{open,close}_rxq handling for leased queues, proxy
the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
that in case a virtual netdev picked a leased rxq, the request gets through
to the real rxq in the physical netdev. The proxying is only relevant for
queue_id < dev->real_num_rx_queues since right now it's only supported for
rxqs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/xdp/xsk.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3fab551eeaf7..f4b048f3c123 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -23,6 +23,8 @@
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/vmalloc.h>
+
+#include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
 #include <net/netdev_lock.h>
@@ -117,10 +119,18 @@ EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 {
-	if (queue_id < dev->num_rx_queues)
-		dev->_rx[queue_id].pool = NULL;
-	if (queue_id < dev->num_tx_queues)
-		dev->_tx[queue_id].pool = NULL;
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+
+	if (id < dev->real_num_rx_queues)
+		WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &id));
+
+	if (id < dev->num_rx_queues)
+		dev->_rx[id].pool = NULL;
+	if (id < dev->num_tx_queues)
+		dev->_tx[id].pool = NULL;
+
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -130,17 +140,30 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id)
 {
-	if (queue_id >= max_t(unsigned int,
-			      dev->real_num_rx_queues,
-			      dev->real_num_tx_queues))
+	struct net_device *orig_dev = dev;
+	unsigned int id = queue_id;
+	int ret = 0;
+
+	if (id >= max(dev->real_num_rx_queues,
+		      dev->real_num_tx_queues))
 		return -EINVAL;
 
-	if (queue_id < dev->real_num_rx_queues)
-		dev->_rx[queue_id].pool = pool;
-	if (queue_id < dev->real_num_tx_queues)
-		dev->_tx[queue_id].pool = pool;
+	if (id < dev->real_num_rx_queues) {
+		if (!netif_get_rx_queue_lease_locked(&dev, &id))
+			return -EBUSY;
+		if (xsk_get_pool_from_qid(dev, id)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
-	return 0;
+	if (id < dev->real_num_rx_queues)
+		dev->_rx[id].pool = pool;
+	if (id < dev->real_num_tx_queues)
+		dev->_tx[id].pool = pool;
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
 }
 
 static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
-- 
2.43.0


