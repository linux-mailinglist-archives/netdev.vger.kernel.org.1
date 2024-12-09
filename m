Return-Path: <netdev+bounces-150328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B8A9E9E06
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E3B163112
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909D16DEDF;
	Mon,  9 Dec 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b="nNXVEICX"
X-Original-To: netdev@vger.kernel.org
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4877081D;
	Mon,  9 Dec 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.145.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768786; cv=none; b=jcLiH7YrSNCUC4pABW7R7Ku9ahNRmnPPyA9wpllLi0WHbArqdTJhn1zHuPSIDgalXcfhsrjIZ6Ysvo7wqHIeSxrz/Fff8a/1ePihbrrGMgkL7aW/d3AIHRywitSzFT81o0yw013XKkQ/qQrUEW8VsRHLXYnlWvJPSpxeGHufnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768786; c=relaxed/simple;
	bh=9a+5+CqtO/5Ledr/ETA4KuEwWPlG7VBbkmIrK3j0R8U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hpbX3+iOOPthfuWBMYVhyY0YKMEXJxEv+iURFT52+o5qseiNCDdrQRd0zsu8gYT+U3GMIvoAOVlZ1ZJYhSdIZKVbUQdZVNiSkKYaTIQyZB/ZhIUUc7kHefFfZ1f/eHR4a2S5KcAoeAZRtdgp7nEinFexXaFF8CRdxX+y9MMniH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com; spf=pass smtp.mailfrom=ifm.com; dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b=nNXVEICX; arc=none smtp.client-ip=132.145.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
	by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 4B9G9fcP023225;
	Mon, 9 Dec 2024 18:59:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps;
 bh=D2K4tK+mvQumLQ0glXkC9o580Q0MznLPxats37VY7/U=;
 b=nNXVEICXNoQ9XZv4TY6fd3zbCRhtk1i9kQ2Nk5Ncw6SiV9ZkmqFB292acqB2rSMedqej
 Lq4S1pFTiuW31l72Jx/cChYOAeqwl1BW9zB9FX9Mjmm+ZK0NGtPrHHyvrnfKrbYirfxQ
 i/toa9vXAjUFd9RBHOI+7I3pOI9v8VyDNcjShZ8RfzSt+VdLjMgFTo/DljxGo7uNWnCE
 0Ncm/aFE4KJ+pJG7x3VDdcNTT1gaIm5jrZigi8HOmkp1eLuCXnaRR45Ji3TEhwgy1n3n
 w8Cis4EqtmDOwflrwFJbuXnGo633S0WZQy2dk1Dd5UvYwXZ8/CEARgvFmRAqTcPQDnuM fg== 
From: Fedor Ross <fedor.ross@ifm.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: Add of config for LED
 mode for ksz87xx and ksz88x3
Date: Mon, 9 Dec 2024 18:58:50 +0100
Message-ID: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANovV2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNL3bzUkpTUMhAFxBUlutnFVRbxOakpurn5Kam6xoZJZsZpFuaWZsa
 JSkAzCopS0zIrwOZHK8H0KMXW1gIA/ieci3kAAAA=
X-Change-ID: 20241209-netdev-net-next-ksz8_led-mode-31b63f87963a
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Woojung Huh
	<Woojung.Huh@microchip.com>, <devicetree@vger.kernel.org>,
        Tristram Ha
	<tristram.ha@microchip.com>,
        Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733767148; l=1092;
 i=fedor.ross@ifm.com; s=20241209; h=from:subject:message-id;
 bh=9a+5+CqtO/5Ledr/ETA4KuEwWPlG7VBbkmIrK3j0R8U=;
 b=9xtGTgBxfSd7SdrEcz3U87GBpGBtzkz/fFpT5QoGCBRZ1fCNi/P8pIyr++dcsfRt7k5rdKOle
 TqlrCnGNLBDAcK6jWjqNObgFTJyuyeV7maAfA83gD9h+4EJ5CnQCFW7
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=0Va3CWt8QM1HKXUBlspqksLl0ieto8l/GgQJJyNu/ZM=
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=43cyfjur68 QID=43cyfjur68-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01

Add support for the led-mode property for the following PHYs which have
a single LED mode configuration value.

KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
LED configuration.

KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
configuration.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Fedor Ross (2):
      net: dsa: microchip: Add of config for LED mode for ksz87xx and ksz88x3
      dt-bindings: net: dsa: microchip: Add of config for LED mode for ksz87xx and ksz88x3

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 89 +++++++++++++---------
 drivers/net/dsa/microchip/ksz8.c                   |  9 +++
 drivers/net/dsa/microchip/ksz8_reg.h               |  1 +
 drivers/net/dsa/microchip/ksz_common.c             |  2 +
 drivers/net/dsa/microchip/ksz_common.h             |  1 +
 5 files changed, 68 insertions(+), 34 deletions(-)
---
base-commit: 6145fefc1e42c1895c0c1c2c8593de2c085d8c56
change-id: 20241209-netdev-net-next-ksz8_led-mode-31b63f87963a

Best regards,
-- 
Fedor Ross <fedor.ross@ifm.com>


