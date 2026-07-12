Return-Path: <netdev+bounces-306981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WsuVBor6U2owggMAu9opvQ
	(envelope-from <netdev+bounces-306981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75525745D9D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=ctJpl8nT;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306981-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306981-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F1A3014C55
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0C3B47D7;
	Sun, 12 Jul 2026 20:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84334040A;
	Sun, 12 Jul 2026 20:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888496; cv=none; b=kDqx6roGagFRWnXRw2NKZUapi962KPKzJjLTWtZbBMDrmetV788C5L1464XlF/VDFMoivITCo7k4Q90e2Z9AXh1omgePY65s1rozYSxNe6sQNkFGLK0+M00hMoErEk+ZvQ7QX6gVbE2JcV7COVkZ+GRoCQSmY//u6ztOHpVjamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888496; c=relaxed/simple;
	bh=acDJnTd5MEKvTipUGPLMCNBOBwkkCVfP0RZS48esP/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCUGFfZzVphMsl2cPITKqYycCm95yeEPdkCEcGmZNM5OxlVuztoKUGbqM2dp1QDrQc2vXeC/kV+xhVnad7VeG9qa2E8ymCpE1pSXCBMtO/lILVkuQvbKxoICEk47zBUeRRnwYUA4VkzW++w2RyIJRNNmI9/N2efzPrKnYzkV9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ctJpl8nT; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Mv2WgGTz6WKIqtoJnLFA34PaD05R6doIbVvqCh8lFG4=; b=ctJpl8nTmjSPbLdy7AePVUSEcT
	4SU8EprP9Zha+ttcLt3cuQ6gy3de/Nx2IcCVXn+Ur2u9z3rvkl0k85qyLgLVY3Isde/CeUCrsd4Ib
	ZAGsRB5w4feaOa1KpOapEuzihotjFf4UAmebxw8jth2ErWFcLeLdICBSs/HxLxu2KT0bd2x1bhxgg
	kpH4XNgIxuS3CrTuDcD+ixXLw0+mOhmX5xqlIHxbMm3SO6YH9aSsJWzGv0yIRh+LfTPiJOofmOqCZ
	JkrEQUEinoNIaL5LVIdgrMSih1NbP47hsBTnsMKfF99I/HNZvJ/kFVEWuFx8sSe4knQanm+KgzRJ9
	jwHO712Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanan He <grumpycat921013@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: (subset) [PATCH v2 0/5] ARM: rockchip: rv1126: Add support for Alientek ATK-DLRV1126
Date: Sun, 12 Jul 2026 22:33:57 +0200
Message-ID: <178388833980.1396294.8103967667500299878.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:grumpycat921013@gmail.com,m:heiko@sntech.de,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,motor-comm.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306981-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sntech.de:from_mime,sntech.de:email,sntech.de:mid,sntech.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75525745D9D


On Mon, 06 Jul 2026 17:14:40 +0800, Yanan He wrote:
> The ATK-DLRV1126 board consists of a CLRV1126F core module and a
> DLRV1126 carrier board. The core module contains the Rockchip RV1126
> SoC, eMMC and RK809 PMIC. The carrier board provides Gigabit Ethernet,
> SD card, AP6212 WiFi and Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and
> audio connectors.
> 
> This series adds the Alientek vendor prefix and board compatible, updates
> the Motorcomm PHY driver to consume an optional external PHY reference
> clock, adds missing RV1126 SoC description pieces, and finally adds the
> CLRV1126F core module and DLRV1126 carrier board device trees.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: vendor-prefixes: add alientek
      commit: 068a6bd57167cb97058b08f22db0584fabdaab95
[2/5] dt-bindings: arm: rockchip: Add Alientek DLRV1126
      commit: f1522feb72aa5231532c9f69e7f5cc91972697e1
[4/5] ARM: dts: rockchip: Add RV1126 I2C5
      commit: 17bee9ee734e56d512ec7803eb7948adb56d1d9c
[5/5] ARM: dts: rockchip: Add Alientek DLRV1126
      commit: 44045aa7a9a9e6484617f44f77a3efb2d8e78565

Please double-check the sorting on future patches :-) .
The dtsi was perfect, but I did some re-sorting on the carrier-dts.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

