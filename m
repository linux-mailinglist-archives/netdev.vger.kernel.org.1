Return-Path: <netdev+bounces-109787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECD929F32
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704A4289BE4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0553362;
	Mon,  8 Jul 2024 09:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE346F2E3
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431450; cv=none; b=FRrnic7JMTcr4er6T5H6jYKPAut6yJFlIZZB3Wk3zEbswxIJ3tS0xqj+qwHM5WYvfJmA9l1z7+B5tw03LrQVDbmkafah46qeoODR7aMdZUll5ySt9ysB9NfuA5v/zhS4FDS+PAGfQmUBPzkWK7VPc2BRs6LrAvFFbh0rtr7Lank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431450; c=relaxed/simple;
	bh=XhaBg4Pzx/zQW7qpYBnh04cvI3on0SEg4Dwpa9eNOJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slNT+EOBLgi2yMRRgcz84QKIHyUthu/Dih13OHKpma1X7b82NKrhP931cc9wjrKVItHehQVAOGNm2bSVJwK1rSBsoAHFRxis2xcAXrakTRNgk5tj/OEmLJ+kHFVB5HJsuuGA2JBVRh10kzInPeQsiBBeYmhNU3jHQ/YybG0qas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by andre.telenet-ops.be with bizsmtp
	id kxdT2C0015NeGrf01xdT9L; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJh-Vt;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RSD-TP;
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
Subject: [PATCH 11/12] arm64: dts: renesas: r8a779g0: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:23 +0200
Message-Id: <bd394a7e330610d76d98cd5d230c0b3fcbf5c3e4.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all EthernetAVB and Frame Compression
Processor device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 53d1d4d8197af5dd..d6770d3d488b833a 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -815,6 +815,7 @@ avb0: ethernet@e6800000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_hc 0>;
 			status = "disabled";
 		};
 
@@ -860,6 +861,7 @@ avb1: ethernet@e6810000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_hc 1>;
 			status = "disabled";
 		};
 
@@ -905,6 +907,7 @@ avb2: ethernet@e6820000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_hc 2>;
 			status = "disabled";
 		};
 
@@ -1987,6 +1990,7 @@ fcpvd0: fcp@fea10000 {
 			clocks = <&cpg CPG_MOD 508>;
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
 			resets = <&cpg 508>;
+			iommus = <&ipmmu_vi1 6>;
 		};
 
 		fcpvd1: fcp@fea11000 {
@@ -1995,6 +1999,7 @@ fcpvd1: fcp@fea11000 {
 			clocks = <&cpg CPG_MOD 509>;
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
 			resets = <&cpg 509>;
+			iommus = <&ipmmu_vi1 7>;
 		};
 
 		vspd0: vsp@fea20000 {
-- 
2.34.1


