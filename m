Return-Path: <netdev+bounces-109798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDE929F3C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E72287652
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C726F2E3;
	Mon,  8 Jul 2024 09:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFF6EB56
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431458; cv=none; b=A3KJ7THkQ6GmtaFEgOpIBKm6eX5nKsiI6fu7CUXw+/+y/cvBfEOp1P6ClDfyRLfCYRhimo+lkC3q+nSUGiEgUtf7vm1OIPzTHQfsyn1XAze8EUl/7Q1WivTlnqQ3j2FM39v79bJeU+QSfyvjDCpzDGl2gy6LnvZPKhKWZuaFwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431458; c=relaxed/simple;
	bh=hTa+t1gHi/mQMbfoKjWG8PTLgoNUmDUnN9cTAmJACo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBxdwJQLrClLwtYCYqxOi+EKW6i+TTg0nKalzKMw88b0PFPmpnLk51aqjuKLdafPLT/g/+Nn8zg6D0IHmkh+q//TcUSYjihqeHMUmdGEucq8rDxOJ5grVpgLdmzVI36orr2YIWwPrsSPvyxCdlQ4U7c9X25dGlTcBwv0fY7VZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by xavier.telenet-ops.be with bizsmtp
	id kxdS2C00M5NeGrf01xdSYz; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJ5-Pg;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRX-NM;
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
Subject: [PATCH 02/12] arm64: dts: renesas: r8a774b1: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:14 +0200
Message-Id: <2d6a97d2df0532c661a2be6bafc9e5061c645197.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all Audio-DMAC, SDHI, Serial-ATA, and
Frame Compression Processor device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 10f22c52e79ecfca..117cb6950f91f934 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -2004,6 +2004,14 @@ audma0: dma-controller@ec700000 {
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+				 <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+				 <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+				 <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+				 <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+				 <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+				 <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+				 <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
 
 		audma1: dma-controller@ec720000 {
@@ -2038,6 +2046,14 @@ audma1: dma-controller@ec720000 {
 			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_mp 16>, <&ipmmu_mp 17>,
+				 <&ipmmu_mp 18>, <&ipmmu_mp 19>,
+				 <&ipmmu_mp 20>, <&ipmmu_mp 21>,
+				 <&ipmmu_mp 22>, <&ipmmu_mp 23>,
+				 <&ipmmu_mp 24>, <&ipmmu_mp 25>,
+				 <&ipmmu_mp 26>, <&ipmmu_mp 27>,
+				 <&ipmmu_mp 28>, <&ipmmu_mp 29>,
+				 <&ipmmu_mp 30>, <&ipmmu_mp 31>;
 		};
 
 		xhci0: usb@ee000000 {
@@ -2145,6 +2161,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
+			iommus = <&ipmmu_ds1 32>;
 			status = "disabled";
 		};
 
@@ -2158,6 +2175,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 313>;
+			iommus = <&ipmmu_ds1 33>;
 			status = "disabled";
 		};
 
@@ -2171,6 +2189,7 @@ sdhi2: mmc@ee140000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 312>;
+			iommus = <&ipmmu_ds1 34>;
 			status = "disabled";
 		};
 
@@ -2184,6 +2203,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
+			iommus = <&ipmmu_ds1 35>;
 			status = "disabled";
 		};
 
@@ -2211,6 +2231,7 @@ sata: sata@ee300000 {
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 815>;
+			iommus = <&ipmmu_hc 2>;
 			status = "disabled";
 		};
 
@@ -2343,6 +2364,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A774B1_PD_A3VP>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vp0 0>;
 		};
 
 		vspb: vsp@fe960000 {
@@ -2395,6 +2417,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A774B1_PD_A3VP>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vp0 5>;
 		};
 
 		fcpvd0: fcp@fea27000 {
@@ -2403,6 +2426,7 @@ fcpvd0: fcp@fea27000 {
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		fcpvd1: fcp@fea2f000 {
@@ -2411,6 +2435,7 @@ fcpvd1: fcp@fea2f000 {
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		fcpvi0: fcp@fe9af000 {
@@ -2419,6 +2444,7 @@ fcpvi0: fcp@fe9af000 {
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A774B1_PD_A3VP>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vp0 8>;
 		};
 
 		csi20: csi2@fea80000 {
-- 
2.34.1


