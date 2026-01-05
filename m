Return-Path: <netdev+bounces-247007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB0CF36E5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 415CD3009D68
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D0338F4A;
	Mon,  5 Jan 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxbHD1eT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756E332915;
	Mon,  5 Jan 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614930; cv=none; b=thklm6zuNvze7PpwZPeWP2DEbcmRZn8wdg2CITKd0/VAi4lOvPuHpE424j9U64u2NSAI32h0v/5at91QZRM50LEAoAY2JimnuDT/LzP6+Ovm2TTaE6yuY3PF1KjBXLThooat3BYhJT3b3mJSz3h8rtDypl4WGIp/WcIhmSHTYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614930; c=relaxed/simple;
	bh=eYjmO4/KcUuQSAgS/pqGfLZtRf+t9bOtnePit3tibMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nor25jdZTKZmkHlSDzxR8NHxnsNyrKpKBbFDTFcJr33Qpc9zwK6xuMvipyRJs4yJUYHgJr696BCCQCdFwyyKr6uIoyyJE3/9jUHydBWrXr0OC21ettt3t5XRny6zHNloqsTSfuh/u2AUnbeDZZ86RtGZBX+OAuyxI1ABZhx1meI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxbHD1eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E411C19423;
	Mon,  5 Jan 2026 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767614927;
	bh=eYjmO4/KcUuQSAgS/pqGfLZtRf+t9bOtnePit3tibMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SxbHD1eTJ4owNlGjsW70TBjverDtGr56WE31xriIvnnry3XEZ3jcSh1E7VHVrSbkA
	 +/DfAHvV95XS+zfBGK3Bvcq4ns/5fTKJXBZPK0Z1go+3wmJsAA8ZiLlvC4YizCF0A3
	 pVnEDTxl1wiyzm0xrzSNVWgbL9DCM0hCov0VPr1cVA6c7VJ3p3XDl3Y0sDF/omnMqB
	 mpX73gC6HT5rVbudQywidJHdaGIdV7JXL5TByhnKc3B1XXj/T5mZEKcYuJE/3z9ys2
	 ebBnDiwijtOmjFUZX/xdME8E1MLJSJSzOp8XC+4wG7Id6DpEu/xeHwoZW0P0ySXe38
	 BFFYmySrx34mg==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Mon, 05 Jan 2026 06:08:22 -0600
Subject: [PATCH v2 3/3] dt-bindings: net: altr,socfpga-stmmac: deprecate
 'stmmaceth-ocp'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-remove_ocp-v2-3-4fa2bda09521@kernel.org>
References: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
In-Reply-To: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=eYjmO4/KcUuQSAgS/pqGfLZtRf+t9bOtnePit3tibMs=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpW6nFGDEllWKa5yDVYKLtEHySPlbck9AIb35oX
 E72YoMUWMGJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaVupxQAKCRAZlAQLgaMo
 9MKRD/9Yk152YGHFJ8AKQitkuaNlY1VXWKWvxwWHopFkr8fWGmHO4yFMObHdCmZXPBn4TRaf7kR
 yO4LdO1avjGMUPAIrQClArlZYlTM2htGT1OWhBRNFtMJzrLgbycBXZRgG8hSEol9sLKUqnIza5H
 9YAokKctmMLwhKKTNua0unbOJkKHlzOTbxzn/AksmJIuO+q53wg8dQ/l7rwvkkSPNgDvE7AqSyv
 5/jnJHWPpu4iHqJr38V5EPPSsZTolcZB0bDhR1FzivhwyOUDVsqKT1Cl8tehrsmAsgUNWg4ge+p
 OmB5TIquALO7ykX967taXm4psv808EROVI6WpI0VnoQt2KpowZHRxVmlUXuR0etN+VK5B+p9FRl
 s3QDVue004RHuNUNWvwc7VO859aQN1a9MzK50OhvRLWi58/4//qP+INhEwU8VNT9NVYe6q+LGUQ
 ha00k0Ah1372Rkre6IUwDdurhNWM98ugq9QXYhLI5uQXwPib1wrF7Q2PLMT4+mEiJ2ZYiudKlyP
 OApm/7M8mMUAl6AUZbOGM89xFr+f5kwachzy6oIeXxR1ybOMGkMtssUCwHgnM3OaoED74d7sNTG
 EfDHwEMyUu/dz1Wj1oLi0ed5h+Fse58bn6vqbsSgYVXF4aGCRksoENoVXRT7HXIpWgGae70ET9H
 ulRcXdkmUjDj2bA==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

Make the reset name 'stmmaceth-ocp' as deprecated and to use 'ahb' going
forward.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index fc445ad5a1f1..4ba06a955fe2 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -13,8 +13,6 @@ description:
   This binding describes the Altera SOCFPGA SoC implementation of the
   Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
   families of chips.
-  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
-  # does not validate against net/snps,dwmac.yaml.
 
 select:
   properties:
@@ -84,6 +82,15 @@ properties:
       - sgmii
       - 1000base-x
 
+  resets:
+    minItems: 1
+
+  reset-names:
+    deprecated: true
+    items:
+      - const: stmmaceth-ocp
+    description: Do not use 'stmmaceth-ocp' going forward, please use 'ahb' instead.
+
   rxc-skew-ps:
     description: Skew control of RXC pad
 

-- 
2.42.0.411.g813d9a9188


