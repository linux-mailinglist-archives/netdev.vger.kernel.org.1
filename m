Return-Path: <netdev+bounces-103779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5382909754
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9A284552
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206D224D1;
	Sat, 15 Jun 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="cKpwuuCg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813701CF96
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718444465; cv=none; b=WH/bQ4kV1//ior8V/LaEMi2hQOdoXJjuSv/1fbqFzWmeFXwu6xTDrMxuNU+wz1tmiu2wWM7k556knJHvIhbnRFEHn1mp4fpQmcMxbY6GUz2FUliIskMaSdGwv6x6xmFThqU98Nb2e8IcWM5iiUgEIqLVN+szVn5DorFr2Ph8gZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718444465; c=relaxed/simple;
	bh=lUac5tF0AUoJuQTSNJfwmnyilaoEyDoTyEWDta/czRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9oocte4mtDk5VL21UcbNrPTdsvY0AjRWCD9ItPIbDQTuBdLO+kXnSHgcFkniebX5Tduf4W3F+5V/xJI2Ut6nBp3aBwbo017lEX46U3uVq47f0M1Wj2UAQlx7qJgmlyGemES5iL4NmZ2o1fqYGUzqegCNXdurqQzAKMMyNu0O6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=cKpwuuCg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718444447; x=1719049247; i=hfdevel@gmx.net;
	bh=5N7RTEWkyG7FrwsAznJXwQRWU0QYsx609shhmDAEoZA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cKpwuuCgL/76RqwtCst+Lz6rmWroHDaY3dFUQypIzT3XuNIJA+/9ZeXMljCJY9lQ
	 ZiApbnB6MRUGhb4woY3Wx5lXR4gYSc3NPtFl0/BxYQTRJrqY+AnpGQXcrqfgPCr1t
	 RpV+fO/VpWLFUPOaPO6BUHjhV1uU80oPL6S6itTnsvH/h2Ki8a3EmaNAShWvQvmYT
	 rl4TS2nb9ffVdxqFsWfOE8gpJOkEaNdO1Sz2hhmuqB9If6KKCHH+ua4MdqfNlR8xl
	 D0xyPFetY/QTPol5lNR4oK7adI4UZZwEy3Dijsg5bB+KNO3SXiL2rIYT3wJag83VA
	 3xxREOwkfvab2mfjMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1ssIsn1YbC-00aOz4; Sat, 15
 Jun 2024 11:40:47 +0200
Message-ID: <2f9cf951-f357-402c-9da7-77276a9a6a63@gmx.net>
Date: Sat, 15 Jun 2024 11:40:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
References: <20240611045217.78529-5-fujita.tomonori@gmail.com>
 <20240613173038.18b2a1ce@kernel.org>
 <1ae2ddab-b6d2-499d-9aa1-3033c730bb87@gmx.net>
 <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Cl8j6OTd3TijRxAn/K5JFUrYurjhQLnrV0EH7K8mJshmbGPSlK
 dCVfghtRuojgTpQp//knRvs5anacx/oCLriJ5JHv5Xb+OuHW+m0RgMEG7aRhKC+s9d+twFp
 lBbtXZ4r8tYa+NiEC3ahSjEi32m8jj9UsIMkSfpgUeGsutvs+HA6CksOaZV+kqg5RIffz9i
 EcNTVcZKu9eMFvBUDECBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8EIYI5b8npg=;m8OdhK8+vfSX4UNidXy6fuIFDZ/
 yIKx6FAvrrs3t6WtwiWEu1U6AzqygYDHn3TdT+NfMHc1QhFfhB4Ue7hc9Rnun4l+z7R+7HqYd
 24dGtGyvz/oojSfMysRAPGyMadTLHM8zdPicC5xoIGOr2gMKMnrnY3DxAgWqDNFwXh1i6n36g
 EmPmI1R2DwT1QhK9oyb8NzBZQlkjOV7IKMga3BJyCPyPh397l6faM+gyR620ccXPhRQGq2VPi
 oejyHquoM/fnKe3mF1dbLuqKpDtJN66ert54ZywUNcaOJAR6bX7C8Y4eH1KP3/Ovd+5/Tfv32
 yxAS8sWQ0akcvG8kYBuUa2wbOW82Bu0ebnSjH2s+uINKrVfvRgHc/dKeiJt9acx/yo1PKACF+
 MWiX543ZrKpXclqj4GPAgrLIvbShQZeawlAyB8DMpUuSy79nCmio+hqI8EK5QFKkcpTrjdZVz
 3BuTwnUr9vXhqP3Il5dF/AjNQirL1VQtNXaO6QF/Si6/gLfMUGpJIsn+h9QxRvB2KYIO2IXzd
 Y1K5Pcizkf4rEOh3E8a5Jd6OdBjID5KiKoMqk8BVgT9Lx/ysVEAO2mNSY41+uScH4I1qyOiCe
 rcorCVSohXM+SeEtz+Nq+JP29TKkdpZa0Asa8nj6o4B9yAnEXuxarANKG2xR4YvQ0X/3K7owN
 6khc2Y971PBVRkgTSpeHg4qWGpB/DGmoFT+WqedSjeVGGdY+PuP/Jbz4fMZvZRu+vImC7ghqL
 XyRoOkOSPPHi2mCyQUwj9qn3e1HtpAk//7Nk1wMlJR4YuMI6cLDcFIVi7ZJiv3r79k3knLsM/
 pPdOOwKMFzrKVfrYoEdXlOWRflf/qUAYYnbofvixi7dHI=

On 15.06.2024 11.02, FUJITA Tomonori wrote:
> On Sat, 15 Jun 2024 09:44:31 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>
>>> On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
>>>> +static void tn40_init_txd_sizes(void)
>>>> +{
>>>> +	int i, lwords;
>>>> +
>>>> +	if (tn40_txd_sizes[0].bytes)
>>>> +		return;
>>>> +
>>>> +	/* 7 - is number of lwords in txd with one phys buffer
>>>> +	 * 3 - is number of lwords used for every additional phys buffer
>>>> +	 */
>>>> +	for (i =3D 0; i < TN40_MAX_PBL; i++) {
>>>> +		lwords =3D 7 + (i * 3);
>>>> +		if (lwords & 1)
>>>> +			lwords++;	/* pad it with 1 lword */
>>>> +		tn40_txd_sizes[i].qwords =3D lwords >> 1;
>>>> +		tn40_txd_sizes[i].bytes =3D lwords << 2;
>>>> +	}
>>>> +}
>>> Since this initializes global data - you should do it in module init.
>>> Due to this you can't rely on module_pci_driver(), you gotta write
>>> the module init / exit functions by hand.
>> I would rather move tn40_txd_sizes into tn40_priv and initialize it at
>> probe-time. Just thinking what will happen if there is more than one
>> tn40 card in a computer. Then a driver-based global struct would lead
>> to
>> all sorts of problems.
> The tn40_txd_sizes array is ready-only and the same values are used
> for all TN40 cards? So no need to move it into the priv?

very good point!
But if this is anyway just a constant translation table, why not
pre-calculating it and making it a real const?
something like:

/* Sizes of tx desc (including padding if needed) as function of the SKB's
 =C2=A0* frag number
 =C2=A0* 7 - is number of lwords in txd with one phys buffer
 =C2=A0* 3 - is number of lwords used for every additional phys buffer
 =C2=A0* for (i =3D 0; i < TN40_MAX_PBL; i++) {
 =C2=A0*=C2=A0=C2=A0=C2=A0 lwords =3D 7 + (i * 3);
 =C2=A0*=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (lwords & 1)
 =C2=A0*=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lwords++;=
=C2=A0=C2=A0=C2=A0 pad it with 1 lword
 =C2=A0*=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tn40_txd_sizes[i].qwords =3D=
 lwords >> 1;
 =C2=A0*=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tn40_txd_sizes[i].bytes =3D =
lwords << 2;
 =C2=A0* }
 =C2=A0*/
static struct {
 =C2=A0=C2=A0 =C2=A0u16 bytes;
 =C2=A0=C2=A0 =C2=A0u16 qwords;=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* qw=
ord =3D 64 bit */
} const tn40_txd_sizes[] =3D {
 =C2=A0=C2=A0 =C2=A0{ 0x20, 0x04 },
 =C2=A0=C2=A0 =C2=A0{ 0x28, 0x05 },
 =C2=A0=C2=A0 =C2=A0{ 0x38, 0x07 },
 =C2=A0=C2=A0 =C2=A0{ 0x40, 0x08 },
 =C2=A0=C2=A0 =C2=A0{ 0x50, 0x0a },
 =C2=A0=C2=A0 =C2=A0{ 0x58, 0x0b },
 =C2=A0=C2=A0 =C2=A0{ 0x68, 0x0d },
 =C2=A0=C2=A0 =C2=A0{ 0x70, 0x0e },
 =C2=A0=C2=A0 =C2=A0{ 0x80, 0x10 },
 =C2=A0=C2=A0 =C2=A0{ 0x88, 0x11 },
 =C2=A0=C2=A0 =C2=A0{ 0x98, 0x13 },
 =C2=A0=C2=A0 =C2=A0{ 0xa0, 0x14 },
 =C2=A0=C2=A0 =C2=A0{ 0xb0, 0x16 },
 =C2=A0=C2=A0 =C2=A0{ 0xb8, 0x17 },
 =C2=A0=C2=A0 =C2=A0{ 0xc8, 0x19 },
 =C2=A0=C2=A0 =C2=A0{ 0xd0, 0x1a },
 =C2=A0=C2=A0 =C2=A0{ 0xe0, 0x1c },
 =C2=A0=C2=A0 =C2=A0{ 0xe8, 0x1d },
 =C2=A0=C2=A0 =C2=A0{ 0xf8, 0x1f },
};

#define TN40_MAX_PBL (ARRAY_SIZE(tn40_txd_sizes))


