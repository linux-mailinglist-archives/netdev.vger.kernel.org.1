Return-Path: <netdev+bounces-300173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZS1IABSaMmqu2gUAu9opvQ
	(envelope-from <netdev+bounces-300173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FE699EAA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=KU1YOTDw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300173-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACBA8300E3E4
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3D404BE3;
	Wed, 17 Jun 2026 12:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968203FF8B0;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701116; cv=none; b=e/4nLbU37yG3JKYIiIA6AFqs8qkOmfl/MRQ/QnN4o27nd936WEYW9xYCpeAudDtY2ZPSEVUSAJ6qu3PInePHNsEAOK+gPvYcLJk+NMf36TuryvPh8cWg0HR/oxobWxfXjD439XTsamBDyM3R8tVfCAJr7xUVPtIlrFes5d/a4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701116; c=relaxed/simple;
	bh=ZwE7QIllR5UjXdD36Vy637TMxtThVapvnR6S8FAuDUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2LiPtuTrR7W5EsobUzSsq8ihMSWFmetscYHMNULJvmSKTlPQO+7s/xB7kgW9WhRqr9sAxwEPjn9a0aZ8vz72KugNkCxcQQOiSwQwHGqgK+M6NrHk2RSJgOKvETh1klD7+5SphQ32oEHCcmIg5m/QLxSBT8clJejw7Yqm0V/0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU1YOTDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 494AFC4AF15;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781701116;
	bh=ZwE7QIllR5UjXdD36Vy637TMxtThVapvnR6S8FAuDUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KU1YOTDw+2Rbp9JYLM/X5toz84SrCiAiJJd9fs7Gt1YL2XZANdp2NpBwTNoimI7ST
	 A6D4qK+KjRNE5hThoKjc285XJMs7Vz8G1EIxewiLTLjSBND64yHMCYuGWXdIMdbtaX
	 sf1j9IWmH5V1Rcw50LtR6DNVI8dYM20Ph3Xw84TOHxVtrXgW47lvipKnH288Op6JXD
	 /niP7NdOjSocZVzUfY3S3ChBzQ+seaduSPDP1R7G85PBdP5ZiX6ZRQF0A/T24Aipox
	 4uuww7Xq6c/mh5Tgo81VuCgsYETU/VNZwgQIT+IE1W0ThZvQmgF3oASB07bwjHq0wS
	 OtQGlHwK2XBtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B585CD98E2;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Wed, 17 Jun 2026 14:58:30 +0200
Subject: [PATCH v4 3/3] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on Radxa ROCK 5 family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-3-2bd38922d129@pardini.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=MognxmUJ6xqKPxqxbx7vV1ir4AaICF3oo7pMGUUP9SY=;
 b=owEBiQF2/pANAwAIATteP+Oex+3pAcsmYgBqMpn5nzZFgZCVPzJQ5hejWuqpriuYPqCKN4E+U
 5NPdJDcxIyJAU8EAAEIADkWIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCajKZ+RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQO14/457H7enDYQgAhTEPZa3xyAoVucFR5lfweGyEi+18ig9
 hNb6ty67yz4A3kVZVJCXGioEFpOu+Ax+hJm9ELV/6LyvrlwG1w0pNQOf4rcGdrMLjwqy9E8C39T
 ghQRgAXm6LXw65+9MgOI145DYXEQJJpKQHou7q6z0IAJ9tkruKPBT9emgh/BEZLfbj6fV1MtKk/
 +CdRbKuQtC1Pj/mhR1bpIBhF0dKvZ/7hkzw53fc+Fqr/Yij7vwX4QXY9a04EhtBNovJV0eKMeGn
 LDDq4bteRpWmn0N+xtwtxU77fJtGs80K7qJ3xGyInpOvgpZLx/R9KECSZaZ3PIwLwg0CxiFaSLR
 Ol3DM6fti8Q==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300173-lists,netdev=lfdr.de,ricardo.pardini.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pardini.net:replyto,pardini.net:email,pardini.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 799FE699EAA

From: Ricardo Pardini <ricardo@pardini.net>

The Radxa ROCK 5B / 5B+ / 5T all carry on-board Realtek RTL8125 NICs.

Describe the fixed function nodes and attach ethernet0/ethernet1
aliases, so that U-Boot's fdt_fixup_ethernet() can inject mac-address
properties from its ethaddr/eth1addr env, for stable MACs across
boots that both U-Boot and the kernel agree on.

The RTL8125 on pcie2x1l2 is shared by all three variants. The ROCK 5T
additionally describes pcie2x1l1 with its second RTL8125.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 .../arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts        | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
index bf4a1d2e55ca3..b53dfe6848cce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
@@ -10,6 +10,7 @@
 
 / {
 	aliases {
+		ethernet0 = &rtl_eth0;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 		mmc2 = &sdio;
@@ -482,6 +483,20 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
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
+		rtl_eth0: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x410000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
index 425036146b6d9..b1a3e4b2165f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
@@ -8,6 +8,10 @@ / {
 	model = "Radxa ROCK 5T";
 	compatible = "radxa,rock-5t", "rockchip,rk3588";
 
+	aliases {
+		ethernet1 = &rtl_eth1;
+	};
+
 	analog-sound {
 		compatible = "audio-graph-card";
 		label = "rk3588-es8316";
@@ -76,6 +80,20 @@ &pcie2x1l1 {
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l1>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x300000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x31 0x3f>;
+
+		rtl_eth1: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x310000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {

-- 
2.54.0



