Return-Path: <netdev+bounces-165246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2BA313D2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD37A7A32EA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CA254B17;
	Tue, 11 Feb 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUdzgNYR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F6254AE8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297644; cv=none; b=IFeejQ9mkopLffn86CMn8u3I6VqLA02v9m2CHZGScf0wr6B+ZFbTMvFLJ9Kd6K5/bIw9eAuyWTG2UtyAT0NvcRWkv5HxWm3B3Y1zkmQnroBbr+tUL5qsGIFkm/cFnc9O0r72AaG5k6IdLdTFxIYDPVsHs7Z9kUo3NH3/hazqHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297644; c=relaxed/simple;
	bh=RQSDTFERgShMM+kbS7pCx3jsMqsdFJBMfnPeMvdI5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWXjisIqSSH4lER2cYusWWT3DKuolH8ta93NcOza4eEvD1ScMT4ojW6WT3sMNBH52AkYmsP4sDY4ebGIGzlJx7/TRIkYD935VLtN0Uo/yu9sqNQ1OT/mPcq5XDLjunEuN8h5QxQiXa7M3y6ETRixb/OnKhvZxzQpVgqvSZXl8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUdzgNYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3E2C4CEDD;
	Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297644;
	bh=RQSDTFERgShMM+kbS7pCx3jsMqsdFJBMfnPeMvdI5m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUdzgNYR+bECgmZzc4oYagi6YDoJCyHT/KWsWs9646thShY72BRCEUXL0aTp4rV2z
	 xNOooqIps54UkvxJNvzBkNt5gftOwJUve1a1b5vzFq0kYNLW/gZ10Ik6iniaKrCQda
	 tjuYzn3hir8sdK2wNKfVZnuQMlLUq9AE8O7TL+kdI+UwSon43w7GGq1yVFhmHbyhmr
	 AzDRsv7omr/5OV3BM08vyj7DY44IAWW5cjl/azDYi8swUGq2TU0khVoAQwMH6mCwEV
	 IxM8MFO5A5igEPzxs+xtxL44bUGs3Rxhwehh761hhBDPNWW5OOnkmHsfEqGxbBtzH0
	 K1KaXw5qfagHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] eth: fbnic: re-sort the objects in the Makefile
Date: Tue, 11 Feb 2025 10:13:56 -0800
Message-ID: <20250211181356.580800-6-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211181356.580800-1-kuba@kernel.org>
References: <20250211181356.580800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like recent commit broke the sort order, fix it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 239b2258ec65..0dbc634adb4b 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -20,6 +20,7 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_pci.o \
 	   fbnic_phylink.o \
 	   fbnic_rpc.o \
+	   fbnic_time.o \
 	   fbnic_tlv.o \
 	   fbnic_txrx.o \
-	   fbnic_time.o
+# End of objects
-- 
2.48.1


