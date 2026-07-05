Return-Path: <netdev+bounces-304795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdmCOgSJSmrOEQEAu9opvQ
	(envelope-from <netdev+bounces-304795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F070A95C
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=AjWgptbT;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304795-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304795-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA28F303D2E2
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137B2F8E8F;
	Sun,  5 Jul 2026 16:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05232F7EFD;
	Sun,  5 Jul 2026 16:36:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269375; cv=none; b=Ut6RXwNjpuj0cnTJ0FQisnCoNJMJ3BGfMVfo4LTV0W29sqC7EEPra67tyrWdswMke18jJ5zKi7j13YMvAr0tYVKo/y3bdliIJAu7ZBpwvE9fkbXmDvyVELrDBlSawTNhsfIahvQZ6/UdXkTWZXU/rAkWKzuw4HEeVVfdbWsCIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269375; c=relaxed/simple;
	bh=DBEWBevAesgbf8ydJs9SdZNHSVlnmmHkJER431egy3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuLqj6h6siR7CmxDliqWCP1/ADtdNqxiByWGTDyBjw1xIg73GMPxGPNigRegzOGmfDOjAQDhiLRN9NoJfSSJyP2AlE1ovweWPqR51hozMq3etgLtf25U8Kb/QPnG41+NvOWVdJ7JIa7fsKxOxnTvOeMB4prAkKEzYXsmTM3P7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=AjWgptbT; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269347; x=1783874147;
	i=markus.stockhausen@gmx.de;
	bh=LHXFrqH4+CmmwBqbsCHecSNhZY4Pjbckmq8rXysHC3w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AjWgptbTmR1z/PEeZJ86fbKkDSC+CCiJfKYq60jLdwZh2Ead3e/wNwKBoyPfuMPM
	 /GQ/BU3R7dnCFaCmCSbi2jzquqRC66lfq/UEy2Qmw12xa5ExrxBMlbplQ8lK88l0d
	 aBHl9xwkwcH2BbPcXo9VpP83Gx3y33DIifFNV5fUC1xTczvcykzJ2ikbfOLejA10P
	 nw8yVIyW7m5ktmIamnQ+MYWUhJPwxYKI1O5jfxkRNBOP2Xf63vCFizdhGCN8wi2jo
	 l3ciw9J2JWdoSBbwMSlUNPwq0H2HnU6Olx/0svWUWVYhxvwSrPWLfiS1zKJzySrB5
	 4IhHWtapBDlgQoWByg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bfq-1x9Y1F0RAc-0171Eg; Sun, 05
 Jul 2026 18:35:47 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Sun,  5 Jul 2026 18:35:25 +0200
Message-ID: <20260705163532.2853959-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oL2KN7DmKgiVYFR3XEe4P2eodK9wg5QaRKQbO8NqI9rNbsiMatp
 Oogyn3pnu9fjS28i9eCP06VUcIGGLOQ8A+TVXMvvxnYv/y5CYVRh3anCdhNHxE1XnyKBryF
 FC++NDK08QxnL4RNz/s6GNfbjBKaKrGMheaIFhubTpzebMy2LFCmNdRHd8b/efUPRsS+H9R
 MwMe2zENMOVqsbxdL/lGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ot/56BM4w8E=;SKkvZWqNA03XIDczPy/2HO2LxjZ
 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
 7NJma+mwTZiX7A8JieWhrlc6C9RYq6dU1IbwNfb
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304795-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devicetree.org:url,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7F070A95C

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 56 ports

The Maple based devices have 3 different SoCs: RTL8380, RTL8381 and
RTL8382. The Cypress series consists of the RTL8391, RTL8392 and
RTL8393 SoCs. The MDIO controller of these switches works like the
existing RTL93xx logic but has different characteristics and different
registers. Add new compatibles in the device tree.

With the extended compatibility list change the title to better reflect
the scope of. Especially add the "Ethernet" tag as these devices have
multiple MDIO controllers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml         | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 271e05bae9c5..67e0b23a8470 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/realtek,rtl9301-mdio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Realtek RTL9300 MDIO Controller
+title: Realtek Otto Switches Ethernet MDIO Controller
=20
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
@@ -12,6 +12,16 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+          - const: realtek,rtl8380-mdio
+      - items:
+          - enum:
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
+          - const: realtek,rtl8391-mdio
       - items:
           - enum:
               - realtek,rtl9302b-mdio
@@ -24,6 +34,8 @@ properties:
               - realtek,rtl9313-mdio
           - const: realtek,rtl9311-mdio
       - enum:
+          - realtek,rtl8380-mdio
+          - realtek,rtl8391-mdio
           - realtek,rtl9301-mdio
           - realtek,rtl9311-mdio
=20
=2D-=20
2.54.0


