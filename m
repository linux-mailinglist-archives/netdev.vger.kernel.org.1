Return-Path: <netdev+bounces-167443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BEA3A4D2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C178C16FD66
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C1270EB8;
	Tue, 18 Feb 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WmGJep2P"
X-Original-To: netdev@vger.kernel.org
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [80.237.132.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CF270ECA;
	Tue, 18 Feb 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901597; cv=none; b=MiZhvdEIrZ5/41PCY/O9NLFRG44kcrq2BRALgBy3jG6LYVpt+t8mOPb5TvO/TcwPVQpYgR44drAGscR+oXCi33Ri9uYD6II2JBfKTVN4vFUo28MBUPfDVMo0ip00XxaACzecW2VGViscQFpWY01/qo9SuN9PTU863vkOm9lsyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901597; c=relaxed/simple;
	bh=Pb4GdmMiZqJpSKdPUHREckPwTt9gksY1gJvAlHlOncw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p0v3Uw6beLE6VZU7JCKtCcuf00EX8n0RjwB/xagIV6uAFd3i9y/vqlMDKd8G21p+2WPyGUWZikgS+a/uZ2Pj5QbXDDq01Zys6d9sqVoNXUd44qGArk3Dnw8tUttfSXkssDPNGJvZTruc0zEX/HE/NfN6ZJn1F10WQ9fkqG8goTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WmGJep2P; arc=none smtp.client-ip=80.237.132.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=birger-koblitz.de; s=he134867; h=Cc:To:Message-Id:Content-Transfer-Encoding
	:Content-Type:MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dOvRCp0epH47Aog3x2xfxLd8Tpx+8FCeF68J2cDy2G0=; t=1739901595; x=1740333595; 
	b=WmGJep2PaBow35HC/lKrqtVrtYj4cmdsFboiq72QWu+OmUHCv67W2u/4V1bwod2pgfPlIisdsEV
	ToZgSXREo8WTsAXOGfPAr+1TmWkBKeUzPXOW0Zov7D5ycg89ldQSPUc687NPnN5BMGQQrCkWHaiDC
	YL5drjRnJDvC4rv5BcPIavV9pxeEc2vDksFZG7QHj9398zCtBqhbulk2Q726Yc0LRW2PxpkQgMaQk
	aybSjfGAWxVcBkWMzP13cjsZSiRX8VOYElu4yt/uwLWski6K9TRd66YCP9ZwrTDt0s5pbDy54Wg0w
	RSOWyRwt3RarkRt7DMBtx8p8waexEp8FhrIw==;
Received: from [2a00:6020:47a3:e800:da9d:a6d:db2d:3dd1] (helo=AMDDesktop.lan); authenticated
	by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tkRsn-008uy8-1m;
	Tue, 18 Feb 2025 18:59:45 +0100
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 18 Feb 2025 18:59:40 +0100
Subject: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-lkmsub-v1-1-1e51dcabed90@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAIvKtGcC/x3MTQqAIBBA4avErBtI6f8q0UJtrKGy0IogunvS8
 oPHeyCQZwrQJg94ujjw5iJEmoCZlBsJeYgGmckik6JGneMyr+HUaJUWla2EbUwJsd89Wb7/Vwe
 ODnR0H9C/7wc86TiyZQAAAA==
X-Change-ID: 20250218-b4-lkmsub-fab17f71f9c6
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Birger Koblitz <mail@birger-koblitz.de>, 
 Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.14.2
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1739901595;3aaba111;
X-HE-SMSGID: 1tkRsn-008uy8-1m

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee26a221e9c47a6f030c8a18317bdbb..9369f5297769493efcab0ed4c356245baa1aa248 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),

---
base-commit: f80d71e9c515163dd337d3b22b6915b1bd7b478d
change-id: 20250218-b4-lkmsub-fab17f71f9c6

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


