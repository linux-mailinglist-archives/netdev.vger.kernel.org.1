Return-Path: <netdev+bounces-273524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJaFNJGGy2l4IgYAu9opvQ
	(envelope-from <netdev+bounces-273524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:32:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6723662D0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3F830137B6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EA3DF003;
	Tue, 31 Mar 2026 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R/E5nmoq"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183083DDDDA;
	Tue, 31 Mar 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945679; cv=none; b=JgtKfjBAXmiaM2NEJP6jiJ2Aa+pSwcQrFURS5Pjn4WsulWMKHwp4JL06b2lcqdGbIQF4ubyYz/yssQ1f48MY/U+MCogGQN+9m8Ij/zKoiFwMWFx3XVBkrU78L/ktKpdL8gavuuuqCgrryLQbqMR9y2GHGWHYGWtsQ14lrMBmESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945679; c=relaxed/simple;
	bh=tfglbo7YKFh2nE83V5/6Vy6ooHG3lE7ZaYqSgCjhWQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJCrOVJWeImCo6+f04gcqZy7B9pHK2Qf4GWhyceyf7je0EmVT45PnGEFJ3rlTrNtl9wEL93IUPpTvykgIo+VPlU8jXRskG0CerQFDGSoWx4+eeW0SDfWdizvFM99WhkkqDEaOGgeEKNZ2CplHVlzTMyS3Tjc1mXyk0yk23zPVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R/E5nmoq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62V8RHFc82892489, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774945642; bh=iB1i/PR6VgFdbFeV7giDXrZhrIHgPqwhIP44cV5hbDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=R/E5nmoqOoZyABXAujzTamvpDzZ/W512LVV2aSo6eivnSUaYgEoZxcUFlqAIAojRg
	 3/KMoxUUyVyV993woaIUD2Jer3sLI0tbrDWSa+yUUPK3PQGPZgDCtXHz2ADAVTb6GW
	 ViPfrvN18X6srUQ1nTDFg8UItr3CCbfGKzSdbmxIpRaUcegJBHzkoBO7zJ8Fpnvfm6
	 FWByvr3xftZcHqUoJB8o8wM+NxN7lvuoRveTb4//QGJTOM7dfn6XiUuKNTSCFl0fzg
	 NZn6BpB4tvsGLHBViM5Ae/Fk1/6wW/DK1MqUiznytiA3MFNsyWJ9Llt+ukIv6/Ly+k
	 wNI3usTtS66qw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62V8RHFc82892489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 16:27:22 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 16:24:38 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Tue, 31 Mar 2026 16:24:38 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Topic: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Index: AQHcvPO0ywoZAMBFW0+K73BymOGShLXHZLAAgACjrzCAAEsN0A==
Date: Tue, 31 Mar 2026 08:24:38 +0000
Message-ID: <44da80d47d2140f687f57df2ed602c02@realtek.com>
References: <20260326073925.32976-456-nic_swsd@realtek.com>
 <20260331020156.3518006-2-kuba@kernel.org>
 <0fb2fd8f26334b578c299ee71958202c@realtek.com>
In-Reply-To: <0fb2fd8f26334b578c299ee71958202c@realtek.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,mork.no:email]
X-Rspamd-Queue-Id: 1A6723662D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Tuesday, March 31, 2026 1:46 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; nic_swsd
> <nic_swsd@realtek.com>; linux-kernel@vger.kernel.org;
> linux-usb@vger.kernel.org; edumazet@google.com; bjorn@mork.no;
> pabeni@redhat.com
> Subject: RE: [PATCH net-next v4 3/3] r8152: add helper functions for PHY =
OCP
> registers
>=20
> On 31/03/26 10:02 am, Jakub Kicinski wrote:
> >
> > > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > > 32a4e8d423115..8747c55e0a484 100644
> > > --- a/drivers/net/usb/r8152.c
> > > +++ b/drivers/net/usb/r8152.c
> > [ ... ]
> > > +static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear,
> > > +u16 set) {
> > > +     u16 data;
> > > +
> > > +     data =3D sram_read(tp, addr);
> > > +     data =3D (data & ~clear) | set;
> > > +     ocp_reg_write(tp, OCP_SRAM_DATA, data);
> >
> > AI flags:
> >
> >   Does writing directly to OCP_SRAM_DATA here actually write to the
> > intended
> >   address?
> Yes, this actually writes to the intended address.
>=20
> >
> >   Because hardware indirect SRAM access ports typically auto-increment
> their
> >   internal address pointer upon access, the sram_read() call will advan=
ce
> the
> >   pointer. By writing directly to OCP_SRAM_DATA instead of using
> >   sram_write(tp, addr, data) to re-establish the address, the updated v=
alue
> >   would be written to the next address (addr + 1) rather than the origi=
nal
> addr.
> >
> >   Could this corrupt the PHY configuration memory across the
> > initialization paths
> >   that now use sram_clr_bits() and sram_set_bits()?
> >
> > Can you confirm if this is legit? Not sure whether this device /
> > register auto-increments or where AI got it from.
> The address pointer, OCP_SRAM_ADDR, is not auto-incremented after
> sram_read(tp, addr).
> However, the address pointer is incremented automatically after
> ocp_reg_write(tp, OCP_SRAM_DATA, data).

That's strange - I didn't receive the previous email from Jakub Kicinski.
Also, the answer above is correct.

Best Regards,
Hayes


