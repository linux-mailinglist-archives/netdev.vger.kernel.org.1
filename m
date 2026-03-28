Return-Path: <netdev+bounces-272793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMeRGCYdyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B334F8C8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D16783043D54
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278F3A75AE;
	Sat, 28 Mar 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Oey0HPSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9A3A6B99
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722226; cv=none; b=VwvMTh6lW/4w2OUmxWN7ch5gKEkUrj0xHkOKXfhs+gGqNNsYvy0w//3sfUeLl1Y/OB5H1QE8oEPqRfwEBm3kMICo5R20RsBf/PfwTUCMkgZLfS6FEqzMfoSL4VqifLmcARFxihAhq9/j0OOeoa+BJ8+XY+9lSDgYeEfBvFNEtqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722226; c=relaxed/simple;
	bh=z45Yq224SJar0fRYxPoIkKiyvLWdYT0mWNzdNiZfIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tqntp+2bhf3M+EEyozHnaQa/GfQpOGDhW056E6kHcNiCPPmSD78B/zG8m4E9VaboLLr/r8X45q08fjykJJ8vEQOTW9TG/Fz3481MIfYmunhCCjycvXQf4IO3XAeaOtIvn59mqkC9TB50ZxNn+QZv9hOmWcxTXGOZ+DZo1bwS0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Oey0HPSQ; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271195d2a7so2785635c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722224; x=1775327024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/HjTjEDk3HEzcc7y1c0QvXV9RdidAj497VgPBg/7VQ=;
        b=Oey0HPSQN0cw9Y6drpse0LWS3B69B0QLchjLe1o7w940tOl9n6O1rS3C4I5dss8wze
         SuJBOj98p/qA228JXelweMRbq1csjsog9e93kQhWHV6SkDHtiGGqVpgYFdtvUcn18xAG
         aHshn2FDjsPrqgL8bkaI0L5Babr2KRV9J1VCPl0Gn4ea+Oq6yS/hUk20chPFH0n1JEPh
         C04H8onjOfZ7ykz8JeWQUhmqC37w97597+yeiSqZDd1mRJMxbIfRdXlRUsG8A1398/kQ
         l+W0FNQdV7vmUTI1Zrb82TvpR/QAIbB3mzLJwSR+mM3TC7Tqj01d0/XJC+mP5vCCKcyY
         2btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722224; x=1775327024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/HjTjEDk3HEzcc7y1c0QvXV9RdidAj497VgPBg/7VQ=;
        b=szQcjQHcs5Of+KWVh1hHdDzydYi90lOmqlcDZVplj55zAx9So93INPEzNRrOYNPdGm
         nMwyi/PySaDNXsQdq8to9oEVRF6DsiyrjNodbMW7eRQb+4EPsldFPsatt4ya491zCJkW
         kdGXMZNNQhzWrOFQUYvh98uMsySmhUQfDavaS97rFwhmWDyExSgf0Hs5rcvjU0jwo9Ho
         pIwKSBTHWsHhY5HujnFRf0yGruhqxb72afZMwrqpvm4jMp30Zij1MO92JfzSXMyhvjH8
         OTyTwtb410icSrSqeK2wtqyWw7fapGJ6sqdU3/lB48MuJuv/WZA4da0rLitXUeY/Hc1B
         sC0g==
X-Gm-Message-State: AOJu0YxvNvSPJoiy4sNdm6pkedMgwJk5Sw0UG3AlB98d8crPMovttlEf
	/8RWeenPzT2a9pG1ypRks0R8fP9cXL46VtdkcYSmgsKaAq7AyQGnHtoxzyU4Czz2M3mBBlfVB4T
	nPbus
X-Gm-Gg: ATEYQzx9m7CjOY3YAs5eWfD4GoWm6CkniAIpExxve677h9IQScZ0KTFV0pWky44N6KA
	KWSCQphw7MChgGFQyBs+LNmFqCnhtLE/ztxKOs0owOa/S99U2H8iC7EcxIfSLYvln+moBCNIBOw
	Hna9EqUe4mDdHcg2rAbKFgR/guNw8EE5qEkDQO7if4ffi6fgVmAt2HermUTtGyhDYe4CV0jWDBZ
	ezAPpzRPLNrN8udF46N+sxS2n/0LfS834oeQtEdvhlQwcgkh2yixOLveITBsL1zbvj5aQbClm6M
	7OCo/fvHgjNCygv3yirpBPZsjRNeE1uZv8o8S7zDfewLRNRkKd1HBYgIrcIWLOhmTtccg5Ejr5x
	ZYkCmXGPsaC3LUt8UwsASe7nVc3jtpS8UmXLFzXmcOYqKaievVL4/tM4F7URx8g8/gZEQEn303D
	Tc38NIXzQ1OJa8k+cD3OMAMgCPKuY/NMuP
X-Received: by 2002:a05:701b:2410:b0:12a:b7d3:fbe9 with SMTP id a92af1059eb24-12ab7d3fc61mr1623205c88.7.1774722224045;
        Sat, 28 Mar 2026 11:23:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:43 -0700 (PDT)
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
Subject: [PATCH net 3/5] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Sat, 28 Mar 2026 11:21:47 -0700
Message-ID: <20260328182336.392817-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182336.392817-1-stephen@networkplumber.org>
References: <20260328182336.392817-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272793-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D34B334F8C8
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


