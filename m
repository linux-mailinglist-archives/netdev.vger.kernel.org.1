Return-Path: <netdev+bounces-222478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C1B546AB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D99E56685E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304425C70D;
	Fri, 12 Sep 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VUcLbeHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C62147F9;
	Fri, 12 Sep 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668593; cv=none; b=EMDk+KGmzSj40Jo1f3H5UaGsYXWaVOmM9wl1QbE/cwmWydK9djV5/ET7r/ETgI7RfIul/pbZa9MW/JkuFAXc8bSRm+lbWspGhrR60whrnc5cPq3Dr9dXcnKoTcCl/TDLnoDN9sLWH6abdDRhxofw1KAe18efLyFf+bV3PlhFtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668593; c=relaxed/simple;
	bh=7OR7HppxTw/se1tdMEw98Kckfb5ReDZTpbEK8WHUwAE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o6T+B72XdPzq9F7pXxJoGXP3TaKfT1+hpedcuWpQru1Uwjau4HqqVLcVkHzb8RY7m9ioOaq/WJOY/aU3YAeMsMhEtv6Q1j9FnMibThsqKrsYazeY28Hc71RDJI2WxmFnlk2DC1DNtLxwAe9rIXKbHpRisIn4qAXpeUlbEb4WR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VUcLbeHl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 907821A0DD2;
	Fri, 12 Sep 2025 09:16:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6434160638;
	Fri, 12 Sep 2025 09:16:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D829102F29CD;
	Fri, 12 Sep 2025 11:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757668586; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Sbx15ceVQ0E7zTsXXcC3d0eUvlZGM1pQrq+8QZlX8Vw=;
	b=VUcLbeHlNtfd1vrzBgirKdDPSGZew7MHHj1RyzhAqCZNj1mpMjvpUD7IZv3rAXAjqnnFoJ
	4vm+3O/UMm/03HsZ1M4amF5u4Pt4+UoqbvB9qPJYiBxzIfmruVD4Y6hqtSX3IzG/sOOu73
	9bu20qsOob43fGlUzlnk3grrktLbzr+oPW1t59zmPK7BS6JbpNmSgBvRKPcPGCD6BtRQ4B
	aPW+KRboJxz0PlesUOMD71NGIBn9vvNZdn9Wew4J6if+LRMFK1vcRJENMcQIPL/MPJdj0g
	L7w27KzATRLtI0GXOB6NPp/vMSshXnEmsq4YgGtkXzsXa29QGELEokFLNqK0eQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 0/3] net: dsa: microchip: Add strap description
 to set SPI as interface bus
Date: Fri, 12 Sep 2025 11:09:11 +0200
Message-Id: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfjw2gC/12NSw7CMAwFr4K8xshJWkRZcQ/URT+GWkBSxVFVq
 Hp3orJjORq9eQsoR2GF826ByJOoBJ/B7nfQDY2/M0qfGSzZkioq8KEf1BSbEUfxirY3jsqiMM6
 WkEdj5JvMW/AKnhN6nhPU2QyiKcT39jSZzf+ihv6jk0HCo6NT21o2ruJLG0J6ij904QX1uq5fU
 KPR7bgAAAA=
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

PATCH 0 and 1 add new properties to the bindings that describes the GPIOs
to be set during reset in order to configure the switch properly.

PATCH 2 implements the use of these properties in the driver.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
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

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 92 ++++++++++++++--------
 drivers/net/dsa/microchip/ksz_common.c             | 45 +++++++++++
 2 files changed, 103 insertions(+), 34 deletions(-)
---
base-commit: d0b93fbf220b2e7be093ac336eba3433cf3cd6f0
change-id: 20250904-ksz-strap-pins-2d1305441325

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


