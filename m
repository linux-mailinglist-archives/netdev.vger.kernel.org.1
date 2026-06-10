Return-Path: <netdev+bounces-297814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9X6CyG+KWp0cgMAu9opvQ
	(envelope-from <netdev+bounces-297814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747E66C8C6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=Aj7hmF1t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 265F9300BE82
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAEB369D65;
	Wed, 10 Jun 2026 19:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7B37B01A;
	Wed, 10 Jun 2026 19:42:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120535; cv=none; b=idoUul0NSVBzmBFWtcLvnMMY/JruNon3SOQKYzgGLFROzypiK5G9e/6vVtzaPSSoppZfAjsUDYMg+ms9GIelr3xnqofa5Ac4oM9M3g6gVTz/K9P+1J7qVP+ljtQkY6L/ePlMWxodsy5VVyfcJN7AucDrRISLJCV3c382WQH1mcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120535; c=relaxed/simple;
	bh=BTJSjAIoe1UBYz6D9cVcvBLJXAOJ6PcRzqw6bNq2PDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLAD+J35u3PlVlpHE/O7Zajio8DRAPGN3vxFegpAVwy/PB2Lfw3wR7H7C/9lS61zyYTPEZNfkot0j5ykYJUq57V1EFaa8dYqDFKr9zByaNC9uTcG8+mGB7kdfeNluawRzxp+lfidtuFOQRY5cAEVoyuIwPHhSKGB1gHQG8zSoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Aj7hmF1t; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120523; x=1781725323;
	i=markus.stockhausen@gmx.de;
	bh=R8XSfKFyNqjS0lbNR3IkCeLUxC9KCfgYshjdvnzLwEo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Aj7hmF1tNjv5zVdULUuLjKg9O0xi0XgHeysacTefKjQ0hMJT86iWXUKs54iPplA1
	 LkJFcTBWJECJWmWk+FqnfVebyoKM6yvm4HoAkcs7ozPQnstsxuYhaJOFadUXyjgzW
	 XZjP5izuPIJJi3lqEPs9/F8JfZmvEPpGuDvmlA8RnMDWSjpyXIb5R1xLhCOH/m62s
	 whxxsuWIh7VGooYot+W6Ou/i/4VbfLHLZLIZG6PuIempAMAyot0bctknY3G4I/IYd
	 Xv4D0ZS0Fiza7LiXr/J39SHna7/P4dKHEdhKk6nNIn0GSfNgICBVhXZIFtJdqDu49
	 Pl929OaQy2YwEw/cvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1wvPxz2NUO-00j7Lj; Wed, 10
 Jun 2026 21:42:03 +0200
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v3 1/5] dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
Date: Wed, 10 Jun 2026 21:41:41 +0200
Message-ID: <20260610194145.4153668-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
References: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sli53TH4MXcJ6n9v1h2Y4oaagMkug37ofsJiJAjj758xkd6UJrk
 M3XPUTw0+TZsBE+lyZbjx8Ztf6keHr3sW1+WOYvX1ZSm5RUXDh/VybXVrYbGDuMsyzKGCi9
 CSQ9WDZib7zXkEn895l+7OA2pz4ExYxj87rUgJlFCForfbQ54+y+gduMQXYbWvfSPcobznR
 yxMYAYT7/HVegx5qBuQWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:shOkV7msDw4=;Fax7nj6mD0f6vqvJdyw92uY23lG
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297814-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,oss.qualcomm.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2747E66C8C6

The 10G Realtek Otto switches are divided into two series

- Longan: RTL930x up to 28 ports
- Mango : RTL931x up to 56 ports

The Mango based devices have 3 different SoCs RTL9311, RTL9312 and RTL9313=
.
The MDIO controller of these switches works like the existing RTL930x
logic but has different characteristics and different registers. Add new
compatibles in the device tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 02e4e33e9969..271e05bae9c5 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -18,7 +18,14 @@ properties:
               - realtek,rtl9302c-mdio
               - realtek,rtl9303-mdio
           - const: realtek,rtl9301-mdio
-      - const: realtek,rtl9301-mdio
+      - items:
+          - enum:
+              - realtek,rtl9312-mdio
+              - realtek,rtl9313-mdio
+          - const: realtek,rtl9311-mdio
+      - enum:
+          - realtek,rtl9301-mdio
+          - realtek,rtl9311-mdio
=20
   '#address-cells':
     const: 1
=2D-=20
2.54.0


