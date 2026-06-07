Return-Path: <netdev+bounces-296235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3HWIBBqJWoAIAIAu9opvQ
	(envelope-from <netdev+bounces-296235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47E650921
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:54:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=LVgX0Uy+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296235-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EFA73004906
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062B3A4F4B;
	Sun,  7 Jun 2026 12:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819A3A6B6D;
	Sun,  7 Jun 2026 12:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836877; cv=none; b=blQQx3VPdnI76e3PS+0jyhD9vXiVK2E6wYmxumWK30FbOzrANbBFkE6yYx+6YzSvZj+xt0iC54opL9d65dH0fJH92AyJz0RV7q3i2bvdLRhYm8olCzX12+nRTKkl5oHNyNzE59hiadi6dngP/3Wlq080/pdVhbDqy/ui3EoyrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836877; c=relaxed/simple;
	bh=vykCKXXlkS4UseniRutu7UwNEQNJBLwC74LBmmSgTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBlEBi19/Fh1SWChRyI7Q5eNxrG3uqC/gcyz97Y9ywzB8OKzSRaG2jEKUIGAdDFGDQvwxE2W+PiJ91mMsuJoyQ3SHiD63N/NQDizOLamv+ISJok7xhpzkCI79v7GRnu28/lFDfdxYWiIi0+bNxsHMY7ZCY94nI4kU1rtsvh0lGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LVgX0Uy+; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836863; x=1781441663;
	i=markus.stockhausen@gmx.de;
	bh=dt2xoboSY/U0ti/lbt1+Tbovq+O3m5hs1lB4DKb3v7Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LVgX0Uy+VM51xbjpWFvDTNNskbPQ2qwsSMA9iNciTcFAIcRtDKtUXCZQBTMJoNAr
	 2eCXpnbss4T9uc6QzMLR2dUN8oHDLlCS54cN+x65vRr0pl3+Cgcs414eqqP+pN4pn
	 PYaKEC3xW/PboEP3IQrupZhgoKF6Ibm0hOlUN2ZmRTFfrq5NS6kkc5upUVDb2JxOw
	 3WsTCMTCqFBtBQAK/cGaoJSSeSr1vxtND2REylFd8vB35x+LPpciwlTV0IFIu8pq0
	 gzYOUv0Tq5R17E3rs9e+6Ioheoy7DxxCzreHUaEmYJRdY7q4Tia6oZmD8iie9qNc0
	 rK3UjYYAsvsllqSItA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1xTxR60s8J-011otD; Sun, 07
 Jun 2026 14:54:23 +0200
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
Subject: [PATCH net-next 0/5] net: mdio: realtek-rtl9300: Refactor initialization and port lookup
Date: Sun,  7 Jun 2026 14:54:01 +0200
Message-ID: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TrqtpZmLg+HSIiGJx7l3JXRyrgc/A3yHJNTlUCSOb5KZQmrPMw5
 Q1rINu1m1zM92voQJPt35xWsALvf+IBQ7dzmsVndfYAVppiyhU1aXM8tmoHHzjhEX305U5z
 NihZuqPL8sUTHW82CTQdLspX6mtBPL4/+2rpfELhH8F9T1G0NkleA9LTMtvGK2mupuu1xW4
 U0CjVHGzw6/8tg6SYQPGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OG3Uhx31Dzg=;Yx+9SC+ZX4t9YA1Poa1wdqVl4a4
 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
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
	TAGGED_FROM(0.00)[bounces-296235-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F47E650921

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
is needed, especially for the RTL83xx SoCs. So add this lineup of=20
devices, that are known to have no obvious bus parallel access=20
issues (at least from testing and vendor SDK perspective). =20

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--


Markus Stockhausen (5):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
  net: mdio: realtek-rtl9300: Add prefix to register field defines
  net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
  net: mdio: realtek-rtl9300: Add registers for high port count modes
  net: mdio: realtek-rtl9300: Add support for RTL931x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |   6 +
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 210 +++++++++++++++---
 2 files changed, 183 insertions(+), 33 deletions(-)

=2D-=20
2.54.0


