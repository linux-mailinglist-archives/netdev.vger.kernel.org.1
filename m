Return-Path: <netdev+bounces-272792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKQ2KskcyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:24:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67734F884
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D37B3032DC8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5A3A6B8A;
	Sat, 28 Mar 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IJUhw0tR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E3340A51
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722224; cv=none; b=P8XuUuk/lA4Qw+3LKO0sRW8fXQ5h4O09lf64jrs/n/JjDkr9V8xOoNtLhrfOrZlIusw7Z0JN6XZtHLkdXqXsHzKtmm8p64LJjmXzJWUYLOXBNeFwS4RUL01A8mBz7X5i4XmMv4ZgBhpf7Rj2VVP+ZfSk5UFOsmVJukKhPrKGDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722224; c=relaxed/simple;
	bh=n5gLdW55iVjWbli7Cw3KezMlHCHUoFCYKjjm71hupcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHqgsIy8ORbxTjz/h2t+vrhaoenICy4e+H+7qKXX4xpXQ0n/lNpsqyG5KEyhF1qj6DbcD9CE0c6fQ6qYXCRtsjmbSlngXLthrkWTPbN9fqrjWQoip9JhmXr7qeoR6w1zqA7O864GSHAv16azsoJ2ZaHZfgF0xWsayONmKdNTtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IJUhw0tR; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1274204434bso3159136c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722221; x=1775327021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmhsDMpsd/+3K0C1t5lpdl1RPDllE8WJo/RPfumhe9A=;
        b=IJUhw0tRtF1FYuAn/G/852kkfp0JQFVvsghiKlVtooSGZHrd0yMuB8qZT2hwwi+fra
         JSiuOoYRHRnUn+UibdufNqc1U2W+u1j2klLeXqLXa+w+1WJzFFKFRNtDuqoOTT6lQ+t3
         e3Kz3hDSeuDHK8amCfq/95+lok1JwAsu4eruNGpDVYwDAE+RWsNaxUW3CeiDupPpVJvM
         x9HNsSR5lbrGIgr1cqOOmtCuzEtCb0XfQsePJE2E2EERScZ5L7EM0czQ9Fc8UtbRdUsh
         COGx0EQFQDB7oc7dT0SnTYFpTzN6BjdRFYASk8KcZjd5O/ZjFzTGM1hnQC8fBEQt9ux9
         aEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722221; x=1775327021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmhsDMpsd/+3K0C1t5lpdl1RPDllE8WJo/RPfumhe9A=;
        b=Y1zm10BCdlIqzD3Yz2gQJf+ps/ckOkHDouIExm/S69PoMJS8AhOjX+uCuCX+o4D6lp
         KSORaiLWg/9RO/usfygemWeMpgWHTkpSaCMi3xkEpmQuioiYxm01LO9HsSxer9SSV3ZD
         KThBf3qxNSWpsZqYsmGhJPwhEqjTfqTE5DZxL/KpTQ/P1D96Ubpm/Jvxi0cLB2t8Qk7E
         ku0FyTCNggxHo8uMk16t7ODfmRLivLxkzO6qcM4/vwz4CUGWNtg6pVllL3D9HN3XoAvG
         464gXK87OYeG9AQ4YNmMVBPpACw9N0KNPxhaf9wsBa9EvhnrSSd6zmimpXXQwBWJ09k8
         IR8Q==
X-Gm-Message-State: AOJu0YyP9fHFYtw8gcO0Q/SyTZDW3DOc6BZmYSeDhjB2cK30i9LzRwIx
	YZWWxgurkLBpfGqQR0Zpgf9hGAQFJ0pr8+H1rdqlgPYOaZo12VZAyoWb90L9HVS9loM18un9kvh
	cZwIA
X-Gm-Gg: ATEYQzyRmzvyCDt/bQGp7VYMoazHEgRVDARs6h0G9cwatEPa19eB1hWw+XmqQlPJolS
	vt6+vNQ9kbTxO3DZtgpg1F2Z3R5EymyUn00MVarUfcEk1pGPbEgsjddc6dGabJ9XzgROLKEeUA+
	lQxQRB0iTI6e88M89Yl2LpWquLPSLeGIGp1i59VViDThoyxF6VP837borbMSXmr4r1qj+5ePlsX
	iQJS2rdQESuf+wf3g1dLAjUWYi4mwymybqlF8dm2BNXC9czD972KK7kPo3AzuEyazp5Yhz4U8oL
	Ew0KoSs5Eer/EOGcTPoAgbblo7YSKBj0AknANVGLE6J2Fx+5Pt1DHmTFPdU1fUNORhU8QCvsvkG
	nR8ABVyiTZvkCjnkg89N6xK1DrMEM77f5FPZMqzgrdNnHCDH9nwzGn0s2yfc4K3cCpqX45bYz1B
	EEKU+Txv+fRqnJ6hmzCDPk1VkCkGxwSHva
X-Received: by 2002:a05:7022:f404:b0:128:cf41:d6e4 with SMTP id a92af1059eb24-12aabc052bemr4620868c88.21.1774722221335;
        Sat, 28 Mar 2026 11:23:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:40 -0700 (PDT)
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
Subject: [PATCH net 1/5] net/sched: netem: fix probability gaps in 4-state loss model
Date: Sat, 28 Mar 2026 11:21:45 -0700
Message-ID: <20260328182336.392817-2-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-272792-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D67734F884
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
index 5de1c932944a..2cc3acaa4068 100644
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


