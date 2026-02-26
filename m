Return-Path: <netdev+bounces-261288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLW/HUIpoGlIfwQAu9opvQ
	(envelope-from <netdev+bounces-261288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:06:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 323431A4D14
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89E93131D99
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C56335BA7;
	Thu, 26 Feb 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4MlhLGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF433555F;
	Thu, 26 Feb 2026 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103826; cv=none; b=a5Vr8GZX954JvkKwOuR7Bso5gEydTgp5prA3H7YtertdC3hr1lBsRaIRnM+I/L91hdVqqKVDQF0M+0N7Yw1kWnGa+vY3Lf4Apl2e65RKzs1CCUS6CnXnpRBxR7nod0aSpqDVRepgMMehfMwvPTue64KVlxMJOWg+LrR/Ty9mxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103826; c=relaxed/simple;
	bh=phQfqbyabbOdNqjOuj7NK2iAIoyPl/OhSuvCTIyQ0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syA2lTeNe4W7pOR1gQWypF+rIHlRWgytlkEabzTxNf/WVw0Nebw4x9BLs/L0F/zxBa8CmC+4Svw9zTmC7Dp3bXn9gh+l620UIrZhmx5cY+z+Hghm4d0sIxiCDTNabo9ynJdQk1O2PS3QKcely57T7mWTG9xQhUw3BKMMxR5UysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4MlhLGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC173C19422;
	Thu, 26 Feb 2026 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103826;
	bh=phQfqbyabbOdNqjOuj7NK2iAIoyPl/OhSuvCTIyQ0qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4MlhLGiCDU2UEPxMRw+USykYsQpETX9z3k+qEG+CJYRUewxa4mpJjOC3lfBFo8xH
	 5GdmM2pBxpu/V6i+UBEm62Ss7zBNtEVQwZReO9jjGPohBD5teUZf9nJ9IC2N/JCVQ5
	 aeZ7X9T5axbqW6KKE3DeqHlUwjn5KdPD7H2L/CXj/yZysEd2KXNbJ5HqgppQi3Omdp
	 iHrVvIERFvshZPz3kyvey1xBznsFW3TdA7L8Cy6dP3YIOoJzjBD/gz20RHLGE1crC4
	 n7Qn8ly8+vD5muNoNL6BAYAPo/nZVjrnZiwk3Fow6UfCfE+4EVcboWzXF1K6zv4piM
	 ukjFxiTBMfHVw==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 1/8] riscv: dts: microchip: add tsu clock to macb on mpfs
Date: Thu, 26 Feb 2026 11:03:16 +0000
Message-ID: <20260226-briskly-severity-69c2988e8dc8@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226-snowshoe-amusable-6716d4ddea11@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3466; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YBmcAd9qnWn/x3Gu0jOv29xyhvfqaOmflkLzzges9dc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkLNMoY0jNXFK98wBMobtnKtZbpHcfT4Ps15x/z7VzIE VIcM/9jRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDaEi1MAJhL2lOG/J3uF6xe+cON/yXdW 6M3efKrhtpzlfQ1Z4ak2J20nZHL0M/wV37Q3YGvYDbcnCS1hUdx+h4U/HtZdcm3qufilChtW7br OBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261288-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,baylibre.com,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[1.50.218.176:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.50.226.128:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 323431A4D14
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

In increment mode, the tsu clock for the macb is provided separately to
the pck, usually the same clock as the reference to the rtc provided by
an off-chip oscillator. pclk is 150 MHz typically, and the reference is
either 100 MHz or 125 MHz, so having the tsu clock is required for
correct rate selection.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile.orig | 26 +++++++++++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi     |  8 +++----
 2 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile.orig

diff --git a/arch/riscv/boot/dts/microchip/Makefile.orig b/arch/riscv/boot/dts/microchip/Makefile.orig
new file mode 100644
index 0000000000000..e94f4096fd401
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/Makefile.orig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+<<<<<<< HEAD
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-disco-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit-prod.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+||||||| constructed fake ancestor
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+=======
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-tysom-m.dtb
+>>>>>>> riscv: dts: microchip: remove POLARFIRE mention in Makefile
+dtb-$(CONFIG_ARCH_MICROCHIP) += pic64gx-curiosity-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 5c2963e269b83..ccd7c2e4724f4 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -448,8 +448,8 @@ mac0: ethernet@20110000 {
 			interrupt-parent = <&plic>;
 			interrupts = <64>, <65>, <66>, <67>, <68>, <69>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
-			clock-names = "pclk", "hclk";
+			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>, <&refclk>;
+			clock-names = "pclk", "hclk", "tsu_clk";
 			resets = <&mss_top_sysreg CLK_MAC0>;
 			status = "disabled";
 		};
@@ -462,8 +462,8 @@ mac1: ethernet@20112000 {
 			interrupt-parent = <&plic>;
 			interrupts = <70>, <71>, <72>, <73>, <74>, <75>;
 			local-mac-address = [00 00 00 00 00 00];
-			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
-			clock-names = "pclk", "hclk";
+			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>, <&refclk>;
+			clock-names = "pclk", "hclk", "tsu_clk";
 			resets = <&mss_top_sysreg CLK_MAC1>;
 			status = "disabled";
 		};
-- 
2.51.0


