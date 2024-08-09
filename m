Return-Path: <netdev+bounces-117044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2A94C7BB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8151F25EDC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DD8BEA;
	Fri,  9 Aug 2024 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AD5MQ0mk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6A2900;
	Fri,  9 Aug 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164226; cv=none; b=UqHRhZFVbj1zhRD3d19KyFgbb74mWrYJHv7bs+dKenK/B+2ejNMf8dzSjFseOIR0mTSv5AzSybffbl4mdsls+8FfAHX3W0bBK8O5sE7HMglzdzPXhF44E0wbemABY9p0YbUUv7vcbat2LcpqbK3bEOj87TFuFKTwHvOT+7fhcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164226; c=relaxed/simple;
	bh=Mgs1lNnhWggFlDV9vg7amh0jKUngzBpu0PzJAxQ4z4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOH9f0XVUwBlp4i+R2ACSaDfvIpLcHaxiJRGurRPU5jIaADcipXdrhuCdWoUOx/OdhACEkUH2M3VZTmneTthWkq0s34g+CwPBevdEORJnBqqZe/9XiAQA9BpWm2O8BqgM8RGpw4WPupWDoJVXltw4SItJTby+aBSXV2FE0k442g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AD5MQ0mk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723164224; x=1754700224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mgs1lNnhWggFlDV9vg7amh0jKUngzBpu0PzJAxQ4z4E=;
  b=AD5MQ0mk8jdHOfMdtA8v4N/1B3CDMjtxNdL9rsj7JnhTRAMUnx5VcPQ/
   EaGeaLJJ+kl4o9LMNIUDK/mTszyoZm6jRJ6mSRx41SfbUuULFr6Uf89YQ
   1//sCuZdc2UX9w5pSIMKQ+L0T2PkVwlEuYqWtRZSp+tJyI66jVj1SYFoW
   QK/4SIrDQQuDbdkfoZncXyup6PMji8zA5Fly66G4z+uj0vAIq//Cs4ITa
   2CUPux3bpiGOSqGKy0untMZ4fTEFQdwCknKyTIB0FQm8OynbN3YxZgHDD
   dKvoP1QzacmM1xEN1BMfeJEjTQV0QZ9WjfugpvDyxrDuJc8Xt0vk57c33
   Q==;
X-CSE-ConnectionGUID: +8j0qFodS5iV1GC4lWtiSA==
X-CSE-MsgGUID: Fr1ODLI0QVWZlDv3tnK3IA==
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="30947694"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 17:43:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 17:43:11 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 8 Aug 2024 17:43:11 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Thu, 8 Aug 2024 17:43:09 -0700
Message-ID: <20240809004310.239242-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809004310.239242-1-Tristram.Ha@microchip.com>
References: <20240809004310.239242-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
KSZ8863, so it shares some registers and functions in those switches.
KSZ8895 has 5 ports and so is more similar to KSZ8795.

KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
while port 5 remains as a host port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..bbd6fd9e6894 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -21,6 +21,8 @@ properties:
       - microchip,ksz8765
       - microchip,ksz8794
       - microchip,ksz8795
+      - microchip,ksz8895	# 5-port version of KSZ8895 family switch
+      - microchip,ksz8864	# 4-port version of KSZ8895 family switch
       - microchip,ksz8863
       - microchip,ksz8873
       - microchip,ksz9477
-- 
2.34.1


