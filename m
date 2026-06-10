Return-Path: <netdev+bounces-297543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DpyvHS8mKWotRgMAu9opvQ
	(envelope-from <netdev+bounces-297543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:54:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C16C0667762
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=R5oem+WO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297543-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD83322A4B9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98D3BD64D;
	Wed, 10 Jun 2026 08:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD173BCD24;
	Wed, 10 Jun 2026 08:41:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080908; cv=none; b=V+J5DzNzL4iNYz9/w8ADyEUN+6ZnGA8Ps5R7ZfLoA8QRCst4OTXYTer97ChV8uOSdd0u4Ql8YkqOCi2pphU/hUJ44hcZmXo+7MRnpl+Bwb49Ddfg5VMqp2hMeEVVLvvh6eCgT96IV62qddor7awkbSHMjb8JsP+3Ujd1AValkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080908; c=relaxed/simple;
	bh=3lFJnBqnKSo2+StgKXVA6UlMw2cv3e1IJkH4vnVp9ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mc9fi80jAbcCcVXLimnRNXfg5wShvE5p2PVT6lC8/hGMjoWyx+gbBz3gkWRRO1e7FKqw97ImkraPsk08uoBrwMG5D8brXE3+u5tdFWGQmTHjzTzF608OqE0eTE3oOR2aMyD/8smretrKkof/f2HwmAHg+i4tQF35yyGAeh4xcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=R5oem+WO; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65A8exfhF994810, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781080860;
	bh=vu7xMbJAOLWLR7XX0V4ysN/uopxYxfRnDPuIT7qo8OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=R5oem+WO4U/Wmziw9PmDIIMYzS6DjU+nLU72U/bNVRNz/+cAks9qtKm4oiGymkfkP
	 ngLvek6EVDP0/yfEsqu0BWzpT2sUCt0uszDPpSaMb8XRnjMN5+nuBq+fS+H7yWyqkG
	 GS7B68Ymd0jGRCglakMWfxVab715Nh2Z2j3rtAfvd9QkjevVt4xZhAkvWzLp70qViP
	 H8/ysTLaE4UBgJLTS/TRNzeD2T/G888MzpgIBc6gorFj5hg3aFl6WQbmYXoqf8VlkI
	 5guDUNnIaJMltWtFomxuw3B7C2vS5WZd2C2KlUR70dzceNfX0YxeKREqTvOODYKSv4
	 ShbKxaNahQbpw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65A8exfhF994810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jun 2026 16:41:00 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Jun 2026 16:40:59 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 10 Jun 2026 16:40:59 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Thread-Topic: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Thread-Index: AQHc9NeKx3fmMihSw0SPIMX6a9yYtLYwzGSAgANkRqD//5L8AIADs7/g
Date: Wed, 10 Jun 2026 08:40:59 +0000
Message-ID: <7473edee9a67407c81b357492e9452c3@realsil.com.cn>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-5-javen_xu@realsil.com.cn>
 <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
 <b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn>
 <282e4c64-a088-4602-b053-7a8e1cd32c5a@lunn.ch>
In-Reply-To: <282e4c64-a088-4602-b053-7a8e1cd32c5a@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297543-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C16C0667762

Hi, Andrew, Maxime

>On Mon, Jun 08, 2026 at 06:32:19AM +0000, Javen wrote:
>> >> +static bool rtl_is_8116af(struct rtl8169_private *tp) {
>> >> +     return tp->mac_version =3D=3D RTL_GIGA_MAC_VER_52 &&
>> >> +             (r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) =3D=3D 0x0030=
 &&
>> >> +             (r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) =3D=3D 0x0000=
;
>> >
>> >Do we know what these magic numbers mean?
>>
>> 0xdc00 is a package-detect field. 0xd006 is internal HW id. RTL8116AF sh=
ares
>the same RTL_GIGA_MAC_VER_52 mac_version with other variants.
>
>Since you know what they are, please add #defines.
>
>> >> @@ -2509,9 +2543,10 @@ void r8169_apply_firmware(struct
>> >rtl8169_private *tp)
>> >>               tp->ocp_base =3D OCP_STD_PHY_BASE;
>> >>
>> >>               /* PHY soft reset may still be in progress */
>> >> -             phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
>> >> -                                   !(val & BMCR_RESET),
>> >> -                                   50000, 600000, true);
>> >> +             if (tp->phydev)
>> >> +                     phy_read_poll_timeout(tp->phydev, MII_BMCR, val=
,
>> >> +                                           !(val & BMCR_RESET),
>> >> +                                           50000, 600000, true);
>> >
>> >Maybe this all needs to move into the PHY driver?
>>
>> This is after firmware application. And PHY_MDIO_CHG opcode switches the
>access callbacks between PHY and MAC accessors.
>> data =3D=3D 0: phy_read/phy_write
>> data !=3D 0: mac_mcu_read/mac_mcu_write
>> So the firmware may contain mixed PHY and MAC.
>
>Normally, the MAC does not touch the PHY, it only calls phylib/phylink API
>methods. If standard MII interfaces are used, you can connect any MAC to a=
ny
>PHY.
>
>If it is all integrated into silicon, then there is no choice, you know th=
e
>MAC/PHY relationship. However, it is still good practice to keep MAC code =
in
>the MAC driver and PHY code in the PHY driver.
>
>Can firmware programming be moved into the PHY driver?

For our PCIe nics, they are single chips. r8169 driver is for the entire in=
tegrated chip. Some internal phy shared the same PHY id, but the required P=
HY parameters differ depending on the specific MAC/Chip it is integrated wi=
th. So I think firmware here can not be moved.

>
>> >> -     rg_saw_cnt =3D phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3ff=
f;
>> >> -     if (rg_saw_cnt > 0) {
>> >> -             u16 sw_cnt_1ms_ini;
>> >> +     if (tp->phydev) {
>> >> +             rg_saw_cnt =3D phy_read_paged(tp->phydev, 0x0c42, 0x13)=
 &
>0x3fff;
>> >> +             if (rg_saw_cnt > 0) {
>> >> +                     u16 sw_cnt_1ms_ini;
>> >>
>> >> -             sw_cnt_1ms_ini =3D (16000000 / rg_saw_cnt) & 0x0fff;
>> >> -             r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini=
);
>> >> +                     sw_cnt_1ms_ini =3D (16000000 / rg_saw_cnt) & 0x=
0fff;
>> >> +                     r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt=
_1ms_ini);
>> >> +             }
>> >
>> >Can this move into the PHY driver?
>>
>> It reads a counter from PHY, but the calculated value is programmed into
>MAC OCP register via r8168_mac_ocp_modify, which accesses r8169 through
>tp->mmio_addr. So I think this can not be moved.
>
>So, big picture, what is this doing? What is rg_saw_cnt?

UPS mode TX-link-pulse timing calibration. We read rg_saw_cnt from the GPHY=
 page 0x0C42, register 0x13. This value is the SAW calibration result burne=
d during mass production. If rg_saw_cnt =3D=3D 0, it means the MP did not b=
urn the calibration result, so we do nothing. If calibrated (rg_saw_cnt > 0=
), we calculate the 1ms timer counter: sw_cnt_1ms_ini =3D (16000000 / rg_sa=
w_cnt). And then write it into the MAC OCP register (0xD412). This requires=
 reading a hardware-specific value from the PHY to configure a timer regist=
er in the MAC. So I think it can not be moved too.

How do you recommend handling this kind of SoC-specific tight coupling with=
in the phylink framework? Is it acceptable to retain a local phydev pointer=
 in the MAC driver solely for these hardware-specific initialization quirks=
, or is there a preferred approach for single-chip devices?

Any guidance for the migration would be greatly appreciated!

Thanks,
BRs,
Javen
>
>        Andrew

