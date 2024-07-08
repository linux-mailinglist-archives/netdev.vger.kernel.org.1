Return-Path: <netdev+bounces-109808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BADD929F75
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1D2873D6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10B61FED;
	Mon,  8 Jul 2024 09:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1059167
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431862; cv=none; b=ppXjdbX5vsc59n//bGEPDalMw5puOT3TjzQFKA2fZhaheVAOvomFkU31w4zBGbhMusFbjjuqFNfhDC5Uhkta8JfLy2O/sIIdZesPriaxaI+BKJBaAoigLloID3nl2k4gEOEjxA6DZDCQkKNNb5Qqo5TvqH3H2dekkJ7lrFJBGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431862; c=relaxed/simple;
	bh=mnlOyPj1SzOyIYGNYlg9KoWWwgczB0qSvOwICYWTIpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1e71dtTcvZqkSQFqW4JMRiVpIibUzF3SmbvUQej+md/18qo9mev7pUV99qnl/sq4i8N4LsztZpti+mco2OxkbQ8qHYp4841ZnWOvZs1nWeNaPYR13LFYzU/ZL48qMvZmRCfTI1w9DITcrcQd8o6MW5n+tNFKdVoGuJj2Da6wHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4WHfDG4Yxwz4x0t3
	for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:37:34 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by albert.telenet-ops.be with bizsmtp
	id kxdS2C00c5NeGrf06xdSi2; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJ2-Ox;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRU-MN;
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
Subject: [PATCH 01/12] arm64: dts: renesas: r8a774a1: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:13 +0200
Message-Id: <114e9915356670e59dae412c1054afad4ce4c964.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to SDHI and Frame Compression Processor
device nodes that still lack them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 1dbf9d56c68da8c6..f065ee90649a4a5e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2277,6 +2277,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
+			iommus = <&ipmmu_ds1 32>;
 			status = "disabled";
 		};
 
@@ -2290,6 +2291,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 313>;
+			iommus = <&ipmmu_ds1 33>;
 			status = "disabled";
 		};
 
@@ -2303,6 +2305,7 @@ sdhi2: mmc@ee140000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 312>;
+			iommus = <&ipmmu_ds1 34>;
 			status = "disabled";
 		};
 
@@ -2316,6 +2319,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
+			iommus = <&ipmmu_ds1 35>;
 			status = "disabled";
 		};
 
@@ -2464,6 +2468,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vc0 16>;
 		};
 
 		fcpvb0: fcp@fe96f000 {
@@ -2472,6 +2477,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vi0 5>;
 		};
 
 		fcpvd0: fcp@fea27000 {
-- 
2.34.1


