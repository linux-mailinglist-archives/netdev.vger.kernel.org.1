Return-Path: <netdev+bounces-291872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KYfKOvdFWrTdQcAu9opvQ
	(envelope-from <netdev+bounces-291872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:52:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F145D5DAF74
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E5330CF287
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE13537ED;
	Tue, 26 May 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="K1+5VHdl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F1413D8B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817473; cv=none; b=rZHdxJlyQsRV8W/ucrGSh5JhorCxcG6l4dut4GhjrT0f+PiCsV3/xul1YA+n0AHUUzeNx6njzynQjm+AQZVej1mReO5wezpPUeRp4xv4EiGQZvtz2szhxRNriIgvodEKwmJ1Fu8yl00FrZeswPP++VjdtZMIDK4WfGoi2vrjM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817473; c=relaxed/simple;
	bh=/ZdT3O3e1zQjE9qyso2pTuXkY1kMkiFojOnB4zdIP6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTkITk3dFyuiJspy/lRwP8JzgbRdXZj9QdC9nBubs4EKe57W7/ZuixR5Cq0HpBl1A+Akpv0Bu+A3pK5GX91pw3pVELg4HYCJyXHcL51OjfXpZF3/jiAspLezDEesHmsAbBYAkJ5Ug3Y+soMVgpWJXbe123c4MnrKpXOazztFStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=K1+5VHdl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817442; x=1780422242;
	i=markus.stockhausen@gmx.de;
	bh=cuPAqG8i7bmQ0P79jZ/PLEes1/KofmhNYjxuAGBLTqc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K1+5VHdlIql1NHBVu6sXI+prVvYwYjtaSLxLOrgB6BdjcMcGxeq9P3q59HacZF6A
	 tAkdtaYVI2JY8a81UlJcUyC77eH0pvckD9gumpq/xHfP0NEvN9dyqxztrrBnwvJUi
	 BR+cFePjCmopZygN+Uzdom/GYqbTJrnBtbjUbEa3nwjgVi6DL/MeVr2uXRniZBKVG
	 XDEW1h6mcnxIYFXtke7MgY2bD5O4FKRW0JtCErXKrjwgIyxY1l/ab3bYEgT4Huy4M
	 GGSVT2KAEiFXxS94MIEmItYAKf/66bQoHvyfebIXgLNNo2o2+q/c5lP/Lhd2ocZ14
	 4dT/54utzBewe22xdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1wlvNh1ALL-00MowL; Tue, 26
 May 2026 19:44:02 +0200
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
Subject: [PATCH net-next 0/5] net: mdio: realtek-rtl9300: SoC independent command runner
Date: Tue, 26 May 2026 19:43:39 +0200
Message-ID: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4GIE0wusfrLl0poK9uj8jaKhDLGjeAiiVxOm2aeUQ5qBEGKHUv
 db7C9ceo8se5ildcugu1Y2bHsc7uDVpF6zGvCCk5e31J4V2ZczpSiQGYXhqDzi6VcpLASFC
 UiW96ciNLGJ9xdMRAXNg13mzUzvQYRV24pWtgp4KQ7vI62dcqtAdWojHNlH8LUEtlCltECk
 mOBUw3FN3Wcwx7DenIM8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7UgOW/7atfY=;0yBHo8d+uFmbOJtf9BHbBWr3Kte
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291872-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: F145D5DAF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek Otto switch platform consist of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

After establishing basic groundwork for multi device support, this=20
series harmonizes the command handling of the MDIO driver. This is
the second step to allow easier integration of the non RTL930x SoCs
into this driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

=2D--



Markus Stockhausen (5):
  net: mdio: realtek-rtl9300: provide generic command runner
  net: mdio: realtek-rtl9300: use command runner for write_c22()
  net: mdio: realtek-rtl9300: Prepare command runner for reads
  net: mdio: realtek-rtl9300: use command runner for read_c45()
  net: mdio: realtek-rtl9300: use command runner for read_c22()

 drivers/net/mdio/mdio-realtek-rtl9300.c | 319 ++++++++++--------------
 1 file changed, 132 insertions(+), 187 deletions(-)

=2D-=20
2.54.0


