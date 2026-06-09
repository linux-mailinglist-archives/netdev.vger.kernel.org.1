Return-Path: <netdev+bounces-296909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CQZbIAOlJ2pe0AIAu9opvQ
	(envelope-from <netdev+bounces-296909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F327E65C70A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=mDyWaEbX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296909-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D273E306DF84
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894282FFFA5;
	Tue,  9 Jun 2026 05:29:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762A2135AD;
	Tue,  9 Jun 2026 05:29:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982999; cv=none; b=KPcq6VzRoB+IpanveJGOrjhw6OCHm4fCaU08Bjr5mkVC5d2i24N7NSRx1xIvNcR3lz+aBdSzzVoiXe5FnYJNK3i2YvVZy03ATft3PniUvlgSqOQwwaC4RIBXJl10EHyMN7XUfXiNTQgnAO1P74mdzMB4o0STl2aPwezz6dv/mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982999; c=relaxed/simple;
	bh=1Oya6VCLBCj7iiWA8RHJ0+MxxvkfhiQIHC9MSW7H1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1oVja3lSbWOV6TJ+/3sI68AQdVC0sM89BSznmpEl+RX+Ib1AOkzvFgD9p00Kb1hurSJNfzOcj4RUoQv6c+hnkohZ6uyxJXlleR0GqyCHM/9wo4BcjKS5xpMEtxRMVnpqScNrV+vFWZtlZ9/CFJBnaGMZ2mL4VIxc+hsrVFGAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mDyWaEbX; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982963; x=1781587763;
	i=markus.stockhausen@gmx.de;
	bh=trdrBTYG5VoI+PCFH0aS8/zneWR+XOpnuJWH1/pofk0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mDyWaEbX6MfigCtSsJHJ3zLQeOBjXVcZbYW0QRFcqFP7yOiBepZmfEAgXSihqba3
	 d8XdrR18j1ou3X1O+7sn83AZBYFPTrB3Kqkc79zE6cFdPsDU53fiys080CR+cxu/F
	 iDwoSd8g32xoEbH3TYkQnYsTyDsL565pMhimW+17V3maZATw8gJdWxs3iLwjX5hdn
	 CzRK4fLETxRrXoROuhmzdzgZhBaY8H4tNAM6fndTUC4u2NM0Bem+vyew7/pvKBHrF
	 wJIZw0rkFTtTvsTBSGbe9tkGreFdqIxjTa6E35Mr+YuGT4nLQ3qPfQcP05tIi8jfr
	 QM7Ia8y8dagWXmdEzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1x4EIm1SH0-00fylo; Tue, 09
 Jun 2026 07:29:22 +0200
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
Subject: [PATCH net-next v2 1/5] dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
Date: Tue,  9 Jun 2026 07:28:52 +0200
Message-ID: <20260609052856.3142922-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDA1xcauyKea+rGXPNkiHE9tDS43+KypAUgBdxXXbGfOunEl1i4
 Ed3Hdi0uFa2M52X5H8DCekCL3lT4kr4qHuvfn3HUys2nluMO3ngE+vwyggnLKIQ5+Omuo8q
 nvX6NGX30RoqIlYIzGFEMCMz+b3isTg9K5yKKYPEw47+eNDpN2NUAAQRySQvjKcWMdb0vfc
 6qICvoLkhDiwaJ0SA9MBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EHWuZKdNcOs=;tJJiaKHP9ol5lGM61MfvYPSh8z8
 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
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
	TAGGED_FROM(0.00)[bounces-296909-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F327E65C70A

The 10G Realtek Otto switches are divided into two series

- Longan: RTL930x up to 28 ports
- Mango : RTL931x up to 56 ports

The Mango based devices have 3 different SoCs RTL9311, RTL9312 and RTL9313=
.
The MDIO controller of these switches works like the existing RTL930x
logic but has different characteristics and different registers. Add new
compatibles in the device tree.

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


