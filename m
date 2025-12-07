Return-Path: <netdev+bounces-243962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3172CAB9EE
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 22:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332F430102AD
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504D2C0F8F;
	Sun,  7 Dec 2025 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=betterinternet.ltd header.i=marcus.hughes@betterinternet.ltd header.b="Wz3lRoj1"
X-Original-To: netdev@vger.kernel.org
Received: from sender2-of-o51.zoho.eu (sender2-of-o51.zoho.eu [136.143.171.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225A28D830
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.171.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765141519; cv=pass; b=WLDEla9vLhK8Xmu2hE0tinwV2PylJviIXfzSJ3t8ve97eM2coKyCqLy425tcrqHkvm430wMbE7wtWENAFuav4pJ9UE8NXvTq/Myhshe40n2T2sVumJ3b98isvALFgvaJXUCdEy39e4Z8lOBLL2vq1u29FuAWzmw0FvB3eYCQiyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765141519; c=relaxed/simple;
	bh=NC10/MFdlHQE+54qa7FQNjGqM3WyNqIa99ZL4ofLymo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8l4bntRYC9aGKdfsrxh8wBFv3lgyt48NYB5rjOn1uhRnS/PqI95DO/rcrg6Ec+Yb3gaOBbacCRRcfGOzeJQYnY8tQKS3KSELnjhJ1574q3n3S7xFr0gu1W98bhnfFijFBRAabPxzQFy4iX2HlR1xEQuO5zXR1qP95D5Wqlgp1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=betterinternet.ltd; spf=pass smtp.mailfrom=betterinternet.ltd; dkim=pass (1024-bit key) header.d=betterinternet.ltd header.i=marcus.hughes@betterinternet.ltd header.b=Wz3lRoj1; arc=pass smtp.client-ip=136.143.171.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=betterinternet.ltd
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=betterinternet.ltd
ARC-Seal: i=1; a=rsa-sha256; t=1765141477; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RqU9W9nbBmwl1gQCb5iQLzIVLvEDWcC2VZipMnE7iCtuaXUAaS20uAQEUnro2ElFkKl/PMJ6Zr82M9WAwADHtoFgqAIhS9DqWiDYVROE3qdKI5z8T/E4go1US2bglIi8V/nGS32DMpwaPvdIbkpbKofYepm25UCAyoAkXnVI5uY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1765141477; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V8jZQV/I0+Srd3girTzGkRW0T+l9urYiLGSkzJ1zlWU=; 
	b=SxUQq6lrcVTqYj/cxrDF1oCS4PPVOKWvw4OchxO75ixxfh+8J/o0YhegaJ441y2jcPbn8qvGoikcbeNXO5lNb4pXnd02wisysm3x27gwltA1BOVMIlESP4vf+V7lWMOMvZPM7Xsymql1Dr/d1CcP3JG7en4KDtFzFyvdDtmuYLE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=betterinternet.ltd;
	spf=pass  smtp.mailfrom=marcus.hughes@betterinternet.ltd;
	dmarc=pass header.from=<marcus.hughes@betterinternet.ltd>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765141477;
	s=zmail; d=betterinternet.ltd; i=marcus.hughes@betterinternet.ltd;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V8jZQV/I0+Srd3girTzGkRW0T+l9urYiLGSkzJ1zlWU=;
	b=Wz3lRoj1tweVm2n149Q50wGQBYRU1lMxDghkS4rZ3CPVANTvXBboDaU3DyFXMSON
	PJV5dAKHXmMKIYxDsGPT6gfrO8K8dzvj6OSAk2pqjLWRVXO9+Ig55+3fRllBv99gEPK
	/IsQ7j4NZy5YPHb19zwOoaXgNK/DvO45ipZG6C7Q=
Received: by mx.zoho.eu with SMTPS id 1765141475937821.8787071069646;
	Sun, 7 Dec 2025 22:04:35 +0100 (CET)
From: Marcus Hughes <marcus.hughes@betterinternet.ltd>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Marcus Hughes <marcus.hughes@betterinternet.ltd>
Subject: [PATCH] net: sfp: extend Potron XGSPON quirk to cover additional EEPROM variant
Date: Sun,  7 Dec 2025 21:03:55 +0000
Message-ID: <20251207210355.333451-1-marcus.hughes@betterinternet.ltd>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some Potron SFP+ XGSPON ONU sticks are shipped with different EEPROM
vendor ID and vendor name strings, but are otherwise functionally
identical to the existing "Potron SFP+ XGSPON ONU Stick" handled by
sfp_quirk_potron().

These modules, including units distributed under the "Better Internet"
branding, use the same UART pin assignment and require the same
TX_FAULT/LOS behaviour and boot delay. Re-use the existing Potron
quirk for this EEPROM variant.

Signed-off-by: Marcus Hughes <marcus.hughes@betterinternet.ltd>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 0401fa6b24d2..6166e9196364 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -497,6 +497,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
 		  sfp_fixup_nokia),
 
+	SFP_QUIRK_F("BIDB", "X-ONU-SFPP", sfp_fixup_potron),
+
 	// FLYPRO SFP-10GT-CS-30M uses Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("FLYPRO", "SFP-10GT-CS-30M", sfp_fixup_rollball),
 
-- 
2.52.0


