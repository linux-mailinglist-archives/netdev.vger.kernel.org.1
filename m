Return-Path: <netdev+bounces-278447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOWVB2A73mnipgkAu9opvQ
	(envelope-from <netdev+bounces-278447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 825153FA46F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E9793001BEA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A338396582;
	Tue, 14 Apr 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9oAJT39"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774F1F8723
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171849; cv=none; b=CX1EMS78eMmR1B/QcnXAI/EfaMFeLPubXmH7GWC9mqrddYii7+pEjADShRpcnL9Vs08I/L9OFyTXPIfto4gqesTEqqsWAaPIWQIcR6+5Z4LmlszhR1mZS8h0HSHKvuCspBf2Hi6NIbKQFqmGn3NAKt1bUGXqVfehm7fTJCh3VLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171849; c=relaxed/simple;
	bh=+SdxuvV++RW3Au9ENkYe7TDMNH7gu+U+TpzaE8EMu60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmEnkO1SxWvUPkwvQmK5IrsWRILInjK956RIMLQoxMd3OeXY4OzEEppL3yPRLRDLxcD2g2aY5p8bVrxkgx/cGyWqRTkeSUMdZ2tGWGfsDqa7+SJnaC3A/t0aJ2H/XIygaN9JncrUQ+N+kb/arfOi7GGE05/DtTW6rIruhHgsozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9oAJT39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FCFC19425;
	Tue, 14 Apr 2026 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776171848;
	bh=+SdxuvV++RW3Au9ENkYe7TDMNH7gu+U+TpzaE8EMu60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9oAJT39GRuHqt8X4CzT3FAocKIXUrycPfF479DhSGQ9lDYjqZdrVJMMal/khypft
	 uiE8m/T/lSLmTIrK4QZWNc34kZjGFlo/wt5DEA2oaCJcSw7k68zV185MyRzvJ0gf77
	 gmQqDnU+8WShfOA5yrhzQaTFUgVOE0lRhPJjt6Rbi8PFzGeQSJHVv86Spki/3gY24c
	 a85V+kaLHRCLxXfBwiuGHLaMEVADYE/07rb4xmJQpgYmq0hFqSlY/90+VLZQGnF00L
	 OzZEGAoHbm7cCiw6TAahbBkkvoG2JfZYlUQvV1HFlpnClg1Ukpzqq3uefkRNX+JbU4
	 dNrPfidGe3fKg==
Date: Tue, 14 Apr 2026 15:04:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix max TX packet length configuration
Message-ID: <ad47Rn6O3zxMGvga@lore-desk>
References: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
 <20260414124011.751922-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q+gggKPI9waM/m7U"
Content-Disposition: inline
In-Reply-To: <20260414124011.751922-1-horms@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 825153FA46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Q+gggKPI9waM/m7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: airoha: Fix max TX packet length configuration
>=20
> This commit fixes the MTU configuration for the Airoha driver by removing
> ETH_FCS_LEN from the maximum TX packet length, matching the hardware
> documentation which states the register does not include the FCS length.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index c14cdce588a7c..a81ffda72b39f 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1629,9 +1629,9 @@ static void airoha_update_hw_stats(struct airoha_=
gdm_port *port)
> > =20
> >  static int airoha_dev_open(struct net_device *dev)
> >  {
> > -	int err, len =3D ETH_HLEN + dev->mtu + ETH_FCS_LEN;
> >  	struct airoha_gdm_port *port =3D netdev_priv(dev);
> >  	struct airoha_qdma *qdma =3D port->qdma;
> > +	int err, len =3D ETH_HLEN + dev->mtu;
>=20
> Does this regression cause MTU-sized VLAN-tagged frames to be dropped by =
the
> hardware?
>=20
> By limiting the frame size to ETH_HLEN + dev->mtu, the maximum allowed le=
ngth
> becomes 1514 bytes for a standard 1500 MTU. An Ethernet frame containing a
> standard 802.1Q VLAN tag and a maximum-sized 1500-byte IP payload require=
s an
> 18-byte L2 header, making the total frame size 1518 bytes (excluding FCS).
>=20
> Previously, the inclusion of ETH_FCS_LEN inadvertently provided the 4-byte
> headroom needed to accommodate a single VLAN tag.=20
>=20
> Could the configuration explicitly account for VLAN headers using VLAN_ET=
H_HLEN
> instead?

ack, thx for pointing this out. I will fix it in v2.

Regards,
Lorenzo

>=20
> [ ... ]

--Q+gggKPI9waM/m7U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCad47RgAKCRA6cBh0uS2t
rPLDAP9Q5H7Gu+YaELSGXFfA19Ve/ujnBdFo02w+qdtwsV1EiwEAz8wT7BGV5Axj
dQ8zS8efuQJZOHb4yYvA+gf5P4uGIQ8=
=4+Tn
-----END PGP SIGNATURE-----

--Q+gggKPI9waM/m7U--

