Return-Path: <netdev+bounces-255145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC5iLIawfGmbOQIAu9opvQ
	(envelope-from <netdev+bounces-255145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:22:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3EBAF29
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96618300DDD0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19D296BCF;
	Fri, 30 Jan 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmmNvDKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3D29CB24
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779199; cv=none; b=Y+gSZtfROm5F9aMtFfG35NGvXCBm2PAE6a7g0GlpKNT12C8jlBJ89gtV2ng6AY8aZUQimizz6eEJQk9hZAyP+Nqy5Op5OVPpHLkO+uHQLkrGxvNGyqmHjaTtkAnEX18ysTfukE5H5ni+jjfIpjtEvCycP04VOQzj+gJx7w5rGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779199; c=relaxed/simple;
	bh=lyq2+FgR/1ySLRVYYvLqN0e5dDkbuV/hAjk2MnK+D1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szx4JLKCXaIDiMXRhvp2SaunvQNAWLCmWd1JFqLWZ2oplqcNWq0SQbkh2pYRYBzaP0Si5ACb9+dTn1f+JMAVdBHTCOyi4hraMvSff+SoP27MAywHlvzPt/ePR5IUNZsf0iIWozMDLlTDl+95SE2P0P2rdXRux6j2wW1EPP/xIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmmNvDKw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480142406b3so15945185e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769779196; x=1770383996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7iqxSFKMNDlzFewoVPAW0lYx5PILeCQdoigY8yMUaRo=;
        b=mmmNvDKwQig3TtC8OSe01sII0wGg3OoI/ltCGexA0Dv4NbIM68pYOcRdkSOHyeyEVZ
         qfiCOhkh+VTTKOer3QCtCANCtpAj7lwHoqROHB15Hu2zIIwDfeZvV++QCPmHC6xbJn0y
         TO/htetdbOEVeeZ+fz8v4rDfnN76XpkPTWU1Hr+Tu+ZrgLIOsp+oB0InsHx/fuiE91KX
         3fHhHyHDzO7kXy7hAcPXBm7FlYyEW5+rl1JcML6puRZfo4BPhNLk7ivcMjc24hY+hAzJ
         Xo21AFwKOQoc8N5nlmy+QzblHoHpMWbEPn83iTq+95zFqUzUql6e3ZohxyG+9g4uVms5
         C0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779196; x=1770383996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iqxSFKMNDlzFewoVPAW0lYx5PILeCQdoigY8yMUaRo=;
        b=mNMCh4BUKd1V20ZyXwFUjhP2aeff8EwvlpRXVJXYy/qV3FVfghRn6ujwLmz0WS2bbY
         hf5sFf0QxjG+sRfCTdaYhMup2D5Dw6UxbD4t5HgxaBlk0BKNdqwtZ8kEkO/Qdu3R0Jm9
         7bnPcOiJMBdBy1drpoKlj8x1VJdiKEx1LCgE8i009nwCZ5XtoSU//kapchnhjCiqKp6P
         eams/p4ZcgwDQ0xilN+6YZ0/VC7Spz0wK7q2uIiHOOtx7l4U9xp9xRFdRuytxGgQHtx2
         vts5m36pqdPFrSburqnRUk5+P0EdE8N/UyMCTKoFiD5pO6AsA41B2kpQXuQAIM41dn1C
         zxzg==
X-Forwarded-Encrypted: i=1; AJvYcCU79bEDdURdMiFN7BXdKjim7My0z9ekT6mTrs2YcHvAHzi7xj5eRO3LD/xjcH1M5u9w7H3g4f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKo2OfKF4V6an14TyzaVM2ZUrYthTd0TbDVCHlWqttuTUJIBAH
	bOqHyLHknM++BHp5aarHYxT7oc1XbGIoU9+Vl9LkYmZ1ULJU17rSwfu7Su390X4LszY=
X-Gm-Gg: AZuq6aKx0r7LDNdrPibsEjt0JKzt+pCltFNBmcnGlX3/ZjX0oyQZCnnK/HI+sVhmTk6
	UURVPczIOWx7uqhUBJ/l52+deZZe44fV/tNNlf/MgBrwKw4Cdnb4Iv2A2xpR0Rdli0QVtOxKmmi
	96NkCxpoeV9Ap5ak0Vhka5RxVgXk7/WI8Nxx7NMIrZWEnaVElBDUpxGFYSOhezX5GwMj3E6PdHE
	DqTtCTyoFQc+O+uOW4W4mcWJVVxUplbEhuaKDLgMuFzEpMSVsm/0LiL7GaPPbbwDyvrU6MaEsd6
	AldPDtTcsPLKRxzMhnOVPbPQHtCg5odpPGOZT8Gpi8kNiVzmynw+xIlSsoWqG+8pjHr/p3z2DLM
	HqkxBMKo2T1908Lm/ju2ErseJUsOOk9poWVhf/+cKAm7aAqE7vBoDhJ80jHrW5v2JbKg/3MuqCz
	MPeJ6U7eDvR4i4HI/a
X-Received: by 2002:a05:600c:1f8e:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-482db447b14mr34825915e9.2.1769779196189;
        Fri, 30 Jan 2026 05:19:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm22863188f8f.36.2026.01.30.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:19:55 -0800 (PST)
Date: Fri, 30 Jan 2026 16:19:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, netdev@vger.kernel.org
Subject: [PATCH v6 3/3] dts: s32g: Add GPR syscon region
Message-ID: <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769764941.git.dan.carpenter@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-255145-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.com,oss.nxp.com,nxp.com,pengutronix.de,gmail.com,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[400a4000:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,4033c000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,4007c000:email]
X-Rspamd-Queue-Id: 14E3EBAF29
X-Rspamd-Action: no action

Add the GPR syscon region for the s32 chipset.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v6: no change
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


