Return-Path: <netdev+bounces-298954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ae6uJ2A/LWoieQQAu9opvQ
	(envelope-from <netdev+bounces-298954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8A67E772
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=MeEH5uqJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298954-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298954-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9435E303D0B5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4F3DF004;
	Sat, 13 Jun 2026 11:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3613DEFEB;
	Sat, 13 Jun 2026 11:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350220; cv=none; b=U56/34QxyO8PL0lKh+HbYrMUjvSgTasjsH0L08/dKVF04cskTRFfeybPB/SfkNYUn1JLtv5Osu1McmDFxyzbB/cirWTCW5Xa52vwzi2L9Q437+zy0NsmsEvDIZJa7odfo7276f+5C/NFgiIndCb9sf5sdcKiSBy45RrQ4wBUD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350220; c=relaxed/simple;
	bh=i9ZNWcrhoz5T858bvFoENmuslweMd9mLZGesG7rb/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuginxGncQH4Qxip5tASUse97/+0PyiEJzX4iAvExHM43patx7g7ZBywwyuDwHheKW/Cz+eGhonAtPoMSCnTkXcVeDroNjBMYE7d+P1KiQAPdLPJupk70kp/JDF8GhxaLoWvylE/pdZQ6h6yVMT+ToDo85ROkedvF8s6EdxHQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MeEH5uqJ; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350201; x=1781955001;
	i=markus.stockhausen@gmx.de;
	bh=2S8t55mwfSxMtIucYVPtRBCNqM5C1UWWTVfoVHjWUK8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MeEH5uqJJhN8UtKSWylj+m8fUdWmGYucC4KWtP6E+AhGcsL1bbXF684bDmfPKedv
	 0eDjQCsNjwIIIZ5HFhqUW4MzBqhliOjv5459kgYksDa4iWnZ3moNWrUCwZ++L8HUz
	 Cc2jzl5j8OejFXlWlFSTA5ahpqI3wgdMYBwryHbi+HxN4pU+S6AI3LqwUVQ3IXwkY
	 x3s1AVTSWiVP+1I2TuSfGeU1qE7jUFTKQgI7IlU9Napml7XkLV0W5TpxFG2Di9+2u
	 xL9PZnGulHkoefqkQb2Wrkgt2wy3cMEcRhz2Hu4z14qB3EWdk9/csc2jxs98zCYER
	 P0n3sIG1+7HcnCKHHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1xMskK1Vgf-00sIP6; Sat, 13
 Jun 2026 13:30:01 +0200
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
Subject: [PATCH net-next 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Sat, 13 Jun 2026 13:29:39 +0200
Message-ID: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nwH/Rb8knhBeiXvQxd2PnppNl5UAmeoJ3wdUjiSRu27h8DDJ0ez
 xSjWbjqWtSRjtOu4h/WX9wOazWyLUyqslJiRPX82T5KN2Jn8W1pp94IFQp1iIEPRPIoXn1M
 W8ErIPtvBrS8cPlLnFvtS9BE78GPY9gDofwiL/uL0Da3x3vzXo5P8X0s4Kj/5zVyWt39kmP
 1/jytQ4F85JTblrX9nCgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v8odhttnvFI=;j29Ciko/FO9cSu1eTwZWRTWGD1w
 +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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-298954-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16B8A67E772

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 56 ports

The Maple based devices have 3 different SoCs: RTL8380, RTL8381 and
RTL8382. The Cypress series consists of the RTL8391, RTL8392 and
RTL8393 SoCs. The MDIO controller of these switches works like the
existing RTL93xx logic but has different characteristics and different
registers. Add new compatibles in the device tree.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml           | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 271e05bae9c5..de33364b67ef 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
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


