Return-Path: <netdev+bounces-221725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD4B51AD0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD981CC1037
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A632C33E;
	Wed, 10 Sep 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFLJYr+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0A23C4F9
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516150; cv=none; b=osE93byDP3IxPLoazHRKSO66mCEHQib4226XntvyxmB+cdrXn4nznbjRVQ4uJmBXmfRuuA9ffyd8U0DwdvAHrqJ3yvmvXV7XkhAsDaPEcRNemTvj6/N+TGoihAiaZfhtw2+FtzW/yqIuerdFHIFVqR3gSDowwDJJdKT2ChcHbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516150; c=relaxed/simple;
	bh=kYumvV2bBmiRhEEKGzDZquHePlI/ZEMfmJ7m/TTdBKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C/j770ytpQCpSQg9UnJvlZ55j0oV9sm9SbdiyTy3M5O+4R7ruxRfGwIeHBqi7xLdDXIKU3u/S8VYecyZiR86ZoaVlH6TSVt4sttY+N57riU+UXCFzI/OmayuKAVGnsDuql1J7DknkfnqxAhQXXu7mFeAHvSapgBUmKsnSQfHPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFLJYr+A; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DCABA4E40BDB;
	Wed, 10 Sep 2025 14:55:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C30D7606D4;
	Wed, 10 Sep 2025 14:55:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2869102F1C96;
	Wed, 10 Sep 2025 16:55:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757516144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zGfSVlfzIU1PG20Ke/ZHqH5bX0elA0AX0uKu3jyr/+g=;
	b=PFLJYr+AlBBPMcctIVThMF6iGYj0MOEZiCJfvGgBf2Y1ncoeJOLC5abYHjFoY9m+OXdQLO
	9mB5bwB1XdV9fFUr/1UKz97B2nzHdUpM82a4JJQ04nbw5NLjDxw15uEJ0zwlK8jGrwe2cP
	oPDhr7paX0lYkyRPSEe011XlHZJYpfk/pTjx+k/LmSs1ypJxXgyuPenyoxsYfTCabWmLQN
	jz4b8QGNOIAA8msJ+qA8QAo9wLz+33PhntGDHQZOH328e8PrESPC0zcM94zUE1ChhiHQss
	wVmdDOKYATLi8WBvawIKuUjuKlb/jCu2awNaqlelEAiqooC9e97XDTcvmbJYbQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add strap configuration
 during reset
Date: Wed, 10 Sep 2025 16:55:23 +0200
Message-Id: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuRwWgC/x3MMQqAMAxA0atIZgNtbQe9ijiIRg1CLE0RUby7x
 fEN/z+glJgUuuqBRCcrH1Jg6wqmbZSVkOdicMYF0xqPu96oOY0RI4uim21jgve2cQFKFBMtfP3
 DHoQyCl0Zhvf9AKKzqHJqAAAA
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

This small series aims to allow to configure the KSZ8463 switch at
reset. This configuration is determined by pin states while the chip is
held in reset. Normally, this kind of configuration is handled with
pull-ups/pull-downs. However, in some designs these pull-ups/pull-downs
can be missing (either intentionally to save power or simply by mistake).
In such cases, we need to manually drive the configuration pins during
reset to ensure the switch is set up correctly.

PATCH 0 adds a new property to the bindings that describes the GPIOs to
be set during reset in order to configure the switch properly. Alongside
this new property, a new 'reset' pinctrl state is introduced.

PATCH 1 implements the use of this property in the driver. I only have a
KSZ8463 to test with, so only its configuration is supported.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (2):
      dt-bindings: net: dsa: microchip: Add strap description
      net: dsa: microchip: configure strap pins during reset

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 12 ++++++
 drivers/net/dsa/microchip/ksz_common.c             | 47 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)
---
base-commit: d0b93fbf220b2e7be093ac336eba3433cf3cd6f0
change-id: 20250904-ksz-strap-pins-2d1305441325

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>


