Return-Path: <netdev+bounces-285570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAzjNCpE/WlDZwAAu9opvQ
	(envelope-from <netdev+bounces-285570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F64F0AD3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3079C304C070
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00525333F;
	Fri,  8 May 2026 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="n+SHHv7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFD2566D3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205596; cv=none; b=QCoyK29s0pWWilIn9Mop7t6saz7I1r40+1S0Aqm9+RgdwfqWyVJXTQ3rC5Z/1mRXRskkf0+kKOPN0HBa/YvAZYhtjSVCuV3Z074mxJh+eBxf6mMWSBFCWEYbuN07sdDZCUdJYn1qKOKrqeWeFCifwt4EPeh569vv7eZXKuJZFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205596; c=relaxed/simple;
	bh=HtYVrg/Vw4mSVH94F9/G2mEG9V6Dst5DVZvTk7ojCJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOprT7BZz1PlCrysAQguTfwktLMRQvJwzpwfGOKcM3FMh/KsJMK2AtJN9/Cbu1ZyZ8YguD/QPq1/69Uo7nhpHG+obna+MtSVD/ivZoyUKiccwCHHCg86O9/Xsgprh3ktEm92IKpjc8iUVscU4Rdu9mll7FUY11S6IId5awLgYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=n+SHHv7X; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1638048eec.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205591; x=1778810391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CXiOetWfOPX+NNCrDyidAkyh9VnGD6A1wMqx06ky2Q=;
        b=n+SHHv7XDmnqyOmU2DoAtXsUUGiZPWSD8+GjAH2/onJq4/2ep6/uwhagNZX+P8NWRY
         bbxb+sHjPkJiXfMIzRcKzHiegrMllk4oQXbop8LkoceFatlQM6Xf1DuWjOq4P8tXQ9H7
         K5h8mlilHcvegttJdPpxNLMJPyZcRUt18faD4mUaOlnRdghxnhyvsybSum6LBlrG5HuB
         rZ3M5jLWeaXEm9CZeABQGzKxKjWXESs6SWHAPGiEcsWtoZj1Xw6/ivC5n7mMtyhOjob+
         xQrdy+FUPrOVH9MGensA25cKFVHH/p/MIYVdJ32zE7dyOXcOWl+cxuur1HP0SVXTM5yU
         SjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205591; x=1778810391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CXiOetWfOPX+NNCrDyidAkyh9VnGD6A1wMqx06ky2Q=;
        b=c4J6FKGtuyDaGDPz7HZI3uExX/VLhcS2bf0i7Wf/UvIo+PfoNg4qvScC7DY81FZvTH
         D4sAakY803M9/YsxsWC5RBJVu9gFNYSzuC1ICvinetnid7q8Uko0fINxoA+8ug0EpyNI
         PS9KXZQUaigx+HcL543sP83U1YEoiH/yjxyOdxl4ZWgL2Zu5bzxFF8gfvhsS7ZNQ2mpU
         OFN8maOIPnxh5EGXfXf4pV6/qv8G039TyxtJLaHN39UpfphY3b8wUf9YkJ/e7Vyzb5IZ
         aWQVm6cgCgNGDm/lRWhLc30zJmX+h0B3CITqnI3uPRh9t5OjALq7GwfJmJY4NvpDVIRN
         IYIQ==
X-Gm-Message-State: AOJu0YztEUK9V52Tw5ZTBrM3S3iltC1YbYA93K3XAoJZQJ7MD589JUvB
	ZBHpJmpwUoW+1QouuO0gUkfXPefg+MrZYl0U/+q0AYg7tNZWRmyYBWqkOqzcsKjbhxn1kYDBDqI
	ogKxw
X-Gm-Gg: Acq92OHU2Y06Pcu3hhqqHGDDBUE2jlY7E2uCFkQjddtljDMJzEViHAYcxteWdKziBX0
	MnT1LoaHv04bWNL3BCJM7R5MDNAvlGY2qYikdfUvTc2EEQfqDe0W39/RgeI0LY1pF+K+WC2JqWA
	VS28jwePYj4FSHRNK0YROG5Y24HOxvn+HkeZtOs3WfUyDLEvwhd+kTUPWhlGvvwXZoshhrv2PRY
	kznn7MKTWDz6r46ftnfpYY4A5zMNG1FttKa+YthAYeJMZagP05vIM7ZiDKvbfL7ZIwfYVq6VZKn
	e2Fr6iQjt1G0mPfZVlFnHO3MC8IW/FKD1ndl4UqkQIcz4jl7ym1WROY5e/VDjS6mCrWmPtsBo8z
	Vq8miX/redxroKJ11zB/1MiYHnBq9TeW/RSWCREoOvKUCM8v2nsUO1EekzLkI5ELA/PpncV0A7z
	K7CyrAmsLkj9Qb92VjMFVhuzgi/oi5LYFE
X-Received: by 2002:a05:7301:3f07:b0:2ed:b131:240e with SMTP id 5a478bee46e88-2f54a67d551mr5571411eec.23.1778205591355;
        Thu, 07 May 2026 18:59:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/5] net/sched: netem: replace pr_info with netlink extack error messages
Date: Thu,  7 May 2026 18:55:19 -0700
Message-ID: <20260508015940.554462-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508015940.554462-1-stephen@networkplumber.org>
References: <20260508015940.554462-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 348F64F0AD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Use netlink extack to report errors instead of sending them
to the kernel log with pr_info(). The error message can them be seen
with tc commands; and avoids log spam.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 2b0b5c032e70..53bdfa77ee2d 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -921,7 +921,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -934,7 +935,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, la,
+						    "netem: incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -953,7 +955,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG_ATTR(extack, la,
+						    "netem: incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -967,7 +970,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_ATTR_FMT(extack, la,
+						"netem: unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -990,19 +994,21 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, int len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG_FMT(extack, "netem: invalid attributes len %d < %d",
+				   nla_len(nla), NLA_ALIGN(len));
 		return -EINVAL;
 	}
 
 	if (nested_len >= nla_attr_size(0))
 		return nla_parse_deprecated(tb, maxtype,
 					    nla_data(nla) + NLA_ALIGN(len),
-					    nested_len, policy, NULL);
+					    nested_len, policy, extack);
 
 	memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
 	return 0;
@@ -1057,7 +1063,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
@@ -1097,7 +1103,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1193,8 +1199,6 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.53.0


