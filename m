Return-Path: <netdev+bounces-192132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1AAABE9A0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E116D26E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B322CBE8;
	Wed, 21 May 2025 02:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7822CBC0;
	Wed, 21 May 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793673; cv=none; b=mhVn2UOElEQrT6xdwBRMdVOOYybpWBZm+RdLWnjI67X9digoXrzsX6n+1wac5grf5aaRhn+7a83WU5xMcXWwK3AIdk5X2go47mcVYHLM2CF+bNynwxjikhJebAk+NFRamESpz//tbaBgsK42oCwJKqT1jjkaoDtouipvj0ia4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793673; c=relaxed/simple;
	bh=6zpccith/abrhU1H7DLUzXdUOdDU3udxwjvX3isTFRg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=AOKtN750IOQzHPz7KEyjartAhH3ax70H7t5FddczRX46DHyNpq+UnLICFxLQIm86QCO2+jt8d1Va5kvqeqZSlkQuTe6SXwLA2c3zjKkQUr2L9tx6nNQ03K9pQykuAXaNPXDnOv7oHuGhE4LIaw/SfpUvF4NFGG6lCTCBQdy2oWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4b2FNd73Vrz51SYf;
	Wed, 21 May 2025 10:14:25 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 54L2E7Kj094652;
	Wed, 21 May 2025 10:14:07 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 21 May 2025 10:14:08 +0800 (CST)
Date: Wed, 21 May 2025 10:14:08 +0800 (CST)
X-Zmail-TransId: 2af9682d36f0076-b1c22
X-Mailer: Zmail v1.0
Message-ID: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <horms@kernel.org>, <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <fan.yu9@zte.com.cn>,
        <gnaaman@drivenets.com>, <he.peilin@zte.com.cn>, <kuba@kernel.org>,
        <leitao@debian.org>, <linux-kernel@vger.kernel.org>,
        <lizetao1@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <qiu.yutan@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHQgdjJdIG5ldDogbmVpZ2g6IHVzZSBrZnJlZV9za2JfcmVhc29uKCkgaW4gbmVpZ2hfcmVzb2x2ZV9vdXRwdXQoKSBhbmQgbmVpZ2hfY29ubmVjdGVkX291dHB1dCgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54L2E7Kj094652
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682D3701.004/4b2FNd73Vrz51SYf

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() used in neigh_resolve_output() and
neigh_connected_output() with kfree_skb_reason().

Following new skb drop reason is added:
/* failed to fill the device hard header */
SKB_DROP_REASON_NEIGH_HH_FILLFAIL

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
v1->v2
https://lore.kernel.org/all/20250520180552.GP365796@horms.kernel.org/
1. use kfree_skb_reason() in neigh_connected_output()

 include/net/dropreason-core.h | 3 +++
 net/core/neighbour.c          | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index 254067b719da..a6e2c91ec3e7 100644
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
@@ -1541,7 +1541,7 @@ int neigh_connected_output(struct neighbour *neigh, struct sk_buff *skb)
 		err = dev_queue_xmit(skb);
 	else {
 		err = -EINVAL;
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_HH_FILLFAIL);
 	}
 	return err;
 }
-- 
2.25.1

