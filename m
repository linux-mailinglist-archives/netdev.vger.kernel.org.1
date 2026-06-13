Return-Path: <netdev+bounces-298951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKYpKU8/LWobeQQAu9opvQ
	(envelope-from <netdev+bounces-298951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785667E75E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=PRA4ww0X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298951-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298951-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795A03021E90
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2F383C7B;
	Sat, 13 Jun 2026 11:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A30366060;
	Sat, 13 Jun 2026 11:30:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350206; cv=none; b=HgmBMosOu8TdM5VZXoWGlJCP7a6N+5fJ8A8j09+IpxIkDejg/a3PZsRhOs9ew/ttPN/TUW1KPVLoP+/q1sGRCpHfl+Zg0VZaeoBN0nDz//Gk1jFhgkbdTLBkmrNGbBJiG/xBCjC1S19imTZ15s2hgQ6KGB733N0xjiv33m+dGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350206; c=relaxed/simple;
	bh=BQbbEDS4UNksol9nlU2Rj9a8mCSdDev96FzwENlE4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBi2Kz89yBOf0i9OB++AeloU2rbraaHEEamUNvULwkRfbW7exJPC6LxqVqMhFmOAMSS8d6CZblI/HaywGbb3mJMfGv4abg2NC5eRJLqDZTA1MI3/G4K0zIwF/2N3Y7yylgtdf91aANSSX79jdkBDgSom0SFJJtdU2wfx9sZp9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PRA4ww0X; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350201; x=1781955001;
	i=markus.stockhausen@gmx.de;
	bh=cxBmpuzTasKQ8Ke3njGhxsP2f+gi/S51e3rc85JZDLs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PRA4ww0XJHc0jcuglxWmQ98DwZ0fLjqnVoBHFlU/mRywTt7vKsHh4cSNcd2eNQFv
	 kv4TD2q0l6quppA7Q6gQylIv9RDWEyBaHtJceS+PXWGf0VJyXoAYZjL6IjGQvZvBn
	 H53apxG4TyGHPy0wmjWHXROi/o2gsMlQl5PYenHaJa7sbZMHBJIH/GjbkTRTiwUWj
	 03fpReA/1lHeT0JpgwrClN1wWOHzXTAvsDwHLs43aFV0njSkgJ2EjAX4I8k1/pT8D
	 CyUCnxxANBC13nmbbZzvX/nKGBodoPZ9pJFCi0cTVBip2AHmN+k/VpTkPvMs/Bs8Y
	 F413twuMKCP+iJLikw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1wioYZ02MY-00VYZH; Sat, 13
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
Subject: [PATCH net-next 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Sat, 13 Jun 2026 13:29:38 +0200
Message-ID: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sivCha21fddCzKy9mb56Ap7EtWgO1qALFGdO5fMM9HLiimSArVk
 PcLuPZeW07GCKANsapIJtjsX1r79+eaD0de2zWIOaB1pJxSVOw2NvpjYswra8bHJZyrfWMO
 HlpW1YlewmCcVots//uSYu01duYuzgddKRJA+UABV2lRxqWPjvmPbTHO6LLhbARxrSTP9xh
 az0ami/z2BfKBV7/Rd4UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LByVGPhhf1k=;2XnvpWEjHlzl7VLgNChJW5bBGja
 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
 RNmRLTCYlvyCE8i8VpHzbem7gH8=
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
	TAGGED_FROM(0.00)[bounces-298951-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0785667E75E

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

While there always was a good knowledge about the MDIO hardware
polling unit and its necessity for the MAC layer, there was no
detailed documentation available. For this series the MDIO bus was=20
inspected with a logic analyzer for a better understanding how=20
polling and kernel access interact on the bus. All this is now
explained in the driver comments.

This patch series adds support for the RTL83xx devices. For this

- Enhance device tree binding.
- Add special handling for limitations enforced by hardware polling.
  These already have minor side effects on RTL93xx devices but are even
  more critical for the RTL83xx hardware.
- Add RTL83xx coding.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--


Markus Stockhausen (8):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  12 +
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 399 +++++++++++++++++-
 2 files changed, 398 insertions(+), 13 deletions(-)

=2D-=20
2.54.0


