Return-Path: <netdev+bounces-274683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bUdbN7zPzml/qQYAu9opvQ
	(envelope-from <netdev+bounces-274683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57438DE71
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01021303FEA8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864C388E64;
	Thu,  2 Apr 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wqNqFt1a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193A384232
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161253; cv=none; b=cCT+5wL+lgM90aBj2UsEn8tryDFDZz5FSzQllcSbxGRUk/6enBAWHhlx5mgydYIuKAirk6TmZeE+ljhfZwDWC4+hdE3yLYi99giNTqgq0DaEyxezFr+5tLI60/qF+RTIGOQ7hoW31VrGOAkGIvMW/7Bh2ZUcHhOdTsUzXMfoegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161253; c=relaxed/simple;
	bh=67Uk0DchRlxi/hd+AfiBdzz/eR7f6xCRNtjViWJPj8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXYIJFgWfPSw1kENNF4TBUJYvHRWIOerD3w6dUevnYJ1U0N4TmEOw0NWlmyj1m70iVSs1LOybm5cAgNcWqT1ICOlA/4U3DGdknCpCzE1p6XuQUoQznCQ2zdUw7GeJ34MTyNBKQchslX1FyJhK3lcu1ycSGO9FWqKhfaOrn1lyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wqNqFt1a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82c68339cf0so1495988b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775161251; x=1775766051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaxWqigDenItBeL+ZtZ3MEKy+aDe2MGgNHbYTiCtuns=;
        b=wqNqFt1aXWPt2lzksZmYdMRk+9lI2fO41Z+YGXd5IAkWpaNp2GlgkkW1ZjJMIX/RrG
         JNmJACXQfGqImTc00rmsPW/LBPuZgADjTwho2ktW4FMepCwO+/J3dUA67L0nQrOxyHkP
         +KT0YqdstiPa8R2JfF7NbzaEhaxEG6oLH9qKx4AHilndBBE2g6NBi9HqQ2OyFyKqX/Qh
         Y9BoZvhg68CL9ZG4adGgU3TBSsEdZ4xlwHEj28GvPNrF6z9JChgAWmgcVGS2Zbdf3SkX
         bDLzUDeeu9bztkOllmfJRaOAeHn5FHlICOwsibbsywH6JymOHOGgeTJxqRYGlvoo0kLz
         XvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161251; x=1775766051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaxWqigDenItBeL+ZtZ3MEKy+aDe2MGgNHbYTiCtuns=;
        b=GtPH4LbYv0vLWka993h/FcpoMvARZ9G0vRUI1IJ6cgN/Akn2yscfXtoMrPIUyZt8FE
         TlMliEflUYtMLFJN/bRWd1RGEHcPUqS/VbjREY7gx+O41P/iXbuKzyOR5uNPrI7sdaKZ
         bx/ZBNvJWwl2B+4/+vHQDcO0yTxi6Pu/Fhn4X+65NVC7Kuxepsg1NTvL2iEXFLZwOjmA
         0ZEx+V7qNbQGUiskIYe1ca4DAq0PfxmeFebYulGKUgvArrl301gm2+o0+SdY+vArYO6P
         vOHA9TP6/18NHt+LrcDYv43FQzrBWHayLqa7/Ht/lSdIO1U7s8vMyc75lWveurXsaM+d
         E6YA==
X-Gm-Message-State: AOJu0YwZAh559hy/a0vYhVjd1t5Pjj3ypeAuikHml4LFbxf90WeKeKAZ
	DNqVzls/4hgMP2kd2jOphFO59ns/ID/UM2/yIzFA0YtqUvmbKB1L6YpzGzbuxpKSlFr4Wfc9MjU
	mL10+
X-Gm-Gg: ATEYQzwz/zhPZAD7n86H99zhZF04mqHJGGVRtoWq5LCgr9Wp3KhCHj2D2Y9zb5XJs0O
	RipQYoGiXG7hfBTEKlCLOfgEtV/Nc2+AgViBi6uQtqsrYY8YWw05x/rx4SVmfF8BNMzqLyyi4Kk
	KSdMyZoxdhAuA01ac+rOYqhHTDG1ZdrJA7sTizDV0lJMr9Ld/JyKd5QTgkvOg5bkTe9AtgiuZYn
	yRWg18JJG0Z6eJzcZmfMUXFFZ/v2pe7UA/pvvzkJGmvLfqiVWyOpDBVbD7sx6tTG0g0/h8YJn6j
	+Vjxzvzbvx62ACcQ569GUGtiHjiH7RSN1whZiwZxicyJxOgS6js66sTHkq8lhZn9psk6CW+Uilo
	W1uuglRKIx3YOXgXS3zNOzJ9qI8wcgFho0tw+rXUkA1uJkWBVB2cHhXUcnG5m4JiBWVPA4abulE
	qiGKDLPv3LEtK6xmNqc/KbRe8v9oHKAqnwZTOC7MGlB4g=
X-Received: by 2002:a05:6a21:3291:b0:398:9929:5184 with SMTP id adf61e73a8af0-39f2d845710mr455886637.3.1775161250677;
        Thu, 02 Apr 2026 13:20:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:20:50 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 1/7] net/sched: netem: fix probability gaps in 4-state loss model
Date: Thu,  2 Apr 2026 13:19:29 -0700
Message-ID: <20260402202037.176299-2-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274683-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A57438DE71
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
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..8ee72cac1faf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0


