Return-Path: <netdev+bounces-286199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOc8ER9r/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:13:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FB500A9F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B43A302D5D1
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131E3BD638;
	Sat,  9 May 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="EIBopuqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B03BD22F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346695; cv=none; b=Rw/Ar9ERm8tlgZIHeLx84pnfofsUvf7LKdyl8Jnww0JjkYkIvSKDwsrd9MKoh1b/rCtakrABRWYQhbLpZmBWkqGf0/UBcskIPV1DQ2OoU9eexNBeAVw4CDRLCvkN2zknHl4XeuX22X/3O3yddln6DhPDJz4vjtW6hQ3/5pvrsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346695; c=relaxed/simple;
	bh=RQrx2d2FwtjpRzRv7tYhBmYdcUrZnk9ci5oY/OphN6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1gxsJxchbb+QRnFKzcRt8HjXjt1cypuHj5hxPcK9EqL3H5Qc4Qi35ETOy0UGhbhiI3RhO3oZNhKnKBzoFsswXs608p4mEKRVh4+3lnMSZOcJPxjRXQKNKby4nD796EU7w4Fdgifa6VSkqtWNkK/3X5cEpEf367YA9ay59CLKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=EIBopuqg; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5369284eec.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346691; x=1778951491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vErAbYMlCEdGOQOS9I0amTdK1+90/qI1fzJK++j/sx4=;
        b=EIBopuqgq0MV5pFBWqWxL4mFPGrHmG8bh3byJB2V5jkujgh3+BI5DEquVKXWr3x852
         zhrdONejfNdKBy3wz/9WTGa7OPBgO/LZXk2OxiTLw30XqvYljs1QP4D7avSC+dAixn7M
         E6LRfqMLJdiE8A2VkjgL8xGfs5pG4p8kz6wca8s2Y0Cu8Txcb8xINL33Ve9g4AGKVxN4
         UFYdTUhofBbrbar8Fyn9oBWZuOHTNqPo7/SkQxTsnBxTFsmZn2IROiuoEK3HOlffzMGx
         e32pKWUClKeUlyxZXMwo10qojnP2Ngiqr6m6C7Y8MZp5aEDQNu2T4VVR5X1vyqFWKfPO
         IjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346691; x=1778951491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vErAbYMlCEdGOQOS9I0amTdK1+90/qI1fzJK++j/sx4=;
        b=eYUZefn3C0HD1T+78siTq7SkU3V1cQY7wFmzTB3UMV9F0EKOyBpF9k5Az1CflV/vYC
         NUeL46H4RTOXyeZLov31Dd+QSHvqbEEhuOGVcfd9AkgWu/hzYzseE/nyO818vMiv8cqx
         RDapVbc7ikI4IgJt87UxIJIB8o7oYgtmb9Ton9N1n8Pzzc5uGlGZwE2eCADGwrKkrQss
         Vedoo6gU5egpu/6DKh6leu4RSvFoRzxMZBpsADM3JWfmKlVBe0Yu4Kdlqu8mYpVCnQ7M
         2MrKlViFNliIife4laW9e0fyKFe9TJo7vQ8SbV9M+PLV0dHIFhv7zQEYipf11jhos5VQ
         LMKA==
X-Gm-Message-State: AOJu0Yz7p5zeIm4vqq/o8FoyiCphJUxq43pDvS+ZM9Cw9TDtPZWhhmYk
	jdaEo5903y2/cRfAI4aU5KskYddH1O2x3JBd/NRpKcfU39RmDSqCt0V6O/EaUQQQttNpDk/sdDl
	4BvOa
X-Gm-Gg: Acq92OHOT3sCWQscV844i/hGH7BpfsaRrFFwBFGFPiCLaooH4+hAPZ4Py4c15DTlhsn
	OQGdWm5cU8Iv/2iJwVe2BSDyeNbFMQZPX1oUXS3mi20gJZmoSQSuXSrJHyvxNLkd4WBINbE4+bE
	QPPALb02f2QWOT2blpuBkvZ5k2VivleO9LJFnyVCoKCgycO+KP2DN3jq5X0FigiBM2k0InNz8gj
	RVihutKaldwnyapg57oWbhVHje5mw4mejQjYQiBezD+qEMqowxaDi5n0algDr11DKzJIwUPOhUF
	E9mvuAEfPi76w8V/So5WQ+wHTTr7KyNp7jrI/FbhNIy+N047fHm6/83821mIj9Y69SxS1Mu8sck
	Fy/1T7sGc5uP/gdOvrhv3jmABEQslhzGR11JNVfoV1DlNQDR6GfGNoXJZivxJ1FbWj7U9lb98Al
	2krBPTTksP+2BJtLpVkNNkcAFUiNDReTx0
X-Received: by 2002:a05:7300:8b84:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-2f5508508d7mr8611170eec.26.1778346691239;
        Sat, 09 May 2026 10:11:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:30 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/5] net/sched: netem: replace pr_info with netlink extack error messages
Date: Sat,  9 May 2026 10:03:24 -0700
Message-ID: <20260509171123.307549-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509171123.307549-1-stephen@networkplumber.org>
References: <20260509171123.307549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D58FB500A9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Use netlink extack to report errors instead of sending them
to the kernel log with pr_info(). The error message can them be seen
with tc commands; and avoids log spam.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6480de1d07d9..cea6b6182913 100644
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
@@ -1181,7 +1187,6 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		      struct netlink_ext_ack *extack)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
-	int ret;
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 
@@ -1192,10 +1197,7 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 	q->prng.seed = get_random_u64();
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
 
-	ret = netem_change(sch, opt, extack);
-	if (ret)
-		pr_info("netem: change failed\n");
-	return ret;
+	return netem_change(sch, opt, extack);
 }
 
 static void netem_destroy(struct Qdisc *sch)
-- 
2.53.0


