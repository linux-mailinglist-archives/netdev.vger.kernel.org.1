Return-Path: <netdev+bounces-126397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB971971030
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D961C221A1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5271B0136;
	Mon,  9 Sep 2024 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e0BtfpJT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D631B012F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868091; cv=none; b=Z0zkpsd8BTAqwuyt2sUm3dT1dvXZYPy4RAPg7xumKH1+P8+OZTTF1DtWVf6YbXTxxJDcCIfxFhGJd29UZArf6tlZF2L0boooGptrWCm0IIiBllqrcUHoDk0tG8pQ5HB1w5PppXBXUeIHrlmy+6btnGazYla0DtGV8k5zYwAGjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868091; c=relaxed/simple;
	bh=PVu0AO3goLCjMmjEeFnjdb8rsuK1z5+HinRLmU09zvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+hBDkkeGkQ4fCi8riVFcWTEK3lQVaEBimNZ6CS6bWWqVgak6B3JHGXRIRzHSR0paqswO4k9/ZjRN+F3TyD6AJBWf/pFL/1KYwX7L82gnz4GP6N4ZoRU2MO3JdYkSnylrcd7XJwkC70e86RD48jLo13LKZqDApYN7cVQEoZMzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e0BtfpJT; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725868039;
	bh=HQ+u1pFtHvaYXeS206TMW008UyQVv1/1fvQ4x78GPS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e0BtfpJTzjNYuZ+e42YV401O5DW9uYj70sQ4SdUuEVBnESO12BGtsu1DNJqwB/myu
	 nIGv+XlfO/axGBkEKbpOjsytoBeIhBz4lvhVQRI4/9TLgMGJEGL8gvH10Wgv+6FrAi
	 ibzcKwgj2Xp6uZHNGLxUOd5ysKhhHV2KvzdS1Ul0=
X-QQ-mid: bizesmtpsz13t1725868021tc81xv
X-QQ-Originating-IP: xgxCbM7/VxtkaC6p5voMkjfWvVx83murpI+h4hb+tFM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Sep 2024 15:46:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8765951806881718135
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 2/4] riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
Date: Mon,  9 Sep 2024 15:46:28 +0800
Message-ID: <8830E9DA269F759D+20240909074645.1161554-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909074645.1161554-1-wangyuli@uniontech.com>
References: <20240909074645.1161554-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Xingyu Wu <xingyu.wu@starfivetech.com>

These pins are actually I2STX1 clock input, not I2STX0,
so their names should be changed.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
index fb0139b56723..256de17f5261 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -240,8 +240,8 @@
 #define GPI_SYS_MCLK_EXT			30
 #define GPI_SYS_I2SRX_BCLK			31
 #define GPI_SYS_I2SRX_LRCK			32
-#define GPI_SYS_I2STX0_BCLK			33
-#define GPI_SYS_I2STX0_LRCK			34
+#define GPI_SYS_I2STX1_BCLK			33
+#define GPI_SYS_I2STX1_LRCK			34
 #define GPI_SYS_TDM_CLK				35
 #define GPI_SYS_TDM_RXD				36
 #define GPI_SYS_TDM_SYNC			37
-- 
2.43.4


