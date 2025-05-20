Return-Path: <netdev+bounces-191713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB5ABCD60
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42CF3A4730
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6C256C73;
	Tue, 20 May 2025 02:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD52566E2;
	Tue, 20 May 2025 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747709089; cv=none; b=tJVZj4wfdQZKlfgYYBQNGZtNwU7w1glbJRxkiHSGVruaQaPppDGV05oGoXWQoln1Go5cS9akVZvtdp4825KoXK1VX+WVx9e05zJTCVgxPwtecFZHPWIuuqQoHlZokmcSNr85hdqkHKw9C8n9A4l6Z8oiJ6ZF9P70/F3rxXSjUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747709089; c=relaxed/simple;
	bh=AO3acx0F1xrB7Ct42otcaMivOdY422GrOk9AB5fo+kc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ZfU8Gjm+OkkhV1XCUZC4fbrqxpQWQPtmWpOzeWcac3Etshf//inIF0EpbREcClqNQpBqortsfw0sNnHRUT/MJUaus+DVl04rcsPgVfL6jQ2UdbRcDeMNDWZeA+wZo23v+Stt++5s4G5mk1eKVLBJ10vTyF0WqW163DSdFgJCOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b1f5w3lgHz8QrkZ;
	Tue, 20 May 2025 10:44:36 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl1.zte.com.cn with SMTP id 54K2iCZI059387;
	Tue, 20 May 2025 10:44:12 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Tue, 20 May 2025 10:44:13 +0800 (CST)
Date: Tue, 20 May 2025 10:44:13 +0800 (CST)
X-Zmail-TransId: 2afd682bec7dffffffffc2f-d6eb0
X-Mailer: Zmail v1.0
Message-ID: <20250520104413538Q88ZB2XVWu1BthfQkFSuW@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <davem@davemloft.net>, <kuba@kernel.org>
Cc: <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuniyu@amazon.com>, <gnaaman@drivenets.com>, <leitao@debian.org>,
        <lizetao1@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIG5ldDogbmVpZ2g6IHVzZSBrZnJlZV9za2JfcmVhc29uKCkgaW4gbmVpZ2hfcmVzb2x2ZV9vdXRwdXQoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54K2iCZI059387
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682BEC94.000/4b1f5w3lgHz8QrkZ

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() used in neigh_resolve_output() with kfree_skb_reason().

Following new skb drop reason is added:
/* failed to fill the device hard header */
SKB_DROP_REASON_NEIGH_HH_FILLFAIL

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 include/net/dropreason-core.h | 3 +++
 net/core/neighbour.c          | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bea77934a235..bcf9d7467e1a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -62,6 +62,7 @@
 	FN(NEIGH_FAILED)		\
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
+	FN(NEIGH_HH_FILLFAIL)		\
 	FN(TC_EGRESS)			\
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
@@ -348,6 +349,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NEIGH_QUEUEFULL,
 	/** @SKB_DROP_REASON_NEIGH_DEAD: neigh entry is dead */
 	SKB_DROP_REASON_NEIGH_DEAD,
+	/** @SKB_DROP_REASON_NEIGH_HH_FILLFAIL: failed to fill the device hard header */
+	SKB_DROP_REASON_NEIGH_HH_FILLFAIL,
 	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
 	SKB_DROP_REASON_TC_EGRESS,
 	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 254067b719da..f297296c1a43 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1517,7 +1517,7 @@ int neigh_resolve_output(struct neighbour *neigh, struct sk_buff *skb)
 	return rc;
 out_kfree_skb:
 	rc = -EINVAL;
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_HH_FILLFAIL);
 	goto out;
 }
 EXPORT_SYMBOL(neigh_resolve_output);
-- 
2.25.1

