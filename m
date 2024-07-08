Return-Path: <netdev+bounces-109794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBE929F39
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C2728A073
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A8770E5;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E966F2E3
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431457; cv=none; b=Uo7hTKVQ7TEO6K6b78U4aGkH6aytqUmdAGwyFZNGEow0knAMYlyYu8w3KS4mt1bVgPyyxp+jBqPGIPIGai5pQnAOKqCix+KktyYCbbnFRNxiqEHnmG7N9UEyizz4/sxzzP+XTk5AZixaM0MX92UHh6KSHErytoDIKvni+SjBYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431457; c=relaxed/simple;
	bh=kNkctWVh1s7KzBOr2SkXjSb1nqSqfJ62U1TvxfjywhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oT5OM0GaEG1Ot8WXto4uANqToeoj3umWDE/bRgbHEWsJcLimG57n/EuJeCddUiWzWKIy4DJ9R6J+7YtNUcG0xMsl2iXYZa24fmmzgRMIWsmNUTClxCcXiIfIP5dERA50+iXYKhTX79FuMiPfNIEKLrjGxXn1ev9bTziKS55a7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by laurent.telenet-ops.be with bizsmtp
	id kxdS2C00n5NeGrf01xdSwX; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJV-Tk;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRy-RB;
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
Subject: [PATCH 08/12] arm64: dts: renesas: r8a77970: Add missing iommus property
Date: Mon,  8 Jul 2024 11:37:20 +0200
Message-Id: <41445bdf72a40c9deb36b88e8360b50eb2836919.1720430758.git.geert+renesas@glider.be>
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

Add the missing iommus property to the Frame Compression Processor
device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 64fb95b1c89ac63a..38145fd6acf024d9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -1092,6 +1092,7 @@ fcpvd0: fcp@fea27000 {
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
 		};
 
 		csi40: csi2@feaa0000 {
-- 
2.34.1


