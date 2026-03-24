Return-Path: <netdev+bounces-270882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJUHCZArwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:13:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436E302AA1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DEE31583F7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743E3AE1BC;
	Tue, 24 Mar 2026 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="P450m6/C"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF63AB27F;
	Tue, 24 Mar 2026 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332309; cv=none; b=iNBSWbp/fpYsm6PQxV1GZZLo/r6m7tdzetJ592BrzVm57g8z8vWp2pc3g7Y0oGaMlbvflWggArv4BiZJWkUXGyLDggNdf0w9mxZPrLtFarr+Lp9NcgiOP1/FAva+DASbBLyD5/PAJv/u6/bqtamvFYsU1N7uBf8RT+Oett4eTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332309; c=relaxed/simple;
	bh=lgAOaXwx63jlZ4NF20oAO80m0dmNmB7iY7fzgBRIj8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M0eu/RSGBXnF6ruCBM5TuhEL2/LQV3B4DQMEu9u9XT+BSifiNzs8WVhTE8wLqCY4nX7zQ7WBKwS49Xz8DeQBIWjg4Yv+pbDi3q2GdmqNnNHQQzEE+loEro020TzGzMyDZsAt6vLSod6cIpyxVK495w4eSpIMN71KNmcVgQgreGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=P450m6/C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O645JB0536955, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774332245; bh=o+uAhGp4kUANfU1omeqOJ3VOe58cQQosKNTQYobN19s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=P450m6/CUeZaD3dg/msc9e2HqJXPwaRB+F15n0DWj8ZUMUVEOkndIUHdwDO9Fo6qt
	 7oNfgaW6075bB6EVr9CE9eR+nfujQVsvbCZK181fhsIHnjBUVbg0FeQD6f1Rnc9+sl
	 ide502pG8PpXvBThuafr0yeBL1DZmxwlSu22PHPOOlqelwegNTm9hAeFasaw89e9DH
	 rvmc111B1T1D2QoPljqj6QbG37LhJ8dte0OyPBHfet548dTo+7ZbHxyRIKH4K3HkaY
	 Nlta2+20RVJjmmRfv7Nhgqf1R9+S0Ai21DMEo0Ng9QJlr9tFUuzsgEsAvYvr031MFa
	 D+s2ifQQGbDXw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O645JB0536955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:04:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:04:04 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 24 Mar 2026 14:04:03 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Tue, 24 Mar 2026 14:04:03 +0800
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
Subject: RE: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Topic: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Index: AQHcup5a2tbaq/y5fUWL1A5/CeAKfrW9LZWA
Date: Tue, 24 Mar 2026 06:04:03 +0000
Message-ID: <be38bdf5c2b64629920bfe6688907992@realtek.com>
References: <20260323082226.2601-450-nic_swsd@realtek.com>
 <20260323082226.2601-451-nic_swsd@realtek.com>
In-Reply-To: <20260323082226.2601-451-nic_swsd@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8436E302AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Monday, March 23, 2026 4:22 PM

> @@ -7166,21 +6942,17 @@ static void r8153_init(struct r8152 *tp)
>  	r8153_u1u2en(tp, true);
>  	usb_enable_lpm(tp->udev);
>=20
> -	ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6);
> -	ocp_data |=3D LANWAKE_CLR_EN;
> -	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6, ocp_data);
> +	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6,
> LANWAKE_CLR_EN);
>=20
> -	ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG);
> -	ocp_data &=3D ~LANWAKE_PIN;
> -	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG,
> LANWAKE_PIN);
>=20
>  	/* rx aggregation */
> -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
> -	ocp_data &=3D ~(RX_AGG_DISABLE | RX_ZERO_EN);
> -	if (tp->dell_tb_rx_agg_bug)
> -		ocp_data |=3D RX_AGG_DISABLE;
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +			  RX_AGG_DISABLE | RX_ZERO_EN);
>=20
> -	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
> +	if (tp->dell_tb_rx_agg_bug)
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +				  RX_AGG_DISABLE);

I think you could combine above, such as

	if (tp->dell_tb_rx_agg_bug)
		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_ZERO_EN,
			      RX_AGG_DISABLE);
	else
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
				  RX_AGG_DISABLE | RX_ZERO_EN);

>  	rtl_tally_reset(tp);
>=20
> @@ -7200,7 +6972,6 @@ static void r8153_init(struct r8152 *tp)
>=20
>  static void r8153b_init(struct r8152 *tp)
>  {
> -	u32 ocp_data;
>  	u16 data;
>  	int i;
>=20
[...]
> @@ -8306,48 +8028,39 @@ static void r8156b_init(struct r8152 *tp)
>=20
>  	usb_enable_lpm(tp->udev);
>=20
> -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR);
> -	ocp_data &=3D ~SLOT_EN;
> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
>=20
> -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
> -	ocp_data |=3D FLOW_CTRL_EN;
> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
>=20
>  	/* enable fc timer and set timer to 600 ms. */
>  	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
>  		       CTRL_TIMER_EN | (600 / 8));
>=20
> -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
>  	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) &
> DACK_DET_EN))
> -		ocp_data |=3D FLOW_CTRL_PATCH_2;
> -	ocp_data &=3D ~AUTO_SPEEDUP;
> -	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> +				  FLOW_CTRL_PATCH_2);
> +
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);

I think you could combine above, such as

	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP,
			      FLOW_CTRL_PATCH_2);
	else
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);

Best Regards,
Hayes


