Return-Path: <netdev+bounces-255574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNujGY7LfmneeQIAu9opvQ
	(envelope-from <netdev+bounces-255574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:42:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E1C4DB7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 04:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA62F30160E1
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 03:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4B27FD51;
	Sun,  1 Feb 2026 03:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5F279336;
	Sun,  1 Feb 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769917320; cv=none; b=BPnV64TdvELrFOjeZMBP5s5ShyDU51A6p5j6d/5vL5933lKHWE/WMIRKKstwFWczTROpSM6SVnezqbB2uFhiCtYg/LV39ME1gaDBs3EJTnhbUpBjt7s4KLZ2DzLvaZiT0WvnnpXkiTAB1ntv/Dy92TPDAU3Bl59byglO3Bg8TVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769917320; c=relaxed/simple;
	bh=P9AVHS0bC1kwDKh5P3VUYJNMDUlwRspeNzrhrgPJWTM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uid4t7WBhOas7YZMrqXaC+SZpeOTXSdtG381WvlC2S2Kzx0WomxmBiwT4h1KdExJrbDLPA8EA+v7NgxqwaApBgD1STVK3uGFbQtSQQh9B3gC9GpgDoe1Ao9TEIRmdxplI/D4nRvQTwy9HA7RSZjK7LLSCzGJPX+Kv6gpeX5mNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmOLU-000000002Wb-0tM7;
	Sun, 01 Feb 2026 03:41:56 +0000
Date: Sun, 1 Feb 2026 03:41:53 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <f556ef8be75e37a2f864b9d905a78962bbe76d18.1769916962.git.daniel@makrotopia.org>
References: <cover.1769916962.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769916962.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255574-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.5:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 049E1C4DB7
X-Rspamd-Action: no action

Reference the common PHY properties so RX and TX SerDes lane polarity
of the SGMII/1000Base-X/2500Base-X port can be configured.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: commit message: clarify that the intention is to configure polarity
    at port level, as opposed to the internal polarity of the PCS component
v2: use allOf to include PHY common properties, add example use
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f601e5f9fa6a..b4a31cde4322 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -105,6 +105,8 @@ patternProperties:
     patternProperties:
       "^(ethernet-)?port@[0-6]$":
         $ref: dsa-port.yaml#
+        allOf:
+          - $ref: /schemas/phy/phy-common-props.yaml#
         unevaluatedProperties: false
 
         properties:
@@ -288,6 +290,7 @@ examples:
 
   - |
     #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/phy/phy.h>
 
     mdio {
         #address-cells = <1>;
@@ -320,6 +323,7 @@ examples:
                     label = "wan";
                     phy-mode = "1000base-x";
                     managed = "in-band-status";
+                    tx-polarity = <PHY_POL_INVERT>;
                 };
 
                 port@5 {
-- 
2.52.0

