Return-Path: <netdev+bounces-168746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2343A40725
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489967061C7
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E2209F53;
	Sat, 22 Feb 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUb8T5z0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5C207A3F;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=N9HKf71kdiujin/O0VBm0wYH9lC7yuC4Wq+fvzIosidvCETcuFI+VTwppeW/DzKJ6VinJaSJ7iRO+WezarNHn5p4rbnRCAscyg4yy8roVmZzL7aDUAUCemPiYVS8/mw9xPibsZojNtMjlC0enQFv0VKd6HKggdeELR2N2H9Q23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=93+PXTcdrckZb/2Nnne1jF/O10OyK0HSaybtl4UJ5hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jeXSGnXGwL+6QpTrsKr3oyt8qA7OXP+L2xYe2rbinaqGyxYWOHqk1hwjp69UXag6NDCxHlkbNuAJoRNHAOcY9x+JYbwjk/NQzk2L/sEC1qJPOsso+DPXRmat2OVqt3vfNkyrP5qnAfWimvOVCgEhV8kK+/P0zKzYDoQ2G3cjqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUb8T5z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D934C4CEEF;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217802;
	bh=93+PXTcdrckZb/2Nnne1jF/O10OyK0HSaybtl4UJ5hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BUb8T5z0tb0zj9lYbiAg8nCjTUfSGkmRTdGKFgoEy4xvYoJa9dSVTwycj2WHkzy3V
	 7Zst8V6naVDR8lYPZD8C8Qx5xj6B1zEYpL3XFQ793OUnLgM5jFMdXEMRGlYYP6flBw
	 k3o71qwBxfnH4unSIZP4CiZPTUInir8pmLLnzLYVf3jgyHAymBOa0cKv3rdTX2oZX7
	 9mL7WsyGmrBFUSVdn/qNYvmNWR0M4LPjEuAT6FwnzJqyHEajX+fvwhLtpI9SMGQOL5
	 598JD9usVYyvyOgZir1wzlb+rAJOLVk26AFKPikfYUz+UBI7VLoyBlL5SP1QRDLVV1
	 6DW8V+EoeHbGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C60C021B2;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Feb 2025 10:49:34 +0100
Subject: [PATCH net-next v5 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-tn9510-v3a-v5-7-99365047e309@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
In-Reply-To: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=1329;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=dE9RmcpNBtcvMxg1vX89VIDp9W8qYafc8S1ojRZqfFQ=;
 b=Jca7171c2uczNOMWGlSjnywuy7MH4h3qJirWdBJgy1NgIZl6wUT0ArOXOYPo6xeFox8EG50uG
 FBwaZOTvq9KCcieSWwSm6BiO+AnNBJqM4JsTOcpkAzU+wp5SYbs5IE2
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
2.47.2



