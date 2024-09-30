Return-Path: <netdev+bounces-130287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121E989EED
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123EEB251B7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9018FC89;
	Mon, 30 Sep 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yAQRc8HP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8618BB8E;
	Mon, 30 Sep 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690160; cv=none; b=Z9ihHaBBzR0OEaMiHjYUqqbHerh8xd8gvBOeUsgImmjKnde3A2uon9L7Nho6FdAVNX1Vtay4b9k4l09lbq4HP/aVSCqPZM8WtOgGFTzbtUr55gmPhYORkD8rcnp3YB7F9624VwoYiYmgdVaQf5rpMVar45lBAS+ZUt4K4hFjHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690160; c=relaxed/simple;
	bh=MzmrBwu1Fix+SU8sQPxYff7k52zZhM+jjhB0qylmSjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjxJae/Lvh9NgX+gD1AuxJENwhhDkJAVBq2SMAbDnSs9tusWuN2p9J+Ng45pxpdNIM/8/tPRe/y9IQRj98A49Ap+TklSoFMkjwCil++WKG5qJ3fgmhV0hxlissZxPXdcTyZco5KEQ/pLg/IJCUDbfuMA8TVnnkwZN+cbJ7q5NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yAQRc8HP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690159; x=1759226159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzmrBwu1Fix+SU8sQPxYff7k52zZhM+jjhB0qylmSjo=;
  b=yAQRc8HPgBVH3oZnmoSjA6kK9Brz/I8YfYZIXVOomXGL6ezoD3ULmHGw
   SGmOY4OzFpa1PCA+kWfVYcfcsTPcw0Xha79hZWbFNGjbhhSuDU5tWvDBh
   HxFWl2N38ThOMwhTKqQRzpwjEEjraQRAORRZ84CZX7CQel6S/eI8R4VEQ
   XM2hP8Al+ECruISkVVqhL6/qDi6c1E/mNX92ZT7oeUSNXqcaUspZv2ztR
   tHKF2D9NPAKX4n+rWDaadnQwnidrbTkFWShi76bAJjCDRNCI0JtCXNx22
   /eYo3yY9kTcVKH5C5aNZTcCJnIo+3xGUVQQY9qyAm5rQcxwSRln4z0W5o
   Q==;
X-CSE-ConnectionGUID: jBRUFo6rTUOCd1OoCerG2A==
X-CSE-MsgGUID: eVglGcq4QZ++GPlewQWLCQ==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997913"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:32 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:29 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 12/20] dt-bindings: net: cdns,macb: Add PIC64GX compatibility
Date: Mon, 30 Sep 2024 10:54:41 +0100
Message-ID: <20240930095449.1813195-13-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX uses cdns,macb IP, without additional vendor features

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 3c30dd23cd4e..25ca7f5a7357 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -38,7 +38,10 @@ properties:
               - cdns,sam9x60-macb     # Microchip sam9x60 SoC
               - microchip,mpfs-macb   # Microchip PolarFire SoC
           - const: cdns,macb          # Generic
-
+      - items:
+          - const: microchip,pic64gx-macb # Microchip PIC64GX SoC
+          - const: microchip,mpfs-macb    # Microchip PolarFire SoC
+          - const: cdns,macb              # Generic
       - items:
           - enum:
               - atmel,sama5d3-macb    # 10/100Mbit IP on Atmel sama5d3 SoCs
-- 
2.30.2


