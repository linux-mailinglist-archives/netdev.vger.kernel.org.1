Return-Path: <netdev+bounces-132610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4999268D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19ADB1F22A1E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181C16849F;
	Mon,  7 Oct 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="feyub4zu"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1951292CE
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288103; cv=none; b=kP1yAw5wkIS7AyiXpo5jp/HT1Jr7Kqn/M5CYhfKvw8psro9SdyLyR4rGbS8ueBwhEK0pUwe9rcPLNNfDbv08V46QEQKYIp4YxddBKR/WCrusAfUqXYp3wQMBvs6VXfVSbuiB87YDQw1q1RrHDUrCYUjQinIwjTXEabgMwTPDjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288103; c=relaxed/simple;
	bh=qVGevAljTYytmlrJD2uw9N2ydsoxMTEZq9RwDFGbd48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyUkngSWPuNkDG2R1/Plr9boIUfUuDxPZdpIqHO8kCpAb5BQqrLeDVFevLfhsWXvW54qbpWmZd2F/Yea4NVHHsbjbfdWC0vlCW6Qf3lix++YfORwLNEDtAYVhLdNevs2mOLCddB9aH1U+aoPlw2iOb5j21hyNFFn3SVk8LSPCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=feyub4zu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9853188C63;
	Mon,  7 Oct 2024 10:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728288100;
	bh=YOYqzEswg07UG3xOehbcINnh8Y6YSQe4cZREqK+0Z5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feyub4zuEtPm0lYq5mvDxmrosfrOsYP4DI0apyychO+7h6YuTFKos5zKLdMm5hvkS
	 zSGhrFtCBQuG/Be3NSI0K49gygIxMsAuEtAoRU0PirmWzgRZSYk94b+WTTDNVmBArz
	 KwaGMdMyFgq1orCB6OchuSTp53Zqbu/SZ51M2UT86q3cOOHZJkv+OYHV9igAUtdcMo
	 wz81Ykc3vJYvoMA379Ro/Ylm4v9biX2WhdBaSARm5fbX2mZbmCoJKtpnaelFmaW89B
	 NhGqnszqALlLydcNZaYRAwRpPzcI2Pfo8/0udvqa0Q7rYB9s7cxz/A62nTkQvQuk2X
	 1jR2wZynhvTKA==
Date: Mon, 7 Oct 2024 10:01:38 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Zichen Xie <zichenxie0106@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aleksander.lobakin@intel.com,
 n.zhandarovich@fintech.ru, ricardo@marliere.net, m-karicheri2@ti.com,
 netdev@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>, Chenyuan Yang
 <chenyuan0y@gmail.com>
Subject: Re: net/hsr: Question about hsr_port_get_hsr() and possbile
 null-pointer-dereference
Message-ID: <20241007100138.643f5c61@wsk>
In-Reply-To: <CANdh5G7KBdzVcyrf5dPG2fbXQ5KCzr0LXu_p38H2-Cd4_FNsxw@mail.gmail.com>
References: <CANdh5G7KBdzVcyrf5dPG2fbXQ5KCzr0LXu_p38H2-Cd4_FNsxw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ao48C/QlA6XHTwYGhfNjTuA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/ao48C/QlA6XHTwYGhfNjTuA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zichen,

> Dear Developers for NETWORKING [GENERAL],
>=20
> We are curious about the function hsr_port_get_hsr().
> The function may return NULL when it cannot find a corresponding port.
> But there is no NULL check in hsr_check_carrier_and_operstate() here:
> https://elixir.bootlin.com/linux/v6.12-rc1/source/net/hsr/hsr_device.c#L93
> The relevant code is:
> ```
> master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> /* netif_stacked_transfer_operstate() cannot be used here since
> * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
> */
> has_carrier =3D hsr_check_carrier(master);
> hsr_set_operstate(master, has_carrier);
> hsr_check_announce(master->dev);
> ```
> There may be possible NULL Pointer Dereference.
> However, in hsr_dev_xmit() the NULL checker exists.

This function is called when NETDEV_UP/DOWN/CHANGE is called for hsr
net device.

IMHO, this cannot be called without having first created hsr network
device (with iproute2 command).

> ```
> master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> if (master) {
> skb->dev =3D master->dev;
> skb_reset_mac_header(skb);
> skb_reset_mac_len(skb);
> spin_lock_bh(&hsr->seqnr_lock);
> hsr_forward_skb(skb, master);
> spin_unlock_bh(&hsr->seqnr_lock);
> } else {
> dev_core_stats_tx_dropped_inc(dev);
> dev_kfree_skb_any(skb);
> }
> ```
> So we are curious if this NULL check is necessary. The function
> hsr_port_get_hsr() is called several times, but NULL checks seem to
> exist occasionally.
>=20
> Please kindly correct us if we missed any key information. Looking
> forward to your response!
>=20
> Best,
> Zichen




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ao48C/QlA6XHTwYGhfNjTuA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcDlWIACgkQAR8vZIA0
zr3O9gf7BJOeJ6gSVIxNK2fwHJuSerR+2KHIvqf3tnyMScvlcy/5KioAoYdLVkbj
9ztIG3Jvgp/1YXTqfM/87DQMjIddmX+2BQ3gv3yC8fYY3UI0H95q+sdApa9tvEAG
klNH4rXL0B66w8b4cSFK3Af08SAZ9CASCQJHN1lPkAunAozrG13kn4RzXVG570qC
81U+dOfdRWRIen/RsZV78lffFyOQo8vQtop8kouXgW2JEzzAbbe74SP+tOk7G+i9
YG+O8uho0MtjlQoJ6DXVvvtyxk4FVVT92Au51C96CWjmf2xW7hSkAPebOhQTiiHy
tMc/mtQd4poliXlzjXNnxs/+NVMgjw==
=SR9q
-----END PGP SIGNATURE-----

--Sig_/ao48C/QlA6XHTwYGhfNjTuA--

