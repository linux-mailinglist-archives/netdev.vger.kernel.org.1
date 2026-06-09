Return-Path: <netdev+bounces-296906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AXR2GdakJ2pM0AIAu9opvQ
	(envelope-from <netdev+bounces-296906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90565C6F1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="WQn8/X1k";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296906-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AC3E306DEFD
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B203C1F4F;
	Tue,  9 Jun 2026 05:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E033C1F46;
	Tue,  9 Jun 2026 05:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982981; cv=none; b=qoMoSVHmzp+xQWrM4G2rWDD8Qjka7yzlwhSV+CADfWfdT7GlGTcFm8rP5EdjJhJbWFgiAOY+5jhEw0ia3LUlYgAb4CRGNmM5UsnJRQGHyyNk946SoB3q0BWCS1C0ybs6xUB7sTWYz9EmyLySpvOgtXgQBwWdZOC8/9HxBjDb4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982981; c=relaxed/simple;
	bh=Ws3Yb7MHTktwPK4wXUBAntWU/uRHMBz6ImouH1eY/7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDC8uX5wM0nsLd9ITdY3r4VXzgmeBf8EWTHFNrzn0v+thOYdSdCxDnLqCBNbkGWh2L94tlmoIFRXv4QlgWAtwp54vPFbrjuTltHed+m3Pmbyy9PabZiAkTTz0U/nKq23tQKTGngz41knLm5xRcck+RrYymKvhwRxFk83hDRJPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WQn8/X1k; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982962; x=1781587762;
	i=markus.stockhausen@gmx.de;
	bh=b97Yp6rYg+JqIaGoiJMBNa9yeJT1+Od/mSNrNJ6wX6M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WQn8/X1kc4Do2TX9EybbD7221IEaZS7lEfHbnnyWJY/zNJOdM/dJh3dcMJMaMA37
	 zufICGQtJQYHbit9U/x5gQeLdOkNf/lkrOkk71rpyn3Ee2X3sPLiIfP+be2/NAT4s
	 cZCiO3n0uYZgIE5o+1zei9sLirlI0LTdyw8iP/9oREygDwEP9kKkaTiEGlVBnZ+U0
	 mcZp9Q1Loj5PT1FfWVFCLk0gCBs2EEgf9zFK0O+3KUk8ZLFpLznWdCap+h+V9c1Be
	 lfwOOH3L4d6UTVAWdzkKSPXtHP4H9sCj7sbXSayovjjfroHKQrIzPWcz8YAHeL2re
	 PCaKUU3dd1SL3upDXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1wk4Zd3zN2-00ULYg; Tue, 09
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
Subject: [PATCH net-next v2 0/5] net: mdio: realtek-rtl9300: Add RTL931x support
Date: Tue,  9 Jun 2026 07:28:51 +0200
Message-ID: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A260HyOcQ72W52rSTsxejemFNsPgNrV9gS2EvUZprw2NqIg2Bzq
 KiUC3tZFnh43IwVytmRFJqIZo//X1ubMGMwhvN002MJ1UIY+YmjOG8j2Q/boDier1P6u/2F
 8n0taL/T1nqcgxteuEESJa4umY73g2vBKQG52f0nBCxp9mITM5gsvwIdehcuEFmEuRE5kzN
 +FEpIsL3kk87R4fjPwdug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jsQ77iXybuw=;JQHd69LtNLzVFhKe4DvFnoULWt7
 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
 MLkPwMM3XlF3T6OTnbCK9F7rnpE=
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
	TAGGED_FROM(0.00)[bounces-296906-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE90565C6F1

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

This patch series adds support for the RTL931x devices. For this

- Enhance device tree binding.
- Implement final cleanups and enhancments for the driver.
- Add RTL931x coding.

Remark: Instead of this series it was planned to bring support for =20
hardware polling configuration first. It turns out that more testing
is needed - especially for the RTL83xx SoCs. Instead add the lineup=20
of the RTL931x devices, that are known to have no obvious bus and
polling issues (at least from testing and vendor SDK perspective). =20

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2
  - Fix subject of cover letter
  - Convert const/const to enum in device tree
v1: https://lore.kernel.org/netdev/20260607125406.2853607-1-markus.stockha=
usen@gmx.de/


Markus Stockhausen (5):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
  net: mdio: realtek-rtl9300: Add prefix to register field defines
  net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
  net: mdio: realtek-rtl9300: Add registers for high port count modes
  net: mdio: realtek-rtl9300: Add support for RTL931x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |   9 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 210 +++++++++++++++---
 2 files changed, 185 insertions(+), 34 deletions(-)

=2D-=20
2.54.0


