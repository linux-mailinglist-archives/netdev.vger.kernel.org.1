Return-Path: <netdev+bounces-234303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF78C1F224
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D571A2326D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94233A039;
	Thu, 30 Oct 2025 08:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506C339B5A;
	Thu, 30 Oct 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814254; cv=none; b=Y4Px3yGuNFMU4Fu8na8LnzLO9+NIboIhQmC9Uqjq00RnwdK9Ti4p22YS5lF0+ZSNbNj0t8FBuNG0Fkqqor18W5Vj1CM6ypo6vGNVDbbHdUTJX2aDs7hGo+wPSiZpc0p2KYtde48iG/+K8y7e9KpnBf6C3zpk3dPh7MxulOy2X3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814254; c=relaxed/simple;
	bh=XUfZfKj6nRnDkuEEJo5idgz9v20/kXJKRqv+Tvuh7ME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=otaagjP3xGB5YKdHFzwKSraReHtKkpBFLLTQdynLhqU0SAtSPO3v5eiecH/VFdFN0+jK8z/+3sVHwDXtsGkGnzyPlcK+4T3mwl7LJzhlRW/16cucniOn4ya0yAZy+6bh7x6j8LI+wheAzqdAUVxYgWbcOq+l11MXpXLjOmb8H04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgCHjmu+JgNpOMwJAA--.56198S2;
	Thu, 30 Oct 2025 16:50:08 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	jan.petrous@oss.nxp.com,
	inochiama@gmail.com,
	jszhang@kernel.org,
	0x1207@gmail.com,
	boon.khai.ng@altera.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: [PATCH] dt-bindings: ethernet: eswin: fix yaml schema issues
Date: Thu, 30 Oct 2025 16:50:01 +0800
Message-Id: <20251030085001.191-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCHjmu+JgNpOMwJAA--.56198S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45tr4DGry3tr13ur15Jwb_yoW5Wr18pa
	s7G39xJF1rZr17XayxK3W8KF4fJa9xCF4Ykrn7Xr1xX3Z0q3yvv3Wayry5Wa4UCrW8ZF45
	WFy5Cay0yFyUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRBOJnUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Due to the detection of errors in the eswin mmc module
regarding the eswin,hsp-sp-csr attributes in the
eswin,eic7700-eth.yaml file, the link is as follows:
https://lore.kernel.org/all/176096011380.22917.1988679321096076522.robh@kernel.org/
Therefore, the eswin,hsp-sp-csr attributes of the eic7700-eth.yaml file
regarding eswin and hsp-sp-csr will be changed to the form of:
items:
  - items:
      - description: ...
      - description: ...
      - description: ...
      - description: ...

The MMC,Ethernet,and USB modules of eswin vendor have defined
eswin,hsp-sp-csr attribute in YAML. In order to be consistent
with the property description of MMC,USB, I have modified the
description content of eswin,hsp-sp-csr attribute in Ethernet YAML.

Fixes: 888bd0eca93c("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")
Reported-by: Rob Herring (Arm) <robh@kernel.org>
Closes: https://lore.kernel.org/all/176096011380.22917.1988679321096076522.robh@kernel.org/
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 9ddbfe219ae2..91e8cd1db67b 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -69,17 +69,19 @@ properties:
     enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]

   eswin,hsp-sp-csr:
+    description:
+      HSP CSR is to control and get status of different high-speed peripherals
+      (such as Ethernet, USB, SATA, etc.) via register, which can tune
+      board-level's parameters of PHY, etc.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - description: Phandle to HSP(High-Speed Peripheral) device
-      - description: Offset of phy control register for internal
-                     or external clock selection
-      - description: Offset of AXI clock controller Low-Power request
-                     register
-      - description: Offset of register controlling TX/RX clock delay
-    description: |
-      High-Speed Peripheral device needed to configure clock selection,
-      clock low-power mode and clock delay.
+      - items:
+          - description: Phandle to HSP(High-Speed Peripheral) device
+          - description: Offset of phy control register for internal
+                         or external clock selection
+          - description: Offset of AXI clock controller Low-Power request
+                         register
+          - description: Offset of register controlling TX/RX clock delay

 required:
   - compatible
--
2.17.1


