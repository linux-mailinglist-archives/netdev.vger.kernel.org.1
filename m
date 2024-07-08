Return-Path: <netdev+bounces-109793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E1929F38
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31931C211EC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AC7346F;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E46E2AE
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431457; cv=none; b=B8deUc2bR0T/CuDLw7E8mCAWOmRqt2fdbi/WF/GLtc46SC44Jjd9rwSDTD4ejbmPT37C5ZUkp5KasF0+TwNDCCU6oHEZFbc5Bn4BhbM01RPDMiknsB5K00VlVeDvzgL+ShYfOz306T1r5TyiQ+Lx8L88uDqocpBwJjiE0js82rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431457; c=relaxed/simple;
	bh=3fuqSoN1N0Zg1Vcrm589+Bg3AHwKGvdezCddhRFvkk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMiVtt1nlGqA7xB4r1NqUJE5izoZ3pmuhG7G7hpBrYQ5bJM+rFXEQ1nzR9FggVONWUtXKlFkw8k5q3R42WNq5vLQfHPAd8/MAP2dIKJQmcAZT/24HxNHJcVdYFgzuy4tgp/D3DCDrmkriFGpPUHqPoZZ4AoSWRJCDpDhyb+FGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by xavier.telenet-ops.be with bizsmtp
	id kxdT2C0015NeGrf01xdTZ2; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJf-VH;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RS8-Sa;
	Mon, 08 Jul 2024 11:37:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 10/12] arm64: dts: renesas: r8a779a0: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:22 +0200
Message-Id: <39da0dddf7e7f1fde2b2d83444af7bb5ae73b922.1720430758.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720430758.git.geert+renesas@glider.be>
References: <cover.1720430758.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing iommus properties to all EthernetAVB, DMAC, and Frame
Compression Processor device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index d76347001cc13c65..69652d309fe6f01e 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -707,6 +707,7 @@ avb0: ethernet@e6800000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -755,6 +756,7 @@ avb1: ethernet@e6810000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -803,6 +805,7 @@ avb2: ethernet@e6820000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -851,6 +854,7 @@ avb3: ethernet@e6830000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -899,6 +903,7 @@ avb4: ethernet@e6840000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -947,6 +952,7 @@ avb5: ethernet@e6850000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_ds1 11>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -2096,6 +2102,14 @@ dmac1: dma-controller@e7350000 {
 			resets = <&cpg 709>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_ds0 0>, <&ipmmu_ds0 1>,
+				 <&ipmmu_ds0 2>, <&ipmmu_ds0 3>,
+				 <&ipmmu_ds0 4>, <&ipmmu_ds0 5>,
+				 <&ipmmu_ds0 6>, <&ipmmu_ds0 7>,
+				 <&ipmmu_ds0 8>, <&ipmmu_ds0 9>,
+				 <&ipmmu_ds0 10>, <&ipmmu_ds0 11>,
+				 <&ipmmu_ds0 12>, <&ipmmu_ds0 13>,
+				 <&ipmmu_ds0 14>, <&ipmmu_ds0 15>;
 		};
 
 		dmac2: dma-controller@e7351000 {
@@ -2121,6 +2135,10 @@ dmac2: dma-controller@e7351000 {
 			resets = <&cpg 710>;
 			#dma-cells = <1>;
 			dma-channels = <8>;
+			iommus = <&ipmmu_ds0 16>, <&ipmmu_ds0 17>,
+				 <&ipmmu_ds0 18>, <&ipmmu_ds0 19>,
+				 <&ipmmu_ds0 20>, <&ipmmu_ds0 21>,
+				 <&ipmmu_ds0 22>, <&ipmmu_ds0 23>;
 		};
 
 		mmc0: mmc@ee140000 {
@@ -2278,6 +2296,7 @@ fcpvd0: fcp@fea10000 {
 			clocks = <&cpg CPG_MOD 508>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			resets = <&cpg 508>;
+			iommus = <&ipmmu_vi1 6>;
 		};
 
 		fcpvd1: fcp@fea11000 {
@@ -2286,6 +2305,7 @@ fcpvd1: fcp@fea11000 {
 			clocks = <&cpg CPG_MOD 509>;
 			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
 			resets = <&cpg 509>;
+			iommus = <&ipmmu_vi1 7>;
 		};
 
 		vspd0: vsp@fea20000 {
-- 
2.34.1


