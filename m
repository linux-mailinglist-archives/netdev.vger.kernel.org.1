Return-Path: <netdev+bounces-83112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05675890D9E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7E1F21839
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565B1CD38;
	Thu, 28 Mar 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="cKU0w9hZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jv7Ix0SA"
X-Original-To: netdev@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342217BB5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665113; cv=none; b=sAq15mHHMHefUvivWpfSwIE8M1wmZuxzMg98EZbuFhQ2FgmxssKtwXEffXjVZUQp/UnKiWHb5s+I0ZtpO+SgNU2GhSNQJFyPtR0+RumsDIJOL6D1sYuyUX0XELiMymEB5YEEdmWvpzPQCQYsAikX3OT0bsVio+Drb/N0OFol4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665113; c=relaxed/simple;
	bh=xYby0oT0nLS0T0gdT+VFn17OcPELSuO32ZoSmVFpjzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K++gbiuv44c1/Gkk4pmAVhr7TCkssLt5052jyZWBeefVh6162MFXZBrXmsXpIH20IDjXiE712yj/ak4k+PbMXEhTFGb0r5J5GTvdyVWTjSvf+hTIpCWtv6lNtmX20AK3EkXCiWuXz0FuM1ix7G8+JdYJhbPKlSDTihNGGGOBgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=cKU0w9hZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jv7Ix0SA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA7AE1380083;
	Thu, 28 Mar 2024 18:31:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 28 Mar 2024 18:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711665110;
	 x=1711751510; bh=dLo89DPTrCGC35efpMRUHvoSCZ2cax35wNBelSetaeQ=; b=
	cKU0w9hZLOfmmit/VFaGp1VjaMGdTZ7OMnWPiZA2vqPiPoAnTeQqVutAHJKjS7D3
	VbMkP+yknqE8GkZtTaQwJaGaQVQ1Y8dHd+CVVjIv6NOLEzKKJxwzmrCTSQB/KEsC
	cdKjJaZQ95mbwp2JQXy2QuXlONjL4e1BiJ1BcSTJtHk04S84ehNDBdaobFdepMgR
	vr0jKqU3hVNh8Mf9zqtL3vnVtY2n9shDHVoXLRZB7ZPC/4vtElB9Ek/5QLcwLD0f
	bpgIZ5UdncaYif8zy7inij5weNLjYEfyQ7SFEXCpiHBeezPpsTEAYqYAV4sHXg1m
	lpSKjqncB24VKLHEglyeNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711665110; x=1711751510; bh=dLo89DPTrCGC35efpMRUHvoSCZ2c
	ax35wNBelSetaeQ=; b=Jv7Ix0SAXN6UwKu03lNQuTZDsr+SerhPpBd7ZKSbDY2u
	5q5PCUFNnHZzaigTbGi2pT9QPSPzId8e5OeYDuCb+IUZFS5uBSW2jOFjD+MnE9b3
	ueSozJ2pzsjSXUXPyOL7wzqE8a0sQIfsutn6TUFBAjfbNGYsSHsNY7P7JseusRw8
	gYmZ3baEd1wsT5MG0MiPVPcZJJg4NRZ0lWPpitm46wTsPLWRS6fI+wJ38nosYOhP
	XVbbAUsD5343h5wRAuAJb6QFGPDuAj2+2vrhDkv1VG/rhUyls2CqfIWLMY5cy/bT
	DQ3Lok4Lna/82Ei1yqufMA78822bTXibhFGrUQXwEw==
X-ME-Sender: <xms:1u8FZpYpaWCWiNxmTiA5OlqqPY_Wq_WZpseXmjuuazUTPKlY_upzYQ>
    <xme:1u8FZgaVYTrErcX3MGKtGQB9Gl9fV9hVS9VHLFOsHCOMDg_oV-hATPjy8vKWEJ02s
    DZ43Bg3D0uZ7Q>
X-ME-Received: <xmr:1u8FZr8vWBTc0c0irYszFL9w3V-kEd86C6pPDv-SgbuWPSGb6H8kzbULL2iWhFqCMyoz30Svb2m17vfFyiUKPXEvD6leeyL5wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghr
    vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
    hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeu
    keetteeggffgkeduheetgeeileejjeeiiefhjeegvefhtefggfetueetteeuteenucffoh
    hmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomh
X-ME-Proxy: <xmx:1u8FZnpaac8yJkpDnk6fnEyeB1T_DKAClWzru9F8zK1FN_5ayxjKgg>
    <xmx:1u8FZkrm4GebYiB8LQqxF8t7KKyTYUJmv7anzFMrM_Wl8h4Hy3bC5g>
    <xmx:1u8FZtQlx0IFVlX0dHnKAdVpOVElboCDTdDtdxZZ20bMmbZTZ6mZkg>
    <xmx:1u8FZsok1YTX19J_wiJU57fnjnAi1yvQi6ctqMf9mVRS5Nfopm_Nwg>
    <xmx:1u8FZh7CXe_zRRSP2ziNHNP64_ZsY5dr5_FMXH5Zd0aBr_y1Snl4JA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 18:31:48 -0400 (EDT)
Date: Thu, 28 Mar 2024 23:31:45 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, arthurborsboom@gmail.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
	dkirjanov@suse.de, kernel-team@cloudflare.com,
	security@xenproject.org, andrew.cooper3@citrix.com,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
Message-ID: <ZgXv0dFJ3T1Yq-Ve@mail-itl>
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5NxXEymOds7Bg/x"
Content-Disposition: inline
In-Reply-To: <171154167446.2671062.9127105384591237363.stgit@firesoul>


--u5NxXEymOds7Bg/x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 23:31:45 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, arthurborsboom@gmail.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
	dkirjanov@suse.de, kernel-team@cloudflare.com,
	security@xenproject.org, andrew.cooper3@citrix.com,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle

On Wed, Mar 27, 2024 at 01:14:56PM +0100, Jesper Dangaard Brouer wrote:
> Notice that skb_mark_for_recycle() is introduced later than fixes tag in
> 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").
>=20
> It is believed that fixes tag were missing a call to page_pool_release_pa=
ge()
> between v5.9 to v5.14, after which is should have used skb_mark_for_recyc=
le().
> Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
> ("net: page_pool: hide page_pool_release_page()") and remaining callers
> converted (in commit 6bfef2ec0172 ("Merge branch
> 'net-page_pool-remove-page_pool_release_page'")).
>=20
> This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: =
catch
> page_pool memory leaks").
>=20
> Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfr=
ont")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> Compile tested only, can someone please test this

I've got a confirmation it fixes the issue:
https://github.com/QubesOS/qubes-linux-kernel/pull/926#issuecomment-2026226=
944

>  drivers/net/xen-netfront.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index ad29f370034e..8d2aee88526c 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(str=
uct netfront_queue *queue)
>  		return NULL;
>  	}
>  	skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
> +	skb_mark_for_recycle(skb);
> =20
>  	/* Align ip header to a 16 bytes boundary */
>  	skb_reserve(skb, NET_IP_ALIGN);
>=20
>=20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--u5NxXEymOds7Bg/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmYF79EACgkQ24/THMrX
1yxwlwf/XUrABq1kmtKxeomxnO1eXtzR3tys87jcg9Nshm8fQdTRVixVO+j3SEgt
sRlf7oPRMb8VLYJaLnUhIZyc8780bgklFn2MUUdrNvzIEFW8T+v0xtCT0LQF7Ln5
U2TYcjthpjMbCWG2qqefCq6whTZpFTRjQ7ayEY81C0n8yA/y8Ly5W5zVKeqIChn6
EXdr92h+0XfJiWjRY6SpvSFmFrNhXg6XDAXDMmWARBustYR87icJm92VtQDuEbCG
r9SEKz/pZbrsj7seqNfbsdkkkNWAhZoiDvsODrudAfR5vnaF6RxQ//3RD1Vsi8Tl
vQ1uNGNYZV2NXNKuFIC3N8OSPBWBvQ==
=IwCF
-----END PGP SIGNATURE-----

--u5NxXEymOds7Bg/x--

