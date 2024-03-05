Return-Path: <netdev+bounces-77406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4CF8719C5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A81D1F21F22
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615A52F68;
	Tue,  5 Mar 2024 09:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAA535C9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631715; cv=none; b=J1ix+H0x9s7ZPrRIHHoGSU/3HG0aaAV3aPPSSIV7plR/CiJO5YzpvMaCHPUDLOnCMzfa2DPhXkqgqT0kwe2gNzWKoKJ9kN+GUoxx+jKzXLX1HgnjXkoAnJTxIzCGXVUEu+cuD8c38558q5eWoqWSYsLi6S+Mf3QeoCCDEglxTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631715; c=relaxed/simple;
	bh=dMwgmbNGxOjzag43qzzaR5zBokKVeTOGOhp5Q6wizmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1+aHOMA9MqQ96l4erhqjxIozJWv1QEi+AshYbcSHHoTHppVzssYCLtwG9ijpDz+kll+JFHGOJjcAn/2/CJYOKWi9FUCb6MVHDiJQkTnAK6auzIgc0f+pRP5i0kKB6t2AfkanzYRMjSXOYqWclWrAuLTFgvrNpDZSjO2t27piUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([84.195.187.55])
	by laurent.telenet-ops.be with bizsmtp
	id uxhm2B00G1C8whw01xhmG6; Tue, 05 Mar 2024 10:41:51 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhREV-002PPO-Tg;
	Tue, 05 Mar 2024 10:37:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhREi-00BUN7-Ih;
	Tue, 05 Mar 2024 10:37:24 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Thanh Quan <thanh.quan.xn@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] dt-bindings: net: renesas,etheravb: Add support for R-Car V4M
Date: Tue,  5 Mar 2024 10:37:18 +0100
Message-Id: <0212b57ba1005bb9b5a922f8f25cc67a7bc15f30.1709631152.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thanh Quan <thanh.quan.xn@renesas.com>

Document support for the Renesas Ethernet AVB (EtherAVB-IF) block in the
Renesas R-Car V4M (R8A779H0) SoC.

Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 890f7858d0dc4c79..de7ba7f345a93778 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -46,6 +46,7 @@ properties:
           - enum:
               - renesas,etheravb-r8a779a0     # R-Car V3U
               - renesas,etheravb-r8a779g0     # R-Car V4H
+              - renesas,etheravb-r8a779h0     # R-Car V4M
           - const: renesas,etheravb-rcar-gen4 # R-Car Gen4
 
       - items:
-- 
2.34.1


