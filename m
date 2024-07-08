Return-Path: <netdev+bounces-109788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE78929F33
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871CA1F22B55
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7D61FCF;
	Mon,  8 Jul 2024 09:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE006F2E2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431451; cv=none; b=D1fnQxOlbFiu4c54QEf92dSWyO8WHayLP87SrIgX6b/FvduUUYTcfA12vMu90rppnXN/IPptYNXhSde8IRvQg6uFY3t9wkHaiMl0Dfjlu8X61kYLBBfjFfmWVxhr+pjMb0iupF0DkM1e+OmjSouxpNSd29D1Wx0qstblqe5A8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431451; c=relaxed/simple;
	bh=4oagJWISEzadUZIq6IhZE2uTNFZ35ob5BVNVEki6y6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbXgpgsoCWPXN2V8kw/gCK6pvQ+xfN4nI9iIwZIJcZOzlcABpXVtK3F2AIawD8rA11QEN2KM/wtT+r3oQzqOfYYWcSJRd1UrNoIQ9carT/VQ+5Zi2hJq8wtoc9QoPHwjlrY4bMZQ+FXPe8XUSmvwWquqqGv0mmLHJ/8284zFtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by andre.telenet-ops.be with bizsmtp
	id kxdS2C00L5NeGrf01xdS9K; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJB-Qz;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRg-Oi;
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
Subject: [PATCH 04/12] arm64: dts: renesas: r8a774e1: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:16 +0200
Message-Id: <b2a1a5fd41c78c881e6e410b720e5e12572e2668.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all Frame Compression Processor device
nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 1eeb4c7b4c4b9282..f845ca604de0696e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -2652,6 +2652,7 @@ fcpf0: fcp@fe950000 {
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 615>;
+			iommus = <&ipmmu_vp0 0>;
 		};
 
 		fcpf1: fcp@fe951000 {
@@ -2660,6 +2661,7 @@ fcpf1: fcp@fe951000 {
 			clocks = <&cpg CPG_MOD 614>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 614>;
+			iommus = <&ipmmu_vp1 1>;
 		};
 
 		fcpvb0: fcp@fe96f000 {
@@ -2668,6 +2670,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 607>;
+			iommus = <&ipmmu_vp0 5>;
 		};
 
 		fcpvb1: fcp@fe92f000 {
@@ -2676,6 +2679,7 @@ fcpvb1: fcp@fe92f000 {
 			clocks = <&cpg CPG_MOD 606>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 606>;
+			iommus = <&ipmmu_vp1 7>;
 		};
 
 		fcpvi0: fcp@fe9af000 {
@@ -2684,6 +2688,7 @@ fcpvi0: fcp@fe9af000 {
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 611>;
+			iommus = <&ipmmu_vp0 8>;
 		};
 
 		fcpvi1: fcp@fe9bf000 {
@@ -2692,6 +2697,7 @@ fcpvi1: fcp@fe9bf000 {
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A774E1_PD_A3VP>;
 			resets = <&cpg 610>;
+			iommus = <&ipmmu_vp1 9>;
 		};
 
 		fcpvd0: fcp@fea27000 {
@@ -2700,6 +2706,7 @@ fcpvd0: fcp@fea27000 {
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		fcpvd1: fcp@fea2f000 {
@@ -2708,6 +2715,7 @@ fcpvd1: fcp@fea2f000 {
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
 		};
 
 		csi20: csi2@fea80000 {
-- 
2.34.1


