Return-Path: <netdev+bounces-306060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1tCMGARDT2pVdAIAu9opvQ
	(envelope-from <netdev+bounces-306060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC272D492
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:43:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=GqhsZn9J;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306060-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306060-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4EF4300CD9F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923403D8133;
	Thu,  9 Jul 2026 06:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB23DA5AB;
	Thu,  9 Jul 2026 06:42:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579361; cv=none; b=hKHhQrr1HPfGAEJVaTcGt4ET3sSK7HWIKSGuDkIq2bJLJY1R4v+01HK9bxImJl6C17jfQi1+Coaekp2SlGGpKHGXCVa6e+CNT4yxo093b+i6VwuDOjTT1rLmcGWMqVhoCm2yGdFWNjVakV0StBYJp51f9b4xulWPBKQk3XWQyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579361; c=relaxed/simple;
	bh=3lhixlEzjpK4OUQiJDGFFmLEk7YG0ct7fFTXGfjnaYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtJfVC8HhEFt2LBFD5Kv4scWmIg4kjhZz/0Ypc3Fx/hVqf3S1QKDFJDYcXEFVcdSlSZyayYg7WN8ylVc8xAZmwcwk4h9c4nJHzZERZwul4Fvy7qYmNoaB/xwj2VYCmHyCp5cGqWM/hdshKDHx53VgYbjcflb8y8VEiCSFYoksIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=GqhsZn9J; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579332; x=1784184132;
	i=markus.stockhausen@gmx.de;
	bh=tpcxuW2VgXfk5/Ed+vqK4YstGR6Atr/YQsn1RH4/eJI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GqhsZn9JBxSfXsB4HC1vO9IxTYOD/k0MWY0bM5T7FTr5N+LHxvPtRnNrNiRFhRDj
	 Exi5GFz5XEmRzW9CNEewwS8TpI3aPLSMFalMaWscAVJIdcSKQ/VYVIhmekqrLNcSP
	 c0B1m5ir/1C87KMVf0Of6KSILEXRP6fEce52vEAlofxedOuqyFXPdb9qNdmHRrOwP
	 OOAb0B4RtOJFmE2++dpXXzmVCL4reNPvpqHTxabugJMpML2xeg8lzBU3u2o+MLuCn
	 g67YsySsAmj5trdUCDIBj/v+Rt3x7apDUHYOpZeEA5CEBKS7q5Vcrrs2CSds+vQKv
	 TOHuOZJpoBaBnlvlwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1wQu8P0M4D-00K0u3; Thu, 09
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v4 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Thu,  9 Jul 2026 08:41:49 +0200
Message-ID: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NcmR73KFrMaMeO5HBJrWIRQA2qV7cniIZU7sO3b3tqJ2LIM4tr4
 FrghQJEgPAROj3vyYL2cevolplLRpcbiUaB25NuYSlJv9JlbiebNldOMdGTjiY7FbQar6th
 xGgxV2RRuRk/2nlHmukvzvE2z2fLtGyzuGZWWDDUEEPcriR00pLQ8P1UjGS6Ht1VKjHZaDR
 f6uWCEwXat6LJQJM29b0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YhmeqzIwI7Y=;XDmx7oNDsDBQKV79F2V53baQifC
 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
 ncBeJ9uMzzUEsQv3DA=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-306060-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44BC272D492

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

While the MDIO hardware polling unit and its necessity for the MAC=20
layer was always well known, no detailed documentation was available.
For this series the MDIO bus was inspected with a logic analyzer for=20
a better understanding how polling and kernel access interact on the=20
bus. All this will be explained now in the driver comments.

This patch series adds support for the RTL83xx devices. For this

- Enhance device tree binding.
- Add special handling for limitations enforced by hardware polling.
  These already have minor side effects on RTL93xx devices but are even
  more critical for the RTL83xx hardware.
- Add RTL83xx coding.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v3 -> v4:
  - Add Acked-by for dt-bindings commit (Conor)=20
  - Test phy_poll bitfield under lock to avoid race. (Sashiko)=20
  - Fix whitespace in commit "configure hardware polling" (Markus)
v3: https://lore.kernel.org/netdev/20260705163532.2853959-1-markus.stockha=
usen@gmx.de/
v3 Sashiko review: https://sashiko.dev/#/patchset/20260705163532.2853959-1=
-markus.stockhausen%40gmx.de

v2 -> v3:
  - Enhance documentation and make clear that the driver and not the
    kernel must handle the bus mess. (Andrew)
  - Block non-Realtek PHYs on C22 buses to avoid issues with driver
    internal register 31 handling. (Andrew, Chris)
  - Drop C45 over C22 patch. This would need a bus lock/unlock design.
    For all known hardware designs it is not needed. (Andrew)
  - Drop tune_polling() and init_polling() from private structure.
    It is not used in this series and only produces review bot
    questions. (Sashiko)
  - Sort patches for better logical consistency. (Markus)
  - Add device tree patch that was missed in v2. (Markus)
v2: https://lore.kernel.org/netdev/20260629152336.2239826-1-markus.stockha=
usen@gmx.de/
v2 Sashiko review: https://sashiko.dev/#/patchset/20260629152336.2239826-1=
-markus.stockhausen%40gmx.de

v1 -> v2:
  - The polling activation logic was refactored. V1 simply activated
    polling after bus probing. Now a dedicated phydev/bus callback
    takes care of this and also handles deferred PHY probing. (Sashiko)
  - Run MMD prefix helper before register 31 (aka Realtek page register)=
=20
    handling. (Jakub's bot)
  - Always run MMD postfix - even if the c22 register access fails. This=
=20
    ensures that the MMD state machine stays consistent. Adapt the error=
=20
    handling inside the postfix function to not overwrite the real MDIO=20
    return code (Sashiko, Jakub's bot)
  - Drop unused RTL8390_PHY_CTRL_PARK_PAGE define. Like on RTL931x this=20
    field must not be set and thus can be ignored. (Sashiko)
  - Change title in device tree documentation. Because of this do NOT=20
    add the Reviewed-by of Krzysztof. (Jakub's bot)
  - Fix wrong use of RTL839x in commit message of patch "c45 over c22=20
    mitigation". RTL930x was wrongly named RTL839x in the list of good=20
    devices. (Markus)
  - Fix typos (e.g. c22 over c45) in polling documentation (Jakub's bot)
v1: https://lore.kernel.org/netdev/20260613112946.1071411-1-markus.stockha=
usen@gmx.de/
v1 Sashiko review: https://sashiko.dev/#/patchset/20260613112946.1071411-1=
-markus.stockhausen@gmx.de


Daniel Golle (1):
  net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

Markus Stockhausen (7):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 395 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  |   9 +
 include/linux/phy.h                           |   4 +
 4 files changed, 412 insertions(+), 10 deletions(-)

=2D-=20
2.54.0


