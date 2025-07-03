Return-Path: <netdev+bounces-203591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAAAF67A3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4779E1C283F4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F381D5161;
	Thu,  3 Jul 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jgRSSGdA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411113635E;
	Thu,  3 Jul 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508153; cv=none; b=jLsUGzMf1S8OGM/xqPT3Gnt2MZexk3ZwPqf/hGtVhoD6Lrdawl66AcozzkjN1bZXMzlHae8oPLPlJHPNIChHyE77rRHwln2gvLdNmiexWxMFcprFg++3YWyrRz4/t8jKkMySlYiaDEZAhmQ5yQ+nO3hDkDYuDuoPEkqEbhuaKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508153; c=relaxed/simple;
	bh=Ivk9CmB5Xpl4qfnnkhGKgkFBDyv2dw7MCTAYbBqMzDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnAOlzekz1Sw07z+PTTlxzmnI52jf4HV9XbP/T7EdkSn9X7pntPQLvmaVdw0keGbSCXWmVvZrMhI1GJcW9bORdqDCXHSPcC9x8WV97hMgVpoect1A18NIviiMXiCsb3j6Xo366CQypfTJ1jvMeMsS9qvVdzBobzKKrtrcFUmfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jgRSSGdA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751508152; x=1783044152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ivk9CmB5Xpl4qfnnkhGKgkFBDyv2dw7MCTAYbBqMzDA=;
  b=jgRSSGdAr42F+OQH+Dx8ekV/+Pc1KRcSadxy1DrefvHk+z8v1KVqi1Uo
   TM202+kJP4FdqyDLQr1rQzptrO2dYcOX2n1nOY/lkalPkUvzkWGTYDiBo
   memTDh9huBjWnaSif/Vy5mOsLWZzuRqVmjB0Dq8YFvUzBHKKuGKE7LaOw
   MELYdXv1FjVTP6rbt1+SGNnDwcKlIulk5DtQivwPuYihKUUgunsl4rdqu
   uh+j9pbUEiCR0tmhEfJN+mPo0ZREakbg5dT5mpO+tURl/5O8JkuaflQXW
   Xtms7mNLEBNwPWGhjNF8knZMN3rsKvpuXIEfhOG/JMehLZDbki/iUmtKn
   A==;
X-CSE-ConnectionGUID: CQFyRSm3RYe0HuwgMRiJcQ==
X-CSE-MsgGUID: xQybPVw7SfmH9xYYKoXryQ==
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="274911714"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 19:02:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Jul 2025 19:01:53 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 2 Jul 2025 19:01:52 -0700
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
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
Date: Wed, 2 Jul 2025 19:01:54 -0700
Message-ID: <20250703020155.10331-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703020155.10331-1-Tristram.Ha@microchip.com>
References: <20250703020155.10331-1-Tristram.Ha@microchip.com>
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


