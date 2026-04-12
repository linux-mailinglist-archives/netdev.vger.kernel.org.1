Return-Path: <netdev+bounces-277814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ERsHkm522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D13E4766
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6834301349E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED53382363;
	Sun, 12 Apr 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="xSamUu/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F83803E2
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007477; cv=none; b=fUETe1FRzPk99GAYH6D1EaEe/xknSPAN9/WnAffJaMKjWd9nlvhoSz0C1yNBxt2zBUFoOXFA+fHTvAtF5PnFbI8QYOGiiQUNUEuhogFxrbgk1zt+uNSJkHqoHcgfX0tFOY32n1t4Sx2JBlSUL1rqHmUY8ssHXViawSuqVbfc2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007477; c=relaxed/simple;
	bh=fbqM3x3GD1CCUD2vyX99XNBmMghubH80srElmDJt3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEsFzdTJnl2vuvp9BXXZedQdLMEvfDwNRD8+VN4Zzo2OxAiEhmgdhT4ig3YUf59bWjllu4Bo5TsXBEpDj/f7eDhSaeuOqC/i7C9gMfVNSjbh55qW8NNahdOxSHsO4AYJEtUx4H7OvaiPGNJJ3B8g0q3LxW8V0o/f1Imuvj172IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=xSamUu/F; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4710c186d15so2000553b6e.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007475; x=1776612275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=xSamUu/F1MXMUpAsxSlfIBDmeAgjxWrQYo9EPHGGBgr/7qPwKYGg+sFLIBkAu8PNln
         rkfYFjpVMdk6N5drz93NgBfUIR3cQnBXNID1LX9h++nnhydmUHLMxOJ3LTtGCzRQuU1b
         CX87dffF4MeVIHfUbwKm+FjBVAf4VHFmXZc/quJwIJb5+TPOU7T8ht7K2XpHVhRV8+fl
         wyWwxUqnUq+k0+kfeucFy1ZUzxuuH1hqN1LxRwUzxC9m/SbDW3m2AbtNHSQatRRpp7fh
         RmChTF76OnFPOyq9YDmgoFjCNX157+M/P7YG0hHGpxvKKFhTJtT332iSRAOIqVrEC04Y
         1ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007475; x=1776612275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=rp+PU/zWwYz8eREmtKnA18gVmoahdV0b87cYzY7TwCZwdT+PWUWI6p/J5ZAKUhxVaK
         js8864dK95teCNxXaxbFpdPwt1d83lqftCG299HlqH/VwwAEQHHzhxoQX8tIyF/PS0Ee
         JItTlnDWg9vQVqWPzkg2sXs2Qt1JNBKDl+56iOJcKz0pY1xu3O0EOD3OxT1mWs8tFaJ2
         NvC59FoTl4apIOOhsbOXjNknnwYUH5t2Kw64PzQcDzZTyzE+HfZiZEb+aTM547IyeEv9
         how+y1Trnh04na3owOvSIRLPYB23ILhSoOWkMqJtnqC471vCDZaD+bKPa2HDaFPSesxS
         0yFA==
X-Gm-Message-State: AOJu0YyeaKOOfArnW5Ee1l/Ohz0uT1m2EuV5jU6OlprPv4WnNlQY368+
	TpSVGzDC1m2NJizkHILQ/eyJCg7MvSkpWoHpwUaf7Ss87sVDW7OZzurIjN3xJ+/mbdcPk9RyKvR
	3XHXH
X-Gm-Gg: AeBDiet8gFOE2e/yDXdN5LjE/ue6sE74eX15f3adMzpC+sCj8uPh4sah12S+NG8DTS8
	pEhAzZGZ8SqXdx6JpGQx2xFxY+VX8yWF/MhSZ7uDIabHY9HL0ooTG5IPMocNU/HHj7mWie/8xq0
	DFKL0LrK2nRL6FzScWTbBdi5TIt5EFX86MeyowNifWDnT6ihNrybXyubt4D2tW25yXTHtrITpkD
	qJ9VnZDEvpH0VuvYkZujfRq3/NDb6sPrY+MpdseuYZCS5i7daY1lMJF7PqIak4/JHiHN4n8Jn8l
	jwNJDxVFCM29FP82p6eDN7QJ4wBPlY5vbWi/qs644IXuGxAgzW40VkYEELydaBCVGLhV0xWR4a8
	yJzYJ3/8fHZT/RvcrdmrEm5SQOy00W/s2/yfjKHMC4nAdWH/i8FkilHZ4FCMfoHOw4LApGSTjNJ
	VM2jtwUQSpND6tEWsMY16gfRPu3hXFvpfJ
X-Received: by 2002:a05:6808:c2d6:b0:467:fa3b:b519 with SMTP id 5614622812f47-4789f10a5d4mr5361041b6e.19.1776007474861;
        Sun, 12 Apr 2026 08:24:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:34 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v6 1/5] net/sched: netem: fix probability gaps in 4-state loss model
Date: Sun, 12 Apr 2026 08:23:51 -0700
Message-ID: <20260412152429.143474-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412152429.143474-1-stephen@networkplumber.org>
References: <20260412152429.143474-1-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-277814-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: A57D13E4766
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


