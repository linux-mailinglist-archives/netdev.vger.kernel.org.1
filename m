Return-Path: <netdev+bounces-152715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544809F5875
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC22E1893FBA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48941FBC8D;
	Tue, 17 Dec 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2XHY6Ya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7E1FA8E6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=B6A4bNmnoqlGfDjOoBu9GtE41/k2xFPGjX1wac5zejiIeH/Zu0yoXLyxOh+THT41J2bS9waQP5+El19cIjZiVSwXyjOjLpIE9OZvhO6ONQ8DrgTHzau4cQyvlqD4a9nFPry2p8KQYYQmJlQiVF4AkU7o0dTPS/quOpl3iTuuHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=MGrxxfG18O/UOrjPuFWbMeYHAZMncy1WnK1iYAlTJL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhRHxI2JyNSZg+3JEhX+BcW6iAy24HCsxTdMJniaA/ofLFt/7FdkOi6tvvZdMcJPcftSJ1cRlKd1Jw7hQ2+7OiEVWxBkEgIAmBrMk91yCQ4nheIVjIBLfgvJgtuvxJlylxD2QFU0agFpYDci1oDopBT11dddJJ/Cy/ZKWSZS/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2XHY6Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45FD9C4CEDE;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469659;
	bh=MGrxxfG18O/UOrjPuFWbMeYHAZMncy1WnK1iYAlTJL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q2XHY6Ya0IJhxTrIPKDx3wHM7Y16JfjWcVwtL0cQ/nmgBq9VhD/QdvhrazdsPYWG8
	 lAm+AwkEtA52LX9itDo5QEHf8KsjM5KAwQep5IvVe8G4r+aqLzpT7ifX95NIxeexFB
	 2kP+Sk8Xq/X+PYsZiOa3xKkTzk3mRIBZjxhKgIIu5FqeQl98hSXL9tOK1UNwcLAlLz
	 fqZhTPlHU7wsQVI10a1tMJV9HkOlUx3RNRjvqZafnTSSCK1oqQtFhxU219dg6l74Es
	 W4k7hsgJgVtP5S1KkkCflMFDTaNIWOLBRJeWEA1lMHbCicLVT7RCdPxIEMBlv+gmKT
	 3PnG9j2WTYevA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08BE77187;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:38 +0100
Subject: [PATCH net-next v3 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-7-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=1228;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=aJL2+Qt1fXp1c8Nkhc4Qvp7fWnaLIrf+lqxUzAEbh+w=;
 b=ykcDIxI1JWhHGDCGeBp/uszL6eStVzeak/U/tdYGxkuh67ZfBvP/SyieLLLsMWqxADcAkyS0O
 PUm2L9mpc+QDbt4EIfovsq189psHzM9/jnw8yM7fdegdfICNc9Lr0I3
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
---
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 5f73eb1f7d9f74294cd5546c2ef4797ebc24c052..2f4e0dad388f84d6daf651d67ef99c6f62244586 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1840,6 +1840,10 @@ static const struct pci_device_id tn40_id_table[] = {
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



