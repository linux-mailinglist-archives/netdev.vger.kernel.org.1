Return-Path: <netdev+bounces-204798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A01AFC14B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BDC1888E9E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E7235BE1;
	Tue,  8 Jul 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uKS6BymJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788F22837F;
	Tue,  8 Jul 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944747; cv=none; b=dlHTJhM/BvpkFwJBBifuRplT3CDG0icQOJ9b4i6TBvN1DlsRLH/jYVWI63bKMOgJaBbfh9nO8Igd+3c85BF0Hwnqi58OLp/NXGkNm7/Rzw/bM9yJSeVVAakeC4ktSk2PObAuKZnFB08Ofu5Lb3ybQyBXXRhA63tB0YVHzCcEr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944747; c=relaxed/simple;
	bh=Ivk9CmB5Xpl4qfnnkhGKgkFBDyv2dw7MCTAYbBqMzDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHkwYH19puxv6ZPSpyTk0lpadyDpgxwZh1R1l2xRoDPLxbtnMJRZCo05eep6tRMkFiVksU8dUDunrU6MD+xgxm6vJq7RzkRC6FboM8M/QvUudalT2MsoTd+R9tm2QD+m5xXPsUZnYwd4Banw+g3jbtee1++cgZkuzKcXL7GImFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uKS6BymJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944745; x=1783480745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ivk9CmB5Xpl4qfnnkhGKgkFBDyv2dw7MCTAYbBqMzDA=;
  b=uKS6BymJXOlsHSudK++uCzptsDj4HWOE3qtDV4MX1Gn7FzgPR8Ntka3E
   bXnyQQbu4sav369JEg6XjTA1CQpUZ3Ut39TjXoFPsL+Z7UkOMrN63g550
   +SxCaHkTLqKO6NQvYFG/OiBdPzPq7zbL+lqnxSXRPiGn3uBPczUdhQ2oZ
   kPSlgqtzckZcDgi4t5u9LnIkvsthWwKSQUJSCrDzjb2mWQiIPuDGE0xyo
   8+pkQpfkLbPm6fX8h4QvNbYn8JJmBBUvt7ob1rsQaMpCokTBW+IcLHMsM
   kK9MGaQCsDI7ZrPJuKMBS4B2wO2LJlQ/yXHtpsorOZfemrSYABenfq9ZN
   g==;
X-CSE-ConnectionGUID: 2pvk/woCRhK7m/XLenE80g==
X-CSE-MsgGUID: N4hF7oSFQg2/87pMFiWeXQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="43686943"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:44 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:44 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 1/6 v2] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
Date: Mon, 7 Jul 2025 20:16:43 -0700
Message-ID: <20250708031648.6703-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708031648.6703-1-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
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


