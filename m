Return-Path: <netdev+bounces-109796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6119E929F3B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F50B2387C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA756452;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11256BB39
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431457; cv=none; b=NdDFuhQiAP8j7IHIbfD5vQ6/qnBgW15C/uCEcmG0O0G1+rHLP6gGEhagYMFSwEer136UPyjwfs8p3SiW6+h6R3s7oEoOUABRpo+E0VUalKEnPIbhv2ZP+BCyLI2wAHFUSD/lU4zhPcFHg5W6BFoyt4A74K+ZBc7pxd78qTFMDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431457; c=relaxed/simple;
	bh=oqQEAb4/HNgbLVyXabPY1PW4jXWXVt1Dp577wl8mEmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E46DREetYWgbDiU+hSgPYQoffGHaaaRzbkPPKzyrFBasSjy5yOMSE7wWAYzwYS1aHmbk3LnqEwhML71F7MECfGYaCifIMvp5c6MDcJGH7bp1LMo/uW3ZtWsWNSFG56iShL4CLh6GvqumFkFpNunQAFd6lflZ/XXxB16dfrCZEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by michel.telenet-ops.be with bizsmtp
	id kxdS2C00P5NeGrf06xdS1g; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJN-Sa;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRo-Pv;
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
Subject: [PATCH 06/12] arm64: dts: renesas: r8a77961: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:18 +0200
Message-Id: <25f8764edcb4f83f4dc3acfae36fa1fcbfd10cd7.1720430758.git.geert+renesas@glider.be>
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
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index bf1130af7de39ce0..3b9066043a71e81f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2502,6 +2502,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A77961_PD_A3VC>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vc0 16>;
 		};
 
 		fcpvb0: fcp@fe96f000 {
@@ -2510,6 +2511,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A77961_PD_A3VC>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vi0 5>;
 		};
 
 		fcpvi0: fcp@fe9af000 {
-- 
2.34.1


