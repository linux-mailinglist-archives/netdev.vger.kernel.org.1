Return-Path: <netdev+bounces-141054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3C69B9448
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB0B21584
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46811C9ECC;
	Fri,  1 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GHyfIKED"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BC1C760A;
	Fri,  1 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474457; cv=none; b=WKuE5E+FCBCofMoDZyHbNU5IpTgPw44s1H5BPV4fbIFJOketoJ5imh7S+94HR2psCSMl91oG4j50+hAysEGSdkXufHdM3vwuKC0GP9xKfzNft5ZdTMDQKwx3qnpPQ/jOti5UBEHtZzOEaOpZKW9QzzH1BZpNuCShRTLkOHo5ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474457; c=relaxed/simple;
	bh=uJk5zksfhouWGMoFsDHDsI8Z9+bLS8yFcfshC7rakqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv7MSECP+tdb4S7VDeZoZ8DFNHgrez6lToMQLDiumyLJ2gKVUHJKuo2mj8ifVT27BNp6xBX1wBLhjGB+Hy/FUoVojlsBH8TYovWJLbnRp8+eLQPgHdr7AJIQR/XMwmXDYeSgL+kqqbKJi0Kyf8/ad8BH75JiCETNsog8wk5aZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GHyfIKED; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730474448;
	bh=uJk5zksfhouWGMoFsDHDsI8Z9+bLS8yFcfshC7rakqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GHyfIKEDrY9ML7tc9WCoIGPV47OSQFh43C05dV6KkyoR6m2vo/doP7LNAIMTbDxM9
	 lchuGR8FMvGxcFHI67T8ePKCcrz/tgfjG2mAf416JOUKyR4DETOMlXjELTslVjtgxe
	 Ca1GmZ3hTnK3ZM1YU0FBUErPV8Ok5XVwuw36FTOJau+K0H1D3S+G8YKlSoiliNndN1
	 069IdUG0fbbInN/Lh7wR2N7uvDGxyRloossaANu+xllQPESC2rX2gEXaiEb+oE7PGe
	 e4IYfiDV9psVm5fQVqzYPNM0r/9DAxrslLtSPedoPpO51e8XuJmWP44buY9i75RHAB
	 AExaN4igeGs1w==
Received: from [192.168.1.214] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6298517E0F7A;
	Fri,  1 Nov 2024 16:20:45 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 01 Nov 2024 11:20:23 -0400
Subject: [PATCH 1/4] net: dt-bindings: dwmac: Introduce
 mediatek,mac-wol-noninverted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-mediatek-mac-wol-noninverted-v1-1-75b81808717a@collabora.com>
References: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
In-Reply-To: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

The mediatek,mac-wol property, as described, was intended to indicate
that the MAC supports Wake-On-LAN (WOL) and that it should be used
instead of the PHY WOL. However, the driver code currently handles it
backwards: setting up PHY WOL when the property is present and vice
versa.

In order to rectify the property's handling while still maintaining
backwards compatibility, introduce a new property to indicate that the
mediatek,mac-wol property should be handled as it is described, not
inverted, and make it required for new DTs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/devicetree/bindings/net/mediatek-dwmac.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index ed9d845f600804964e0000dd4354898673fafe08..0f20c4e09e79ff722d53a364825da29bd6323c31 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -125,6 +125,15 @@ properties:
       3. the inside clock, which be sent to MAC, will be inversed in RMII case when
          the reference clock is from MAC.
 
+  mediatek,mac-wol-noninverted:
+    type: boolean
+    description:
+      Previously the driver parsed the mediatek,mac-wol property backwards,
+      enabling the PHY WOL when the property was present, and vice versa. That
+      behavior is kept for backwards compatility, but newer DTs should specify
+      this property to have the driver handle the mediatek,mac-wol property as
+      it is described in this binding.
+
   mediatek,mac-wol:
     type: boolean
     description:
@@ -140,6 +149,7 @@ required:
   - clock-names
   - phy-mode
   - mediatek,pericfg
+  - mediatek,mac-wol-noninverted
 
 unevaluatedProperties: false
 
@@ -181,4 +191,5 @@ examples:
         snps,rxpbl = <1>;
         snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
         snps,reset-delays-us = <0 10000 10000>;
+        mediatek,mac-wol-noninverted;
     };

-- 
2.47.0


