Return-Path: <netdev+bounces-113351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C993DE28
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D741F222C5
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3565481B7;
	Sat, 27 Jul 2024 09:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-117.mail.aliyun.com (out28-117.mail.aliyun.com [115.124.28.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A195FEE6;
	Sat, 27 Jul 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072350; cv=none; b=SgaXEOfP/OCqX1/koSRHyZaOAPIl8R98gj8NwZGIz3D9JPyAeS+EVyTeZ19eL3L65ldwwI4zmhAgE4o31nYU5/XQld5yiblL+HFSrgkIBeUQSXst0v4Lyk7et0B/j7i4CB8gIY9Im/8knv2uTJiaxH6xcIr2btwOKYoGWAfedwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072350; c=relaxed/simple;
	bh=GIaQaR4MoMMps+eeCrgXSkOgKHHqzpEvFFzG9ao4lwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5ZaAUPdaBqX6fBWcpCChmGgN2F7hgfZ9JEKRfCT5NFEhcNcT0c8RQfWhlfLrOlSmJNPKzZr4fIdzQPDzkV9XE5e+K9U+W9l3X7HVpMZELQB9la8yhna7O/kLzQofNGe44L/pEwooEBflPzLDw/l/QcWpVhtdus8QShjiGHfrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1290324|-1;BR=01201311R161S60rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0112291-0.00128819-0.987483;FP=4814649912190311895|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045207070;MF=frank.sae@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.Yb6Zy98_1722072011;
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Yb6Zy98_1722072011)
          by smtp.aliyun-inc.com;
          Sat, 27 Jul 2024 17:20:18 +0800
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
Date: Sat, 27 Jul 2024 02:20:09 -0700
Message-Id: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 The motorcomm phy (yt8821) supports the ability to
 config the chip mode of serdes.
 The yt8821 serdes could be set to AUTO_BX2500_SGMII or
 FORCE_BX2500.
 In AUTO_BX2500_SGMII mode, SerDes
 speed is determined by UTP, if UTP link up
 at 2.5GBASE-T, SerDes will work as
 2500BASE-X, if UTP link up at
 1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
 as SGMII.
 In FORCE_BX2500, SerDes always works
 as 2500BASE-X.

Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
---
 .../bindings/net/motorcomm,yt8xxx.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
index 26688e2302ea..ba34260f889d 100644
--- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
@@ -110,6 +110,23 @@ properties:
       Transmit PHY Clock delay train configuration when speed is 1000Mbps.
     type: boolean
 
+  motorcomm,chip-mode:
+    description: |
+      Only for yt8821 2.5G phy, it supports two chip working modes,
+      one is AUTO_BX2500_SGMII, the other is FORCE_BX2500.
+      If this property is not set in device tree node then driver
+      selects chip mode FORCE_BX2500 by default.
+      0: AUTO_BX2500_SGMII
+      1: FORCE_BX2500
+      In AUTO_BX2500_SGMII mode, serdes speed is determined by UTP,
+      if UTP link up at 2.5GBASE-T, serdes will work as 2500BASE-X,
+      if UTP link up at 1000BASE-T/100BASE-Tx/10BASE-T, serdes will
+      work as SGMII.
+      In FORCE_BX2500 mode, serdes always works as 2500BASE-X.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [ 0, 1 ]
+    default: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


