Return-Path: <netdev+bounces-226912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D856CBA614B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F7189E17D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586E2D73BE;
	Sat, 27 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="SCf2xhQt"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C63C148
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988876; cv=none; b=kCjrZMkvuw+Di8jaLBG0yq6WTiRNobtMR06xvdfg8iw0FLlj90N7WbFJfUpi4M7NaCdFTPHdEkOfcis6crbTccSgCAJ8v3GXiCJCZJBEoAr6w7NtG2LXMVMbNdgLrHnXTUwQsl8C6tvMGl/pPFPFvyJ0nYA/qQhMYZSIKQOjUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988876; c=relaxed/simple;
	bh=hm8HUOyoH5qZlM+/z+bMGAvaSuXN9Qce+23OXA4KtkQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L6mt13QEV8uTA6QNaJaBBxIoKaWHwdDk1UzDVhy1TrCVAh0M1fCg7lpZ9z6wO+Psrc0GvIheK5OHDhQv2uhMaNONVJP/G9PZQV3f710G99RADvMy3PZpa2d0Vs9ZJrTMsESSclX1oXgs35f84qiiYasekmoECEhUMHqdZ44ClVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SCf2xhQt; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58RG0fRf027866
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 17:00:55 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58RG0fRf027866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758988864; bh=6C9DW8zfbE3maWJHz98tNFElQ7y2LO+SSel6NOxsxyk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=SCf2xhQtQU8LcYb34vqv5vc//GTfclT4oJVPMJgZi+Mg2Im53oC6tutsgj6IzZ48/
	 F7meicpiyDC6MVpjrmcwVwhqL74YqIthowtYj5kcubeS+lDaJoC4MbIWUxGIWfRDtJ
	 JHY+sYuk/ItFYBVqPOxm9Hvj9z33CdlT3aoEFkBv1mVmFPG2+6cvwGBC6zOKK4cC9f
	 55JaVMzZ3D/x90a5blNroWNRthGc4z2SACnRt0AZyKm8APB+0PaHfLCSjcrRGkWTC/
	 kP6qczAMZnJwrTrMoCAQb4gcf7MZ48vUwDEWG0yzuisja3VzICE/XG7blWix2RIGRZ
	 3BptsVx00jXJg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
Date: Sat, 27 Sep 2025 17:00:08 +0100
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2B00AEE-521F-48D1-8290-18A771986AF4@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-4-lukeh@padl.com>
 <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On 27 Sep 2025, at 16:12, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> +/* MQPRIO helpers */
>> +
>> +/* Set the AVB global policy limit registers. Caller must acquired =
register
>> + * lock.
>=20
> No where else in this driver is this assumption about the register
> lock documented. If you forget it, the low level read/write functions
> will tell you. So i don't think it adds value.

Fixed.

>=20
>> + *
>> + * @param chip Marvell switch chip instance
>> + * @param hilimit Maximum frame size allowed for AVB Class A frames
>> + *
>> + * @return 0 on success, or a negative error value otherwise
>> + */
>=20
> kerneldoc wants a : after return.

Should also be for @param then? Seems fairly inconsistent on a brief =
survey of other drivers.

>> +static int mv88e6xxx_avb_set_hilimit(struct mv88e6xxx_chip *chip, =
u16 hilimit)
>> +{
>> + u16 data;
>> + int err;
>> +
>> + if (hilimit > MV88E6XXX_AVB_CFG_HI_LIMIT_MASK)
>> + return -EINVAL;
>=20
> Does it make sense to check it against the MTU? Does it matter if it
> is bigger than the MTU?

I don=E2=80=99t think so; this is hicredit in tc-cbs(8).

>> +/* Set the AVB global policy OUI filter registers. Caller must =
acquire register
>> + * lock.
>> + *
>> + * @param chip Marvell switch chip instance
>> + * @param addr The AVB OUI to load
>> + *
>> + * @return 0 on success, or a negative error value otherwise
>> + */
>> +static int mv88e6xxx_avb_set_oui(struct mv88e6xxx_chip *chip,
>> + const unsigned char *addr)
>=20
> Maybe be a bit more specific with the documentation of addr. You pass
> a 6 byte address, not a 3 byte OUI. So "The AVB OUI to load" is not
> quite correct. It is more like, "Use the OUI from this MAC address."
> I've not looked at the big picture, but i was woundering if it makes
> more sense to pass an actual OUI? But that is not something we tend to
> do in the kernel.

Passing in an addr lets us reuse eth_maap_mcast_addr_base. Agree the =
documentation could be clearer. Perhaps this extra restriction =
(requiring AVTP DAs in secure mode) is not necessary anyway.

>> +static inline u16 mv88e6352_avb_pri_map_to_reg(const struct =
mv88e6xxx_avb_priority_map map[])
>> +{
>> + return =
MV88E6352_AVB_CFG_AVB_HI_FPRI_SET(map[MV88E6XXX_AVB_TC_HI].fpri) |
>> + MV88E6352_AVB_CFG_AVB_HI_QPRI_SET(map[MV88E6XXX_AVB_TC_HI].qpri) |
>> + MV88E6352_AVB_CFG_AVB_LO_FPRI_SET(map[MV88E6XXX_AVB_TC_LO].fpri) |
>> + MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(map[MV88E6XXX_AVB_TC_LO].qpri);
>> +}
>> +
>> +static int mv88e6352_qav_map_fpri_qpri(u8 fpri, u8 qpri, void *reg)
>> +{
>> + mv88e6352_g1_ieee_pri_set(fpri, qpri, (u16 *)reg);
>> + return 0;
>=20
> Blank line before the return please.

Fixed.

>> + * - because the Netlink API has no way to distinguish between =
FDB/MDB
>> + *  entries managed by SRP from those that are not, the
>> + *  "marvell,mv88e6xxx-avb-mode" device tree property controls =
whether
>> + *  a FDB or MDB entry is required in order for AVB frames to =
egress.
>=20
> We probably need to think about this. What about other devices which
> require this? Would it be better to extend the netlink API to pass
> some sort of owner? If i remember correctly, routes passed by netlink
> can indicate which daemon is responsible for it, quagga, zebra, bgp
> etc.

An additional flag to Netlink when adding a FDB or MDB entry would =
certainly be cleaner. I=E2=80=99m not sure what other devices do, I =
suspect some support similar functionality but do not have driver =
support, because most SRP implementations have managed the switch =
directly. (Mine [1] uses standard kernel interfaces.)

> Since these are part of a standard, i assume other drivers will need
> it as well? These should probably be somewhere common.

Yes, can put elsewhere. Or, if we have a suitable Netlink interface, =
they can be removed, as we won=E2=80=99t need heuristics to determine =
whether a MDB entry is for AVB. (This also likely takes care of =
mv88e6xxx_avb_set_oui.)

[1] github.com/PADL/OpenSRP=

