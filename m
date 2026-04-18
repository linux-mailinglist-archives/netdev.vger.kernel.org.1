Return-Path: <netdev+bounces-279455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNFwEPb44mneAwEAu9opvQ
	(envelope-from <netdev+bounces-279455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:22:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5F41FD58
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598B130A5DC5
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591DB3290BB;
	Sat, 18 Apr 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="iFjiiAic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B25331A6E
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776482439; cv=none; b=HuhcnrnL2z4kp8SioA2ZJQEbV9N2V4SoPnIrN3ISW/l9ahKkCXVLK5smtJtWV/zoo7e8wFTRQIBtdHxDO8v809VC4Ztacj755nRQTKXZLwqDYloiEaX3kzn/udmQRCRZmadnSNFZlh5c2iotzhcGX+W77IpQAZgT4D08Ai1J4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776482439; c=relaxed/simple;
	bh=fL0OfMMtDWSxHR0JJrLSv+7El8c9nsPcZEBdX0sgkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPKIh7dg2QoYFwMjvgaZXoFqUnMJJplPIxi7AVGtqnnHzzb//eY8+HyRqW3UByG0snNWHamQkn14eM8RX3q6Uk0gHhULTR7WhRyoFJ3ScasCfwdcyDSPmR9zkAIkBpZpcnQjQyehu2JvIuosALJDgMEPejBj0eDzK+xTHlAXukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=iFjiiAic; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d55b97f358so805244a34.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482436; x=1777087236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=iFjiiAicdHzJQlvCp+hUz7TFMlGdPrR+a7N5Q4VLFmcEHDnC/Nu548yOaDqxYj6GA5
         DfDWmjxyUWGP6kQ45VMWOBTflFJ3SBUX1eATToWB5n/Zfu3RmGPZ8OREWrjQ4gfHzZyS
         WnaKUbO7B8yAQzF1VuN5rhdnPqWrtGnAFEFKdU2zgBRzSR2H4B5bJgr88eQnA1BfA6L8
         0YYkhFuJp4vuhg+bDdNum6HkHhrtdYgZzjcZ4whtAfCJ644YzzY+zFe2fmljZZaoIiTo
         lYQ1DE08tWKcgIHDe2piFHH0MZ47aIvhoe+TjBccCrKsjXzCdNQjcABLT2Sn49G/S3We
         8Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776482436; x=1777087236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=ni/ygUOJRnVTpzmznhYOoTAU+PyzaUujYQKv3ViSQvALtTepQDnijaNlnXmjYGhKHB
         JTFaUmwhJ+4rKQqYBTn9O4u93dfq/VWU+CgRt6hC4QK8BkIlR6V2l1A6gb61t4K0TnJL
         x0zNenpTVwjLyJcULwITdqF6wQGQLl411X8XGeEVUc2oERfrZyPfEKCTDP8vzVOlwzIA
         Jn5g8/qkZEpeWsHETOGFbf6Y76fqFLgBC7GGa0vAMBXFkLz0HKskItGOTZE6IHXlJLjA
         zmljOMWtijHN+ZOxsFPMMDq3v2sS50sLxKDVjHBkc4jOyGTSoB/peV6DMU+/afntUfHW
         36wA==
X-Gm-Message-State: AOJu0YxnnrFZpg2NpuOI54eS8JRqTxaPIJeYQvuy8IMppE63uOSTyf8k
	wBJKd7PIPnMXb3kyhDnt2xU+vMKwpjakq0UhILzSzSnq4gDGptls1JJIJXSeUzrXRvMLUmeL2z5
	uMAus
X-Gm-Gg: AeBDievL1CBuGPfHAB8cfDEKhAfdwDO59bDkXxWgSFNoLmg1evd563d3xkJDSHi4kMd
	fmmFELOjilsmxA/X8ddHp1EQZlnMMmDC95/it2ay8fUd23qMKQDGZKFpmSctHibbJS1p3MEl2OH
	Yw6LKwsNUefefPOypoKisElRS8kajz2leX9d1yD0X3r+SMTUi77lxO9XHgaaW6IUJaIjRk+KcLi
	XqTl0HWO72CuBKX14NlXVHvRChawgaSChgAwcENgxZhMS1NcpBd1DdFBLMIaV/6or6iRBP0r/BR
	ytkpDjev5v8R5/6VscyBkPQKbzzJoYFmdSAyiMAOcot1j3YyPrxHuNHGxSbYdVzhnJfc12HbJpw
	Mp+ceXlzqktiHF5fJUxqEMQHUCIUdB2Oo/Cgsw91ENPf3o1VWX9uX/hzp256oHLbRjcZiCGQ62/
	xjRDXcNQWt4PvIhw0h/QyMNE3HP9A3M0X83gF/fmioloA=
X-Received: by 2002:a05:6830:7305:b0:7d7:cea3:6d89 with SMTP id 46e09a7af769-7dc94fc94ecmr3702427a34.4.1776482436533;
        Fri, 17 Apr 2026 20:20:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dca7b6b5bdsm276902a34.5.2026.04.17.20.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 20:20:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	horms@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v8 3/6] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Fri, 17 Apr 2026 20:19:41 -0700
Message-ID: <20260418032027.900913-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
References: <20260418032027.900913-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279455-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94A5F41FD58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_change() unconditionally reseeds the PRNG on every tc change
command. If TCA_NETEM_PRNG_SEED is not specified, a new random seed
is generated, destroying reproducibility for users who set a
deterministic seed on a previous change.

Move the initial random seed generation to netem_init() and only
reseed in netem_change() when TCA_NETEM_PRNG_SEED is explicitly
provided by the user.

Fixes: 4072d97ddc44 ("netem: add prng attribute to netem_sched_data")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d400a730eadd..556f9747f0e7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1112,11 +1112,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
-	if (tb[TCA_NETEM_PRNG_SEED])
+	if (tb[TCA_NETEM_PRNG_SEED]) {
 		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
-	else
-		q->prng.seed = get_random_u64();
-	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+		prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+	}
 
 unlock:
 	sch_tree_unlock(sch);
@@ -1139,6 +1138,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.53.0


