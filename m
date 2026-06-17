Return-Path: <netdev+bounces-300172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIG+HiKaMmq92gUAu9opvQ
	(envelope-from <netdev+bounces-300172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4728699EB8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZXAgPdxg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300172-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300172-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C171B3037EFE
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05633401A13;
	Wed, 17 Jun 2026 12:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBA3FF1B1;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701116; cv=none; b=oV8QbAAfTWk0PRcHLQEExSDaOzBRpHB0EySImNTqjN2ZUXVRZwHWnT/GZFqcSi9NcX9+j3EkLxwqWSB0iH2P8DtHyQ2bQcZvVF2U95U0Wtxj1PorBm8RK0qO05Mhv9DWOScw4ObmM12lDomvcDN3UWDwF9x9IX1En63APUEefTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701116; c=relaxed/simple;
	bh=M4ZWt+mHAF2ELChePJVTfUftIkxuHKKjLWjocgHzY3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2upI/07+RXj/pIN+Yr3n3QcCmq5apr5MSOCebK+iH+rosCgwzSwI9cjlhnZXhemBmO7T8xhGpHOT/yRXtxU5irXbN0Tc7/FKGkAYkMdMOToakSE8wWV+qeqRIylyoQ/v8J2PFMi8eruNJ/DnI5M0bkstsQy7nevkimqCj5OtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXAgPdxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 283F5C2BCC7;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781701116;
	bh=M4ZWt+mHAF2ELChePJVTfUftIkxuHKKjLWjocgHzY3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZXAgPdxgg1lf09DDzGpDjjVnSyM2R8SxTP4yBbCn9hCpKtHAoFiK2WXsHWi4x3GCf
	 LpV1X+xrxPqZrwxuKGps/VXzLNRrMIINuqEBtR1oZxizQu2Yx0G0k8rL+iWZ4amKHV
	 gXBIu7eHwaLPfxR+2OJOhJqzsu40GnZwEe4Qgk2ZO225+h9NqpHQDEEK3+ijGQ2VSp
	 sRuQ6VDx/5fNm9xf9wWoRrpvPx/whcnR70YF2ePMDzBlpCkL4u35bbZQucOqenIW82
	 lnBMRLcUm0Al3RxpmYIUZnBtADJaCR9d09uDERlDbQtGKd9G4mMqyE2h4yNGA14aFD
	 swdZyfgVOc0Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1921ACD98E4;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Wed, 17 Jun 2026 14:58:29 +0200
Subject: [PATCH v4 2/3] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPC-T6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-2-2bd38922d129@pardini.net>
References: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
In-Reply-To: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=NO/6wZ+sLcKe/QLBAJT3lasFlNbRmNJFqsdQ9xTA3gg=;
 b=owEBiQF2/pANAwAIATteP+Oex+3pAcsmYgBqMpn5+l2uM0Oe02l892Ed5Wt6vHMpu245f0spl
 bAjoyTJnmiJAU8EAAEIADkWIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCajKZ+RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQO14/457H7elyoAf/dyCjkuHSadpA9YEs6+JhUH6k/AbW/Uo
 n2/5XarQAeNs8PC7/6m3NZmQkGxfFweOcnwPdpYBJ/+4r59mNUieAJHLQGzMwxcWSUs4qUh5ptR
 oFEAr/VpsoFyqHTjM220vhaK8Zx9cv+lLldK3y6mzai54IeEz9zQIhlXL6jLKpyLCP4dhDV2k/1
 RYcJ0H8+/66NyEw7807/6kv2tpcfrwfvYTZ3omb57DvTJxvRK4vgRzPzmyTdti2iSzacOtTXNBs
 qk4qD/Y7IwVUijsWgYs9LLgZt5R4XShdIrNGxBnnQyjI7gKxz5rzjNce4MWWSL+alPbZjS2YxOj
 zcIbtU4q3rg==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300172-lists,netdev=lfdr.de,ricardo.pardini.net];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:ricardo@pardini.net,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,sntech.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ricardo@pardini.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pardini.net:replyto,pardini.net:email,pardini.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4728699EB8

From: Ricardo Pardini <ricardo@pardini.net>

The FriendlyElec NanoPC-T6 carries two on-board Realtek RTL8125 NICs
behind pcie2x1l0 and pcie2x1l2.

Describe the fixed function nodes and attach ethernet0/ethernet1
aliases, so that U-Boot's fdt_fixup_ethernet() can inject mac-address
properties from its ethaddr/eth1addr env. The on-NIC EEPROMs on this
board are not pre-programmed with a unique MAC, so this gives a
stable MAC across boots that both U-Boot and the kernel agree on.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index 84b6b53f016ab..0c11033f9d8e4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -20,6 +20,8 @@ / {
 	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
 
 	aliases {
+		ethernet0 = &rtl_eth0;
+		ethernet1 = &rtl_eth1;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 	};
@@ -635,6 +637,20 @@ &pcie2x1l0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_0_rst>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x200000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x21 0x2f>;
+
+		rtl_eth0: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x210000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie2x1l1 {
@@ -651,6 +667,20 @@ &pcie2x1l2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_2_rst>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x41 0x4f>;
+
+		rtl_eth1: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x410000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {

-- 
2.54.0



