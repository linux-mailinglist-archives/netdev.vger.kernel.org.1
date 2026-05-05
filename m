Return-Path: <netdev+bounces-284535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG55IAQs+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BD4D23B0
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41853082EB5
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243674ADD8A;
	Tue,  5 May 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="nlXyG47Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAE4A3413
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002870; cv=none; b=b4a4dM4KpsFGCxKSQlDxiW7UDK5UYV7KTqnfgGt21gb22YXqeZgrL5/EIAqZJ1lE477ISYAkMy22Z1o8olXbK4A0Lc4kSR0C2KAAqUBpfvwST4xaSm9+yPJlOuRZjATHxuVMDVj59vy0xMPAtDwgr5l70FYDpBn7yBd4LzS2pA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002870; c=relaxed/simple;
	bh=HtYVrg/Vw4mSVH94F9/G2mEG9V6Dst5DVZvTk7ojCJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZu5HmecA9C82TMURS6Dh9FsZbQUqY6Nv4LqIsQC50L0oP2Chnao6eEr5sW+5/aedhnlYM5uifLnNN9yma/v94Gg+GswzsL5wvFLxLbDx6tdk76wsNiNEOmblcM0m4yNjvhHkLfGZRFrKGTv5qO37H6nMfNZuujjmVSERfQ0INE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=nlXyG47Y; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-464bba3a9easo2838695b6e.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002868; x=1778607668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CXiOetWfOPX+NNCrDyidAkyh9VnGD6A1wMqx06ky2Q=;
        b=nlXyG47Y2KScPhnqDVNckN7XZCymm/0wIbB0XxXaRBWa+oPEHvZntAU/uEYVjx74Xx
         JQCuRJ0LM++bumtMEd7KVzgfAYkb2a1ctF7hC6C/OT75l7xCvteoLkVnXDTYUzM1Ehl3
         9vFmv7WqXNCvA64j9AKmP+G5HlcEvYFizf4Riij+a/lYKXN2WcY+kBHgJyKikCRT0ZyA
         OkMaz9wj+p+1a4UO8vMFhEGB30JBc9QOtFF0CohlYRNNFV3SbdT6fFoO2qHCB3aP6wpB
         HrEWAhpjNyrDxszKDzkeQ6VXzZL/3B8jvmRr6G5n+/9Elyr8Lz1tbJS4UzXJHCKPCJhT
         f93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002868; x=1778607668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CXiOetWfOPX+NNCrDyidAkyh9VnGD6A1wMqx06ky2Q=;
        b=cK9JrN0nKLf2XFsdSsLQH7RERQxsWQalb9zfXDb+gfpieJrXZJD5tsHc+CvEj63PNu
         PMzRsvBUsCp9aOA5Lj0o16DxM0KqYfqRMy/7t3iUfgTOMjqQf9LUK1QvvIyghY5QEQ80
         6PaCWlojoOB10000mCgD9oln84eaStmpeOnaCY6EP3CZ94sfQEbzVphz7WXFBOx54GHU
         WOZmvYvfTA/OQAzqfPQ/nfb4PvLfctOcYegobJHgX8+xwW5jC/yi+K84ZY5odNQwqPpR
         xRHAQu/nL6U7SBLIhLnISrXGZq5GahgcXl2ZW3lNni/kgP5pBj/My7I3E2IUSk/7jEvg
         3+Kg==
X-Gm-Message-State: AOJu0YwPpGAcr77ZUlEKYdEzOh7F00KXX+hl9VAKIIjEaOLADMOf+Hqj
	f9LpqGUO9RgdAmHVXWLX1vb81Z51+/eOhQU9cQXhrz1b4YiPMaO46h5wyfoGhnnoyg6YXcY7jVR
	yVGJb
X-Gm-Gg: AeBDievAZaF/MhxGCg4lJ5Nuw4W61NyCvY2VZ8WiGD8ujV5nMt4nhVrxfnQMhGaBk9O
	vqL6AQRLfdWdj9kumh8h4dinBEV6YLe5CJE6ZA13CU6op67H7H7gERnjwhyldEEtu+KmG+n3KGq
	KWgUZL9ksi0quuMm0n3Vj55AXpZws06fJzVIof03EWuMTp6PqifM70oJ9O4sX7GVouUI1kxnElr
	4D9EBfHkDqxo4l3v0s4Rak66R9W1fBqpMUuGeHxo3jG7nVIuhW6ixaSpm4VyaQX48+Uad8pM2pF
	3AsoyglHXn6i6wK5tSO3Xr3756VXq6HlDNWxuCSThsZ+0zpCnFqZMTVOH3H9ViyCSYEPVJjBmMl
	VIWVEpjN/1OcxlK853RDuZmk6ztAIy3hxBShjO7ZzOwmKziKGfZEGgEQSWGyKrknrO1PmT1wmdz
	1KwW/QYFwd0SLI4udIixHCWQTcVf3rso6JxUXG4/aoPV8=
X-Received: by 2002:a05:6808:320c:b0:467:880:744a with SMTP id 5614622812f47-48042496b28mr3826b6e.24.1778002867971;
        Tue, 05 May 2026 10:41:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 3/5] net/sched: netem: replace pr_info with netlink extack error messages
Date: Tue,  5 May 2026 10:38:43 -0700
Message-ID: <20260505174059.651260-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505174059.651260-1-stephen@networkplumber.org>
References: <20260505174059.651260-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E84BD4D23B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284535-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]

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


