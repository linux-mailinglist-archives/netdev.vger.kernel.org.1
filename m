Return-Path: <netdev+bounces-201136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFDAE836A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBF6A3779
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C0261393;
	Wed, 25 Jun 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgo5cfGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96D261390
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855943; cv=none; b=n9dFn6s5Y9n1qdyUH3QjVslxNduLsQ6dk9ScqXSpiBqENUv3Vb6CJipIPaDMvc4AENxGmCK7mcinp8XLJMbNcOMEH6De7pVdhvdUQ7b4vZHBwwTsci86KsrAWReAPlQ9WjVTjEhEejAC9KrCE5BmUo3pUTV/aN2Xs2Vsv490+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855943; c=relaxed/simple;
	bh=lrGJWpMrdwaCLp9XqcVclLVJiL6eGjT6cGqHD6SvrT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uyy88O7cLPCgU/jqlnhhgzbIiFuSK8FzEZm8MuzHwlDrDD2jVChCeB/5NJZXdNx8iut5gMFlzGqiXMGFeQ80ZrJN551ESF1/WOWKxvzH1PF7YsEnOLELw+O+G1eix6HNFriBLXU6XuZ6dFeJfy8aHBSmly+dzOjMekiAHQe+9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgo5cfGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04FAC4CEEF;
	Wed, 25 Jun 2025 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750855942;
	bh=lrGJWpMrdwaCLp9XqcVclLVJiL6eGjT6cGqHD6SvrT4=;
	h=From:Date:Subject:To:Cc:From;
	b=dgo5cfGmlIE8IuMKqhP3xtTmCv8ljpV4XzAd4uDiCa9iIpBAomKDFrYsTEwFgzmiP
	 R/LpWL0rHMos2anNjzstAWfd8y949/I46iNXLFkibqVbSEhkFdAHKl995BgeZfegKK
	 uT6n09j16wL2PIn+B6JNhaj03UlMjP671CqpPanW8r8RpLwsEe9iXWHDMa/rMmTnze
	 aTwOQbXwGV1DBsWOOcCwiCXRA4xKAU5/kvi453JvmIYfhGyTiAjxywT2h4hfnc9IqN
	 u58BQiACeURLWs5M9O66tXoo/dxBOhcplqwDv9vwmhnQOomLFy8QZHltXiyKK37HiW
	 yWxunoYdueAcQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 25 Jun 2025 13:52:10 +0100
Subject: [PATCH net-next] tg3: spelling corrections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-tg3-spell-v1-1-78b8b0deee28@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPnwW2gC/x3MSQqAMBAF0atIr23QaJyuIi4cfrRBoiRBBPHuB
 pcPinrIwwk8dclDDpd4OWxEniY0b6NdwbJEk8qUziqlOawF+xP7zm1ewyhtmmkqKfang5H7f/V
 kEdjiDjS87wecOmekZQAAAA==
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Michael Chan <mchan@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Correct spelling as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 ++--
 drivers/net/ethernet/broadcom/tg3.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 91104cc2c238..c00b05b2e945 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6686,7 +6686,7 @@ static void tg3_rx_data_free(struct tg3 *tp, struct ring_info *ri, u32 map_sz)
  * We only need to fill in the address because the other members
  * of the RX descriptor are invariant, see tg3_init_rings.
  *
- * Note the purposeful assymetry of cpu vs. chip accesses.  For
+ * Note the purposeful asymmetry of cpu vs. chip accesses.  For
  * posting buffers we only dirty the first cache line of the RX
  * descriptor (containing the address).  Whereas for the RX status
  * buffers the cpu only reads the last cacheline of the RX descriptor
@@ -10145,7 +10145,7 @@ static int tg3_reset_hw(struct tg3 *tp, bool reset_phy)
 	tp->grc_mode |= GRC_MODE_HOST_SENDBDS;
 
 	/* Pseudo-header checksum is done by hardware logic and not
-	 * the offload processers, so make the chip do the pseudo-
+	 * the offload processors, so make the chip do the pseudo-
 	 * header checksums on receive.  For transmit it is more
 	 * convenient to do the pseudo-header checksum in software
 	 * as Linux does that on transmit for us in all cases.
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index b473f8014d9c..a9e7f88fa26d 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -2390,7 +2390,7 @@
 #define TG3_CL45_D7_EEERES_STAT_LP_1000T	0x0004
 
 
-/* Fast Ethernet Tranceiver definitions */
+/* Fast Ethernet Transceiver definitions */
 #define MII_TG3_FET_PTEST		0x17
 #define  MII_TG3_FET_PTEST_TRIM_SEL	0x0010
 #define  MII_TG3_FET_PTEST_TRIM_2	0x0002


