Return-Path: <netdev+bounces-153924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B292E9FA109
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DC166CA4
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C61FCCEA;
	Sat, 21 Dec 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpm2lYJW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EB1F868A
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=m1nrmuv/eylsFwopcXZhs+HhqJ/ntnRqSOBS91OPVu0Ak84OIMCf4KpsnrjljABERWaW4quLbpxfw46MiiguEgMiZBqK/xm18wWkblJxZNXL44HdvaaPaTof96ALN3SRwbrZtqc9ZbFYBbD8eLFFIsuB2fto8OOapG6nMDyOOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=Q80IuyLp1AWhiinI8ZNGtWUI414ucBhpAiHOdgk9cG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQqeBufNPbXkkYJnMAVKVOM3dd+p/+nvuXdUtH8jxrZPdYzyn39U85HyDW2oe2GK3nnJLOyeXpyGHhfCqJjJLcnNVgEJ5D/7pir9jeAxsN/8nT1NgP82nMk8HgWSw20Uh9NhOxUevZSyLmAkwX2S93nt/NNaqg3h9qMST+3ryPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpm2lYJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D3C2C4CEE7;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792253;
	bh=Q80IuyLp1AWhiinI8ZNGtWUI414ucBhpAiHOdgk9cG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qpm2lYJWKWw2TBkPrv4rbTAUNFVnk/J9yQiRAFrJ1jer4RhmxyGdDSUBPzfpsk2wT
	 UrcqWH6RIwjFUVnCj0GQMXy5JlOtE7xFMh6pC/PbUxAy9rbQKEG46aK6X9nHYx7mBf
	 nAFqVwLe2h4s8lt+l7LCysyfpKcmSvvAfb6gYlXEQGKw4Wi8IRG3E0pdI8xkS3ha3k
	 vAnxYvsc+WmcZoYyiX208v/hQZvdoarJtze8ve/J2sP/FjcBOT0aKQzvLmN/1VCvL/
	 TYrmTdyIZZJlOsFtgtCsN/GXjccWLAGPDNt88SaD+Tcg+Lz4jRAYsxFd6AIH7LoNNx
	 zEcrJxWRF9jGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE5E7718E;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 21 Dec 2024 15:43:42 +0100
Subject: [PATCH net-next v4 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-tn9510-v3a-v4-7-dafff89ba7a7@gmx.net>
References: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
In-Reply-To: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=1329;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=yjBuIErbiO77pHQVHm/YuXX+rV3PVtu1mgIKIbg75dI=;
 b=WMGd2nQUCbQCX66X6C0YNMCyyK66BoZgKF5S6VGS2k6K/dk3Tjh5nl88k6hKL33Uko6q24ofo
 EqpJMSiuxnaB+82wxEPvXKF/9rj3frKynBfMHjBeS/APYdFPWkm5PDV
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
of the tn40xx driver on these cards. Here, I chose the detailed definition
with the subvendor ID similar to the QT2025 cards with the PCI-ID
TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
the AQ2104 is currently not supported.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index a4dd04fc6d89e7f7efd77145a5dd883884b30c4b..aaad40c916ef83f457e1b5983c01dff2de148fea 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1835,6 +1835,10 @@ static const struct pci_device_id tn40_id_table[] = {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4025,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4025,
+			 PCI_VENDOR_ID_EDIMAX, 0x8102) },
 	{ }
 };
 

-- 
2.45.2



