Return-Path: <netdev+bounces-277661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCFHEHDZ2WkItwgAu9opvQ
	(envelope-from <netdev+bounces-277661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCA3DE64D
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F053031F22
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28127FB3A;
	Sat, 11 Apr 2026 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="T2T/afRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9917B425
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884647; cv=none; b=Lvq4bvBJsEBE7twd/okQiTxKBrwczeh52n52yGcYWpr90CXV1Eepu0MkSub4ELFbmjja7fzM97KnXGNubVXNJfRzn912aJdd9RDHyuXC8WcPi2LirgWC97fUxWudvgJLyPmRICDMFPTBtJJT/kfQ5q3iLcamBVT1FKI4zRUKd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884647; c=relaxed/simple;
	bh=fL0OfMMtDWSxHR0JJrLSv+7El8c9nsPcZEBdX0sgkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UALdWfpdKqEqtTHqEWQvxukuq3wWv0KCNrwEXC2DHiihR9w2sg/5s0olW5KQY8TafdmJz55t8o1/A4KpX6IhYriAbLXyZq37EuY0i7nds6jvjYrmaV6Ry//jYBvgHbZ0PnLyG5wd86saZfyD5KxtS4DfYxH6Deh1mkhfwFc+bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=T2T/afRL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so1635111a12.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884645; x=1776489445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=T2T/afRLkkToj5NW9bBd8GpuBTqvD1+BWB/16aFotoyI2651qfOg7O69gYK6kjbZTu
         g/CsTkCdPxWYBo+s+F+is1o8c9Ef9Oy0maymS3swEDu7WEqvdkiD7zkdSLBOeQK1KpIS
         g15WIaSDFgTZ4WCZsfJwQf66EmP759tCQDJa+Mz46rGDAKFJmH9HIeQcdJeQTyHzk8/8
         Dtt3EIwcO6AI66IZ/94ca+rBZA/OF6catpRWDR2UVIJYzWxu2AEdmA32Boi0qD5GcjfV
         LqCOsA98xcUVfLElytnyfSZjum46HO385X7Y4c4KZB2yB34YhjnrdUSdi/NxRFbK0cat
         Zq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884645; x=1776489445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=fhZB59PIWavLTNMJ/j2Rdv54D4XQXzz4qHU0yKpA1A3jYwrxo0F0gbC4QFR9AnsgEY
         FUu5+U4WPLoSqeri12A+bd135b1P6ZdoL3nrby4GryHLUXS+UWsiVB8PtWLk23tYm3Ai
         jJFok3gwxTW6OuBzf3Eirk9tE3ZLmnAAEBinWpOzF8VxzYMtaaQGS29l8+US6g9O7WLc
         dbv1zPlg3HiL3z13XKwnpqeWWlJg0NSo5XJoNlTjDYagLRw5g/yjwCa4zc3bB2ZllY3F
         uGd/rAiJtSTCtX2U7yTqxcZ+IKQZF+OPNqY6bs3kMN4RKYUHBWBaBFX9O9j1WrtW4FNo
         2TPQ==
X-Gm-Message-State: AOJu0YwzBFMHYleNDpLNnJZtfSPGMx59pqCQ+zSDotcuxPfrtkQVWSR6
	Kj1I3LF+6HiZwDYWHVM9svoEk9+O7a45jEH8oRFlPP5Z+RTfHKgMMpXitl9o/81HZomsRMnTUOn
	ywV24
X-Gm-Gg: AeBDieugIbE+EDx5y+5Dp6pFv3pUzywfWjZc5J2Hsoy15JxxnZh67bKssQtJi8ElQLT
	1oNu3scdDZvlZAVCE9KETSEw4s3yM45Rv/lAotl5lXH3jE1/qhShc+mH5Br9SwVdZJUSv0RHM/5
	BSlq1PbA6qx/HKZxeKJK9L98kQA6gnikHNpKjVUQWrH3uim5wVVHwaRkBtbHOCU9CnvJaS2kQU0
	vnsxAmFkH1wl1800ZSSmq8kU6ZRQGotZf49QvffTSl+jK6gJHeVpqcFDLbPjZGo7osAc3+i2ghw
	T6wLoKmpfAPrRFYDh4WKap2qul08upo3SmGlkLfdDu8MPXhaglAIebZPA6RDnm4w3yoWgH4upiO
	4l0DRXE9q2MOjsfCOJuoTspQcal+MIxtYw7MZ4bUmkp/XzWs68z6q+HoK6ScMx+4dAEcK1TidGS
	swlfYetGTSBh1vTKeGzVMyW+zvxb1KgMPF
X-Received: by 2002:a05:6300:8e10:b0:39f:23ed:8979 with SMTP id adf61e73a8af0-39fe3f3fb78mr4573458637.31.1775884645406;
        Fri, 10 Apr 2026 22:17:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 3/8] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Fri, 10 Apr 2026 22:15:52 -0700
Message-ID: <20260411051700.311679-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: B7FCA3DE64D
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


