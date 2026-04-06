Return-Path: <netdev+bounces-275665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOeIFznt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:28:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB463A5B06
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EE13021E9B
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E138390222;
	Mon,  6 Apr 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ZZUOYELl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11F38F251
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496414; cv=none; b=mSdjYGzZ2M+PsZAG3j2iEq66vCIKiz+unHlIcVQ4MMrCQWO3lzu514Nqc7zfUcOCuCVckpUyNOAiTuTS8FRTuY0oE9O9PX+/hbr9188S4UHsbhlzTaqfdH6RrAV8Gfqn3i3edESpNpyPCCXxwbB6BxQHLjGTj+5eoZMwlJi3sYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496414; c=relaxed/simple;
	bh=fL0OfMMtDWSxHR0JJrLSv+7El8c9nsPcZEBdX0sgkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbiHsDKeeIEz3eg4e5DP5nYCvrDqS3ZCIYEJB1JxrIvyIuwcWyFnmfANZDFF5YluPc6xxfurFj5MBu9Lx4IvrePVlY6NeIlxPYfOKDaGI6RJ9L0khVMIqoGL+sEtv8gRGU0yghEddZ0B+51xOF5sjkUFKxj3Mo1AtgrYVghVwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ZZUOYELl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so1758112a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496413; x=1776101213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=ZZUOYELlZimddvrB8UvvH7IqvmSa6bvmlxXmPoPf2Cs8HrnmKw9CF9LCKCg9SXGwhQ
         K206Sotpv7FgW4rkYwqkix6oozOxw7DXBaDCHE1WuDJQ5sbOYMeIbNIoNTKp70BJSxkT
         XAg8Co3nklhSFugXEd9eVqbOAjiAq0lnG1TBxZI/dvF1CjMn5JkYmDoHJTxyS0sfNvDv
         PS2TYKnCTN2u/7YHD2EjvCtQC0CHRk3cCrflcgsrffGaOZaZhf8kcKw0B2MI0NIPA9ib
         N8fB9GXkrAXsA50xBdo+A9BhRyPkwwbxn3AfcI8iOPb8JvvLcPDYIZLNPYLITAIXkKna
         18yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496413; x=1776101213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=Gm8cK+nMxiT8IYVDkS+4Ksl3m9Iel0YP67t9MDt/j6Tnkya5NSKd1KRy4nCs5HexR9
         /aOzqqhGZTH2BH+61A/4Nsxb3RNjNGE0wjoH9rGBj2nemsTBuZRsaPPXHSCqDs6GzV8P
         zt9EOjy+koIXDP0dz+izAOQGB0KHvWbnLqCmuoPdeWalbq179xyNsnDK9RPXQXXxX7F7
         UYResTGdv3bgZn/bGzOzMnVPw/+nRxo1VojTwOfqLaZcnUqDZEOvXjzZGX5lhUMh5F2c
         7w1FWGEPAbQoCg6Attk3G9OhI0kO6Eb9mlkqq49Rw+ITGRQeGb7q7lgM8e9h4zGiUiM8
         nUKA==
X-Gm-Message-State: AOJu0Yys3rt19KVNqLzU0LEN0aALpAGLI06zoU85zv06ppG8REVMAowA
	Qq5jdkPzuP0UIt4sEBML7FiC9CZDI3ExP6iAnMV01nanBmKZZM2X0SxdKucHSPZtjU/0SXrfbgN
	q2S9g
X-Gm-Gg: AeBDieutnFeUoPyM072qICaNStLY7PpnTgnWZHfzki4XvsfWL73UjlNblGsYnzQrTpG
	MlLbjyqHiqi0NbJO/Sg3MmSommD/FU9czx20oPyt4rIT3D70qvx/ZDV4CBgpJkXwS3HTQfCdfzB
	eDjvQopxtNIwLpSc4Pu8VnJPjVy+f+bJXGT3J7TaSUAXcrE2i0LvwlPYTbZmFE8Iwl91qt5Tfp/
	VVcqheUtxMaypZyblvYmuqZc2H/rhEARNrmyFP17hY0ywnigEFljkDVdfWhqnoTSA3uezPaSYOS
	aplicsjruLnHG1O4Jv5IvIBUpOO+Ki0KL7XBVTa+x6u7Hfb2+ivP8HNbaUJAbufSO4tNenio/am
	Rdp/HFm5wF4Rrwekv0ouBq8RklKDGZulI78hUx8JoFlfTW4k9Bt5M9KmYTjThg2MYYASDCMvqCY
	rP7EIjpOiiI7wOALUmolJqnxb5lWoPnBbr
X-Received: by 2002:a17:903:90b:b0:2b2:6df1:111c with SMTP id d9443c01a7336-2b2816c33a4mr141974355ad.19.1775496412698;
        Mon, 06 Apr 2026 10:26:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:26:52 -0700 (PDT)
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
Subject: [PATCH net v4 3/8] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Mon,  6 Apr 2026 10:25:11 -0700
Message-ID: <20260406172627.210894-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BDB463A5B06
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


