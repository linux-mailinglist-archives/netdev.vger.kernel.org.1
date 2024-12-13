Return-Path: <netdev+bounces-151646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC439F0733
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192E2188BD15
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199981AF0B8;
	Fri, 13 Dec 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JaL5zOhb"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB819CC2D;
	Fri, 13 Dec 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080735; cv=none; b=GpIerndlQ5dAk0ksWKB6McY29FBzk/3TI8UKk3Z+wLldwAgzDn799vjkZ+mDrDGWn8tPKXWLiu9PktQD7UCF/y0UNPEmkTEoRl+Fo1PN7vKBUrVX9XesGkxTFd4K5uouM+BWVYqy3YaxpYPzHKnLYN6ZIJiVuukQMqpwL+rBPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080735; c=relaxed/simple;
	bh=n5ZcLBHj7pfsmR/9MuwhngnQRBs3J+uwb0CL9BUR8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6u2JKjhc4FgKt33lk0WvTAtlMahT8RUdliqDVHDoewFP73jn6u7Ho+1NUACmuV1RckD3fX07tWicKdMp6iXIA+HqaBPeRgCQh191XeresGS5/Hbw5euMBXDoWsFMiMLJS9bf6q1DjWjyYzv5tXxE4XyDeiBJ3F92BpLR5dkc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JaL5zOhb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F8BC1BF207;
	Fri, 13 Dec 2024 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734080730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oMe35rpj3pGiRrVthFbN55YWzxRRPpFse7Y8Q5/jxqg=;
	b=JaL5zOhbshsW8+n7cBu7ZUVx3aRCCpSTvbQZkydzCq2K1aFWd/DAM0B9WvMnCmRxwWlzGW
	uh2MRn9ref2MKLQqurotEa+QH2KCG+Uu3eeuFttjFgrLvhOSfRYp4beZ3wkVG9KWiE9NIZ
	73L81hYlOmS9UKYb//0LcyZ6EduS9mtv2kf+3+s2/2+LbYUHiO2GLu6cmIwsjw9ssYfUyI
	/dyp7lG2YK4dY+tpc4C93baFrIL1659QYlw3DbtAFYSp+jL4wC2tSs9S2yFSMGHCedJJ4Z
	o+y/qRFHwI9MmTf5GG8OpMs5Ld8NIXSXeVrHy2QuH5xTykTMUwbRHlP+pRNkCA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-socfpga: Allow using 1000BaseX
Date: Fri, 13 Dec 2024 10:05:23 +0100
Message-ID: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This short series enables 1000BaseX support in dwmac-socfpga. The support
for this mode is coming from the Lync PCS, however some internal
configuration is also needed in dwmac-socfpga as well.

Patch 1 makes so that we enable the "sgmii_adapter" when using 1000BaseX
as well. The name is a bit misleading for that field, as this is merely
a GMII serializer, the 1000BaseX vs SGMII differences are handled in the
Lynx PCS.

Patch 2 makes so that both 1000BaseX and SGMII are set in the phylink
supported_interfaces. The supported_interfaces are populated by what's
set in DT, which isn't enough for SFP use-cases as the interface mode
will change based on the inserted module, thus failing the validation of
the new interface if it's not the one specified in DT.

When XPCS is used, the interfaces list if populated by asking XPCS for
its supported interfaces. I considered using the same kind of approach
(asking Lynx for the supported modes), but dwmac-socfpga would be the
sole user for that, and this would also need modifying Lynx so that the
driver would maintain different sets of capabilities depending on how
it's integrated (it only supports SGMII/1000BaseX in dwmac-socfpga, but
other modes are supported on other devices that use Lynx).

I've chosen to "just" populate the interfaces in .pcs_init() from
stmmac, which is called before phylink_create() so we should be good in
that regard.

Thanks,

Maxime

Maxime Chevallier (2):
  net: stmmac: dwmac-socfpga: Add support for 1000BaseX
  net: stmmac: dwmac-socfpga: Set interface modes from Lynx PCS as
    supported

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.47.1


