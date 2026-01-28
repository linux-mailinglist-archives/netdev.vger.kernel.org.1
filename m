Return-Path: <netdev+bounces-254180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOgPNUvdeWnI0QEAu9opvQ
	(envelope-from <netdev+bounces-254180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:56:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9F9F122
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F386304E72D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009F34CFBB;
	Wed, 28 Jan 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIlDeW1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3534D4FD
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594059; cv=none; b=Bld5JiQ899Z/jK5GvFDGtqsuR5PMwdS6WFbbXRkQt1XaIzYeUf8dGhygMOaIG65llA48oYoKFfenjkn+68PwTnJaoxLXd2nc78daIf+J0+Q3PBz2Nb23VymxqKVUqMD7ncs++37nTifBPvpKAnAv9wBAyK4O1i8uA5k1APpPLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594059; c=relaxed/simple;
	bh=8OOj3Wng4dXaPJsiDwVOM1LzCgSn6Um4RNSrv4895sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM3M6sdzT8DE30XoCD1JLLsGEgVMcHWxyVdt1t+RJH2hdnLMrIRG3n3cn780ekiO1H4TdgHmOmTKuXv54ELFwmylv8Hyval93Cs+XXx3e9os++tMC3j0IhHijmeqGbQbjaQHTRFwn7Uyp7JycN/RuP4hZcI0Ix6FsX4QGd2xhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIlDeW1b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so2028275e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769594056; x=1770198856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93zs4bIGQjJ2eAJOoDnsMxPVORSrFYYCc5PKWJTbXFs=;
        b=jIlDeW1b5o+cBEAZCUzsZAh8M9q4DYiYmboP2EEsyi+j0vGBio5x7tM5+LAPaK0PS5
         iimWiGFtjCbecEYRSDsDg2gU7PYlC+Lm2Lvu+oSt3K5ClCeTzd4Blj8VAI9NpR0P5aXr
         qccMfRpjoJDqMgvjDAJXXWsf5qNGc/tK9KovUWK4uLejHihh1WAdMmYnS/LOM8MgXTeG
         jxTMosnVUhiaoHlDrlAFDVccAs17qONeVC3iUZmNfPCrfNozvTiKbRy1vKA+1ea25UAc
         xala84Bx/9BYOZ02ZRuFWj25SuuP2dp7tVymeTQxht+p4YlwrEdiP7R40n/YJqnI6qnK
         Y0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594056; x=1770198856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93zs4bIGQjJ2eAJOoDnsMxPVORSrFYYCc5PKWJTbXFs=;
        b=SnR19X2aNPYhq0UcnNQKHlXl4R9Tix3V+iexp98kLVGxQrxijtn4RG4cGAKAo6s2JS
         KioKdmZG3/fQHcloZh6r6zwuiVAlaM0acPt0znp5atrNY0XqUjTj1vd9NbgBTSBEye0M
         VtJXXheSIpUR90MQKsfgp8ySxeHxtkNGRne1kGWMdsOfUVrdqweJ4O5nBrmvld3FB4b5
         CEFJGMQuX2lxCwmC4991YeQHu8Os8CpAG7Cl4jibDSCQ2hJ0O5oscVI6vR/dRZngiEDR
         EDH6tU8YFXgmOwrdQwwQxfoxqLsvtpVnikbL5z/csaEzCu3biQqy6VKEeix5IQTmunyt
         j4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUe12w4Hotuos6RewR2Psy43a42jvhtEgNUvN3PlFt2fFyUvTj8FjbmEEHAzarusUSCnvE380A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhupJIDvkF+dI0caYbP5ah3UrzVooCxtjLSKvVbaMuzs0lUwU
	R38BQffYgPJ4xXx6DR7aE0TFP+jQbu2yqx53p8dFFTUNUPhW9O+e6YNukcpwVJcOOAc=
X-Gm-Gg: AZuq6aIM04bJkkzGHeVTsBYqpBVLvTnCcqqm4LWfobbJddPn64AXY7DwVEDALSEUnZJ
	LuaXG5OgcUTOMey+fX79l+1NCXGWgChRKcazGxc91aM3ysGWOdqhUoAHIJsel/62j9wQZPZG8ec
	W+SR1fGSNzRAjfy2g8aDIv1V4UQrT5gPZDMDIbn051u1SXkDGruhLO+T0U0GvAhhq1o4v5OQ5zc
	LnpcfKQbezpz9sEX54wi6DlWdyTf8k3mwTWmJoy3oTC1PrSYLV1FCvmgOm6CGxgK1UaEZaW+I3j
	Zn0plPgjTsqUvBpnSqbnivMV+7XIEd8UfRw2goFC/QhL4lMujaODKlW9x24KdM6VEqpPFFhfA5y
	ebSw8uyvEWjTvjIv6KZqwO9LZLYGU+awR70hRqqS6vOEt+p4EKFl/DVGHaBzANpE7oGgc3Ta86s
	vVpjVkEXdQCVFTf739
X-Received: by 2002:a05:600c:1d8c:b0:47b:deb9:f8a with SMTP id 5b1f17b1804b1-48069c7c4eemr58122425e9.30.1769594056369;
        Wed, 28 Jan 2026 01:54:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354114sm5903050f8f.42.2026.01.28.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:54:15 -0800 (PST)
Date: Wed, 28 Jan 2026 12:54:13 +0300
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
	netdev@vger.kernel.org, linaro-s32@linaro.org
Subject: [PATCH v5 3/3] dts: s32g: Add GPR syscon region
Message-ID: <1fbfa51de753039f132edc2554c41667e00c0176.1769592679.git.dan.carpenter@linaro.org>
References: <cover.1769592679.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769592679.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,oss.nxp.com,nxp.com,kernel.org,pengutronix.de,gmail.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,4007c000:email,4033c000:email]
X-Rspamd-Queue-Id: 35A9F9F122
X-Rspamd-Action: no action

Add the GPR syscon region for the s32 chipset.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v5: no change
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


