Return-Path: <netdev+bounces-183296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B0A8B9A5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B7219010C8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39813633F;
	Wed, 16 Apr 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Blxg+T3i"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654651C5A;
	Wed, 16 Apr 2025 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808107; cv=none; b=dgoFXwhAqWes/JWovCM2JpkJs74lULEY8x1w3xtxsM6IMG1/oMUKTpbYruy0hLHWlTWIS81mj6fxOEdOnogmrgDjI51Om/dkBk3KOfAflCFaX6yLjejSDfKkSORQdHcYPtnaqed0ie7l3LxwosyDvY6pH2mZVlZpnSOt7fg2wlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808107; c=relaxed/simple;
	bh=J3UlWU4kVp1jeLMLUUcSRNVHxNYnSaTzuq9vMvYpi9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naseTvRrfjH297+CkYNkXlPCfm5MWH41627txvb4YVdfP/N7zZafirzpYhn8Rv/RQaTkWgg0P6efyXFib7BHVi6kyvgvbY0f5H+sBtwLUiMUUNJY3K5WaCNBC970ymkvTWPtlaWmsnIVwODAHXcpz093GZwnFDtltkdRZh/lip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Blxg+T3i; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A725543B1C;
	Wed, 16 Apr 2025 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744808097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WByd2mJP1+KNt1V0a0T6t7/su5eUb2ZhTX1kkFHvsPE=;
	b=Blxg+T3iMKuswhkX7sv8uL4jGQsbtOzWUdfe6DqzanNWLfyfssnGokOBOrwCKGFmUeZTtS
	Zd3Vd1PnLvZOs54Vcms5+g1UwqoPE9CNg+v78ZAbbsqlz5FXr5fWtaoWwksedK0QnVNyRN
	fim2PIaicLyP3Omk5AZBAMRf/YrjiL38yCMsbJHQyuoLdfwsrAEcoQ/rD+wJpfRFT43Ngc
	+NiKyfCfqehG+UKYXR5j1cj3hYzrkScmuxJnhErPm+npa3zF9qFoWHiTCcs9uaDdr/mjdQ
	xd2bRRMinXJKCDGOI4OapoVsPgvNKFzeblhhLOFLP3SPCTzEWdbSRIKzZY6tPQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH net] MAINTAINERS: Add entry for Socfpga DWMAC ethernet glue driver
Date: Wed, 16 Apr 2025 14:54:48 +0200
Message-ID: <20250416125453.306029-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Socfpga's DWMAC glue comes in a variety of flavours with multiple
options when it comes to physical interfaces, making it not so easy to
test. Having access to a Cyclone5 with RGMII as well as Lynx PCS
variants, add myself as a maintainer to help with reviews and testing.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Hopefully I'll get the chance to convert the binding to .yaml at some
point, but I don't have the bandwith for that yet...

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c409f504e94b..50524d16abff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3191,6 +3191,12 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA DWMAC GLUE LAYER
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+
 ARM/SOCFPGA EDAC BINDINGS
 M:	Matthew Gerlach <matthew.gerlach@altera.com>
 S:	Maintained
-- 
2.49.0


