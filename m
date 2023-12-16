Return-Path: <netdev+bounces-58296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26E815BBD
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA12284B3F
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890251E493;
	Sat, 16 Dec 2023 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1L1SK0dK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04B1E490
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b5f4a1b48so300352a91.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702759490; x=1703364290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGkCjqBrZueI7OLLPxcfcXU1Q2LF7+DyN4ePbi7d7l8=;
        b=1L1SK0dK2s1FWr3TxJw9tJ3CFWiMFX+/gxe7iLWxTtPQKVm0MJAdds2eGXR9aO/N8c
         hapZ7lpdhwy1j4RPo4awlUX+Bk0k8KGwPOVGYMJNKtZBin8W15LTSughGnzqkawk7dSM
         Z9JPArfUT7PjICe7A5wz8C7fr2YK8CTsBjP5IJTDpM9Wb5rHAt7AzjOgroyEUbJIHiWA
         xX9g2rF7PfesR0OgUC5uMzIlUDJjaYJuNgewNnIeNSdnTUjDWzuwCTU3NOJReubKF0/8
         VxTFj1bhr3NhiyuErcwFC4gZpSdwJpYU+EeaAfYpYzHI+yFbBb4EleT9eU5LxnjHd5ZY
         jpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759490; x=1703364290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGkCjqBrZueI7OLLPxcfcXU1Q2LF7+DyN4ePbi7d7l8=;
        b=gwXPKQjb1EfP2PTR2rJOL8JKIG6oCR/LTOQaCpT8RKyFr12JnaB6eEyDBY5HAYRSl7
         OQK+C/su7V4Sp3Kbmk2ypswnkmdSv8Ab4dwyFmG4BjjPZyAW5GoRpoauH74e5wi//kxf
         MZcMQMH/p3qKBwB4RrYRcQm5xwHSliQBFVDenGOG59BxtACOgaU8SUdvlxd/yROpXYsd
         hME6kP436c4DyGSpXbkY8cU/7UrbRed0deCjg/CfztY8MMjVwdZNDWW1MKb5zbbMGN4T
         YHFAVbGYFy3WwoH34geTWtZ6SdyqBpjhSvskvdPlQtH9Mzm5hZs1XJBvJQ/0g4pnEwq8
         FjMA==
X-Gm-Message-State: AOJu0Yy+lYRTdKZIySk4/Ss4tC4HNZ0PfKZE6n9O8Ohpx/TZrooRIAkS
	bOcNigu4LbJjS7JZoiAUKSZEFA==
X-Google-Smtp-Source: AGHT+IGhdt27a5+l17qODfuyqalJpVaWc704JOlZ0ifLMAXgSt8IXKjdGMeOOTq6yIkGPfxZM8dbsQ==
X-Received: by 2002:a05:6a20:85a7:b0:191:309:1646 with SMTP id s39-20020a056a2085a700b0019103091646mr9728215pzd.20.1702759490273;
        Sat, 16 Dec 2023 12:44:50 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b0028b5739c927sm1380343pjb.34.2023.12.16.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:44:49 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v5 2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Sat, 16 Dec 2023 17:44:35 -0300
Message-ID: <20231216204436.3712716-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216204436.3712716-1-victor@mojatatu.com>
References: <20231216204436.3712716-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incrementing on Daniel's patch[1], make tc-related drop reason more
flexible for remaining qdiscs - that is, all qdiscs aside from clsact.
In essence, the drop reason will be set by cls_api and act_api in case
any error occurred in the data path. With that, we can give the user more
detailed information so that they can distinguish between a policy drop
or an error drop.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/pkt_cls.h     | 16 ----------------
 include/net/pkt_sched.h   | 19 -------------------
 include/net/sch_generic.h | 31 +++++++++++++++++++++++++++++++
 net/core/dev.c            |  7 +++++--
 4 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 761e4500cca0..f308e8268651 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -154,22 +154,6 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
 	return xchg(clp, cl);
 }
 
-struct tc_skb_cb;
-
-static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
-
-static inline enum skb_drop_reason
-tcf_get_drop_reason(const struct sk_buff *skb)
-{
-	return tc_skb_cb(skb)->drop_reason;
-}
-
-static inline void tcf_set_drop_reason(const struct sk_buff *skb,
-				       enum skb_drop_reason reason)
-{
-	tc_skb_cb(skb)->drop_reason = reason;
-}
-
 static inline void
 __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long base)
 {
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9b559aa5c079..1e200d9a066d 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -275,25 +275,6 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 	skb->tstamp = ktime_set(0, 0);
 }
 
-struct tc_skb_cb {
-	struct qdisc_skb_cb qdisc_cb;
-	u32 drop_reason;
-
-	u16 zone; /* Only valid if post_ct = true */
-	u16 mru;
-	u8 post_ct:1;
-	u8 post_ct_snat:1;
-	u8 post_ct_dnat:1;
-};
-
-static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
-{
-	struct tc_skb_cb *cb = (struct tc_skb_cb *)skb->cb;
-
-	BUILD_BUG_ON(sizeof(*cb) > sizeof_field(struct sk_buff, cb));
-	return cb;
-}
-
 static inline bool tc_qdisc_stats_dump(struct Qdisc *sch,
 				       unsigned long cl,
 				       struct qdisc_walker *arg)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c499b56bb215..1d70c2c1572f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1036,6 +1036,37 @@ static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 	return skb;
 }
 
+struct tc_skb_cb {
+	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
+
+	u16 zone; /* Only valid if post_ct = true */
+	u16 mru;
+	u8 post_ct:1;
+	u8 post_ct_snat:1;
+	u8 post_ct_dnat:1;
+};
+
+static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
+{
+	struct tc_skb_cb *cb = (struct tc_skb_cb *)skb->cb;
+
+	BUILD_BUG_ON(sizeof(*cb) > sizeof_field(struct sk_buff, cb));
+	return cb;
+}
+
+static inline enum skb_drop_reason
+tcf_get_drop_reason(const struct sk_buff *skb)
+{
+	return tc_skb_cb(skb)->drop_reason;
+}
+
+static inline void tcf_set_drop_reason(const struct sk_buff *skb,
+				       enum skb_drop_reason reason)
+{
+	tc_skb_cb(skb)->drop_reason = reason;
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 16af89a733e4..b87504078320 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3753,6 +3753,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 	qdisc_calculate_pkt_len(skb, q);
 
+	tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+
 	if (q->flags & TCQ_F_NOLOCK) {
 		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
 		    qdisc_run_begin(q)) {
@@ -3782,7 +3784,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 no_lock_out:
 		if (unlikely(to_free))
 			kfree_skb_list_reason(to_free,
-					      SKB_DROP_REASON_QDISC_DROP);
+					      tcf_get_drop_reason(to_free));
 		return rc;
 	}
 
@@ -3837,7 +3839,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	}
 	spin_unlock(root_lock);
 	if (unlikely(to_free))
-		kfree_skb_list_reason(to_free, SKB_DROP_REASON_QDISC_DROP);
+		kfree_skb_list_reason(to_free,
+				      tcf_get_drop_reason(to_free));
 	if (unlikely(contended))
 		spin_unlock(&q->busylock);
 	return rc;
-- 
2.25.1


