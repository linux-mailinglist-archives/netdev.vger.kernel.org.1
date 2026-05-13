Return-Path: <netdev+bounces-287520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN+YGRFUBGp/HAIAu9opvQ
	(envelope-from <netdev+bounces-287520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2D531631
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A02E9304E9DF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE743F7AA5;
	Wed, 13 May 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtiSQSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E173E9C30;
	Wed, 13 May 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668521; cv=none; b=LAMjsDfq7yulamku6EHpO0rX7DTE1yY6Vqv+h0v8B5y1WT5Hnq5D4L+3us/3jFjM+kbxpj9KQ8PUzlDmv07fckj0q5NUWMWRGuKzDTgZftMeCbBbvis01JIEijch04iqPK7g7MtaTr8jhrfbqVGndKikm3xF53K1R6D1lqwHWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668521; c=relaxed/simple;
	bh=LJEnQGCxmpT8H5OOyRq2BjQAVPyNqXeudAIu9GFxSBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJFd0ZSP/KIx3y98hBPRWC3ccE7rGOR0h/W8XzetpTC0RNVGtbDQ0nEYdlsL48eOlTBhzai6+++rXH/W5fwvTUUANWIAKZGPhtdOauMuAD+lN2PjmUyH9LiphDyAf3ACIsyl+seUlwojDLm8HpuVLhXgd7tcEBqnAyh8cKRQKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtiSQSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3876C2BCC7;
	Wed, 13 May 2026 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778668521;
	bh=LJEnQGCxmpT8H5OOyRq2BjQAVPyNqXeudAIu9GFxSBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjtiSQSEtVPbIQJULENgyqQ5HO7XywtjOTdlcLlC74wDqaqhWZPu0sQj85LErqBCF
	 8yGKDWkzxs1/9st2SY33taBno/GNZezEVQ7WRORKiHKejxz8XhV17jsakPBjsqha9k
	 M2HDS3URszd6y33KiecijcY/nxGyHQfevQjKWlHw9TkJUmW4EVkFiMfRR+gS22+bbJ
	 +LvDphHRmJ0CxgR6ZDRxbpzc/ODKf98Upw2byXQ0ROtyWmmYjcEX0+ywXyDVKU7zVp
	 idljGyhQlVdxWm5q6VV9bi50f2SbwxVr4UrhOmN1VdgyR2ZSLbHHYBzoOddEc84WwQ
	 +rVJVuOEz5ixw==
Date: Wed, 13 May 2026 12:35:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/12] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <agRT5gMzYuk2qqsX@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-11-c899462c4f75@kernel.org>
 <20260512234745.34227C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HK6WfaX2FoNzYPzr"
Content-Disposition: inline
In-Reply-To: <20260512234745.34227C2BCB0@smtp.kernel.org>
X-Rspamd-Queue-Id: 4FF2D531631
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--HK6WfaX2FoNzYPzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Strict OUI matching logic breaks random MAC initialization and c=
reates a MAC configuration deadlock.
> - [Medium] Unaligned stack array passed to Ethernet helper functions.
> --
>=20
> commit c741e4a94d25c6203f98c2a4392d2ea65e6c3156
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> This commit extends the hardware LAN/WAN MAC address configuration logic =
to
> derive the correct minimum and maximum values when multiple interfaces are
> configured as LAN or WAN. It assumes all interfaces configured in the same
> group share a common upper MAC address.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> >  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> >  }
> > =20
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
> >  	struct airoha_eth *eth =3D dev->eth;
> > -	u32 val, reg;
> > +	u8 ref_addr[ETH_ALEN] =3D {};
>=20
> Is this stack array missing a 16-bit alignment attribute?
>=20
> ether_addr_copy() and is_zero_ether_addr() require their arguments to be
> 16-bit aligned. On systems lacking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> passing an unaligned stack array cast to a u16 pointer will cause alignme=
nt
> traps.
>=20
> Could this be declared with __aligned(2) or as a u16 array?

ack, I will fix it in v7.

>=20
> [ ... ]
> > +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> > +				continue;
> > +
> > +			ether_addr_copy(ref_addr, netdev->dev_addr);
> [ ... ]
> > +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> > +		/* According to the HW design, hw mac address MS bits
> > +		 * must be the same for each net_device with the same
> > +		 * LAN/WAN configuration.
> > +		 */
> > +		return -EINVAL;
> > +	}
>=20
> Can this strict OUI matching break device probe or create a configuration
> deadlock?
>=20
> If the device tree does not provide MAC addresses, the driver generates r=
andom
> MACs via eth_hw_addr_random(), which produces differing OUIs. When the se=
cond
> interface attempts to register during probe, this check will fail,
> register_netdev() will return -EINVAL, and the entire driver probe will a=
bort.
>=20
> Additionally, can this prevent userspace from migrating the MAC addresses=
 to a
> new OUI using "ip link set"?
>=20
> The first interface update attempt would be rejected because its new OUI
> would not match the OUI of the remaining unmodified interfaces.

As already pointed out, this is a requirement imposed by the hw design.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260511-airoha-eth-=
multi-serdes-v6-0-c899462c4f75@kernel.org?part=3D11

--HK6WfaX2FoNzYPzr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagRT5gAKCRA6cBh0uS2t
rLW/AQD4m7PAEXyvb3gFS9eyNox/xtKbmG3rc517uPAgmLhtygD/Y938DMlZwZa2
cp/j+aZgwDWrz2s2RIsT2h0HXkQJ1Ak=
=grwD
-----END PGP SIGNATURE-----

--HK6WfaX2FoNzYPzr--

