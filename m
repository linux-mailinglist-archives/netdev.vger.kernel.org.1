Return-Path: <netdev+bounces-275260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHsJFfdE0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EB398DC0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC33E300898B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595037A498;
	Fri,  3 Apr 2026 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="mAmudrgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11E377017
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256820; cv=none; b=SN/GwzTf7wzx/dN7ZTJpJxq3Crf6zfcNjmRefSTacmLY511wF+1u95nxhkzkOLPEzbyM9ajZv5vd7FThubt+/Q/jbGCDv2rK4f/nPpsCcHY0BZlj3608wuC+fna8QyAOI78Ikb3YtsscFh82cEWDgF3ovuzTPfS9iC2iBrTV/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256820; c=relaxed/simple;
	bh=QkpIrfqcHO45Y8k0EHUz6vOHEgFpIhh2MQbefDAyH4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7xwx2I7xEniwldG8a8CNth14lCLE2BC59Xiu77T2vQEfd2EQOlroLwzOHOzZImE3wIErtK9J4X96AZlNLpOKcOUFohms2GrP6ZU5fyCuLklr3zc6I75Wz8+K7W0OT4GaX+J7YH3mzXrjqmbfTQVot30xCt4XEpRU6eEc6uzs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mAmudrgc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1299524a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256818; x=1775861618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp04CFBar6MYdENUMl7F5EarSvpMJQLZmhNOPVRjb3Q=;
        b=mAmudrgcGWfJRi/9+vD/zAVs6TwRBP6ia4Un4SEil90XBUZVoYZywMAn3Asj/sk/HA
         UIdi/Nfk6YOtiIaw7lbSNhc+yQrZtLnKNbg1pN2X4tUBkt0zAu/yorWoe13PSnrTWTEg
         0XbX8aYQRvgJkLFPXWba44P79rL6gUvabCx1DYD4lv1vET4DP4sewxGrZqz4DUYPB1Up
         VyjeCAfzCCxHFrcam71wxh+uASMNzF+B2JmpNyyjn/IRk5WAeOmDeJ92D3TDnW0ou4tN
         OGsdx5anwEO+z9fCRtvxarm4eRFkkuTcto5MnFobcmttQnTxH7hASVKr7qsX+zTS6Fuk
         8SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256818; x=1775861618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xp04CFBar6MYdENUMl7F5EarSvpMJQLZmhNOPVRjb3Q=;
        b=jjU6Gpy7kYu+AsL7ycYaDeK6xRsJmp60HYf7fuPLovSCbmYEw8Iqg0fDzGtIasp5lL
         EDNl7yyPCwi1Uc+sC8aIcqQT7HNn4aeLZbl/WLSUuJaUHx19bx+zHIUuAzsxqgm9mlz1
         2wf7l+D/29IPy+bwdgfdEVnoMDnunNhtpRb1Fqm1ENGDAKD0HBHOx9zdU3EWBuHhsTBC
         Tb50DarnF+BWujjlaUR1ExvFNIzGGQwoWrNdVq+JptXSHLhAa7gbl/e8tx7AP83WRCPR
         oY3+ZsJMs+hJpjAAkjkd+J0sRYB5SbR9ZAQLb7vadQPVGD706lD2/vdm2lcqTi1lP73K
         e5Rw==
X-Gm-Message-State: AOJu0YwBRY1vgUNK5bgb7hGQK1E2wXwZHvBizW+H+wau3mIONMRivf02
	T/Hqgyg1mbceJcVHAN0dJgT8ByxyZPDAdaDghLmhAuoVsYrOHfWNu2wr+y3Wb3wzup27hNw35la
	0FaOi
X-Gm-Gg: AeBDieu5ZiJN5UKPlf6ScD+FHWsYwDoIgBOffox9BTU7MCIRE/JiNKIEOwNkfGfGbqz
	/ZLYUkqmevUunrcsEMcn9ZZZMRmFK4S9aGaQJr7DJkWEYj0XzJJu4ZZkGR8CHbqCgWXrMNTqVrl
	d+T49L0uUeGtsEFPNYsI9sJBYDYR04ws+y+n0/MyBL1snCwiVlHcB8xfWjU37Mw5Wxz/rpnzrVN
	TBfPmxp9gFdg+LUMVNkQAxp8HJF5j8zD/Omj1NaB/2QvBd3oRCt6yuXMhZH+k5/wVqzP9RYe+QD
	TP+wtxdXRYwWfjwn9NJ+YBt4b4kmgyx89g/Fx9muaV5T2R5VOUr+b9wJmcuaS8/ECDa0+WWxOZk
	FfJLCxrE72+hu2KVaKoGVk3WJQdJqq2puD0f5sIzhKxoDAv5t9p1hs947uKw3DRJXsa7YhgHgnx
	wp/ckQw3Op+jIeGV6t+j2KRc9drqIBVRlx
X-Received: by 2002:a17:90b:48d2:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35de682817emr4369681a91.11.1775256818263;
        Fri, 03 Apr 2026 15:53:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/5] net/sched: netem: replace pr_info with netlink extack error messages
Date: Fri,  3 Apr 2026 15:52:06 -0700
Message-ID: <20260403225324.476787-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403225324.476787-1-stephen@networkplumber.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275260-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: DC3EB398DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem predates the netlink extended ack mechanism and uses pr_info()
to report configuration errors. These messages go to the kernel log
where the user running tc may never see them, and in unprivileged
user namespace contexts they can be used for log spam.

Replace pr_info() with NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT()
which return error details to the caller via netlink.
Remove the uninformative "netem: change failed" message from netem_init()
since the error is already propagated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..acf92cc44126 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -805,19 +805,24 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr,
+			  struct netlink_ext_ack *extack)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
 	struct disttable *d;
 	int i;
 
-	if (!n || n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "invalid distribution table length");
 		return -EINVAL;
+	}
 
 	d = kvmalloc_flex(*d, table, n);
-	if (!d)
+	if (!d) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "allocation of distribution table failed");
 		return -ENOMEM;
+	}
 
 	d->size = n;
 	for (i = 0; i < n; i++)
@@ -888,7 +893,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -901,7 +907,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, attr, "incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -920,7 +926,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, attr, "incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -934,7 +940,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_ATTR_FMT(extack, attr, "unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -957,12 +963,13 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, size_t len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG(extack, "invalid attribute len");
 		return -EINVAL;
 	}
 
@@ -1011,8 +1018,7 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
 }
 
 /* Parse netlink message to set options */
-static int netem_change(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
@@ -1024,18 +1030,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
 	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
 
 	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST], extack);
 		if (ret)
 			goto table_free;
 	}
@@ -1046,7 +1052,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1135,13 +1141,13 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 
-	if (!opt)
+	if (!opt) {
+		NL_SET_ERR_MSG(extack, "missing parameters");
 		return -EINVAL;
+	}
 
 	q->loss_model = CLG_RANDOM;
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.53.0


