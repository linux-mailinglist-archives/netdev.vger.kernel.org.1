Return-Path: <netdev+bounces-252958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKyiF1TRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FA7A531
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2AA53012BCA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14226F476;
	Fri, 23 Jan 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAUuY9eC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846E28853A
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197887; cv=none; b=WmdX0fqW4M4b5kBOGlwGhhYZJbVrxhRMhW+0PUEuFOL4PDkv8R8GqJACnqIcKGPgXXSlL6QzfP6ZgEaSsTCNDu+knJj8IE0WNuabe24Fcc0Y3ri2jOLw5dy4WZRMDqdh9TWrKrNNUw8uaqrXMAVMXaLFQ7a78oZjMoQVENoDHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197887; c=relaxed/simple;
	bh=CsVAGnJYyt1gpIKIOyO13ylzg/PQgaXnaqCXcwteapg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnX3Sm8FdtFjG9HKrr+CncRuMA3bGHyfftEYu0/GdCK+mYfHkCkV/f1+TaRdnQulX8ynHsQYBPwJkr9CMoSxqQEnOBTRhIXOSRAFh0/EarYAgLs4Ijl8iYyu0EjlN4zgdArSTEKIxAD/wn4QQT2rWndhfieFhqYQinSCjIh4uKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HAUuY9eC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so22145805e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769197884; x=1769802684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNmEBAcCOcnCArGc8pe5UUOL3dPUYv44y06uRTFe1O4=;
        b=HAUuY9eCLm66QWg1scOsIxXcs9xNNZ16ViTINKCwu7yHrHQyB1qUdo7ppKb+iq17gM
         ewiffFx5oqEKaidR7I5MeN/dsv/eTBuB20uC+xyN4lsny7DZOyLfXYsDAnYGH8s/ymRM
         DncQHYM4bxCyvbQ7H7tZ7dY8VbZw5JFx4VxlExEiAdZ8idjnaPyZ4mYWxLKvxtCcJ26o
         2JBBFGx+y/A4dvSVEc3cJKZsmcq7TqpQpsqk8si4xSWk7vA1MdSYvB+5I3hVmdd1Ri75
         pS2nlyLFLku8BEcuUV2v7zVt73QID7u66vFKxb+/4OfSAB8RBTv2NZsZg4+4HQpwnhYx
         Wd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197884; x=1769802684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNmEBAcCOcnCArGc8pe5UUOL3dPUYv44y06uRTFe1O4=;
        b=snMwYPTiPoHd5yXRauOgVLlBgA6+1yfJgqgmAX4WJMl0RzFDilhoiZoXldY3jCzjbw
         byj2FPkY/5ewMgMY7UQcqMR0Vd9x7ciPPUpnjugPEIORyOpwEagBehBtaVcCiljjd+Ls
         j/p8/IjUUklT2ciOCSEPBremfeDL7sdZ41RWPQIx+ScVE/ssSbDUFHvpGmHdijvPZqbx
         +rqK1zKLux3XNqe1VmLEF700j+in6RAuUI+3C4GW4xHXQMgvcRsUXyKHTlqCM657mPki
         MdG++ut+VD+dFcve/n6irBI6xxner3lVFXciAWJPyWH+6y3EdiY1DQ3cDkSzCnW80ol5
         ocKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdoebgr4ykn7xFOgmdCiQUP2txe373seccSNLmmPD/A1Nae+pj3oqYMiUzlU7anX8guBVMjj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDn9y823QjpLZXMU6/jv2ArPnWMR9A/k2B5UlG461TxAr/s+rm
	BscIAEeCW7cPoWw9+h94pxE1pXe9hUlECLkyG7F5skVDbbC+QgsFhsErsnkB7aRH7Yk=
X-Gm-Gg: AZuq6aJ308avvHhouHogx++wPx3st7RY1el5eQ5Sx8Idin5bmRNhjDV2yNjcfzBnIUC
	lMplkw0toV4rXDsEPkUuvfvM3ZzpnJY3gPet8pPWGFeeiqDtrnupiZtICmYTqaiNpm2X3R5DBKm
	xW2/AQDRSSdAK6DPbhE9I4cFtYtMSOD/udlybhgQBwnOTLMRITp0rthRAuVu32EpCl7L5FIqzzd
	Wv7TxZAU+oEme36IagxDpGSLj9+VO1fYr6zTnb6pzWzHprlKFo0TVmOS3WArUjPXIwFuC6+2Kgb
	FFs8dsbo+9leBcEtmxNl+6zfoKtt2q3T/rqFmZNsXhA6utiV/DqDNen0Nh+2wrXmwJiDMZTYlBH
	pHwEnbAJK29u5ruke2uIMZOpkGbZaTcQEbinZCHk+38qA4QrLQ25yMlYdOsLWYm85ZGIKrdBkU9
	0qc1FTO0Cd6NwKBtFc
X-Received: by 2002:a05:600c:3e0e:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-4804d307b0cmr68595535e9.16.1769197884089;
        Fri, 23 Jan 2026 11:51:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470bfe42sm156761385e9.9.2026.01.23.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:51:23 -0800 (PST)
Date: Fri, 23 Jan 2026 22:51:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>, linaro-s32@linaro.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 3/3] dts: s32g: Add GPR syscon region
Message-ID: <34ac20223cf6833a0fe4291cfb2db5309f4e5eed.1769195864.git.dan.carpenter@linaro.org>
References: <cover.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769195864.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,oss.nxp.com,nxp.com,kernel.org,pengutronix.de,gmail.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252958-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C47FA7A531
X-Rspamd-Action: no action

Add the GPR syscon region for the s32 chipset.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: no change
v3: no change
v2: Remove #address-cells and #size-cells

 arch/arm64/boot/dts/freescale/s32g2.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 51d00dac12de..b954952d962b 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -325,6 +325,11 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		gpr: syscon@4007c000 {
+			compatible = "nxp,s32g2-gpr", "syscon";
+			reg = <0x4007c000 0x3000>;
+		};
+
 		ocotp: nvmem@400a4000 {
 			compatible = "nxp,s32g2-ocotp";
 			reg = <0x400a4000 0x400>;
@@ -731,6 +736,7 @@ gmac0: ethernet@4033c000 {
 			compatible = "nxp,s32g2-dwmac";
 			reg = <0x4033c000 0x2000>, /* gmac IP */
 			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
+			nxp,phy-sel = <&gpr 0x4>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index e314f3c7d61d..be03db737384 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -383,6 +383,11 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		gpr: syscon@4007c000 {
+			compatible = "nxp,s32g3-gpr", "syscon";
+			reg = <0x4007c000 0x3000>;
+		};
+
 		ocotp: nvmem@400a4000 {
 			compatible = "nxp,s32g3-ocotp", "nxp,s32g2-ocotp";
 			reg = <0x400a4000 0x400>;
@@ -808,6 +813,7 @@ gmac0: ethernet@4033c000 {
 			compatible = "nxp,s32g2-dwmac";
 			reg = <0x4033c000 0x2000>, /* gmac IP */
 			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
+			nxp,phy-sel = <&gpr 0x4>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.51.0


