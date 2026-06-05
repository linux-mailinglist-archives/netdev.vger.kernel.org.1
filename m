Return-Path: <netdev+bounces-295600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tu2NMf84Imr4TwEAu9opvQ
	(envelope-from <netdev+bounces-295600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:48:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E9644BE1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:48:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=QFgwXWsG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295600-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B339304823D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAEC375F81;
	Fri,  5 Jun 2026 02:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797043B1034;
	Fri,  5 Jun 2026 02:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627376; cv=none; b=kfVLlO68BU7mXV3GdrcgMB13jdzB3HXiOh1F2FdnNJztF4/yma+qjBMpcDUsdshbhouU7NLg+OCO3Z09rSKfLdlqSLOujiH3HP7Sym32YmBpkWs7gdpch7P+jpcqe33ULJRLgmChscAIw3KOcfy/OBkgef+FMjQ/kTwsg2Mp0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627376; c=relaxed/simple;
	bh=knbVBzJHTBJPWyNraPAnWOt877mFScuJwtybl6ywCGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b8POEw7x7cWOECIFyfwyilBzBliOgvJ/h4HUt1nd7dfNncM1dVjFJKVGYXsYo155SIa2YQt0E+2UbFaDy58/s1dLaZI47gHgBHkR6Q96310mgYoqPFTZn1PWky/76dQELkewpn2giQ5EJYd13jQuaFM97qufUR95hzGAfbmMFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QFgwXWsG; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6552gZtgD1062172, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780627355; bh=MRgeh7Vod5VyrL8PqUQs6OOiUqbq/RWGPVA2a0PITHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QFgwXWsGnsRGyvhcKw44FxU0C9r77WSMy0nAzAIW1x/IvZaq8E4QZPPrbwV0BPsRj
	 BnsmAQ0V5XjH5OaSXZeovWYVywaVklpS5MutlTaCr+3KpsthR3+NY5j/R3U0JrqGL+
	 ik1HCJ0h1fasGCL5NobkE7e09rdxoL5wnEQg5KTcHSt9c//SoDlAQV2yVV2mSMFnUY
	 kkwtZQP2fuVCLXhh+R6EZQQEe/ZyaorrsUibAfuzxNhwIbVeeGmOHiY6s6rvRAdI+h
	 YbKAy2+WHp9jTMbTW5KBEu0Lops7gUM2WwlAjif23e1uU31cyDf7LpiRx+1wkdOQdM
	 q++xnVZ+JZp6A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6552gZtgD1062172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 10:42:35 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 10:42:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 10:42:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 5 Jun 2026 10:42:34 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Topic: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Index: AQHc9APC9XApZAQtH0mFd55w2OdfKbYt1DKAgAFpdUA=
Date: Fri, 5 Jun 2026 02:42:34 +0000
Message-ID: <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
In-Reply-To: <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D8E9644BE1

On 04/06/26 8:54 pm, Andrew Lunn wrote:

> On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > If usb_reset_device() returns a negative error code, stop the process
> > of probing.
> >
> > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
>=20
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>=20
> Does this bother people?
Yes, it does.
If the driver does not return early when receiving an error code from usb_r=
eset_device(),
the subsequent execution will trigger a kernel call trace.

>=20
>         Andrew

Best Regards,
Chih Kai

