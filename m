Return-Path: <netdev+bounces-96230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B08C4ACD
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0716E283136
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EADB65D;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwKSVFV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81181AD5A;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649223; cv=none; b=fElJFr06KbWTza51CTZntMNbw5zgbza/iSjPai4b319KUbxxngHrKzj9EpuDrWp++qD/TlUSgWqpPEK63XSA8o80/nFHILnIXKikpALrNbbEan0wJcgo61P8i/ctR84GEhaDxbG5ItxbVc9/+bv+OrhmmKL8MCGkAJrbmlgUms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649223; c=relaxed/simple;
	bh=SuBQO5z3Rf1aCOlyglm3AKTFHnDNU1WgZ4qtAUIiPDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8E8v/qDjcrWvoShxg9Z5BCTcB222oFLzzv2Xc3Xj3U1LxZ20VC2wDMcmiGpnx/oJDRnU47MWkNywexVoHKFC++AOu4UP/CitKZvf9VHPuKYMyU1jOIn5QO9YcGS0BG4PuUmvUTunbOd0ikdx4vaiiXKisRCoaEDkTI+pfKH38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwKSVFV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2313CC4DDE2;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649223;
	bh=SuBQO5z3Rf1aCOlyglm3AKTFHnDNU1WgZ4qtAUIiPDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwKSVFV8l52+D30/uQIgifgwxne5su7EhYEYrWH2tYXNhvCKB7Kl3f5eWGNCHoiFC
	 ozuNQWQMYfNGgiNRXd0jHzzEI7DRaXKcDuhAzWzv1wIBUsfO4Vs02zilEA9Ol8Rqai
	 2kotIXA8DsdyJIW0rYmyGSzUi2HZfkOD9PbUVuvGcLr32CQ7SYvGS6l1GgSZ7EQG/K
	 IF6I470PAfBMNtcOnLS/2U03QDVrkQG71ZtE3TufIlCJsKgJbpv/L/xmwZCj+0BU5M
	 FlreYGd7ZcO9DW0I49gOErSS/wjggoqFWyKgt5bN7xP/3IWP5c9Wga6JOgwQCTiGkD
	 0lT7XvAKfAIgg==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 6/8] mptcp: remove unnecessary else statements
Date: Mon, 13 May 2024 18:13:30 -0700
Message-ID: <20240514011335.176158-7-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

The 'else' statements are not needed here, because their previous 'if'
block ends with a 'return'.

This fixes CheckPatch warnings:

  WARNING: else is not generally useful after a break or return

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/subflow.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c1d13e555d10..612c38570a64 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1119,6 +1119,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	}
 
 	if (mpext->data_fin == 1) {
+		u64 data_fin_seq;
+
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
@@ -1131,26 +1133,26 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				 */
 				skb_ext_del(skb, SKB_EXT_MPTCP);
 				return MAPPING_OK;
-			} else {
-				if (updated)
-					mptcp_schedule_work((struct sock *)msk);
-
-				return MAPPING_DATA_FIN;
 			}
-		} else {
-			u64 data_fin_seq = mpext->data_seq + data_len - 1;
 
-			/* If mpext->data_seq is a 32-bit value, data_fin_seq
-			 * must also be limited to 32 bits.
-			 */
-			if (!mpext->dsn64)
-				data_fin_seq &= GENMASK_ULL(31, 0);
+			if (updated)
+				mptcp_schedule_work((struct sock *)msk);
 
-			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
-				 data_fin_seq, mpext->dsn64);
+			return MAPPING_DATA_FIN;
 		}
 
+		data_fin_seq = mpext->data_seq + data_len - 1;
+
+		/* If mpext->data_seq is a 32-bit value, data_fin_seq must also
+		 * be limited to 32 bits.
+		 */
+		if (!mpext->dsn64)
+			data_fin_seq &= GENMASK_ULL(31, 0);
+
+		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
+		pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			 data_fin_seq, mpext->dsn64);
+
 		/* Adjust for DATA_FIN using 1 byte of sequence space */
 		data_len--;
 	}
-- 
2.45.0


