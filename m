Return-Path: <netdev+bounces-281615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HgrLEYt8GnxPQEAu9opvQ
	(envelope-from <netdev+bounces-281615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311947D23F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34AA93028363
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A619322C6D;
	Tue, 28 Apr 2026 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v1BLrdcP";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v1BLrdcP"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA23301485;
	Tue, 28 Apr 2026 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347905; cv=none; b=N5gR2njG+HXayIILqcE7DqUrRuPpvG5hNHTcreaZfeONHZKeAIhue8O7N2bR93SYS2zA19Cby1EkOS4Jup7AopmW/q7u3SRA5Dv0MkVJGHoOjSQKTv2NozZQBXJeBLuKdfSynkeOvpO3Ery9T24Z6c3Am0Fbw4iPfvnLh5Hk3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347905; c=relaxed/simple;
	bh=xs7FohA2kQ00M5o/FHhRwv43hH00H8f8LM+NLgsZgU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aUgAYeT4OU2cJP60QaicErSFOKmW5L+2/VEIgOz1W4sMFpWSqKdNDjmuBRKaAy0oPz5rWBofixJcyncdButYxcR3QEtPipmFekRPY0Fzm52bqqqPTOah+lSwLas4BTYV5lXM8L0XvczkrSlN0tpA+gc7FAu0r2aMOLYfBD5v+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v1BLrdcP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v1BLrdcP; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777347901;
	bh=xs7FohA2kQ00M5o/FHhRwv43hH00H8f8LM+NLgsZgU0=;
	h=From:Date:Subject:To:Cc:From;
	b=v1BLrdcP/Yqim8VGoap4xUT6qX+McMcu+7N81pYfOFS4oa+hLriqkqIqg9OX34nOV
	 oZaq/tU4NZuuT++YRMtW9Hs8AetjAhSyXI1AgOkJDFzl+VpXaPGcTTiXyEjL6XjUWx
	 OvKAWlqtdf/puTxD1dv8Tol+Tkvybmi6/CjFOTSS0f+oolWPU9ufNppxsPDrSJf8dT
	 LWzwKzbEHxIkNB8+lD4Nv6beHMujv1zcH1xEmX/ZelYjYM+5bsyboeK4qKkMGtZm7E
	 xn7vLmt+GPDh8jewYnNFe8IXIOHxCXGDakJfOsVDK63GmL52QC0LAls+zFWdfAY/yI
	 59de88ndw65dQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A9503478CD; Tue, 28 Apr 2026 03:45:01 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777347901;
	bh=xs7FohA2kQ00M5o/FHhRwv43hH00H8f8LM+NLgsZgU0=;
	h=From:Date:Subject:To:Cc:From;
	b=v1BLrdcP/Yqim8VGoap4xUT6qX+McMcu+7N81pYfOFS4oa+hLriqkqIqg9OX34nOV
	 oZaq/tU4NZuuT++YRMtW9Hs8AetjAhSyXI1AgOkJDFzl+VpXaPGcTTiXyEjL6XjUWx
	 OvKAWlqtdf/puTxD1dv8Tol+Tkvybmi6/CjFOTSS0f+oolWPU9ufNppxsPDrSJf8dT
	 LWzwKzbEHxIkNB8+lD4Nv6beHMujv1zcH1xEmX/ZelYjYM+5bsyboeK4qKkMGtZm7E
	 xn7vLmt+GPDh8jewYnNFe8IXIOHxCXGDakJfOsVDK63GmL52QC0LAls+zFWdfAY/yI
	 59de88ndw65dQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 054EB475CE;
	Tue, 28 Apr 2026 03:45:01 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 28 Apr 2026 05:44:58 +0200
Subject: [PATCH net-next] r8152: Use ocp/mdio test and clear functions in
 r8157_hw_phy_cfg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-use_bit_functions-v1-1-6eb5a3507610@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIADkt8GkC/x2M0QoCIRAAf0X2OcGs7K5fOULU1m5ftsP1Qjj89
 6THgZk5QLAQCjzUAQW/JPThAeeTgrQGfqOm12CwxjpztXe9C/pI1eedUx2yaONymN0txuliYXR
 bwUzt/1yAsWrGVuHZ+w9Gykg2bQAAAA==
X-Change-ID: 20260427-use_bit_functions-06fa965bb832
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 0311947D23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-281615-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Replace explicit testing of bits and clearing these bits by existing
functions ocp_word_test_and_clr_bits() and r8152_mdio_test_and_clr_bit()
to re-use this code.

This allows to remove the "ocp_data" variable. Also remove the "ret" variable
which was incorrectly used for the r8153_phy_status() return value which
is a u16, so that the remaining "data" variable is sufficient.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
The ocp and mdio bit test-and-clear functions were added in the last
netdev patch submission cycle at the same time as the support for
the RTL8157. Make use of these new functions in the PHY setup of
that Chip. 
---
 drivers/net/usb/r8152.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 7337bf1b7d6ad03572edbc492706c07a8f58760f..c7c1b07d4159d50a1641894235a011e467e5d3e7 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7952,17 +7952,11 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 
 static void r8157_hw_phy_cfg(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
-	int ret;
 
 	r8156b_wait_loading_flash(tp);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (ocp_data & PCUT_STATUS) {
-		ocp_data &= ~PCUT_STATUS;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
-	}
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
 
 	data = r8153_phy_status(tp, 0);
 	switch (data) {
@@ -7976,19 +7970,13 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		break;
 	}
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	r8153_aldps_en(tp, false);
 	rtl_eee_enable(tp, false);
 
-	ret = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	if (ret < 0)
-		return;
-	WARN_ON_ONCE(ret != PHY_STAT_LAN_ON);
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
 
 	/* PFM mode */
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);

---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260427-use_bit_functions-06fa965bb832

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


