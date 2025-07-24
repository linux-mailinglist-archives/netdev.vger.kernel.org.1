Return-Path: <netdev+bounces-209907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB6B1142F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C24AE2FF2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E22571D4;
	Thu, 24 Jul 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="N+7iFAVv"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766C2550D5;
	Thu, 24 Jul 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396454; cv=none; b=FKuVPk1DvF9AU31yQ/qdAy1HlILGCGArt6v8wFEMRg8gchmAc+bZCyLEYaePjO/j1QwMxdM67Nbpu7v9d244RKRLESPM9emRoBBftqQWNYF67FI+BcHvvPn3rqsp/r4CSTFovHIk4G8ONl0BxFmspNe3wUHos2aof+cXnPjm+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396454; c=relaxed/simple;
	bh=LFHODeLdAbpy6Wa3Nx6aSIWt54jeD0+xBiG8vLlMYVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVDvo5cEfIDgVv/e+dyCe/rYcEgzvn/3bboZ6yKILZmLDKDhPRReH/rxJ2QcxpN0Phbu0YINq10Ls48Te1+s0h/uRKTckLutyj/q0P1dxBZpukDRi9Su8MkPl71gKmGVWZ0f/TDUo1qIcchwHhmsCbV3b4EDHrvNMgpthb1/p3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=N+7iFAVv; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8253110391E81;
	Fri, 25 Jul 2025 00:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753396451; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=G3t2ph6BIt6XUlFWszMHL1ivWgnHFafEWjnpg5WiZdo=;
	b=N+7iFAVvUNLtZ9B7M6FFygh5cgP9VBZid+I9ye0a0ZWgNtDZWY36FloZHfLdarUZSlYt3L
	RIBnZBbC/lXWcknYHM7s2bunu0HY/Ib1daLo/wkwY7Ss5izXWrl0JVm2YWENkS9NZma6w3
	BXX5eoP8ovqOak4xQgfywDQQNxXHJj3XCQQDD5p0QUsW3qaDIOGC3abeUbnc/z9w7/Weyn
	9GYp1eBX7Ef/R+uYeLOtGvzvaaxz885G4eENxnsRMHNTvKJjakWp0akq4np9SYdtfPCLvs
	LQK/XALBfo3WkIqxlZ4dQ+jmFIrGdr0nxkRiNIRv4FO/57thyTz00/YRtGusFA==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v16 11/12] ARM: mxs_defconfig: Update mxs_defconfig to 6.16-rc5
Date: Fri, 25 Jul 2025 00:33:17 +0200
Message-Id: <20250724223318.3068984-12-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724223318.3068984-1-lukma@denx.de>
References: <20250724223318.3068984-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This file is the updated version of mxs_defconfig for the v6.16-rc5
linux-next.

Detailed description of removed configuration entries:
-CONFIG_MTD_M25P80=y -> it has been replaced MTD_SPI_NOR (which is enabled)
-CONFIG_SMSC_PHY=y -> is enabled implicit by USB_NET_SMSC95XX
-CONFIG_GPIO_SYSFS=y -> it has been deprecated by moving to EXPERT and
                        its replacement GPIO_CDEV is enabled by default

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v5:
- New patch

Changes for v6:
- Add detailed description on the removed configuration options
  after update

Changes for v7 - v16:
- None
---
 arch/arm/configs/mxs_defconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 22f7639f61fe..b1a31cb914c8 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -32,9 +32,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=m
@@ -45,7 +42,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
@@ -60,7 +56,6 @@ CONFIG_ENC28J60=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
-CONFIG_SMSC_PHY=y
 CONFIG_CAN_FLEXCAN=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
@@ -77,13 +72,11 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_MXS_AUART=y
 # CONFIG_HW_RANDOM is not set
-# CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MXS=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_MXS=y
-CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_STMP3XXX_RTC_WATCHDOG=y
-- 
2.39.5


