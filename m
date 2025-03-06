Return-Path: <netdev+bounces-172404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC8FA54797
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B450188C94C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F31DE4EC;
	Thu,  6 Mar 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qic3uXhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA91A4E70
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256471; cv=none; b=R1RR943Jl8cTX97nplwFfb4s6p6WfapL4qUtceakLZjGdAfRtUuLRLeb78GiiroZvRdX0ENuNScDS6S1kQpAeWHmwwYM4px4mzDtp7d7mSv3e9wpKRMPdV/LVGON8cqxqGT25Dj4D10LJg17XdO7TsddqvpNoVCTy4mkN83l/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256471; c=relaxed/simple;
	bh=Mm3k9fnVDf/ZcbhTg8lbfm5qMKE+i23cwgmVEIjWNUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INCSo1yQ43vI/gOiztxEXhGGA7DO4MeMt67Y9fWoyxfy/swnTRurKjEgU7/WTeIUh3Rwib8WIoNzNIvmzKJIcvI8YzbgaaCPf0M+FUUQS21rprK+dvteZDFakBGJ7vmlCh/uGzeNYR37Jq8Dh0BgeEh2uDAdqMYEBexv7/adevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qic3uXhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C86C4CEE0;
	Thu,  6 Mar 2025 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256470;
	bh=Mm3k9fnVDf/ZcbhTg8lbfm5qMKE+i23cwgmVEIjWNUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qic3uXhg1AIDR6165O4/wo9ziGZmY4FnBFNelbdXwfpLhQQnmd2bc/Ul+8P1IBa4Z
	 XmnHgHlg53uMSUAsw+hL3F+WkwHhaLPKqtxKJOjxRsJR/nWevVltPfr80/myFZsV6k
	 XhLzfpizYxDZtBch/Ds8GMXXYk/B9HYT5pKCnE/8Ii9mpecE83A8MoLKl5YR0hERl1
	 DEHmDKkumRIWuNFYnIfZHNLlmcUB7e2Yq2wUkA9uT+8F75jugejgvwHp/ULWM19eA3
	 D6mTQSOnD6AiGfR2uL3HXNY5t67YPiKb10W04ErA3KNYDGbfhyRvMqhd0fv7UL18BE
	 8TyxjncYCFeGw==
Date: Thu, 6 Mar 2025 11:21:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] net: airoha: Move DSA tag in DMA descriptor
Message-ID: <Z8l3E0lGOcrel07C@lore-desk>
References: <46c1790a-0860-4907-894e-2d8ec4622147@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Ht0+cuR0qs1GRR9"
Content-Disposition: inline
In-Reply-To: <46c1790a-0860-4907-894e-2d8ec4622147@stanley.mountain>


--+Ht0+cuR0qs1GRR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 06, Dan Carpenter wrote:
> Hello Lorenzo Bianconi,
>=20
> Commit af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> from Feb 28, 2025 (linux-next), leads to the following Smatch static
> checker warning:
>=20
> 	drivers/net/ethernet/airoha/airoha_eth.c:1722 airoha_get_dsa_tag()
> 	warn: 'dp' isn't an ERR_PTR
>=20
> drivers/net/ethernet/airoha/airoha_eth.c
>     1710 static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_de=
vice *dev)
>     1711 {
>     1712 #if IS_ENABLED(CONFIG_NET_DSA)
>     1713         struct ethhdr *ehdr;
>     1714         struct dsa_port *dp;
>     1715         u8 xmit_tpid;
>     1716         u16 tag;
>     1717=20
>     1718         if (!netdev_uses_dsa(dev))
>     1719                 return 0;
>     1720=20
>     1721         dp =3D dev->dsa_ptr;
> --> 1722         if (IS_ERR(dp))
>=20
> Why would this be an error pointer?  Is this supposed to be a check for
> NULL?

yes, right. Moreover NULL pointer check is already done in netdev_uses_dsa(=
) so
we can drop it. I will post a fix for it.

Regards,
Lorenzo

>=20
>     1723                 return 0;
>     1724=20
>     1725         if (dp->tag_ops->proto !=3D DSA_TAG_PROTO_MTK)
>     1726                 return 0;
>     1727=20
>     1728         if (skb_cow_head(skb, 0))
>     1729                 return 0;
>     1730=20
>=20
> regards,
> dan carpenter

--+Ht0+cuR0qs1GRR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8l3EwAKCRA6cBh0uS2t
rLWLAP9qQ8CVbWNXkSDkpgXciDMjdOCNaf6hFf+Ldf+56A7xCwEAsCzb0T0tqBHv
7VWUyNUy3bdcVFRApYkHrvR37g5htw0=
=6D1Y
-----END PGP SIGNATURE-----

--+Ht0+cuR0qs1GRR9--

