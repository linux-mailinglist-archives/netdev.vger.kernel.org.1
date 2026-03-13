Return-Path: <netdev+bounces-267615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJnCG6J/tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:20:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C556A28A1BB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0675D31436F4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941337F8DE;
	Fri, 13 Mar 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Hhq/LP9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08A3822BA
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436648; cv=none; b=Q7AYXS6F3oQ1o6RGlUNe65H9sg2+ngWR4O/RUs9NFov7d7fQuRYVaBq1ZwC8w+9/492tMdMzj6pLz57tkAqdJ4Wpg5IUaGqCAyFu4fj1PGCt/HLiAF68m1RWt8kVkt/yF5MS/v7DZ+gtJ4h0fBS9Ik5CKrA2lWOC9biEIJRkEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436648; c=relaxed/simple;
	bh=DlDL2ttYOfYtBam5MmQBnpiKGdMaOFz/e5h1cwN4yfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxcp2oZU3nL9L8YF1sSyNEdLjCV+w3cy5TwfjF/cBnlc7zXRK5ANdGYdMJSWmhOXWMcQmRPPyt/npS60EArtrtwFSePWZ32T+Aj2PtlqB0WckhMGZ6+WblzquEKLADf25Llf5oxUzcrMF4miWoFqrPSjCyOYSSuUD9B6B56v2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Hhq/LP9v; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2639104a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436647; x=1774041447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEhVg6/DMBVx7I54wuSmJDYfgLF1HSbncqmJY3EXK18=;
        b=Hhq/LP9vZTFUW7l5a5tiIexZwIuHJssRmI7SqH0GG0AW6oBP6z5YUR1/haKoHOCTKM
         2ZyCFo0HgVIJ472TkyFloQfgBEKunWzLzbFNzuNbejOCdLt5+BVRd6HIVBKJuypA7ZCY
         sbwycD4vY2L5AqODO5d0Ulz510y4UsF83ySPoVFPOLqX3AWMjuqUIiQV7LzFPbPFcmbN
         P4oYmAi9mVqp02NIOyyYt+qx4uKmhN/1FW/QcbqX4liaVd+A/nuhwL/kQjShhS7S2hVK
         KcfguxLjOBfpLt7X1s/BmT1K1U9jopl8iyz/SnDcvIwTBih1nJY/xqg4penaojmkO48m
         8nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436647; x=1774041447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEhVg6/DMBVx7I54wuSmJDYfgLF1HSbncqmJY3EXK18=;
        b=PeHY/jkt4VAWKDOHRzatDuCf1QkkykXeB1dItFST/wnMJQk+CXnIWSWEWFCgFbX2Bz
         UsmbVvZQWhciOywNz/BLNfwFig51xF1HNyYL4MLTunDsZrnCmSG5xw4ZXm1IKezNCkr/
         osxXIMIjjiNlK6Eb/G1q7ajGcZ7XohRy2n/uHa/beGlFJJ/vn5oWsWX+H27px481l938
         RNg5hqN0CeCyQ+v0pPUw9j747kfF0a+Bv5XX2Wn0YAvBeitvvEnicAeU2AS5ET2EU/+p
         4PJeti78zEHZf+xpj//snhhRBNHZj2ksv0Ka+ecI0dEzOP1VZ7gk7UyUDj+QPX3V9MgO
         XvLw==
X-Gm-Message-State: AOJu0YynI7qJhedefh4SmgSkc8wStoIUWDXgsoYcBbGI1GYEBJ1fV3eO
	XulADtQ1F/wvkKe/aFPPqycaKVaWfWydcjsOhiIcMLpVghddrk2swKlTOeA5S9ZpOlKnqD6/njR
	QmI9/lqA=
X-Gm-Gg: ATEYQzzboprDWvSh0wJtuIoOG9toLOxyQPEP7ni5tKftLYKkFDI2GZ60l7eax8D+a4d
	EKkTpH1sVIwdUV6YTTa4Eo6xkCaIYPBseFZ+wPbOM4QWGu6MngcTwLtkNbdQXo8RoAbX3LcNwfG
	L3IY46G5ZNynGU9zfC+dIBmQ8AolkwqF6z2b9ZIau0as4gofd3T/Axt2CAqxmL8rqXDNr6xqTg8
	mVbz5uZrL6u+ZGbaGkcXN3O06/xgR/dU7dnCj8Mre5wa9yut5FAgabLUbPTocH594X6O0cHcgwg
	BfcRPW4yGvFn9O7lGAcxnsa6XGrrBt1W/tIyM5JRFq2gE2KnVT+XZydyibulQvh7zFDEuINorYD
	fsOP+pmwzb09HCgeI3mMYaJvbWZt150Q2RlP/S6W9pKCvJQHUNLma/iTxn5D60CieQcpeMoYkTx
	R3KYISZnyEvzCk07WDbOKuI3xgRt3Vsk44
X-Received: by 2002:a17:902:ef43:b0:2ab:230d:2da9 with SMTP id d9443c01a7336-2aecac46801mr50154515ad.48.1773436646681;
        Fri, 13 Mar 2026 14:17:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 12/12] net/sched: netem: replace pr_info with netlink extack error messages
Date: Fri, 13 Mar 2026 14:15:12 -0700
Message-ID: <20260313211646.12549-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267615-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C556A28A1BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem predates the netlink extended ack mechanism and uses pr_info()
to report configuration errors. These messages go to the kernel log
where the user running tc may never see them, and in unprivileged
user namespace contexts they can be used for log spam.

Replace pr_info() with NL_SET_ERR_MSG() and NL_SET_ERR_MSG_FMT()
which return error details to the caller via netlink. Thread the
extack pointer through parse_attr() and get_loss_clg(). Remove
the uninformative "netem: change failed" message from netem_init()
since the error is already propagated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 9ae09e781166..0b273e44e561 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -937,7 +937,8 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
 }
 
-static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
+static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr,
+			struct netlink_ext_ack *extack)
 {
 	const struct nlattr *la;
 	int rem;
@@ -950,7 +951,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gimodel *gi = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gimodel)) {
-				pr_info("netem: incorrect gi model size\n");
+				NL_SET_ERR_MSG(extack,
+					       "netem: incorrect gi model size");
 				return -EINVAL;
 			}
 
@@ -969,7 +971,8 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 			const struct tc_netem_gemodel *ge = nla_data(la);
 
 			if (nla_len(la) < sizeof(struct tc_netem_gemodel)) {
-				pr_info("netem: incorrect ge model size\n");
+				NL_SET_ERR_MSG(extack,
+					       "netem: incorrect ge model size");
 				return -EINVAL;
 			}
 
@@ -983,7 +986,7 @@ static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
 		}
 
 		default:
-			pr_info("netem: unknown loss type %u\n", type);
+			NL_SET_ERR_MSG_FMT(extack, "netem: unknown loss type %u", type);
 			return -EINVAL;
 		}
 	}
@@ -1006,12 +1009,14 @@ static const struct nla_policy netem_policy[TCA_NETEM_MAX + 1] = {
 };
 
 static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
-		      const struct nla_policy *policy, int len)
+		      const struct nla_policy *policy, size_t len,
+		      struct netlink_ext_ack *extack)
 {
 	int nested_len = nla_len(nla) - NLA_ALIGN(len);
 
 	if (nested_len < 0) {
-		pr_info("netem: invalid attributes len %d\n", nested_len);
+		NL_SET_ERR_MSG_FMT(extack, "netem: invalid attributes len %u < %zu",
+				   nla_len(nla), NLA_ALIGN(len));
 		return -EINVAL;
 	}
 
@@ -1025,8 +1030,7 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 }
 
 /* Parse netlink message to set options */
-static int netem_change(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
@@ -1038,7 +1042,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
-	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
+	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt), extack);
 	if (ret < 0)
 		return ret;
 
@@ -1060,7 +1064,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	old_loss_model = q->loss_model;
 
 	if (tb[TCA_NETEM_LOSS]) {
-		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
+		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS], extack);
 		if (ret) {
 			q->loss_model = old_loss_model;
 			q->clg = old_clg;
@@ -1151,8 +1155,6 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
 	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
 	return ret;
 }
 
-- 
2.51.0


