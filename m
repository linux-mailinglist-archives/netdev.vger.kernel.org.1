Return-Path: <netdev+bounces-288815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM7MBLd3Cmo61wQAu9opvQ
	(envelope-from <netdev+bounces-288815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516556503F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2894B3018AF8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565A32AAB5;
	Mon, 18 May 2026 02:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F131F988;
	Mon, 18 May 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070867; cv=none; b=i7NK9/+4Lye2Fgy3tbk2+9VSGa/j0OzziWrQnxpc5w2aZQSUO9xJEdvOR+298kXKVb3dNJHWLgoaUVUEn0K2XGZTrm+sa4xha/aJY1CldQ+DOHz3C0m02gUtUGZOrdaHI+iqFHVBogPOPdvp1OPVPqOi2qNU//9hTJ71+z1MQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070867; c=relaxed/simple;
	bh=8wSSop0nuTrl3WI5eKe5CmTNDsY02ZHSlSmRDxigxu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgvU4sMl+tDGTDLsRyjPun+3t3sHj5PiYm5LlDi+eD9kaekQ9LZ1ZQWCPnSNG0z6P6iYhIqJ63Y1X0iG5x2F5nMdN7TH0QtWjJmPSAWLVLf80i9hLXVj1rrzodIVM5UE5aFWq86C2uYQ4tmLVEef84dPSdCb2mNsjCiU/Og4ONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgCHG3BqdwpqrU0aAA--.255S2;
	Mon, 18 May 2026 10:20:27 +0800 (CST)
From: lizhi2@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net v2 1/5] dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets
Date: Mon, 18 May 2026 10:20:23 +0800
Message-ID: <20260518022023.427-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260518021919.404-1-lizhi2@eswincomputing.com>
References: <20260518021919.404-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCHG3BqdwpqrU0aAA--.255S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3ZF1DWr1UZr17WFW5Awb_yoW5GF45pa
	95C3y7GFn5Xr13Wws3J3W09F1fXFs3GFy3Crs7trnrXrn8Xa4YqwsxKw15W3WUCrWxZFy5
	uFya9a1ru34qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 6516556503F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288815-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,eswincomputing.com:email,eswincomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Zhi Li <lizhi2@eswincomputing.com>

Document two optional cells in eswin,hsp-sp-csr for the TXD and RXD
delay control register offsets.

These registers are used by the driver to clear any residual delay
configuration left by the bootloader, ensuring that MAC-side RGMII delay
settings are applied solely according to the kernel configuration.

Add a reference to the EIC7700X SoC Technical Reference Manual for
background information about the HSP CSR block.

Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml  | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 91e8cd1db67b..b66ae6300faf 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -73,6 +73,15 @@ properties:
       HSP CSR is to control and get status of different high-speed peripherals
       (such as Ethernet, USB, SATA, etc.) via register, which can tune
       board-level's parameters of PHY, etc.
+
+      Additional background information about the High-Speed Subsystem
+      and the HSP CSR block is available in Chapter 10 ("High-Speed Interface")
+      of the EIC7700X SoC Technical Reference Manual, Part 4
+      (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf). The manual is
+      publicly available at
+      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases
+
+      This reference is provided for background information only.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
@@ -82,6 +91,8 @@ properties:
           - description: Offset of AXI clock controller Low-Power request
                          register
           - description: Offset of register controlling TX/RX clock delay
+          - description: Optional offset of register controlling TXD delay
+          - description: Optional offset of register controlling RXD delay
 
 required:
   - compatible
@@ -116,7 +127,7 @@ examples:
         reset-names = "stmmaceth";
         rx-internal-delay-ps = <200>;
         tx-internal-delay-ps = <200>;
-        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
         snps,axi-config = <&stmmac_axi_setup>;
         snps,aal;
         snps,fixed-burst;
-- 
2.25.1


