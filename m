Return-Path: <netdev+bounces-271352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIm6NAxQw2lGqAQAu9opvQ
	(envelope-from <netdev+bounces-271352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CD31F011
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D89703037778
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFC2BDC3D;
	Wed, 25 Mar 2026 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QTJYcWCm"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E133FFD;
	Wed, 25 Mar 2026 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407690; cv=none; b=NwDpZ+IdOlkUMAL/ORPjmt02boPlffz9AosiDFx9D0+QVVu6f4dIsD00ED+5DdMG1xYvX3fKIabFyOeoF/Nzloqse3gQHDOeLyMSm0XEZxa4yqLTs9lO5RDyUAhv/vnejrsODWnwMS0Ku630DDWF8qdAxA30sayc86qKx6bD8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407690; c=relaxed/simple;
	bh=NgBtXumRYzlCnV3Yn7sZqZQ6hn+kEyQe8IdIsmh2PqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q48/BCNJU9PTh6lzuB5b6vT2cqkrFeiGPZuZk6icVZ4b3reZgtzwLbUqjI0g31/Pp8cDUKWFeiuhd7Zy0EwJ3Ssx6NR+OxOQez4kR7GQOFQC1HAHwbCLLyoAK80RkfYGh5p9nLxDoCo1Ohpeco63sFT1qLe+UsigVURQ55Ajvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QTJYcWCm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P30n8tA2439054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774407649; bh=gyX10HvKWq0m3Gjf5BnS2Fo+ddbTNDryB1fDJNtEqqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QTJYcWCmCunPaJEc0SBlq3iY6gr216XE2pcJVTEYIcntjOzXBE0cL37So92m15a8y
	 We+UyCU5d3wUGuL8fIAf3jjBbDydukdRXkLBTX2lGPl4OdGpINaTImYrvhQhe1rPsg
	 2HHIyKxD3RhLsicLdZVCg6LyR+lGyAJr/XnNqXRjeE1l6yKGT9YwEnMwZjAwwCJz6R
	 C5T9rTYpm3FRGsbQli/7jmMHmfnQmKigoOXkKOUGzPJRWZ4CMDQQeac7P6WRpDtKEZ
	 n/2vpipAC1nY6VPNC3OG7GxKtdTNbmBUkyqqD49kHE5DASM95Mg2vI4urG9e411PgV
	 pmBIRdWKpZyTg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62P30n8tA2439054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 11:00:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 11:00:49 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Mar 2026 11:00:48 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Wed, 25 Mar 2026 11:00:48 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>, "kuba@kernel.org" <kuba@kernel.org>,
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
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Topic: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Index: AQHcup5ZqnjknxQNN0m9fKk+ygYNm7W8rK6AgACQ0bA=
Date: Wed, 25 Mar 2026 03:00:48 +0000
Message-ID: <48a0d72d1cad401fb19cd1f5353b0755@realtek.com>
References: <20260323082226.2601-450-nic_swsd@realtek.com>
 <20260323082226.2601-451-nic_swsd@realtek.com>
 <be38bdf5c2b64629920bfe6688907992@realtek.com>
In-Reply-To: <be38bdf5c2b64629920bfe6688907992@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-271352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 792CD31F011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/26 2:04 pm, Hayes Wang wrote:
>=20
> > @@ -7166,21 +6942,17 @@ static void r8153_init(struct r8152 *tp)
> >  	r8153_u1u2en(tp, true);
> >  	usb_enable_lpm(tp->udev);
> >
> > -	ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6);
> > -	ocp_data |=3D LANWAKE_CLR_EN;
> > -	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CONFIG6, ocp_data);
> > +	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6,
> > LANWAKE_CLR_EN);
> >
> > -	ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG);
> > -	ocp_data &=3D ~LANWAKE_PIN;
> > -	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
> > +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG,
> > LANWAKE_PIN);
> >
> >  	/* rx aggregation */
> > -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
> > -	ocp_data &=3D ~(RX_AGG_DISABLE | RX_ZERO_EN);
> > -	if (tp->dell_tb_rx_agg_bug)
> > -		ocp_data |=3D RX_AGG_DISABLE;
> > +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> > +			  RX_AGG_DISABLE | RX_ZERO_EN);
> >
> > -	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
> > +	if (tp->dell_tb_rx_agg_bug)
> > +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> > +				  RX_AGG_DISABLE);
>=20
> I think you could combine above, such as
>=20
> 	if (tp->dell_tb_rx_agg_bug)
> 		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_USB_CTRL,
> RX_ZERO_EN,
> 			      RX_AGG_DISABLE);
> 	else
> 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> 				  RX_AGG_DISABLE | RX_ZERO_EN);
>=20
Indeed, I will fix this in v4.

> >  	rtl_tally_reset(tp);
> >
> > @@ -7200,7 +6972,6 @@ static void r8153_init(struct r8152 *tp)
> >
> >  static void r8153b_init(struct r8152 *tp)  {
> > -	u32 ocp_data;
> >  	u16 data;
> >  	int i;
> >
> [...]
> > @@ -8306,48 +8028,39 @@ static void r8156b_init(struct r8152 *tp)
> >
> >  	usb_enable_lpm(tp->udev);
> >
> > -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_PLA, PLA_RCR);
> > -	ocp_data &=3D ~SLOT_EN;
> > -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
> > +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
> >
> > -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
> > -	ocp_data |=3D FLOW_CTRL_EN;
> > -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
> > +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
> >
> >  	/* enable fc timer and set timer to 600 ms. */
> >  	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
> >  		       CTRL_TIMER_EN | (600 / 8));
> >
> > -	ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
> >  	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) &
> > DACK_DET_EN))
> > -		ocp_data |=3D FLOW_CTRL_PATCH_2;
> > -	ocp_data &=3D ~AUTO_SPEEDUP;
> > -	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
> > +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> > +				  FLOW_CTRL_PATCH_2);
> > +
> > +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
>=20
> I think you could combine above, such as
>=20
> 	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) &
> DACK_DET_EN))
> 		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_FW_CTRL,
> AUTO_SPEEDUP,
> 			      FLOW_CTRL_PATCH_2);
> 	else
> 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
> AUTO_SPEEDUP);
>=20
Will do.

Thanks for your review.

Best Regards,
Chih-Kai

