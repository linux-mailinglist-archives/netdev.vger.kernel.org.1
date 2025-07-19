Return-Path: <netdev+bounces-208301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D8B0AD4D
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848CFAC11BA
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323F81DE3C0;
	Sat, 19 Jul 2025 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="choytgcS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92115193079;
	Sat, 19 Jul 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888154; cv=none; b=N4ccW/AW/Lpee6yZMeMQIfvKXMBulGBYy6DXemw4voYMIT4nU0o55NlSPK4vzjdWJqWASBzaqKJGDJywC6V+2uTsUJv3O2ntnswvG88r/EuqCEnDx5igNN937irrgH2r8L4mZqjjm5+3sW/KE2flcbzv+eihkZ4zsL0sC2vGycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888154; c=relaxed/simple;
	bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5ENdyFzSXMnrJsudnnN5AhZsdbAGGe3DtKfOSbCcF9o41KXKDs3ITX4MzOCEywAIMgG3WTTEmDJZmvROg18voPUzWStHRsIRed0u9URhEGUEW7GLZFOlV6FJpMfF74AfKWzaiNHkvdayrpzbnB6HGKhuryxp+OtpjZf9TFGPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=choytgcS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752888152; x=1784424152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbHCZnjrkstbidgrzhyUGpiUbbGUAR3CtOOXEtfl+NM=;
  b=choytgcSsQAu+EwtFfv2DRwj2vqiXBIlF+tO4KqjsaXt0QAXzR8dya05
   KIisPJZLHYsQy6UQokw+W1ZeN2PYy4e7goRRCtY6RnddGQFehPK2VsaoL
   m4dH1R7UYYtdLc6F2CG6OMVE1CR10g5bLkthFy/oMA/h+KoZVFKly+Mbl
   mHIB3WWYzBb3SwRXpoGcF551YEwkYS/rKAfUnHQkjX09B0Pygjisr5kxL
   6F8QnJq2ycH5zsyN9adX6sXXqerfkKJmVUKrJG9AZ3j5gTD0QQre6zEip
   uBiSxtJAns+b5enbz1npa3Iy2LNxHz88JSN4aY1or36PjgZWIjVA0AzCm
   w==;
X-CSE-ConnectionGUID: ddxsHBV8SmSEFdelM5WBgw==
X-CSE-MsgGUID: dpV3D68aQjictR8ODwhYxw==
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="275554255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2025 18:21:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 18 Jul 2025 18:21:03 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 18 Jul 2025 18:21:03 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v4 1/7] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
Date: Fri, 18 Jul 2025 18:21:00 -0700
Message-ID: <20250719012106.257968-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719012106.257968-1-Tristram.Ha@microchip.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 switch is a 3-port switch based from KSZ8863.  Its register
access is significantly different from the other KSZ SPI switches.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 62ca63e8a26f..eb4607460db7 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -18,6 +18,7 @@ properties:
   # required and optional properties.
   compatible:
     enum:
+      - microchip,ksz8463
       - microchip,ksz8765
       - microchip,ksz8794
       - microchip,ksz8795
-- 
2.34.1


