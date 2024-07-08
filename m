Return-Path: <netdev+bounces-109790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A0929F35
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11261289EF2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077556F2FE;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25139FF2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431456; cv=none; b=PNt0XyYBoCfAbhB5tqzeJHy5j0LQFZ/EwF6KZ7rxfnYbWEd77ap87c3YemwzXudVemoy7Q3UXA9GY1CFOOY0xaxqWfoAe1aJrcGP046R1AVdOa1aj7p/+Xq7/bfWBryOa95SFLEDvEKj2rFlAkqHS9Njozb/FJm7k/4UpCAcjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431456; c=relaxed/simple;
	bh=4Pk4Lpp5XZxjbh0d8tvpymghFGt5K4wlY+sOrUfjWlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLR9I0bmdFAuMbNaB6hRHmeE5sIybrgzGdy/yKMysZlQJQIuZJqId+XOPfA51wB3Xg0/mmsXGote9uy4vEzoHGNl0SQlDjpaYMh7Kog3KLHykrE2beaT/iMh/4Fi0AZRaec+IztRDbBJa+s6OPtAOwVZKQEj9YK3y+lMMdbiFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by baptiste.telenet-ops.be with bizsmtp
	id kxdS2C00G5NeGrf01xdS0k; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJ9-QN;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRc-O1;
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
Subject: [PATCH 03/12] arm64: dts: renesas: r8a774c0: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:15 +0200
Message-Id: <299b47bf40d4d2d44beff46b3323c471915c714d.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all SDHI device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 3e2af50ce7c64bef..7655d5e3a034166e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1637,6 +1637,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
+			iommus = <&ipmmu_ds1 32>;
 			status = "disabled";
 		};
 
@@ -1650,6 +1651,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 313>;
+			iommus = <&ipmmu_ds1 33>;
 			status = "disabled";
 		};
 
@@ -1663,6 +1665,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
+			iommus = <&ipmmu_ds1 35>;
 			status = "disabled";
 		};
 
-- 
2.34.1


