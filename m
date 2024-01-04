Return-Path: <netdev+bounces-61614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F5824673
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F04282BF8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89512250F2;
	Thu,  4 Jan 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcXFhRhm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7625560
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so203436a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386354; x=1704991154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhbY+v12ve1yL5Ldf33Tz3oo+ah7uJgW7E4zT5w4b98=;
        b=IcXFhRhmN69VDBfgVdpr3iplh4h35+qXqYkenB5UcVS8e/6E9VjIbcxgL0+yxDFRmE
         J+bHmU6xgHE3PHsjSFbOCIvXw0tsJqU6HLwqwWgjx55v8fJb0vlocBvC5vnUUsfYSWLP
         272UBfseYW1kdlSvB979HudhVEoyp3ucyYuMcnCcGAuKSfsP0ZnG7mapDtpHCFtR6wmb
         G0NnLKMMysv84zQj1RcP/54M2FG5WHlpjLtuiwo95cQtKhlTPn01HQjTFNnaiokSPX+M
         5ebxNZ6jNNWPfM3/+lJ25tArDf0b5+aWPwG+3tuhhRAoHEmW/X7l45JsMG8ZPZQwd/dN
         CswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386354; x=1704991154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhbY+v12ve1yL5Ldf33Tz3oo+ah7uJgW7E4zT5w4b98=;
        b=TWgYFf8Hzr9Aw2FhDyWkn3LeSwQK51Mtl+YlDvqMS7pP/yFQIPFmU9PSgsKGB85Bzs
         1xY4MsyvdX0GU+zFKDWgU3Cx234wfNKIurf/2CdloNp6JCwWpsbl04un/ewsrlRtMztz
         ik+cMDlVARYI1PH7VIUphqNsLcuaucOqSh4NJDVidJHL/zkaNv5Js5abMbV8+aT2MUKo
         mhAhRx0VEZ70oVhXJsYuVxcXG997D3qBeopc6meGgf6fr1Ipsz/zk4xzdrqrOLL2vNr9
         yb0ITlrxaM7gh/25CNQlbUs6XlQVX9zZ9/q1JaYWeIKGoDy97ylFoVn1GZymlq3kFNWC
         +8Xg==
X-Gm-Message-State: AOJu0YzAGULal6d8TfUuIEn7t5fAYBtu/9FDoa+cNstRx1+1szejPLyE
	Rvu+5KpiANjcyaVoYZlxigc=
X-Google-Smtp-Source: AGHT+IEB4FXH1N8c7id+eEKq6TZd7uQ3BQ0JKlv2qDUqPeEdRPu0kE1gmGEOaznWTTsUGXNtkCFb2A==
X-Received: by 2002:a17:906:c9d1:b0:a27:6d9c:8194 with SMTP id hk17-20020a170906c9d100b00a276d9c8194mr482089ejb.119.1704386353723;
        Thu, 04 Jan 2024 08:39:13 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id lz2-20020a170906fb0200b00a26aa845084sm13551551ejb.17.2024.01.04.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:39:13 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [RFC net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
Date: Thu,  4 Jan 2024 17:38:56 +0100
Message-ID: <20240104163856.16699-1-alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of now, the field TCA_TAPRIO_ATTR_FLAGS is being validated by manually
checking its value, using the function taprio_flags_valid().

With this patch, the field will be validated through the netlink policy
NLA_POLICY_MASK, where the mask is defined by TAPRIO_SUPPORTED_FLAGS.
The mutual exclusivity of the two flags TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD
and TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST is still checked manually.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 net/sched/sch_taprio.c | 70 +++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..8766934c4f00 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -40,6 +40,8 @@ static struct static_key_false taprio_have_working_mqprio;
 
 #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
 #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
+#define TAPRIO_SUPPORTED_FLAGS \
+	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
 
 struct sched_entry {
@@ -408,19 +410,6 @@ static bool is_valid_interval(struct sk_buff *skb, struct Qdisc *sch)
 	return entry;
 }
 
-static bool taprio_flags_valid(u32 flags)
-{
-	/* Make sure no other flag bits are set. */
-	if (flags & ~(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST |
-		      TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD))
-		return false;
-	/* txtime-assist and full offload are mutually exclusive */
-	if ((flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
-	    (flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD))
-		return false;
-	return true;
-}
-
 /* This returns the tstamp value set by TCP in terms of the set clock. */
 static ktime_t get_tcp_tstamp(struct taprio_sched *q, struct sk_buff *skb)
 {
@@ -1031,7 +1020,8 @@ static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =
 		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &taprio_cycle_time_range),
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
-	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
+	[TCA_TAPRIO_ATTR_FLAGS]                      =
+		NLA_POLICY_MASK(NLA_U32, TAPRIO_SUPPORTED_FLAGS),
 	[TCA_TAPRIO_ATTR_TXTIME_DELAY]		     = { .type = NLA_U32 },
 	[TCA_TAPRIO_ATTR_TC_ENTRY]		     = { .type = NLA_NESTED },
 };
@@ -1815,33 +1805,6 @@ static int taprio_mqprio_cmp(const struct net_device *dev,
 	return 0;
 }
 
-/* The semantics of the 'flags' argument in relation to 'change()'
- * requests, are interpreted following two rules (which are applied in
- * this order): (1) an omitted 'flags' argument is interpreted as
- * zero; (2) the 'flags' of a "running" taprio instance cannot be
- * changed.
- */
-static int taprio_new_flags(const struct nlattr *attr, u32 old,
-			    struct netlink_ext_ack *extack)
-{
-	u32 new = 0;
-
-	if (attr)
-		new = nla_get_u32(attr);
-
-	if (old != TAPRIO_FLAGS_INVALID && old != new) {
-		NL_SET_ERR_MSG_MOD(extack, "Changing 'flags' of a running schedule is not supported");
-		return -EOPNOTSUPP;
-	}
-
-	if (!taprio_flags_valid(new)) {
-		NL_SET_ERR_MSG_MOD(extack, "Specified 'flags' are not valid");
-		return -EINVAL;
-	}
-
-	return new;
-}
-
 static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
@@ -1854,6 +1817,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	unsigned long flags;
 	ktime_t start;
 	int i, err;
+	__u32 taprio_flags;
 
 	err = nla_parse_nested_deprecated(tb, TCA_TAPRIO_ATTR_MAX, opt,
 					  taprio_policy, extack);
@@ -1863,12 +1827,26 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_TAPRIO_ATTR_PRIOMAP])
 		mqprio = nla_data(tb[TCA_TAPRIO_ATTR_PRIOMAP]);
 
-	err = taprio_new_flags(tb[TCA_TAPRIO_ATTR_FLAGS],
-			       q->flags, extack);
-	if (err < 0)
-		return err;
+	/* The semantics of the 'flags' argument in relation to 'change()'
+	 * requests, are interpreted following two rules (which are applied in
+	 * this order): (1) an omitted 'flags' argument is interpreted as
+	 * zero; (2) the 'flags' of a "running" taprio instance cannot be
+	 * changed.
+	 */
+	taprio_flags = tb[TCA_TAPRIO_ATTR_FLAGS] ? nla_get_u32(tb[TCA_TAPRIO_ATTR_FLAGS]) : 0;
 
-	q->flags = err;
+	/* txtime-assist and full offload are mutually exclusive */
+	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
+	    (taprio_flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack, "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");
+		return -EINVAL;
+	}
+
+	if (q->flags != TAPRIO_FLAGS_INVALID && q->flags != taprio_flags) {
+		NL_SET_ERR_MSG(extack, "Changing 'flags' of a running schedule is not supported");
+		return -EOPNOTSUPP;
+	}
+	q->flags = taprio_flags;
 
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
-- 
2.43.0


