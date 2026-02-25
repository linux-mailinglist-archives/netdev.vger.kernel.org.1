Return-Path: <netdev+bounces-260959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCdLEYb9nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:47:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E419858C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9391430F4991
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC623C199E;
	Wed, 25 Feb 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i4C2PrQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF13C1990
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027048; cv=none; b=kQFiDQEuKa8ZJWp+T+ROer4Fc8Xks31MqWDu5oXSNB0sgRwHPn3xPhb2w9/kvdkKQYgvrcbJ1TKfrGgqLAoVg2datssrI8fVzLAYRMSx8MfxKLjhQyrAS+/zIbDZJ/1ezhKIDwWQeFCrgWBfZIaBeFBYjD5LFceWxLm1Cn//Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027048; c=relaxed/simple;
	bh=Tv8D3ooWHsrrQJZJU6Zs5IraaN6Rhqt7asbjzaLch48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRQh/kvB/B36ZTO/jHxpAWkWMUvtxVCo66SrV26cFChxmOwp9Teei7uey05ksqZ/4XVEbAHLQEFPP+6cJAUkLAZ6pH2Q/LnKP0UtirnZZtbDEjelScXFvGZBgIkROucKwEj0j2v5d0KgMAqIec/1G0X5Ph+iqzfP/sXo0NW2rlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i4C2PrQr; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56636dc53a6so2280876e0c.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027046; x=1772631846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuB5WURp7hHKc2L/wHlQOaLe5kBJBFcQNgXO3P8yPlc=;
        b=i4C2PrQr8Tjgi9TH4oU4tNwDrye1t59p/MttTHR7Djs32QJhaIsaXj+G/Ko5DaTcZG
         VV69rkOX4286DbkJ20ijZ31XgNqMpC5dU9aQ/TU6/P0MIhwQPnW9rRJ+Hw0WA8rxURdq
         SY4drUMKb4IOrKNXkSHj1nRwVZedpG+OTQaC4Zmd0Ho490PkPFgqbwobnzHhdCGagoUp
         4EXubLKboxXoqa02dVvw5aV+MkG7Hk00Jxp6W6TH/dCozCwe0a7aI5dVGPs4DSTtMrTs
         BO+c6ABIsnMBGAzUcCUBZ191l6b6+xXi2pS6wsSii3ZUrXPLUOD62W/A9v7utXqtWPV9
         3Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027046; x=1772631846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuB5WURp7hHKc2L/wHlQOaLe5kBJBFcQNgXO3P8yPlc=;
        b=YHs6pKC0A+YuTHGzvWFqa9Un4dSvCnq6wb3Gg+CMtZ6uYKulskiolfP19cAPmlaDTo
         CH7ArMbQxmxWIYXwyMXtNagzpN0gd5vKqyqtuMTMpP7Rr2nqo2/ej+10KUudmSlYv+Lf
         gTu2jzjIxDhwAsgMMgVwHns0WF2XRlIILzKosnLcX90KAYSbjbX1uxai2DfOJ5DJu4Wg
         CVM8KpFOWH/jt7XDQvqcM4+msta/YjBM96zVuFg6U/zy0i25D56AkDCNr9PVkoSslBA1
         TmcMtgNxnDUKcwjO9jNLiB8kmI7jT+eGVCS/MtXq9lqoeqlwq9PuulmkzpEMrQsRZXTq
         az3Q==
X-Gm-Message-State: AOJu0YztvYXADptAVxlYob3XhIfaYX1lvtlSViYha2A88soFwLLeg3Ml
	o5/e7R97B5fMmXFqOjlTYRqSAhhXO3jVcwx3HR/LYsihzfX5og202T01CWOwwL2Ljg==
X-Gm-Gg: ATEYQzwpsEyfmoXDqTDf7v8AiJqFzHFd1YPJY95WJ+YnUIFLNB88rKixbFzwugY23lR
	R1UHzkv8nDJAr+kpYqUAKUK0KC36vYw44bYGXhe9iKmUO6YQxAoqxN2/KeQXWIqgBUfKs6zR4UG
	0Dq1brYfNmyDVD8IiH6BtObHHGni3WIj5IjB2cjR2ocDxcQTLPlb4S14dQX+PX11lpOLwAjntEJ
	me3cDpum+DWcVtLkKeYXlWRVw/N36nEYbV62jHvBDirxXK72SoDGf3lnZRRXsU3GUV+A9KhwgUM
	2Z+Ppo4Xte9/ld+lB89bk1S70OE1F0U7HDgKL308HAPmXACxGxrG03PMzwba6zBP42GKqzD52U5
	vQaqjM/ruyPzFqyyiNpAbD8qJVkmxkrsDp9hldqZ/p0jAkFalI1nbTq++6a1d28H3WkqF445zKl
	TpT8rYKSE=
X-Received: by 2002:a05:6122:318b:b0:566:eb31:4713 with SMTP id 71dfb90a1353d-568e4867e06mr6015124e0c.9.1772027045652;
        Wed, 25 Feb 2026 05:44:05 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e57d42fbsm15971517e0c.6.2026.02.25.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:44:04 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	taoliu828@163.com
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	km.kim1503@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
Date: Wed, 25 Feb 2026 10:43:48 -0300
Message-ID: <20260225134349.1287037-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260959-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: E17E419858C
X-Rspamd-Action: no action

As Paolo said earlier [1]:

"Since the blamed commit below, classify can return TC_ACT_CONSUMED while
the current skb being held by the defragmentation engine. As reported by
GangMin Kim, if such packet is that may cause a UaF when the defrag engine
later on tries to tuch again such packet."

act_ct was never meant to be used in the egress path, however some users
are attaching it to egress today [2]. Attempting to reach a middle
ground, we noticed that, while most qdiscs are not handling
TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
address the issue by only allowing act_ct to bind to clsact/ingress
qdiscs and shared blocks. That way it's still possible to attach act_ct to
egress (albeit only with clsact).

[1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org/

Reported-by: GangMin Kim <km.kim1503@gmail.com>
Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
CC: stable@vger.kernel.org
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/act_api.h | 1 +
 net/sched/act_ct.c    | 6 ++++++
 net/sched/cls_api.c   | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 91a24b5e0b93..2ba40eb45aad 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 81d488655793..7de6eb3ff53b 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		return -EINVAL;
 	}
 
+	if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching ct to a non ingress/clsact qdisc is unsupported");
+		return -EOPNOTSUPP;
+	}
+
 	err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
 	if (err < 0)
 		return err;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ebca4b926dcf..8c72faf3314d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
 	return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
 }
 
+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
 	if (is_qdisc_ingress(parent))
 		flags |= TCA_ACT_FLAGS_AT_INGRESS;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-- 
2.52.0


