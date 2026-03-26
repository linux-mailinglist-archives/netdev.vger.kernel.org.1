Return-Path: <netdev+bounces-272062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAJ4BZo1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:33:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60833602C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AEB231A2CE8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843B2D838C;
	Thu, 26 Mar 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i2Puj8Tx"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74A23183F;
	Thu, 26 Mar 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531219; cv=none; b=B4xnvUwizxm6s+OFFME31EEKjkaaybWYon5Dche+eoZdLIgnlPjpeAzebX7yd5G0HIGWPjWr+VKnGUCoPfeim3qFu3c2R3yVYxk8ytP/xiXI7iwgyCYuT2YM9vl8l//HZp8lwkbKMADBpItcA9X3s06/Pp6eCO7UAt/kmdla4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531219; c=relaxed/simple;
	bh=6XlrwPqmw+0icn+y5ERG6JHVFPDcQZzFRoGuwD3WjXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGyvHmS1oXCT8iz++sOTxGU9xUwRoIbu38QUwcvDHP8PqFvam2HwJyoGehW0GzdoZGkIrntWlecC46lVGOJ/ghzKaOqRsfqjOPfcwcXqX6BjnmimIUJk+LsKnW3d0PyQT9Y2+pt7zUBg4slFjd/gQImaEMbfuf9OIUnaqGmjDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i2Puj8Tx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62QDJs9X21574616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774531194; bh=6XlrwPqmw+0icn+y5ERG6JHVFPDcQZzFRoGuwD3WjXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i2Puj8Tx+DAoIULw4bVJ/UKJAt3sRRcHq4wfEp8K1OqteMO/n421J0z8OQjXV9y3H
	 Ma2/00TS1webtI0Wotvjqx4uWatLL08puA7FAr1n2KgPtYWdgK+jDhidCTmP9icX/k
	 qc8GM9lg/R1lQobpYn8vU32Lpo+8HKDnv4+9eMwCTE4yGGnW6+CsDeSlC98ywtQk9E
	 9rpZeDhFaGYo5VQHe0sQtJChTkmLetYyh/FVjaRY8QNLg+LpMpTiCSfRv0gYb6Jdw3
	 0/fPsi4LixybVY0d5hpvh6zidy5AbF4DX4OMn1fc9/ofTzageMtHT58Onozh1SVnPP
	 NPUOamVe6BKGg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62QDJs9X21574616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 21:19:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 21:19:55 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 21:19:55 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 21:19:55 +0800
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
Subject: RE: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Topic: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Index: AQHcvPO0ywoZAMBFW0+K73BymOGShLXAzGEw
Date: Thu, 26 Mar 2026 13:19:54 +0000
Message-ID: <71b471b6aab74939be1d3abe6802adf6@realtek.com>
References: <20260326073925.32976-453-nic_swsd@realtek.com>
 <20260326073925.32976-456-nic_swsd@realtek.com>
In-Reply-To: <20260326073925.32976-456-nic_swsd@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-272062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,mork.no:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email];
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
X-Rspamd-Queue-Id: 7B60833602C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Thursday, March 26, 2026 3:39 PM
> To: kuba@kernel.org; davem@davemloft.net
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> edumazet@google.com; bjorn@mork.no; pabeni@redhat.com; Chih Kai Hsu
> <hsu.chih.kai@realtek.com>
> Subject: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
> registers
>=20
> Add the following bitwise operation functions for PHY OCP registers to si=
mplify
> the code.
>=20
> - ocp_reg_w0w1()
> - ocp_reg_clr_bits()
> - ocp_reg_set_bits()
> - sram_write_w0w1()
> - sram_clr_bits()
> - sram_set_bits()
> - r8152_mdio_clr_bit()
> - r8152_mdio_set_bit()
> - r8152_mdio_test_and_clr_bit()
>=20
> In addition, remove variable set but not used from r8153_init(),
> r8153b_init() and r8153c_init().
>=20
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


