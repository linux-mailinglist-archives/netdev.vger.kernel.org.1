Return-Path: <netdev+bounces-109789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571EB929F34
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1328D289EC5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F05381B;
	Mon,  8 Jul 2024 09:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F6BB5B
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431456; cv=none; b=pThdcs4TkC2m1OzFg6H4q7bDQA4Cx/OlMxiqu+SfYoeNkGGYM9Y7bkVwyrYLcM5zBJTZ7nIusCQYP0Hj5pjLu6mm00zkSrA3ZDPf3MyhCjISQRqIYP1xgz7QNUAdnVyfHeGiOpSVzI+5tvHoVP4KWJQiYQJcA0+MT0w1Mzy2U7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431456; c=relaxed/simple;
	bh=nE5sZvjwG3cVZEeDS6eFA9WLOFuwjzZgJSHCooMkEpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDrITNmTfj3FiYoajw8b10nAIXhzHaencoerEruSUwUe1lowMAUMdtWYoXLx7npocM0adG4PLNXsKs9BrR3QGwvdltZt3JgWhwxel5WrGbjAPeO+vW/8+YlEcigO5mkGPSEzEOHk0MgmIB71H7afB4iKjL0YRInyrUQLXCFtml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by michel.telenet-ops.be with bizsmtp
	id kxdT2C0035NeGrf06xdT1i; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko7-001PJm-0V;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RSK-U7;
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
Subject: [PATCH 12/12] arm64: dts: renesas: r8a779h0: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:24 +0200
Message-Id: <1ed05b12961662e8fed2f1a6790f5ae3b595f509.1720430758.git.geert+renesas@glider.be>
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

Add missing iommus properties to all EthernetAVB device nodes that still
lack them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index 1267a9790ec0610b..0124e682b248188c 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -769,6 +769,7 @@ avb1: ethernet@e6810000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_hc 1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -817,6 +818,7 @@ avb2: ethernet@e6820000 {
 			phy-mode = "rgmii";
 			rx-internal-delay-ps = <0>;
 			tx-internal-delay-ps = <0>;
+			iommus = <&ipmmu_hc 2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.34.1


