Return-Path: <netdev+bounces-263349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cj03Jucjp2mrewAAu9opvQ
	(envelope-from <netdev+bounces-263349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:09:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF11F507E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90CC9315D130
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19B351C25;
	Tue,  3 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W437R3O0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2E37703A;
	Tue,  3 Mar 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561085; cv=none; b=EB4NaECe4Cu+IzUDxSM/VDlvKJPSLG2SFnA0rmf6dUF1UqC9nAaWD5j7dCgwFbpTrCPX0cIJXq2nMvGafqqiADokkFLnr1u986jYzv1cauvKdFIxZYaXAJBniVKoXJ3K0PxL7L+IIOpc3e4xG/JW5g0584Ii/ziuAcbdCbZ5+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561085; c=relaxed/simple;
	bh=g3fSJ4nyyCP2XBDrOADHU5vpGMsdP/J5+NVWogUdb1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzCifF5/iImXP2i98eYJ+9P87yVgBENkx5H5mmfU9PsTr1N93MES/mVLkccea5TjPCyFy0OeTwFsJJVHRwXDHqbFuSXrqnevyJp5tXjTEs8OSITB3pF8o4kIDYmKj6vlZaDkfaMXwn/V3pSkPiGr+OOm6W+iCjGCzcnHDXefIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W437R3O0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772561084; x=1804097084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3fSJ4nyyCP2XBDrOADHU5vpGMsdP/J5+NVWogUdb1s=;
  b=W437R3O0U5wt67yVzpjkhloS0QoQiGQ5984kEBRHS+wwHELNaySOUdNs
   6QBdij23x7X6VIJDiajixh5PnYPYMflmpgEkyEJIFWswJoeuQwoQx1tBm
   tc3Rjahi60hIf57wOT8xTmRH/bBoR0AsxTWYDxQ0FA37OIJVPtjI9ZTRZ
   ebG2bODSIWVPYN4iJRSfGMu10HpJ2OanXExOLFvoFXQd3rd4h1K8lsEf0
   e5Ya8Ej2Vs8l2P0lBBdChAHL+Tpt/YCxUx1Qg0jwzZ+BIGE992VOHbD7w
   MH8MWZy2s1q4BF5IWzUwH9KXW5qol6WKEpx8RkWbbrq+6VMBQsTsxAINd
   w==;
X-CSE-ConnectionGUID: GMMSakTvRG+HtI9KzbPdDQ==
X-CSE-MsgGUID: dwFoa6vIT5KAcl3hWKOj1A==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221432060"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 11:04:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 11:04:15 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:04:15 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/4] dt-bindings: net: cdns,macb: add a compatible for Microchip p64h
Date: Tue, 3 Mar 2026 10:03:15 -0800
Message-ID: <20260303180318.1814791-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303180318.1814791-1-charles.perry@microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 17BF11F507E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263349-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

"p64h" is shorthand for "PIC64-HPSC" and "PIC64HX"

The generic compatible "cdns,gem" works but offers limited features.
Keep it as a fallback.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index cb14c35ba996..dff350302098 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -27,6 +27,7 @@ properties:
 
       - items:
           - enum:
+              - microchip,p64h-gem    # Microchip P64H SoC
               - xlnx,versal-gem       # Xilinx Versal
               - xlnx,zynq-gem         # Xilinx Zynq-7xxx SoC
               - xlnx,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
-- 
2.47.3


