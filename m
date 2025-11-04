Return-Path: <netdev+bounces-235390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21792C2FA1F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 028E74E58C3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D063081C4;
	Tue,  4 Nov 2025 07:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BE3074A0;
	Tue,  4 Nov 2025 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241658; cv=none; b=UX0a649fzXy7Oqd98uWhPG4muCl6xPpAp1foJ09I5jW+4i/+Ku41SUjYNtFGBW0NcHc3M5aSScuoanoazwZLNUz6NOUMCP9ekg2hzq4gC1OWrHKv4qBYjpAUVzpiOPvSjrKNEwzzRCTWK3n6WghO/myLJiE+KKu8M2RtwuT1evQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241658; c=relaxed/simple;
	bh=3M5g02GMT8gIsSyLWIEsXjrXCwaBqARzDUov8wR/+jI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IH6x/a3kDu+p80VUjZ2AW2zp08YXoHfBHig+ygnwE2KzqfeQHFggBxaNMpdCF5nEk1DSGFRsmWzxitkyHUEEt/5y3iuwVYflkq/HxhlC6W/+jWhrrF+lmGBsJyvEUDHLBBZjrQdwRiU8tc9T6oLB9AoWXiz8v+nP7+HfTtYqpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgD3_ms2rAlpBb4iAA--.8731S2;
	Tue, 04 Nov 2025 15:33:12 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v2] dt-bindings: ethernet: eswin: fix yaml schema issues
Date: Tue,  4 Nov 2025 15:33:05 +0800
Message-Id: <20251104073305.299-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgD3_ms2rAlpBb4iAA--.8731S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy7tryrWw4fWw15GFy7Awb_yoW5Xr43pa
	s7G39xJF1fZr17Xa18t3W8KF1rJanrCF13GrnrXw1fXwn0q3y0q3WayryrGa4UCrWxZFWU
	WFy5CayFyrWUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

eswin,hsp-sp-csr attribute is one phandle with multiple arguments,
so the syntax should be in the form of:
 items:
   - items:
       - description: ...
       - description: ...
       - description: ...
       - description: ...

To align with the description of the 'eswin-sp-csr'
attribute in the mmc,usb modules, the description
of the 'eswin,hsp-sp-csr' attribute has been modified.

Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")
Reported-by: Rob Herring (Arm) <robh@kernel.org>
Closes: https://lore.kernel.org/all/176096011380.22917.1988679321096076522.robh@kernel.org/
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
Changes in v2:
  - Simplified problem description
  - Add a space after the commit ID
  - Add subject prefix
  - Link to v1:
    https://lore.kernel.org/all/20251030085001.191-1-weishangjuan@eswincomputing.com/
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


