Return-Path: <netdev+bounces-274141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGC2LegxzWn0agYAu9opvQ
	(envelope-from <netdev+bounces-274141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968237C862
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EC6F30233C0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E143E48D;
	Wed,  1 Apr 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ul3vYeIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D832F759
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055221; cv=none; b=p+te8Da1Ff5SAj3aHzY+JfcaWwKl/T/ckODPYmzOegVuWID82Qez9OZnP7hfKqbBzRXLHljo9+h5E28tmXWp+PJ8es4IztuV/FCDkrSDS8n2Hv86mEqzHLRQmXBA99dBlsjQuGlBGgyJJqo5OX8iAmOf9gEmrqW6ACKadpe9n28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055221; c=relaxed/simple;
	bh=z45Yq224SJar0fRYxPoIkKiyvLWdYT0mWNzdNiZfIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHHp8J7Ss7+Ax72LrvTW9usP9ynfIhvvvJUhpXpnEb2rIFCI+t7qEPLXyKjqen0dhETvEKM3B9LT8i3HrV+siYekBPppYtuNIHp7dDkw02UWG3fIDmENCgxt5OCNEOgMDKmexGccNglQ7XBhEBUG+BK2mNuRSaK87suftgUk6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ul3vYeIW; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6765930eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055219; x=1775660019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/HjTjEDk3HEzcc7y1c0QvXV9RdidAj497VgPBg/7VQ=;
        b=ul3vYeIW0IrVAQb+x3SJFQkR66WIdNkO91UtMUvLju5ADr6zbtceFVqSJxr6uZctXt
         yh1/JY+yOzphIpcWElz/nd3lU8FGhMh+WncgyDlnaXJ10fMKAchmWhcz2CIEcb5QyLcQ
         1kr7XwIPv+W/aJzDKfco9DNaTyql+PRi1Jrp3xB5BXBb5pst97U4Z5vmSmAfElMq577M
         wAiSL10pJSuMHgYllPNb7lukGKtKiGgp24krWWDsVXmrjJwA0koT1Tk2V2BzT8J9CtPZ
         JWkzEIwDT03b6UKGFQpVFSFUnbvsZroNh98SD8PUsfGIKqQ1aef3ezE33CXQ7kkjuG6G
         xVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055219; x=1775660019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/HjTjEDk3HEzcc7y1c0QvXV9RdidAj497VgPBg/7VQ=;
        b=MrCpKispTWay0VyQzbpF0pulfhrJGyu8S2LU8gVJu/JBX4N5kWzV8z8O9naCut1b1C
         /JKGJ+FswiZIpHT1nWc4DYi0bnU28hwETlh76FUcLm17zKvJXpkcQpCqViUO0BN51Bhv
         KWL3MC4kEWyCoQdkHyAwtdef0GmIZONsm8P4Wc7bPfh5ST7qWf0lS3WXTWRtRcfcH9sy
         jXUi8RznfKh5UBeC8N+oqeyD5382mLiLqoVo0VjTYHmS+dLuHkw3KmZCqzuYgNehzJR5
         Q2/1L1h923NKE00EWpZKAuf4JYPWGUWoXW/Zv/+mBo5wmquYcBOwS3NUZD7uKUTM/si7
         JtTg==
X-Gm-Message-State: AOJu0YwYnrVjdwuuT6vrkMgIFgJ4jLY0fMQ5QXqZTETJ59T1ph34/zZm
	udpOuVD+fcOj6WoBbCZdE5+xPHM4aDoCERhVcITLIFfGisrrc+AYAPlH7w+SyBX6rqED1enPJqj
	josGW
X-Gm-Gg: ATEYQzzaa5MLkoHYv3cT75BpH3v+TS64x8DUwxOHL/H7xZaHQnGA+ju1iH3+p2DM18q
	tD2EPqHPFIlVLSyjnAejE1ASIqCADQTOm9Oi73LHpuEfks1AEzLlTOz2uP2xNmqChwoPxFQgvzW
	mkbZHEgYZdQ2R9wm3A4TkVuuJcjrRjIh6FmHCnBnfacirEhY+PfBbnRajzRkkZSg5EBIod2dnC/
	xkbOJpBQjcfV9XkBViD0j/rcxlT+msawLBzJaJQxjUVjfHJ46zdk/anz+zd8Z4XGb2vPe+UK2G2
	0/2eA5igL8E/EZIg/72raCz/vuyj2LdHFkF6atvu0PJVjFQ2l5b9PXMlRPzDLesvjMNzfLPTWEW
	Jw17CKFsMlnoLv1VRiqef0zpKAmf1qc4kOptlO/YBPmwQ084BH8zn4BFV78iPRH06RSZxosALut
	QYtxQhYC8RY/kehWxEJBLkE9bBoNTBWbCr
X-Received: by 2002:a05:7300:ed0e:b0:2c3:d51b:91c4 with SMTP id 5a478bee46e88-2c930e6b8b1mr2186679eec.7.1775055218892;
        Wed, 01 Apr 2026 07:53:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:38 -0700 (PDT)
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
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 3/7] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Wed,  1 Apr 2026 07:51:55 -0700
Message-ID: <20260401145332.78285-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5968237C862
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
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6cc48b698e48..448097fc88a4 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1111,11 +1111,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1138,6 +1137,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
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


