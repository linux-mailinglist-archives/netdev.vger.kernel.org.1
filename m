Return-Path: <netdev+bounces-268975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INRxIYuEumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:55:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9052BA4C5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67690315B3C5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70973A3E87;
	Wed, 18 Mar 2026 10:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5B39D6E9
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831099; cv=none; b=q3gG+LDyCzaiS1WfyCT/2e6LzYyp9/lLRCzDVd8YwrPuxGIBon2cUnFBkmMXneVCJTMlWgvsKumFmT7c2F7boobVSSCkao6XRrZTm6+xfQoZjfrij3WzVUWAAqCkVM7kxyd9CHJjhv291cf9pJ0AWVHn1kOZvHjOcZocMgZp+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831099; c=relaxed/simple;
	bh=99MoR5B6FN0+kJyUEkYq+JZz0yxs/jel3MjgkwYNru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIVgkmhRW0oesfB7FQPF+gczpZsCHjN4CrOr0EnuqrjpZVERXgaX64GHN4V9IaVZXgo6T3e73P3ZvjyYLYazXw5kqjK32Sju4Mz3fIZGfCZxWF6W4XFRhYZn7bk6zqW4+BEdY6RFkFFYunuHbjqGEks5iZv7RzWMnXUFEYRhwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WM-F3; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-000tSP-0E;
	Wed, 18 Mar 2026 11:51:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUm-00000003RIc-47vz;
	Wed, 18 Mar 2026 11:51:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: David Jander <david@protonic.nl>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 3/7] ARM: dts: stm32: stm32mp15x-mecio1-io: Move divergent mecio1 ADC channels to board files
Date: Wed, 18 Mar 2026 11:51:19 +0100
Message-ID: <20260318105123.819807-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318105123.819807-1-o.rempel@pengutronix.de>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268975-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF9052BA4C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Jander <david@protonic.nl>

Move the divergent adc1 channel definitions out of the common
mecio1-io.dtsi file and into the specific Revision 0 and Revision 1
board files.

The original common file contained incorrect schematic labels for the
Revision 0 hardware (e.g., labeling ana0 as p24v_hpdcm instead of
ain_aux0) and failed to account for physical signal routing changes
between the board revisions.

Retain only the strictly shared channels in the common include file. Map
the correct channels and schematic labels directly within
stm32mp151c-mecio1r0.dts and stm32mp153c-mecio1r1.dts.

Crucially, ensure that the required 200us sample time follows the
phint1_ain signal to its new physical location on channel 3 for the
Revision 1 hardware.

Fixes: 8267753c891c ("ARM: dts: stm32: Add MECIO1 and MECT1S board variants")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts | 50 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts | 50 +++++++++++++++++++
 .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 50 +------------------
 3 files changed, 101 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
index a5ea1431c399..4e795ad42928 100644
--- a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
+++ b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
@@ -36,6 +36,56 @@ led-1 {
 	};
 };
 
+&adc1 {
+	channel@0 {
+		reg = <0>;
+		st,min-sample-time-ns = <20000>;
+		label = "ain_aux0";
+	};
+
+	channel@1 {
+		reg = <1>;
+		st,min-sample-time-ns = <20000>;
+		label = "ain_aux1";
+	};
+
+	channel@3 {
+		reg = <3>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm1_i2";
+	};
+
+	channel@5 {
+		reg = <5>;
+		st,min-sample-time-ns = <20000>;
+		label = "pout1_i";
+	};
+
+	channel@9 {
+		reg = <9>;
+		st,min-sample-time-ns = <20000>;
+		label = "pout0_i";
+	};
+
+	channel@13 {
+		reg = <13>;
+		st,min-sample-time-ns = <200000>;
+		label = "phint1_ain";
+	};
+
+	channel@15 {
+		reg = <15>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm0_i1";
+	};
+
+	channel@18 {
+		reg = <18>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm0_i2";
+	};
+};
+
 &clk_hse {
 	clock-frequency = <25000000>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
index 16b814c19350..d32816093e47 100644
--- a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
+++ b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
@@ -36,6 +36,56 @@ led-1 {
 	};
 };
 
+&adc1 {
+	channel@0 {
+		reg = <0>;
+		st,min-sample-time-ns = <20000>;
+		label = "p24v_hpdcm";
+	};
+
+	channel@1 {
+		reg = <1>;
+		st,min-sample-time-ns = <20000>;
+		label = "p24v_stp";
+	};
+
+	channel@3 {
+		reg = <3>;
+		st,min-sample-time-ns = <200000>;
+		label = "phint1_ain";
+	};
+
+	channel@5 {
+		reg = <5>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpout1_i";
+	};
+
+	channel@9 {
+		reg = <9>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpout0_i";
+	};
+
+	channel@13 {
+		reg = <13>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm0_i2";
+	};
+
+	channel@15 {
+		reg = <15>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm1_i2";
+	};
+
+	channel@18 {
+		reg = <18>;
+		st,min-sample-time-ns = <20000>;
+		label = "hpdcm0_i1";
+	};
+};
+
 &clk_hse {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
index 1b1299770ca0..f91b3d1f037b 100644
--- a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
@@ -90,7 +90,7 @@ v5v: regulator-v5v {
 };
 
 &adc {
-	/* ANA0, ANA1 are dedicated pins and don't need pinctrl: only in6. */
+	/* ANA0, ANA1 are dedicated pins and don't need pinctrl. */
 	pinctrl-0 = <&adc12_pins_mecsbc>;
 	pinctrl-names = "default";
 	vdd-supply = <&v3v3>;
@@ -102,78 +102,30 @@ &adc {
 &adc1 {
 	status = "okay";
 
-	channel@0 {
-		reg = <0>;
-		st,min-sample-time-ns = <20000>;
-		label = "p24v_stp";
-	};
-
-	channel@1 {
-		reg = <1>;
-		st,min-sample-time-ns = <20000>;
-		label = "p24v_hpdcm";
-	};
-
 	channel@2 {
 		reg = <2>;
 		st,min-sample-time-ns = <20000>;
 		label = "ain0";
 	};
 
-	channel@3 {
-		reg = <3>;
-		st,min-sample-time-ns = <20000>;
-		label = "hpdcm1_i2";
-	};
-
-	channel@5 {
-		reg = <5>;
-		st,min-sample-time-ns = <20000>;
-		label = "hpout1_i";
-	};
-
 	channel@6 {
 		reg = <6>;
 		st,min-sample-time-ns = <20000>;
 		label = "ain1";
 	};
 
-	channel@9 {
-		reg = <9>;
-		st,min-sample-time-ns = <20000>;
-		label = "hpout0_i";
-	};
-
 	channel@10 {
 		reg = <10>;
 		st,min-sample-time-ns = <200000>;
 		label = "phint0_ain";
 	};
 
-	channel@13 {
-		reg = <13>;
-		st,min-sample-time-ns = <200000>;
-		label = "phint1_ain";
-	};
-
-	channel@15 {
-		reg = <15>;
-		st,min-sample-time-ns = <20000>;
-		label = "hpdcm0_i1";
-	};
-
 	channel@16 {
 		reg = <16>;
 		st,min-sample-time-ns = <20000>;
 		label = "lsin";
 	};
 
-	channel@18 {
-		reg = <18>;
-		st,min-sample-time-ns = <20000>;
-		label = "hpdcm0_i2";
-	};
-
 	channel@19 {
 		reg = <19>;
 		st,min-sample-time-ns = <20000>;
-- 
2.47.3


