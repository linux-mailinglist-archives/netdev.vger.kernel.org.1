Return-Path: <netdev+bounces-238649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E2C5CE7B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 364BF4E312E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3D313543;
	Fri, 14 Nov 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URWkSUCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9F2877D5;
	Fri, 14 Nov 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120378; cv=none; b=sFv8JxqxCzo1/MVDsxtH/w39/13cSD3d6JfN9YAubFB5A0qVuTps3RzDXZr4vD+aUGIe8JtC23PqaWbBdG4ilTJHfDdOki3vlNjM2kYRnlTnpg5UFb4rozHikFaG66j7SaV1SeFNis0jKk0/Ql9d2M4/Jf+TNwY9hqr0Xi7Lq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120378; c=relaxed/simple;
	bh=QMn+aqsnHLN2238UDQHPXzt6ZSS3mIIatXxiqp40HW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A+lABnaTW1W7sCxKCIP4hHzSzxKAnGJCOeTJAApcbY/+CcS9EtTO/ltVoxX19xN1wrZRd2fbTj2IUNUxmo0BS0g7v6/JitkH6sdleMnPaNtyDgN1nPq+wb+r21ORQy+0z+mNElsCUEg/eMuz785rZGnkLjpMPi9hgXANUWkDFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URWkSUCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB379C19421;
	Fri, 14 Nov 2025 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763120377;
	bh=QMn+aqsnHLN2238UDQHPXzt6ZSS3mIIatXxiqp40HW0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=URWkSUCip83/WH4peliK+3vcsyvf5bK0ysiCJVFiaAzQ+/7NkBz+W615wWGLOr6yN
	 0k7Ksbixju9HrgO+Twq/wN8PUcxHAT34mmcKIEDEnULIp1+CFk0ME/0oOibSRgzjyx
	 /0uaq/NyCOLUZUDOJa4YsHtt0NwHnhuJ6P2xC9c+YGfpmmCDGj1roFxENkFQFTZNDt
	 kpEUElXB69G8Yb6hO3HMbUJ/OzfwfEZ1ytxKZpgfkpQoEQaJWiKq6vQAaoFHeU8QyT
	 +p7wD0fxMRCOd11vyz+xXq96u/NA3pnH18wXrHsASEvz3979bUlBKS1ebNiemaOM55
	 1R9hetdomonHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EBACDE022;
	Fri, 14 Nov 2025 11:39:37 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 14 Nov 2025 12:39:32 +0100
Subject: [PATCH] net: phy: fix doc for rgii_clock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-rgmii_clock-v1-1-e5c12d6cafa6@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAPMUF2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0MT3aL03MzM+OSc/ORsXUNjC8sUAzMz86Q0cyWgjoKi1LTMCrBp0bG
 1tQDDHgxRXQAAAA==
X-Change-ID: 20251114-rgmii_clock-1389d0667bf7
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763120376; l=1933;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=UQyyfUMTpe4dFX3C6T5OVzvfPF16qoNqoI0Ju4mbbZc=;
 b=diLkiXi59gVwA0zYEyEXxtzWagQqnkw7B+Hdj9ZJ3wX5GBFQdTmVFaEE5WCY6ztO+9rJPuaxD
 tyNHKdC92yqCvofN5jwszOP97mpWkqNu770RMJEoiU7oVwa+Hdynp+h
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The doc states that the clock values also apply to the rmii mode,
"as the clock rates are identical". But as far as I can find the
clock rate for rmii is 50M at both 10 and 100 mbits/s [1].

Link: https://en.wikipedia.org/wiki/Media-independent_interface [1]

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
This patch is also part question, I am working on an imx8mp based device
with the dwmac-imx driver. In imx_dwmac_set_clk_tx_rate() and
imx_dwmac_fix_speed() both rmii and mii are excluded from setting the
clock rate with this function.

But from what I can read only rmii should be excluded, I am not very
knowledgable with regards to networkinging stuff so my info is
coming from wikipedia.

I am adding this exclusion to the barebox bootloader, but I am not sure
if I should also be excluding mii as is being done upstream.
---
 include/linux/phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index bf5457341ca8..e941b280c196 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -296,9 +296,9 @@ static inline const char *phy_modes(phy_interface_t interface)
  * @speed: link speed value
  *
  * Description: maps RGMII supported link speeds into the clock rates.
- * This can also be used for MII, GMII, and RMII interface modes as the
- * clock rates are identical, but the caller must be aware that errors
- * for unsupported clock rates will not be signalled.
+ * This can also be used for MII and GMII interface modes as the clock rates
+ * are identical, but the caller must be aware that errors for unsupported
+ * clock rates will not be signalled.
  *
  * Returns: clock rate or negative errno
  */

---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251114-rgmii_clock-1389d0667bf7

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



