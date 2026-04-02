Return-Path: <netdev+bounces-274685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCcZHvHPzml/qQYAu9opvQ
	(envelope-from <netdev+bounces-274685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D2E38DE96
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B06F230582A7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530A38AC8B;
	Thu,  2 Apr 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oXV56H3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7D38A28F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161264; cv=none; b=IppJhzIC1LcAKyKfjNlU6EHm345Cm6Ohx81pZxGTUxGFIkt1j/DLmNIU1mrI3LpNcNki7y8ZXzTvj73rNNPaQco0ut3CUZ8tnFR8bR5Iir0vsxFyUCOJrxK/0dMRx1aBH5L8jQtSNRmJI2i3CED6E2e5Uo1DOaXbq/7D/RqiMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161264; c=relaxed/simple;
	bh=QEc83gOcHEYQydd7I6uVggZjNO4Lkb66/e/DNtQZGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIcyPtVDto+Inz9rxWTe88EZvC3lJWIllxP/+oeiHG3rHxbpjPUvn/lYjoFovsPqZY1uRHs83bY65mKc7cHh5Ybd04FNG0I64A6dzqItkCXDGxIaULxfPTG6iexOrpyeOX5sBMnw0E70w3PfSfOfG7y3e1P/nRQv6ibpBxk7GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oXV56H3U; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so816658a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161263; x=1775766063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJCIzIhUYAY+FwghoNlKo9w3r/39Qk2OPMc1dIVyiPw=;
        b=oXV56H3UnWOC675glssMDgJPlOOZWf4/aNRgFd9zc0HkyGdMXxviRUolw4Wxr25Ovz
         /vhVjsmmpcEl5k80ddMstcEiA2bt83onNMDjfJjJ8yHMwu/ZgN8FqNbXNn2wpEVk1qjF
         orJDbR2XKGGdso0xcEktauWh/YEAPnWOnuDZYVHa40e/zkxI/WaVHWc3un3wnEeP1pFh
         d4nlhr++q84lg/M0TKlb6RrA9OXUjIzVqO2wRFOYjRpTZ4ma+Ih1dmrTt3Zl2bJEhw7s
         I8KIJReAVC+8fAznl9F9zb2L2QtchP9vD8+xyvg7BtOaIQSzVKh+PwoP7pDerpTJI3M6
         s6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161263; x=1775766063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJCIzIhUYAY+FwghoNlKo9w3r/39Qk2OPMc1dIVyiPw=;
        b=Co+SH3+aaoMjZlLahSH9fulFfDJUu0aZpiMkiECPy7feYDqgMQgP9EqEpIEAaTN4W2
         0aS5Sz/QOWwhrdM/BDBmthPY2EKDKyqiYamDqBPeTj4/DWDlzLZzQDugvBlgf+7+EH6G
         K4G0xbClvNhLqp/mESJTQBMlwXNe2bsW7Lj5KrYDI4M876s95vw5fTdzu7KZTSSYXhzY
         8yrQMw8KRCl5OmcamjK25PrxosXCjqdHZUVS4iqLbbQBNL7SYAte0FebU0BSE+uQK3Qt
         I5fQLtpjKswNJpbvAVRowXjstgXr2zfYjiX3mJoi2Vsw4sviGTNQ346ezh3rk3MWYzVg
         KYxg==
X-Gm-Message-State: AOJu0YyY9Ugp+ZltQI5J+Oae0QWuwKLzCfUoS+sqFBekA3laVP0dgjhW
	Lw2vKiR3MdHXc4SGBa7qdbgHbGfUiRZj7TphAlQhbKCyEhm0WbqQYLhkDb6pd44s9aHV3Ngtdxv
	TYO8C
X-Gm-Gg: ATEYQzxj1qRTpXHtrqakZf1jaVML/lsZ5Z0nz3y+IdCRhPZeNlWXXf4THucSro3ppCA
	VykpFgtoKxf+Wc+Z8Po8X4YFnr5BUd79YYgjhzZUJab7H7BOVJW3k9EV1X42SX+w23oXAEoZn33
	4kf2/6dkjRK2aTw8fbd+LnYTzxvaatWtJ49XWRLvW3ThOZbZxoeUmTIjcbsaboiaShm6zQ1AJUV
	/GOlAhbaPXNIn9C/fMaL8Hjwkx1+7ymRZhZXGLOaREYXga6GJwjATkDxC1A31xSozYabdyTIlKX
	GGMJoSeCabZNhTHeVf4LYOGk6Q7LLKQ8sbSrwJ3pF6rIgcgjx8W98XZm5rbEYU910IZYeHtQFkm
	I+m8Kn0f8Dh7qr/VaTdzathS3lOhfeWyAFVViubZHQ9HY10KvPr3EfUGvbgx6T95v5w5Y4hq3Sa
	uzAnCECksb5YRXfG+FjsxGvt3zLH3LA1TH
X-Received: by 2002:a05:6a20:12c5:b0:39b:d9f1:6d00 with SMTP id adf61e73a8af0-39f2f0bb4fcmr286147637.43.1775161262814;
        Thu, 02 Apr 2026 13:21:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:02 -0700 (PDT)
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
Subject: [PATCH net v3 3/7] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Thu,  2 Apr 2026 13:19:31 -0700
Message-ID: <20260402202037.176299-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274685-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 21D2E38DE96
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


