Return-Path: <netdev+bounces-95416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E736D8C2301
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C991C20F72
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247F17107F;
	Fri, 10 May 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ33SQKl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487F16EC18;
	Fri, 10 May 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339952; cv=none; b=QlFor8sQDrVCXK3pYd/z8FglNUZZQcUlJIdZGbomYF38OLC9i2FDrJgb+G1ZaK7iE7gN5aWnSKQx9XJyGgAXbZ6ZWAnukbxJsgygnq7CbNlulxVgqjXUMGr7KucJsURTNom25WIlcme53+NlblnXlHYoURO0Oy5NzMqo12TkuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339952; c=relaxed/simple;
	bh=g9/Ts3HF1r1iy03o7GZp55OQrzTi5Lbtpm9Z2O40MPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtCDafUEYwVAsE9KKUI006kMUPA9pw8L6V/0RWJncVLmpkrBKL9yacOG+yqCWZ9Vx/2ECCDidUCWMgq+PYe4bXhvJ60rjWPd7XViUkUIwWYZNixmSUfDWD+p8IJsSk0UJ17C7V1et+P0NGf58NLoxWTMWlN8SBojV4jue1+xZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ33SQKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F6AC32781;
	Fri, 10 May 2024 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339952;
	bh=g9/Ts3HF1r1iy03o7GZp55OQrzTi5Lbtpm9Z2O40MPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EZ33SQKl6dO4lEs6fb7iiaz/O9behXw9uxJnd/Z4FSo7rxX0Gp0TYgyc9HrLD6/7G
	 zp2TfgdWpo5FtBENqnYp6Z253uQ5MNdvKSdKUyHIJ85zhb6pbdnnVAK1q27X2tUznZ
	 wxs2Y77mdrtldgycA3ecAg5k8DzDDImEYYcvd9skhHTzvASpuSbnWEmcxzgQjjgZtw
	 WOerD8yEPZsQrfNN44+y0GDY06Uw/abVHy65ByUfjaPaelbtX1+ElKExb3hYqr9mma
	 2bpwFzWDNthjnqTM/EY6isKKM6XoV0XLyE4soNVLYnh69IDn2XAOM/9nEMuPhhy4Yi
	 H9C3z4b1ENiBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:36 +0200
Subject: [PATCH net-next 6/8] mptcp: remove unnecessary else statements
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-6-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g9/Ts3HF1r1iy03o7GZp55OQrzTi5Lbtpm9Z2O40MPo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKc1QcUYvndAnUHnijSXy1AReoYUZFJh7zL7
 cPPQACSYUuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 czGoEAC3r8/aL+IMbek1lKsHeROt/gjlk3DFA3X53eSEsJNgKdA3tgXY2KippKQf7yOq106iXas
 WE0j6JyTXyKUtYxiWDkQfmzm4PDjazz1Tb3EDANRklWYcvsy/1ky8nfDgIQ6dG/+ijta49QkyF2
 lNpP8UP9YZwGsMdUUlCQHamw7I81WUfWKYuGkiZuxWcAjdkV/9uG95OllFS70T10BdJjWibfSAP
 di8MHq/Ac5MxkABxmGWdlQ+JFM5VbOI9sJHbfwI0S3vEyrps8gvQaLzBQ0kVpiwIBvZM3vRmI5B
 DNQXoBi4csk4umXWC0ZoUMZ1y0sCbPCpc9cyrPw6XgcZExIXDpta6u84muR2ChA+EqJqYwkwRGQ
 OLs86zrz47yqSdNQelbx7eDo3FzTtNtBUQeMSwkzs9wMQA1qHRHgGVZ64FRzuGrrWwOQ/55HPk9
 1+nTi1PLbZ8hCtoboYNBNk0lnN8LtTmMdEXeeUnZr55A4ZXOS2wC6M269RlNtETM54SxAwIpN3v
 X5wr+KWco/xxDgVW+rJw4ONMNOgf2C/LZi0zAxZukZ/KNEVTW1zksaBa2XQgFPzLPzc9FAOlLzT
 ZfMYFvT2u9U2yE3gGJUtwunro7ODYodNIx7foNNmgkgLrduMz3GKcQzUqylty+L940CzV9cUL5d
 VpveFJz48U78SAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'else' statements are not needed here, because their previous 'if'
block ends with a 'return'.

This fixes CheckPatch warnings:

  WARNING: else is not generally useful after a break or return

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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
2.43.0


