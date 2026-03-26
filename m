Return-Path: <netdev+bounces-272050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNZ5JrMzxWlS8AQAu9opvQ
	(envelope-from <netdev+bounces-272050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:25:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35160335E9A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF03309EA90
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB33F7898;
	Thu, 26 Mar 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qa5yMiLN"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440C3EF67D;
	Thu, 26 Mar 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531140; cv=none; b=jZ+msfGWkgP5o6FOw7CqBbv/7eTR2yEkT6dn0rgFfwMNEOu67rvBIbRnLOy07t5OzA884FKlFXbPPQUMS+4EpmortK1w3t1AIOFq3o66Husgj/gVJz+QMoD0VNOcAPXUNOFiItz5slE3Gbi+zqvMXOI5u/QJutRTrBP8eoEdbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531140; c=relaxed/simple;
	bh=dbSlJJLZr0aDkUKCge5XYxPSmLToKME6MYNLXskWdG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HN0/jKtInHPoSn9neQQqT23BeOcIQ4rP38D0kfRyQ8nFhqnYESLGxB1LY45wDY1JBbCL2POwZM93fAsXOkTb2NoMgc/+VN/mKX5XsasXKixa8q4H1HNCIgDhA4cmSa8tVLjE/xfYyK+lTPykZSpOHq3hh5WC5ak9wjRlg6TMVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qa5yMiLN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62QDIN1801573874, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774531103; bh=dbSlJJLZr0aDkUKCge5XYxPSmLToKME6MYNLXskWdG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Qa5yMiLNgKN4NGypfhmmU2ZphpmWmn3nwilmPv4bEITdcNGQNTOvjl2ncH7YsS20p
	 Tqqdw7zq+A1nDqyuZY1fI36Zka6BVzE+whMMS9A+P58hmGhDJ49rpnRFstkFNWC01q
	 it46x/ff3OaykAQXtYvJ5qw34nHvEQ2Vnmrap9XCaF6NU78SNNvzzD7RSOn+qmJ6+r
	 m5b4xAr7GIqf4dQ8lSVmgU5vBOU+8KDMHidryttzreuQ3O83IwjAYhVi3PU9m/fWll
	 qSyvMoxO3uL1M4VYFgAN2yAxD+41iNgvz8tD12k5d+3KWCQWtLq6hPakTXPZu6Rf+K
	 OM0ZayGg9wUsw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62QDIN1801573874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 21:18:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 21:18:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 21:18:23 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd
	<nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: RE: [PATCH net-next v4 1/3] r8152: fix incorrect register write to
 USB_UPHY_XTAL
Thread-Topic: [PATCH net-next v4 1/3] r8152: fix incorrect register write to
 USB_UPHY_XTAL
Thread-Index: AQHcvPOycbfPy/dSukipZ8LkOW+IpbXAy+uQ
Date: Thu, 26 Mar 2026 13:18:23 +0000
Message-ID: <9260dd860db047858a5a505bf2b2430e@realtek.com>
References: <20260326073925.32976-453-nic_swsd@realtek.com>
 <20260326073925.32976-454-nic_swsd@realtek.com>
In-Reply-To: <20260326073925.32976-454-nic_swsd@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mork.no:email]
X-Rspamd-Queue-Id: 35160335E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Thursday, March 26, 2026 3:39 PM
> To: kuba@kernel.org; davem@davemloft.net
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> edumazet@google.com; bjorn@mork.no; pabeni@redhat.com; Chih Kai Hsu
> <hsu.chih.kai@realtek.com>
> Subject: [PATCH net-next v4 1/3] r8152: fix incorrect register write to
> USB_UPHY_XTAL
>=20
> The old code used ocp_write_byte() to clear the OOBS_POLLING bit
> (BIT(8)) in the USB_UPHY_XTAL register, but this doesn't correctly clear =
a bit in
> the upper byte of the 16-bit register.
>=20
> Fix this by using ocp_write_word() instead.
>=20
> Fixes: 195aae321c82 ("r8152: support new chips")
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


