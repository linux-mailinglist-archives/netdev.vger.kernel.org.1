Return-Path: <netdev+bounces-254962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jn2CCYAfGmUJwIAu9opvQ
	(envelope-from <netdev+bounces-254962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:49:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8325B6032
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1392A30055AA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A752ECD37;
	Fri, 30 Jan 2026 00:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2142EC560;
	Fri, 30 Jan 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734179; cv=none; b=tym9KWZ2hhv53GZh+AnHjR/hdbfEy8xQke9Jj+fKEbvoQIpt40bJGK8+x4dO8djp3N4djUh4U+RMTw/F8m1jDFH8bwS2RvSUxFlNVDCkPdbHJ1/SlwBYDTY6YNw7Gwx+Xp3csQYRVhI9FWq54Fr3ZJfIrSin/+xB7NTpYZp6Jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734179; c=relaxed/simple;
	bh=H6PT+g3TT064fh8FfFxdqhL8YRAq+WgEjx41rfmX4CY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTqtE9RHoHTlVJOZL5VbWYAUkF7fAjPqlMORd3d0rBo1EXgmHNe/5w9R7PIie/u+5jTE1fXkuGZuhZSThN9VuzxAKWdTjQzi0saUsZBSmXejU1VxgqggcJofMuBQGdBgHUhxvBZ71yJWwaN6LmMKlJiVdZDPVnXP7X3Tn6JJkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vlcha-000000007qc-02o4;
	Fri, 30 Jan 2026 00:49:34 +0000
Date: Fri, 30 Jan 2026 00:49:31 +0000
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
Subject: [PATCH net-next v2 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <8c0a6b08588baf33793c3be423a845620ef671ec.1769733972.git.daniel@makrotopia.org>
References: <cover.1769733972.git.daniel@makrotopia.org>
 <875329426cffe416ebe6a3064ed632604f29f100.1769733972.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875329426cffe416ebe6a3064ed632604f29f100.1769733972.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254962-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.5:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: B8325B6032
X-Rspamd-Action: no action

Reference the common PHY properties so RX and TX SerDes lane polarity
of the SGMII/1000Base-X/2500Base-X PCS can be configured.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: use allOf to include PHY common properties, add example use

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
+                    rx-polarity = <PHY_POL_INVERT>;
                 };
 
                 port@5 {
-- 
2.52.0

