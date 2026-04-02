Return-Path: <netdev+bounces-274550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mINnE4RxzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:39:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D5389DF5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E92133084816
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCE2DC76C;
	Thu,  2 Apr 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VNhSVLo7"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFC2D592C;
	Thu,  2 Apr 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136648; cv=none; b=Av1YxKIF0FlFsjOW7mIMZwjHJ67T6iZLJrOUxDmEC5s5a5jrkr+OfG0SO/yjdiFprIZx/6UdnpSmsShwDfM5yXRQvtcgsSv9RmCPLthVdKTC8MQiv0BVAPg/XPJWcYfIes/Hf+ZJZgfMb8x5mXdWVlm2tPP9mWEnV1wAXwbhlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136648; c=relaxed/simple;
	bh=ppLZGurTfCbZTttnNBngDUHRWiboaui5MXdni7c8hJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXxZHbU/RPfjyTCSzVKhH/8gHS16Bc5lDm6x4JMPoxIYUyShP1FKccqyRzOFc2xxMEI2asCAufgaY5UjIounrNblta973UwwVH5Y86SYvomwJmrnjm6m7Sz3i/TrbNMIzTE7zrSGoe5HVhDw1rlR/v2eb4m1/B0e/SLHH1Bc//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VNhSVLo7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 632DU5syC3170864, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775136605; bh=ppLZGurTfCbZTttnNBngDUHRWiboaui5MXdni7c8hJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VNhSVLo7wNTP9gz1mfmJuOIy0NfznL6KXPMIMr8Iy2DMifGCJ18nxs9uuKzxBrzxm
	 bTlBA7OJ8IRH42pbM04fC6PEvIuUdBizo6cqyHZjXgDSufMlk6lit29024eFtXS1JE
	 2NsGZo6OnRjVx/Uc6qwfkjdKagvn3wSLBIVCJwZ1V1gd3HVa4za3ex/PgmlV/+c27u
	 EQuHJUTgIuzA2Cw80hRuohP1a4zcaTbv7YUouRcBTzzq5a3mXG9nAEhr1dHSPGy1ks
	 JJ7pBk7yahrUZdMckvjOC5fPuZTyQRpRtCm2p260Tt4DQABKKaphnFWqNpY0ZmAX6Y
	 EzrBpbwygg/ww==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 632DU5syC3170864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 21:30:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 21:30:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 21:30:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::3d92:67de:2cd4:b292%10]) with mapi id
 15.02.1748.010; Thu, 2 Apr 2026 21:30:04 +0800
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
Subject: RE: [PATCH net-next] r8152: Add helper functions for SRAM2
Thread-Topic: [PATCH net-next] r8152: Add helper functions for SRAM2
Thread-Index: AQHcwfmGF8XAe1q65US4/J+ypPXsGrXLxT6g
Date: Thu, 2 Apr 2026 13:30:00 +0000
Message-ID: <18abe2c485bd44aa95b30c6cd622cd96@realtek.com>
References: <20260401115542.34601-1-nic_swsd@realtek.com>
In-Reply-To: <20260401115542.34601-1-nic_swsd@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mork.no:email,davemloft.net:email,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B81D5389DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Wednesday, April 1, 2026 7:56 PM
> To: kuba@kernel.org; davem@davemloft.net
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> edumazet@google.com; bjorn@mork.no; pabeni@redhat.com; Chih Kai Hsu
> <hsu.chih.kai@realtek.com>
> Subject: [PATCH net-next] r8152: Add helper functions for SRAM2
>=20
> Add the following helper functions for SRAM2 access to simplify the code =
and
> improve readability:
>=20
> - sram2_write() - write data to SRAM2 address
> - sram2_read() - read data from SRAM2 address
> - sram2_write_w0w1() - read-modify-write operation
>=20
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


