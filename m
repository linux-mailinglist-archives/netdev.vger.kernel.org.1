Return-Path: <netdev+bounces-290585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLfkJEpKD2qNIwYAu9opvQ
	(envelope-from <netdev+bounces-290585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6525AAD15
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42E1E303EC1A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C83FD133;
	Thu, 21 May 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="nvAP7k6K"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AD282F0B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386400; cv=none; b=kBJFvP2z4eahgs+IT4MxbzHeROO0wGuYdrEirTRCY8tm6DEGMz7a496Zr+B8+uNJXJF+KV0qFDeZf7p7NihaLSldXLoYe4MYYOJaiBh48z1vBsUZu2S8FuBjWTKnoEW+QIDnwtKoofg3DNRoBf1brb5uY6JcV6y5QXF6ZPYnyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386400; c=relaxed/simple;
	bh=OdhQXR2G+gnUahVNfHLz5Q8/pQV7aZdkn/yeyyCKHbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+fTrHSeVYz7HyUKg0HmDYeLszTGrCsjMrlyg82lfTVQsadIDZ0LECL1H0Qr0CRgjFSQURGccHyiJcS+UhDxCYNKCGoWfjBzsQxVlaq2c20MytE3duvf5vH69d7D/Cf9OYb2D+ayzdE4P1HDeubJJ19LQUh7//Na5OGjru8soTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=nvAP7k6K; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386375; x=1779991175;
	i=markus.stockhausen@gmx.de;
	bh=DeTxQWMKN9wi7oDA+e4DLfRThoStp/eB4G0wWFtuj/E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nvAP7k6K9NZSXYHoEMtV+067a7+qMSCviz08Q4txU70N24ApkSih3yEntXGQEGD3
	 yJiIMAPcoZvGa2qyHhg8lI+ufxvHRFz69K9FEMWwcL/2p+/FzqQeZbWTkSMA3c7+g
	 bBgUvdcunP7GTSTHPQgVqBTpWNR1t6k1/xVF2shaxFUu1PfhVdb6F0Cfk8yWuspXg
	 GSQcd53Oc6DYkEoifSmx/1mXbAYX6I6lEEajAgb4CFAsKzQ6iQSsEGl4pco7LgQ1/
	 x0ScZEagWCVzxMSacizlVBcOFmqotjeZ/dfHbgY97oKq3SrxLBohRbbJxxmqNXL2Z
	 VEPVNt1sd3ILGS6flg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1x7TFs2jSt-00h2pF; Thu, 21
 May 2026 19:59:35 +0200
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
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 0/9] net: mdio: realtek-rtl9300: Groundwork for multi SOC support
Date: Thu, 21 May 2026 19:59:09 +0200
Message-ID: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U9GosWfjuYXWBVQ3F7L1nQ1rdvIEfDogsMqr9B3dM1ecFGV5kUk
 jY9Ept/Liold23Z2UHsa9c6uNROMO/VG9ubmGX/Jk7FsKxjOUJgxZ/kyuOPWYpCmXtifSli
 7YgRmLByvGCEzdd6fUpK0a2KHgOElk418yg127Z4aYd66kNanyNhKnyrhjqHCdmKcKm8wKl
 IiV6xGOC/1INZZ7ihkTmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:08sOwGpTczM=;u5TReJJwh92LEN21YN/7lLNcgtJ
 +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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290585-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A6525AAD15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek Otto switch platform consist of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

The existing realtek-rtl9300 MDIO driver was only designed for RTL930x
devices. The three other SOCs are not supported although they basically
incorporate a very similar MDIO controller.

This series is the first step in a multi-stage approach to also support
the missing SOCs. Device specific properties and registers are converted
into designated initializers. Based on this new devices can be added
much easier in future commits.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2:
  - Reword all commit messages so it aligns with the hardware and MDIO
    specifications. Describe in more detail what each patch does.
  - Enhance in-driver documentation and add an end to end I/O picture=20
    about the port based addressing.
  - Change function prefix to otto_emdio_
  - Adapt raw page macro to RAW_PAGE(priv)
v1: https://lore.kernel.org/netdev/20260519165747.1288903-1-markus.stockha=
usen@gmx.de/


Markus Stockhausen (9):
  net: mdio: realtek-rtl9300: enhance documentation & naming
  net: mdio: realtek-rtl9300: Add device specific info structure
  net: mdio: realtek-rtl9300: Add ports to info structure
  net: mdio: realtek-rtl9300: Add pages to info structure
  net: mdio: realtek-rtl9300: Add register structure
  net: mdio: realtek-rtl9300: Add command/C22 register
  net: mdio: realtek-rtl9300: Add I/O register
  net: mdio: realtek-rtl9300: Add port mask register
  net: mdio: realtek-rtl9300: Link I/O functions in info structure

 drivers/net/mdio/mdio-realtek-rtl9300.c | 262 +++++++++++++++---------
 1 file changed, 168 insertions(+), 94 deletions(-)

=2D-=20
2.54.0


