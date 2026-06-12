Return-Path: <netdev+bounces-298529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2vjADl3JK2oEFAQAu9opvQ
	(envelope-from <netdev+bounces-298529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7A677FB4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:54:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298529-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298529-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00F15301DCE6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3733B6D1;
	Fri, 12 Jun 2026 08:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0931A3172
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254490; cv=none; b=FVau3bzy+mwtINsH7H+OpKDxYVNfKQl7NyKj8a+hMnA77jmDwe2pEd3C/NmEakNVneTQfvAPos1uTelCb9TE56vYxWoid4Jo8EJvkh/sOSxNeW+28hGO1Njqs9CWh4BCTz28/5TmRRNq6SrLyvAn1xZOpNxdwCeWBTILQLM1X7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254490; c=relaxed/simple;
	bh=ofxGsvKOcFY6hn6hK0cFJi+LwExQfBatgOovk1WLMmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cBIxsDV/K3WjMNUqPVyBKfJkQFraq9n+9BQCv14Kfh/+9GAxnqaJpA+ZAU/GTfI1MKYDNIi4d2mMMfiUhOgba2yVyRGi80D7//BdpldsUs0Cv1STk45Pj22wcXRXMycSTzUtcqdab5Nl6oapgb0ASoY6D1wB5Pg+Gphdt0mpBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 5b23c06c663c11f1aa26b74ffac11d73-20260612
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d562147a-fd30-4387-b9f7-1333f8107962,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:d562147a-fd30-4387-b9f7-1333f8107962,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:953913ec72285e1037708d686b59b0ab,BulkI
	D:260612165444UWQUWVHT,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b23c06c663c11f1aa26b74ffac11d73-20260612
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.160.128.21)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 6499796; Fri, 12 Jun 2026 16:54:43 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [net] net/sched: fix partial tx_queue_len change rollback
Date: Fri, 12 Jun 2026 16:54:38 +0800
Message-Id: <20260612085438.834763-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298529-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:zhaochenguang@kylinos.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88A7A677FB4

When dev_qdisc_change_tx_queue_len() fails partway through updating
per-tx-queue qdiscs, previously updated queues were left at the new
size while netif_change_tx_queue_len() only restored dev->tx_queue_len.

Pass the original queue length and roll back successfully updated
queues on failure.

Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 include/net/sch_generic.h |  2 +-
 net/core/dev.c            |  2 +-
 net/sched/sch_generic.c   | 26 +++++++++++++++++++-------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 11159a50d6a1..fa5cae1b1e84 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -704,7 +704,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash *,
 void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
 void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev);
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int orig_len);
 void dev_qdisc_change_real_num_tx(struct net_device *dev,
 				  unsigned int new_real_tx);
 void dev_init_scheduler(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9f7d..bff2760a301a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9934,7 +9934,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 		res = notifier_to_errno(res);
 		if (res)
 			goto err_rollback;
-		res = dev_qdisc_change_tx_queue_len(dev);
+		res = dev_qdisc_change_tx_queue_len(dev, orig_len);
 		if (res)
 			goto err_rollback;
 	}
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a93321db8fd7..d4c62e1f2a75 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1400,13 +1400,14 @@ void dev_deactivate(struct net_device *dev, bool reset_needed)
 EXPORT_SYMBOL(dev_deactivate);
 
 static int qdisc_change_tx_queue_len(struct net_device *dev,
-				     struct netdev_queue *dev_queue)
+				     struct netdev_queue *dev_queue,
+				     unsigned int len)
 {
 	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	const struct Qdisc_ops *ops = qdisc->ops;
 
 	if (ops->change_tx_queue_len)
-		return ops->change_tx_queue_len(qdisc, dev->tx_queue_len);
+		return ops->change_tx_queue_len(qdisc, len);
 	return 0;
 }
 
@@ -1443,9 +1444,10 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 }
 EXPORT_SYMBOL(mq_change_real_num_tx);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev)
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int orig_len)
 {
 	bool up = dev->flags & IFF_UP;
+	unsigned int new_len = dev->tx_queue_len;
 	unsigned int i;
 	int ret = 0;
 
@@ -1453,11 +1455,21 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
 		dev_deactivate(dev, false);
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
-		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
-
-		/* TODO: revert changes on a partial failure */
+		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i], new_len);
 		if (ret)
-			break;
+			goto rollback;
+	}
+
+	if (up)
+		dev_activate(dev);
+	return 0;
+
+rollback:
+	while (i-- > 0) {
+		int err = qdisc_change_tx_queue_len(dev, &dev->_tx[i], orig_len);
+
+		if (err)
+			netdev_warn(dev, "failed to revert tx_queue_len on queue %u\n", i);
 	}
 
 	if (up)
-- 
2.25.1


