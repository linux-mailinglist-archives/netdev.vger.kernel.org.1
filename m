Return-Path: <netdev+bounces-304918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id loqvBjCSS2rfVgEAu9opvQ
	(envelope-from <netdev+bounces-304918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:32:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DF70FDDE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:31:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G9qhEyFB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304918-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304918-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76B43376E33
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5B4C9567;
	Mon,  6 Jul 2026 09:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4685424671
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:15:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329339; cv=none; b=EsJtaVvJ9kq6wuwA69VSaQqxKiwQy7vhPgSEobELalFdkf1MxjNpzoAD03cUcQWx3D1HLWPPIvrI+3Q2d3D+XSH5vHG/uf/YgoreVldqCKMVb39rI1AoWMUuIczisrv/IIaiXgWxKml0FAzRiGSgsJiRpxOo86ae66x/dJ9YPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329339; c=relaxed/simple;
	bh=YYXBhszfUr1JhliGkjK/e/qiP2GmFVYlWneGxF8txDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeOT8U4WVVgBKfkkqHIEm/RLV/VQ9nFjVThTHX9CRlpLDHtff4tPypLb/eh2/FwnWexVklnCAxC9c5SCLDZosl0SUrw463fXJcMPescZgask5+MDqq1Gh3egVEHplqs9SzBsjhlPzu/2zTe4KV5q3EhtgjBkeqhVuTvfsLWM0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9qhEyFB; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-847a5528b33so1379052b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783329331; x=1783934131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEbrn8nkx2n3q4opZ/ye+YyaLjCnYU6NuTNhw5Plk0U=;
        b=G9qhEyFBXS7J9o7DHmg/WSSlOrgKMDf7w/WAttUYFu4PbfQ+hxEc3iyFRx/tx8gOGF
         ehzVFf/dRXY7CfyLQ2pQPbtGw6kQxBgLmkf80srslHrcV3RNKwuSkOP4Lvn6yf6YxQxW
         qMjdaH+oLcHjC5Deh2/0dLUi5CXmfhy/EqifFrO6p62UrkvMfHODsrUM4pgSKqYRyNWI
         q+Hwqwz1xcGr0cFBQcnlFTdz0aMOBm7NGXMHDJKvaGfCm+Vuews96BROMMSa7ts1QtJI
         yDt/QYwowAReqiwb6G0cUmqQUcDWu0b2S33SeHLoMTJtGfeji7DvJCWOcJ5QXPDstQTG
         l3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329331; x=1783934131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEbrn8nkx2n3q4opZ/ye+YyaLjCnYU6NuTNhw5Plk0U=;
        b=VZR0JcYWVNHhHMF98LCjn2jhPOq4Y9IFAwySjPz3BNupMKHbKyQi9oHlF7yqsqHspg
         x6js+jSVKmx2M+217N71vV7ysrmUabHRDo653uj/3L0JgbZoApS1jayczDgOA1xhYb7r
         xOzXWt0SWzVkTkKIK9dm285HUj7LdeHdTCZQvjNEsnK1yU/GzLMxPUdp4v50s7WK1gju
         ZfYhAzD3dBKL4qBCm+rZ0aIFPhQesxl7tfnVHHyWRSxA+n5jRZlKG975HRx5n/R9Nqoy
         IGRDueAwbW75lwFWZ/YN3SSvT6k4mn0HcukCSjcOeQZykLI5E3zXKtBIa1plSljQDvlL
         RHPg==
X-Forwarded-Encrypted: i=1; AHgh+RqwFs4ZAdfHzb2lIdHIJRnOAszTcDDWSrHmBaPDTzi699HXqMOYOPkSgWHdf3gjNlFAkLt/Eo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6syGe7e5cFHCUY6VAwePxpNnhkBaXZxN48f0g29RhbBRkTTh6
	ob+2LehKQhjtcDr2wT6zm5V/VY3guOkXNqy//YI0th+6rbDAKu3zQ6Ep
X-Gm-Gg: AfdE7cm0F0PDW03rGKkdLkJykU52i6YzPAvgrsGCp9anm8k5FV+DfnGY7NsW3llmZk5
	0C9UoWFSMHpWXqYk6rOjzKBd4GRHC8p6hS+LlyI6TlXFt2d0uNsUYs+C+Z4c2QIjpbj9YSTSD0T
	ySmtzysIeT/GygKEsnJA6of/6gLvAcRzjgJjZOG3tJMhw3gQ/sTa21BjfKiA3rwqeeh6aeLHchZ
	JrET16fUqNwjZbVOj+i2RUziGC4oAbFMmziHzPt4ZW47CwC0ePAuh+ImbQ6XcrEXmIwd7FxZhG/
	nimDnRcAz6WImLBeNQY/iXO7RVcetesWXRuez9/z2hX+pfDI9hCm6FP2eYdRAaHfsEysct1FPM7
	T6IKJfpncJBMJpx8YpFziu0R7rCyTCbeCI2edPSYuHvcO60qdz73QvFtoCgSyQbRUnUFg/Mj4qn
	5pmg2Ky4YN+lsNF+Od0N3EmyN3
X-Received: by 2002:a05:6a00:32ce:b0:847:438f:500c with SMTP id d2e1a72fcca58-847f6fcd568mr8517078b3a.60.1783329329369;
        Mon, 06 Jul 2026 02:15:29 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm3445963b3a.53.2026.07.06.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:15:28 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Mon, 06 Jul 2026 17:14:44 +0800
Subject: [PATCH v2 4/5] ARM: dts: rockchip: Add RV1126 I2C5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-rv1126-alientek-dlrv1126-v2-4-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783329287; l=2080;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=YYXBhszfUr1JhliGkjK/e/qiP2GmFVYlWneGxF8txDo=;
 b=YGf9TKEH3HthXKT99UhNu8l/oEBNF6pz0GwXaT72VY1OxJvp6qbSl8vzB/x98CgnlkQqZBtmd
 olvuTvIueVWBLVJh6ktacMSkePgvqDmIUYV1dVFhk9rWAWwM2WNlyT2
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,motor-comm.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A44DF70FDDE

The controller is present in the SoC and can be used by boards for
external peripherals, such as an RTC on the Alientek DLRV1126 carrier
board.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi | 10 ++++++++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi         | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
index 35ef6732281f..1d883b80aed4 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
@@ -123,6 +123,16 @@ i2c3m2_xfer: i2c3m2-xfer {
 				<1 RK_PD7 3 &pcfg_pull_none>;
 		};
 	};
+	i2c5 {
+		/omit-if-no-ref/
+		i2c5m0_xfer: i2c5m0-xfer {
+			rockchip,pins =
+				/* i2c5_scl_m0 */
+				<2 RK_PA5 7 &pcfg_pull_none_drv_level_0_smt>,
+				/* i2c5_sda_m0 */
+				<2 RK_PB3 7 &pcfg_pull_none_drv_level_0_smt>;
+		};
+	};
 	i2s0 {
 		i2s0m0_lrck_tx: i2s0m0-lrck-tx {
 			rockchip,pins =
diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index d6e8b63daa42..d0cdc5f74212 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -23,6 +23,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		i2c5 = &i2c5;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -400,6 +401,20 @@ i2c3: i2c@ff520000 {
 		status = "disabled";
 	};
 
+	i2c5: i2c@ff540000 {
+		compatible = "rockchip,rv1126-i2c", "rockchip,rk3399-i2c";
+		reg = <0xff540000 0x1000>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5m0_xfer>;
+		rockchip,grf = <&pmugrf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pwm8: pwm@ff550000 {
 		compatible = "rockchip,rv1126-pwm", "rockchip,rk3328-pwm";
 		reg = <0xff550000 0x10>;

-- 
2.54.0


