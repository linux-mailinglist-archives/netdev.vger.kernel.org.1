Return-Path: <netdev+bounces-306058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGw5NZ1DT2qEdAIAu9opvQ
	(envelope-from <netdev+bounces-306058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D7E72D50B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=OBMCSEHR;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306058-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306058-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2923036CD2
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88053D9023;
	Thu,  9 Jul 2026 06:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7803806CD;
	Thu,  9 Jul 2026 06:42:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579352; cv=none; b=E+u5FDac7rIJyt7+SUzl6vDL338CO+995PLhsCKlLRrU7t7Omr3Qus8fnFievhe4+E3vlV8BqIKwioWou+e9Hi80aRJYWo1spnBw3KTSOrz2U+n0VNGtph1cUDE9c/wjGdRv+BawcB35py51BBSSQaqIWlbt7NMy/OBXWvVF0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579352; c=relaxed/simple;
	bh=UI0jHS8I0HPPXHUnaxIXdLQBQGmQu6rbNmxaXJ84zUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amw5/XD1l4IfZuNBBapDwo2IGYdn4p0eewmQBlSiGl07nQd+ykuns9DSB+iQx+OrvdbvkfZi7RyHNcbgt+8TteNLb8T2fhhpFA82k8gLBEwmcAEP2iIIakPqz6NrgxE9P8KfU3zdo0IAO95dtvLLbAiGoRIgQvorZ8ppsah/4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=OBMCSEHR; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579332; x=1784184132;
	i=markus.stockhausen@gmx.de;
	bh=OKVUSBchYuomZlHVu8TavsUBij+13Jg7TBySarSEW4Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OBMCSEHRMj2QVbeyTAqiVdcYZb+egHdfV4Ris0Sak7Duzjl84f1h9PqfVvACG6X1
	 g0t8mJC53sX3n3zCD7u9PC8Om52CMtzNhovFFEm9OgnsuTM0j9PxJptt+TocPeU5Y
	 u4sj9Ahr+6aUwVty9RUOhgrsKIWE/tmeNEG9rt0MYrhQgFuLcCmKpShjRo0bNW9wi
	 K7lULCcSBLGDSfxaXMSoiM3ObruHa7uHdpPh7i8ryfV6PNWBiVfoANqvfbja3Vg6v
	 WebgUUuwk0qRuEAUYiL2+Pn8//0c9Tsg+vAOTMngXYOzEcbRdL5Z3j/mk9HjoBvxD
	 yxXC3baH71TgXKMRPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1wO7uN2WSF-00Mm3V; Thu, 09
 Jul 2026 08:42:12 +0200
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v4 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Thu,  9 Jul 2026 08:41:50 +0200
Message-ID: <20260709064157.2865063-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YzZSGRMligSLZzWjnTHu70i0UAQz6/5g0LMA2RVaJ3N9455Gxh4
 km3CMUS8IjPdszzxkJikAvPj0UmZAgIwjwcfVaCEExe/7o3D1I8TV7EyLLRAO6+KPaD+XAI
 r3eCjzPhiRdvUtMVwBIR4RRpEPrWA/SIDibceHUqPTEjzygLHyTDmK631DnKSDateSChwan
 NjwQofGxmuvKbxHEYh+nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3s4SBqEA5MI=;VQvqD9Ufg1NjXuD4ZE2ShNuJLAp
 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
 eyknS9irKene7BML0Ee+I9RaN/OHvpYFFkHaPB5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306058-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,microchip.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url,microchip.com:email,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48D7E72D50B

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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


