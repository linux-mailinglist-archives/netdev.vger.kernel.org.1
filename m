Return-Path: <netdev+bounces-262602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMMGFsRnpWkdAAYAu9opvQ
	(envelope-from <netdev+bounces-262602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:34:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596391D69B8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5847305F497
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2C3A9634;
	Mon,  2 Mar 2026 10:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040D3A1D05;
	Mon,  2 Mar 2026 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447085; cv=none; b=RYQBo7M11G4WuPhgSt47LPD1JI+CdlD4fjNZZsu3soi3L9bCShSwiNU3pr0X4IVh4NGiM/BuTzdEcwAaPQkkHeDGSxtzOrMkIEA4jvR+jQV9NkD1d4yepAKhgcoLcffwZBE0qTvMkpYCj1Pqc2RhnIHQ/Q1JwdcEAHGvqMsXcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447085; c=relaxed/simple;
	bh=aZtDNdr61OwweI7vby67wVIteWF+rJrRIBVHhHKQGhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rtDp45XEZ934LjgAkUNrZ9sn0755OAsZ7uKpr0EpreINh5ZKfc2ptpHzqwSubvIf498IPgtUNhZs/3sio/p9XPP65ZvpIZoHObcvzeCqfCTgXBlGOxSz09QKiIbA7lxRFvrj///9xtYEhe7Ffp51eqwsmLCjbz9iIgl8GhRSF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:29 +0800
Subject: [PATCH net-next v6 2/5] ARM: dts: aspeed-g6: add aspeed,scu
 property for MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260302-rgmii_delay_2600-v6-2-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=1457;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=aZtDNdr61OwweI7vby67wVIteWF+rJrRIBVHhHKQGhE=;
 b=AXmZ0lSoz1tSsrNTPqSr8OhapxV4yxEady0AEJi725vT8llR3TAbxTAXgpQE8otpoSQj+DJ9M
 5XXUXwU8FxuBvN1sBZ/0QQuDmszHZgWhD8W55Az/igxDzBMj/K7GkEF
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262602-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1e660000:email,aspeedtech.com:mid,aspeedtech.com:email,1e680000:email,1e690000:email,1e670000:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 596391D69B8
X-Rspamd-Action: no action

Add aspeed,scu property to let MAC driver to configure RGMII delay with
scu register.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..cbcdc1c6eadb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -235,6 +235,7 @@ mac0: ethernet@1e660000 {
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -243,6 +244,7 @@ mac1: ethernet@1e680000 {
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -251,6 +253,7 @@ mac2: ethernet@1e670000 {
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 
@@ -259,6 +262,7 @@ mac3: ethernet@1e690000 {
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			aspeed,scu = <&syscon>;
 			status = "disabled";
 		};
 

-- 
2.34.1


