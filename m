Return-Path: <netdev+bounces-224292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C1B83875
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C4C178123
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD02F362F;
	Thu, 18 Sep 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jflt6Kd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44762EBDF6
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184446; cv=none; b=fge+MOarNB/vLDugfHweNvOAqLWb0a7nFR98l28dTewrpzjlVK7nYD9Mm8pjUHONjOSX2l+HcUFgxzctAGcu1Xr4vhW7/qTAD3ToOm/v0ayQrflOrZUaT0npINEVplA+aYECSx8H7vqPUD4nM0crwZUsvHpPMBrKdBESlX7iaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184446; c=relaxed/simple;
	bh=W2UevpxpSm8SQYwKL2wt5+cdCkS3INsRoHsUPaaQfTQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vdkg3drBbj11DnZl/ilx3WcNt2V4wlyam/P7+t0tfOTfgeZzMK1QTbzPsRRqK2vNUXDiqBiGqwliSZmt/A6jtpEJwUVxgLxIQPqFnolBv4DZkGdCUYZu6J7rX1LsUItvTefLTUNsNR5U/QVlWUEyygBWagpNNDgPX4/5vSuobT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jflt6Kd0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EDF32C00084;
	Thu, 18 Sep 2025 08:33:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 855B46062C;
	Thu, 18 Sep 2025 08:34:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20D00102F1CC8;
	Thu, 18 Sep 2025 10:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pdSz/jWDXq03u72i3CSr6i5FwEH77P2FJ0Myc7lY4mQ=;
	b=Jflt6Kd0e3oo7s+dPAQYbh1zkjqELdunk/EQGrIBKX+UojCorfrNr/Bx0RxZlTM/A4Iqnj
	A+a+HQaZnI7a4qIC36rNMSFwVCqUB3uO9fsNF3p+d7Y23dBERo5OqJalpsaBgh4FtoeUI5
	BUNtP+5aejEcwRrpSu6hD1yz6o/Q7aGURSsv90VzKO9sFl1wGA+hZHo28idX/6LBcMpin4
	yZOrm5CKQEzpQEDMhtAthNp+srNsRG97VgL1dNHPoeucMSrG+h9ePkdUSCIPBUG2eO7UIA
	ZY0AC6XfLJwyPaTFAyQTkm3O34xZ0e2sXdF8jaPoqh41fRl/NA3oAvKo7yGbgA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v3 0/3] net: dsa: microchip: Add strap description
 to set SPI as interface bus
Date: Thu, 18 Sep 2025 10:33:49 +0200
Message-Id: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3Dy2gC/2XNyw7CIBQE0F8xrL0GLn2IK//DuOjjaokKDRBSb
 frvIm58LCeTOTMzT06TZ7vVzBxF7bU1Kcj1inVDY84Euk+ZIceSK17AxT/AB9eMMGrjAXsheVk
 UQmLJ0mh0dNJTBg/MUABDU2DH1AzaB+vu+SmK3L9RwX/RKIBDJfm2bZGEVLRvrQ1XbTadvWUs4
 ieAfwC+gF7VWPOuUlh9A8uyPAFePjqk+QAAAA==
X-Change-ID: 20250904-ksz-strap-pins-2d1305441325
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

At reset, the KSZ8463 uses a strap-based configuration to set SPI as
interface bus. If the required pull-ups/pull-downs are missing (by
mistake or by design to save power) the pins may float and the
configuration can go wrong preventing any communication with the switch.

This small series aims to allow to configure the KSZ8463 switch at
reset when the hardware straps are missing.

PATCH 0 and 1 add a new property to the bindings that describes the GPIOs
to be set during reset in order to configure the switch properly.

PATCH 2 implements the use of these properties in the driver.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- Replace the 'strap-rxd0-gpios/strap-rxd1-gpios' properties with one
  'straps-rxd-gpios' property that describes both GPIOs.
- Add Rob's acked-by on PATCH 0 and Andrew's reviewed-by on PATCH 2
- Link to v2: https://lore.kernel.org/r/20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com

Changes in v2:
- Make the changes specific to the KSZ8463 both in the bindings and in
  the driver.
- Link to v1: https://lore.kernel.org/r/20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com

---
Bastien Curutchet (1):
      net: dsa: microchip: Set SPI as bus interface during reset for KSZ8463

Bastien Curutchet (Schneider Electric) (2):
      dt-bindings: net: dsa: microchip: Group if clause under allOf tag
      dt-bindings: net: dsa: microchip: Add strap description to set SPI mode

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 87 +++++++++++++---------
 drivers/net/dsa/microchip/ksz_common.c             | 45 +++++++++++
 2 files changed, 98 insertions(+), 34 deletions(-)
---
base-commit: 270d4d5a6cf3f2d9eee48e9cb8c138a975ddae81
change-id: 20250904-ksz-strap-pins-2d1305441325

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


