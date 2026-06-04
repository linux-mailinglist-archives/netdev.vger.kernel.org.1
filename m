Return-Path: <netdev+bounces-295137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLVlInRHIWrFCQEAu9opvQ
	(envelope-from <netdev+bounces-295137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:37:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8E63E9AD
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=k5vjNC4n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295137-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0CD30DF489
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD573A3830;
	Thu,  4 Jun 2026 09:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CD299931;
	Thu,  4 Jun 2026 09:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565291; cv=none; b=u0BfoNuQTmSonWBh7xsc13wo9tHSV4x6oLCR0Kom737jC9zSiz6e2Pif6tGOkgtAQqxKk6r2AE6k2d4T3qZh/yC+gkrMQhVQyPhDggYsAToqCDpyT0qlPtBrLqyL6O41clrsr7BR1pPFPfE0ATH4Wb45sLesTfQOccG9uK4cU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565291; c=relaxed/simple;
	bh=0sERuNzUlon60NH1Auwx6L7IMB2nqtA0p7z5GpOk898=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=phnk+oat7yS52Ezj/2hVHEFmT5wXsg3bkM1TcSJtU0tjI5nWoLFG6/rDDTO3eMwsJ4wmBCpiDjdZE3qouPWZJSA02z4T3jKTb9yqX941/gS1TQdHxZx3nCT+Q+RGDBaXciN+qVrjuh4Df7ii60Hs7XutlnV44gFmvUrU3fwnyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=k5vjNC4n; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6549S2690251280, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780565282; bh=0sERuNzUlon60NH1Auwx6L7IMB2nqtA0p7z5GpOk898=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=k5vjNC4nOv7VQstPo7chZ/kLvIVJ0PBRiPixhrJAzAvPX8xs0mU7G29faBgL8WjiX
	 UAJLKzMW83fz3nXZkkkwcTNvuwfsU8BALyxgajbw5kYWh0lihd7qdju6xXdWO5NKH9
	 /cqe9dKA8x5TpgJXKPh2WbREcisrKAEjp/iImzI/d3ilcdsqWDI21r5e4sZHHg7OUZ
	 UMi7UjVMZTtAnlXPiDMG+W39Lg1I64N3YkUrNwWlxYzYtfqpKYQeXxXOTVmWiQAgmJ
	 A6Bnm5NMtNd4FOIfWbNwvJUlQdnUOvPmRPdefr2GUJly4Ryt19dyJh1KoUbFNXaFLf
	 RWM8hkyfjrqTw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6549S2690251280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 17:28:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 17:28:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::a2e:aeb4:fa27:c32f%9]) with mapi id
 15.02.2562.017; Thu, 4 Jun 2026 17:28:02 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, nic_swsd
	<nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: RE: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Topic: [PATCH net] r8152: handle the return value of usb_reset_device()
Thread-Index: AQHc9APCJVlwBSmXAEOkvH0w1LP1cLYuIDUw
Date: Thu, 4 Jun 2026 09:28:02 +0000
Message-ID: <4bf89cb16f754e748f4db485e1376d3d@realtek.com>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
In-Reply-To: <20260604092247.27158-450-nic_swsd@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim,realtek.com:from_mime,realtek.com:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAB8E63E9AD

Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Thursday, June 4, 2026 5:23 PM
> To: kuba@kernel.org; davem@davemloft.net
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; Chih Kai Hsu
> <hsu.chih.kai@realtek.com>
> Subject: [PATCH net] r8152: handle the return value of usb_reset_device()
>=20
> If usb_reset_device() returns a negative error code, stop the process of
> probing.
>=20
> Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


