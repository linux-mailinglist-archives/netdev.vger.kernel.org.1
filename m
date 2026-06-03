Return-Path: <netdev+bounces-294867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jTlyNjxsIGrs3AAAu9opvQ
	(envelope-from <netdev+bounces-294867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E00DF63A5C7
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=IuB25xYX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294867-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294867-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCF05301ED16
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823C383C86;
	Wed,  3 Jun 2026 18:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E237F74A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509623; cv=none; b=jNKXWFaisbL8/GbCJ16/i03yxnvC2vuuQtMcQb1Jm+yBd5CFmT93hpMh3g+tM1W5HlUPv9PWtiNFvxbQOO0ayfKEwTY68DAOMEeAPgDCwY46Q1tULu3hUEjGQ5s3S2aFg1JjppxAI6lTBdIZYY4zqCAhb5EU9biAJWEPAgwNkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509623; c=relaxed/simple;
	bh=o8QM78Vy6VHvo+rLTGyqqPXklKtEKj9NZP2ta/CnDtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPMP7V0tDHajsAaUZyxr6LV0gL8P2fo13Yv+baRQ7V1+brGD1unEECaMhc8/k3HUWTV9wPtAwgnXwOiUmpNcqSkxKe2WOKnMrNCIQZiKY8v8bYkIxFd1j3khSmvWw8gIM7TkN9so5k36bS+2HlKN7MxH0x9BnXWA1EY3w14Maus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=IuB25xYX; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509607; x=1781114407;
	i=markus.stockhausen@gmx.de;
	bh=R8LHXotqSQYR3Cl5juTx3oIx+bfY49QphVDGN7nvr8E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IuB25xYX54GQiPP+FedIgswgz8V3kiUaZ13qxNVdqlBIcQMomcAn2/CjSpYIWm1F
	 ulvna8Ru3uDV4eFjaTLQGBadZptrdfa1wRwAR/7XO1Z5McNgvp0qit5EB91Xde8Nz
	 0kt+NzBhCE9PmclUhtZ9CVWfCiWJkVhgWwkCtCOIHXfHGJ8ttAW6ch1Iw/FlqrKPZ
	 OoKsdgB4nC9OXhJfS6iDrnG5dRjaffqfk3NDrsGGtP6judNjjRlh+KOb224ldXVHt
	 KaU3ndyKfb7UdRuM4YyTNVuuXbaJnUbuQwHkXylC5NzINY0Zdr99xVXGHuWiaYDtM
	 W+DA5iOA4AMkHv1Fig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1wzBDV11Re-00f9XQ; Wed, 03
 Jun 2026 20:00:07 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 0/7] net: mdio: realtek-rtl9300: Refactor initialization and port lookup
Date: Wed,  3 Jun 2026 19:59:17 +0200
Message-ID: <20260603175924.123019-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QtnGSmmAqk/+CFxsZAzUqUZU5mVGIyOncMKsNK4/k43jAZoMuV0
 m02VLHAbs/GbhakEGlDxe73sYGqjd2ULdPmqqisehG8e4nLgFw+UrlZb82LAVNdrWczAdC2
 p7g2d4ecv5ocVk8T7XmuD3OK/fWjdh4O9v6eOuPZT/e3zJevOfD8xQLXqcnysbyWNEAHezM
 6RkGqHliyD5vKtI7K6aVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+4NrWvyzlik=;raKi0JQL0ul8M3IPW+AYLvDsq0Z
 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
 UL9hPZzf5ECipoW9ig=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,m:markus.stockhausen@gmx.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294867-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E00DF63A5C7

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

A lot has been done to enhance the ethernet MDIO driver for simple=20
integration of more SoCs. Now it is time to solve inconveniences
that were discovered during daily operation. That includes

- Consistent "of" API usage
- Tightening error handling and improving overall robustness.
- Adding support for PHY packages.
- Fixing setup order issues. These currently hinder the driver from=20
  properly enabling the hardware on devices where U-Boot skips the=20
  setup and leaves the controller registers untouched.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2:
  - Drop mid function variable definition
  - Consistently use "of" instead of "fwnode" API
  - Drop usage of low level __free
  - Use of_mdio_parse_addr() instead of open coding
  - Drop separate indentation commit and change spacing in the
    commit that needs it.
  - Fix authorship of "handle ethernet-phy-package" commit
  - Drop performance commit due to missing benchmark numbers
  - Insert new commit "relocate c22/c45 device tree readout" and move=20
    commit "Correctly handle ethernet-phy-package" to the end. This=20
    order conflict was missed in v1 of this series and Sashiko bot
    justifiably complained about it in its review multiple times. E.g.

    "Since this patch introduces support for the ethernet-phy-package=20
     node, will otto_emdio_probe_one() still correctly detect Clause=20
     45 PHYs?"

    "Does moving setup_controller() before the loop break C45=20
     configuration?"
=20
v1: https://lore.kernel.org/netdev/20260602052640.93083-1-markus.stockhaus=
en@gmx.de/
    https://sashiko.dev/#/patchset/20260602052640.93083-1-markus.stockhaus=
en%40gmx.de
    https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602052640.930=
83-1-markus.stockhausen%40gmx.de



Manuel Stocker (1):
  net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package

Markus Stockhausen (6):
  net: mdio: realtek-rtl9300: Refactor otto_emdio_map_ports()
  net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
  net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
  net: mdio: realtek-rtl9300: relocate topology setup
  net: mdio: realtek-rtl9300: relocate c22/c45 device tree readout
  net: mdio: realtek-rtl9300: reorder controller setup

 drivers/net/mdio/mdio-realtek-rtl9300.c | 285 ++++++++++++++----------
 1 file changed, 173 insertions(+), 112 deletions(-)

=2D-=20
2.54.0


