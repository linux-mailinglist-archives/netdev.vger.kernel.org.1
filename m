Return-Path: <netdev+bounces-109791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D049929F36
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286C9289E6F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7736F30B;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29F6026A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431457; cv=none; b=WiQ8iMgVyQVdxUjdfSLmj1DsmUJmkHzSmPG9ytnTyw0Pj6k0XHBAtTFsLEeu53bEnpirwAyGyw/dB/NnkIkplXSVqp10ujQnbr5ceHUnzTH48PWwscK6BgKJAR2hVw4Qf2410MtgfRgtQHaZsYLTH1usucEy116tylER42Wa8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431457; c=relaxed/simple;
	bh=GOAQsszWGhKICZHVh0LVtZ7j2HFrPXH4HpHOiLrsT2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPbhSVlz/uSDOP09CphxXyKjOSSG7YM+f8I24DLccRi9BFmL/EFzOvA4haFLU617v1Jej+YG+XYLi1oSVoVZeedjR+k9OKacWfW0qoq9BlKE69zej5YUqCXAQLm0AVsEuXeq+9QgxRZ64yfOpENwX4iZWRkANEzyOCDuRsKfXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by baptiste.telenet-ops.be with bizsmtp
	id kxdS2C00J5NeGrf01xdS0l; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJO-Sw;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRs-QX;
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
Subject: [PATCH 07/12] arm64: dts: renesas: r8a77965: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:19 +0200
Message-Id: <79fe31020799ba508d16ff8dbd4296f239ecf76a.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all Audio-DMAC, Serial-ATA, and Frame
Compression Processor device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index f02d1547b881716a..557bdf8fab179cf7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -2185,6 +2185,14 @@ audma0: dma-controller@ec700000 {
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
@@ -2219,6 +2227,14 @@ audma1: dma-controller@ec720000 {
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
@@ -2396,6 +2412,7 @@ sata: sata@ee300000 {
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 815>;
+			iommus = <&ipmmu_hc 2>;
 			status = "disabled";
 		};
 
@@ -2490,6 +2507,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A77965_PD_A3VP>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vp0 0>;
 		};
 
 		vspb: vsp@fe960000 {
@@ -2542,6 +2560,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A77965_PD_A3VP>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vp0 5>;
 		};
 
 		fcpvd0: fcp@fea27000 {
@@ -2550,6 +2569,7 @@ fcpvd0: fcp@fea27000 {
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		fcpvd1: fcp@fea2f000 {
@@ -2558,6 +2578,7 @@ fcpvd1: fcp@fea2f000 {
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		fcpvi0: fcp@fe9af000 {
@@ -2566,6 +2587,7 @@ fcpvi0: fcp@fe9af000 {
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A77965_PD_A3VP>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vp0 8>;
 		};
 
 		cmm0: cmm@fea40000 {
-- 
2.34.1


