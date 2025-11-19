Return-Path: <netdev+bounces-240199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025DC71603
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D54E740C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FA533DEFA;
	Wed, 19 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="HcyQQ0jV"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723033890C;
	Wed, 19 Nov 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592181; cv=none; b=iTUJduYiGrdimy9GHzZ70bPQZA2ZWTzhFKxDZnDXrvyHKqzy752DY15uU+GwlEWlGApF2ajSnrmI6IHxqUgQPIsFSvibO1OrKO5hOBKA1CbD94C/1XdKLTsVnFaxKwlEdhpQ/rq1bBjqmBgTQko2/j8MEPwTAVECW5xNrxdeXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592181; c=relaxed/simple;
	bh=m6MBYBFHJ8sJrrv4025LfRQ7bm/ehbJmyyxjIjoiqqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3oaYv1Qr/SHw/HiV/abdMszdkCwEShD8uzTmrCMLCluXyul9TazbXnQwtULILsbBGfFLfvmNw7m73KQ1OPhYYKEHbfPV+Ws9RRUIiBX+7GlIE+ZMGqx/nWohMKT3W21FuctSpcFCXfcyKSpaOmNOZtnsMdDxdvMyiQyd5lYx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=HcyQQ0jV; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-006kzB-F7; Wed, 19 Nov 2025 23:42:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=ONae3XWIWHE3stdMVC07AAUzysrfml8K7utuoa9UFWU=; b=HcyQQ0jVv5i235V1eqYpHH0NO0
	O3eD6uqkFqShD7Wx7YHmQBi4p5FVy6E51ohmZP1D2zgr0An9epW3LVAcqEj3ibxeQTH+udM9lOP1a
	AX47R/wRlwYlQANJ5KOwdKLX7NApkBn06KEEFVwWmHjcc5rcG2q7unHXIs6oP2g2VVcLVfqPuTlDW
	LLTw2de0VSmZH27xN3Ej13VdKMiv65kYSq/K2p2wvrBHql7pN2IYYqJvCTPVToPwh5A4vE+PgOK/3
	Wn1UDWDDlyDedq7XF2NezL5TY/N+nSQ/kjnVsScm/P2u/dSvwSaU4OKjB7Z5Dbd1HKNIr+wDrVo0l
	JkOZaeAg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-000871-40; Wed, 19 Nov 2025 23:42:55 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsn-00Fos6-PX; Wed, 19 Nov 2025 23:42:37 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 40/44] net: Don't pass bitfields to max_t()
Date: Wed, 19 Nov 2025 22:41:36 +0000
Message-Id: <20251119224140.8616-41-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

It is invalid to use sizeof() or typeof() in bitfields which stops
them being passed to max().
This has been fixed by using max_t().
I want to add some checks to max_t() to detect cases where the cast
discards non-zero high bits - which uses sizeof().
So add 0 to the bitfield (converting it to int) then use max().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/net/tcp_ecn.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..14c00404a95f 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -196,7 +196,7 @@ static inline void tcp_accecn_opt_demand_min(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 opt_demand;
 
-	opt_demand = max_t(u8, opt_demand_min, tp->accecn_opt_demand);
+	opt_demand = max(opt_demand_min, tp->accecn_opt_demand + 0);
 	tp->accecn_opt_demand = opt_demand;
 }
 
@@ -303,8 +303,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 			u32 bytes_mask = GENMASK_U32(31, 22);
 
 			tp->received_ecn_bytes[ecnfield - 1] += len;
-			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
-						  minlen);
+			tp->accecn_minlen = max(tp->accecn_minlen + 0, minlen);
 
 			/* Send AccECN option at least once per 2^22-byte
 			 * increase in any ECN byte counter.
-- 
2.39.5


