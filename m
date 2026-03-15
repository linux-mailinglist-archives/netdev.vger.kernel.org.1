Return-Path: <netdev+bounces-267881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzvCJT6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9028F9F9
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F1F230C8FC9
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4CB17BEBF;
	Sun, 15 Mar 2026 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XFRpyXC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EC1DC9B5
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533834; cv=none; b=uAI9DqUhMfqw5kT8x4pWg/m75BVxo1NSlqv13TOh3ejWAjzltAS3U7ho46j6djW8grJj0wq35lE9Ve/O8Lk7RBoIDHTbxpCTAWmAmrHTs+24/AP7JzdYuePTcFh8MzUvoFOpChDNEGQLqTyxihPdxyQCDG5yVE97jGNacOf0/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533834; c=relaxed/simple;
	bh=q6SQeXuvRsAH7t2PNKS9InwdFj9Z+pvGKixdl7YLmMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+PTxzjDPzGtlNngfhqip4yRp82Z59XurKzzFF5I/3QjmJ87vnRokW8KqaE4UKvxHPWeYodok9BzQ5KvIq6Hhq+daIblC9ksCiUAPYD41uh179ih3/tPAMMCoiLnkXRwsW0FsUCzM0Z3M3zIGwOpEu9MRuBN+J1I9lXD544lL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XFRpyXC4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso1390882a12.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533832; x=1774138632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAit/RS78oK38TpPRt0rP94IG/Q3Vq+QxDide6zAtn0=;
        b=XFRpyXC4uOb2NHzAD+O8qyI0ySNbY1ywYhRmwiU9wUr9eVGPapC/plYOkpK6vrcu1v
         moiZl9EfyQOjCDEyIp11Mf4GgmXAO8b7oep3Fsv7OEINXnKKA4PJrhQdT3Nw878Z8ABn
         lvkL1NArWecKQakDUAkNyUcXr0K86zcaa454ocNIh5hVXNPJtTmjC40O3Y2MXidNyc5q
         yx2+1ljCLNtSM2iSY+XFhrLzKwVzc/njeAHCv1OiQYQfZW6w/z5/+q+OCT4KD9WJFVpz
         GZiniVWI4upkDt6E5VM7KkTUixcrSeSKVp8+5K4OFYJEDmF5Qj9VZ2si0xVaYJCHx0hV
         awWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533832; x=1774138632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAit/RS78oK38TpPRt0rP94IG/Q3Vq+QxDide6zAtn0=;
        b=I7wenlKShXtWeoZ8JuRR2CmtCGSXJRkGbAbX19zeUXBObfT505x4EfK8IqAYkNsf79
         3cNJUZ1FUjTOfgRnKQiDjNAiOw+W2fBgsvUch4yjmISn36OLSA9uTITS+UnMDO5bOtmD
         gohCpBB90ySdPERAfIOQOUwZQBQGg20nAw0Kx8m4jDihftNkE0QNDxdA+TRgLDrLUQ36
         jLA5qdGeSX5oiyLfwgCn6Z/RvIizyCIvoWKfU36SHULebtykinfTIxRG4BON0glPcBTs
         Zv+PEt7milbj4l7LgYrY/HysSeSmhBI/VIXgOcNOI/Nee4+6FRmH6Ju2EiAYoq2kmyTi
         EUFA==
X-Gm-Message-State: AOJu0YwI3QgpJr0HVuPwGBFTIr48UGOIFcI1PN2IxOruzK1dxM5vVuoZ
	5a0YTYRxUrrBSqTlc994L1cOoEOR18GGMxpaFyun3yTh93DOXVRQbfozokw4Gc44uJxW2iDhWQt
	z+Lnq
X-Gm-Gg: ATEYQzwLHDcvgobUd4mCqxRuumCDaMBIdnIDjZGxj2KZxnAaN6Rdk2uLvNe02MAsZIN
	soNabDPdyl2BeCHbRhY18tgSInTSsuK2ZBfcqUtuzXt6KfCeaMDHlhD+P7Fn+lF2uNm1bkkne/b
	8uX+toB7Vm/ST60QVsjmdoiKwe5dYKIhr2/8DCjpN3TORdijUnMCZ8Np9rkkq+wA7wOc7KVB2v+
	jqiPtMe9bJvzEMOP0RB/6kyDzTQwwEVgJAcMAluNCNlQK/MHhOCjgs2B36aaG9Ilez634OXl4gy
	sLOIFiDSKbFOw9v/KMFvYEfr00GAz2VI/wx7wWIJyQrGJqHqIgVYe+kEN1eSSB3lXiAZz6ZFfsJ
	HFfFIP0chvrarx2z0I3jCjacJ6etcLFPMAsfggTpG3pVrowR/qfj0XD1QLnbHP/5KKe6+26DJDH
	i6dfpk7ZqVO1nU0b95x/CfvZn5cLWBpI0sspH8eNpm0nU=
X-Received: by 2002:a17:902:ecc1:b0:2ae:512b:eea9 with SMTP id d9443c01a7336-2aecaa38973mr85117815ad.36.1773533832426;
        Sat, 14 Mar 2026 17:17:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 05/10] net/sched: netem: fix probability gaps in 4-state loss model
Date: Sat, 14 Mar 2026 17:14:09 -0700
Message-ID: <20260315001649.23931-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267881-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 98C9028F9F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 7488ff9f2933..3b2211fc03df 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -237,7 +237,7 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		} else if (clg->a1 + clg->a4 < rnd) {
@@ -257,7 +257,7 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
 		} else if (clg->a2 + clg->a3 < rnd) {
 			clg->state = LOST_IN_BURST_PERIOD;
-- 
2.51.0


