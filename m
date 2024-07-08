Return-Path: <netdev+bounces-109797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98968929F3D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CF2B23C5E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B362E6F2E2;
	Mon,  8 Jul 2024 09:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3B53362
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431458; cv=none; b=uQMIvoS1EgE2JrDmA1hpKUJ3wtgdU/oF98h7dzS2bWJJyM/oE8by1aELWFvavIuyTRkrWvF4iV2XZCw3dswQoxBBt8i/1vm1LLvvTIazEirkvi7WwtR2pTHFqQrS0O37g2Uw/8+a5pmeE0T3De2IBF1bW67I5sREH+nXyPt6gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431458; c=relaxed/simple;
	bh=/g9rQn+6o81xUz8RkctxGmJiehaKbMzNmyHIFCwEw3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wm+KzFqLjpg6c8R3pDFU/kcc7y0nFBpqQAmG4VBs9JHPEq/vpxaFDMaeDWPmoiYjvVlcahlv+b6pjIMU+dS7ICF1Gr1ljhkLTQTaXISa9CBobLtxWyhD4IjPjo3I/9WJQ+hfKAoVDjCNrTNQkmas0XKgCJc2VFZS9LmhSCubgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4WHfDG4Zz0z4x0tZ
	for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:37:34 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by albert.telenet-ops.be with bizsmtp
	id kxdS2C00f5NeGrf06xdSi3; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJH-Rn;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRk-PI;
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
Subject: [PATCH 05/12] arm64: dts: renesas: r8a77960: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:17 +0200
Message-Id: <21e6b8dc21d8f1605d1cf5f081811b55e33ce04d.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to Frame Compression Processor device
nodes that still lack them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77960.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77960.dtsi b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
index 1122c470b72f8715..ee80f52dc7cf456a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77960.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
@@ -2652,6 +2652,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A7796_PD_A3VC>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vc0 16>;
 		};
 
 		fcpvb0: fcp@fe96f000 {
@@ -2660,6 +2661,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A7796_PD_A3VC>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vi0 5>;
 		};
 
 		fcpvi0: fcp@fe9af000 {
-- 
2.34.1


