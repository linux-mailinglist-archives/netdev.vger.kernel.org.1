Return-Path: <netdev+bounces-293169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KGJE3zCGWqGywgAu9opvQ
	(envelope-from <netdev+bounces-293169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E94605DB7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C7A03015719
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20E3F1AA0;
	Fri, 29 May 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndKXwALE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1093F1AD1
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073024; cv=none; b=N+h5HQlQZhvgfgUzR52pbL+QY+UPB7gv7xfRjVQaQDkh/3mVXPU5R5iu8gX8XJyu+Xx+eRmM5h4QZPNE7I6DZmGjdAtONN+wsvnZlMl2by31qho3BezOqiLigGG46NYClTeodn6CiYAjYN2/VmkH2jRERnLSq+uMBy0HQOfRjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073024; c=relaxed/simple;
	bh=P3gTgPgiYnLzTdZV868i5bC4Bz7y8ArfTeXxqJ7yNIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4CjwVlimO08/g8qqDbLG/wH0wZq0wx+nYbCbuaBzwzA5FwwLPdEhZMry31kbRbX4lnVEQdhtqfRmKxYrJ4mLjp0T5SZgwmpmGjxR9miagQZu3Q7DzrnqjdKMy1uCZjyOihoBow2ll10Wvp5Uq28r5lRdaPHOwEQ6298YJf4SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndKXwALE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77B11F00893;
	Fri, 29 May 2026 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073023;
	bh=wrQB+CqOBdI/ARCQHNMs8ehEw+gtEWGdQDI/WVWbBF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndKXwALELUBevwh5WUv1/CJV81w4hrP15MegiMKygG3MM39QE7bMIFmh4Ax2iMc04
	 7SmT3BoCys9EKsL5izlcxcwpOVOgpP9Y9fh33xJji6iehutnpl8E8kwh/klubnLiBI
	 p5Hf4A+9DTFClXSkVqrNyfBSDegMv8VxCq4KEKU3OEr4wrR/rgBYMntoLvBIrehSz3
	 ey6X6Pr3EkX2waPDLAYKJrnWvnTKTBzhc3MzlZ8dVyzP8X0CNAJoh3oqETflmnjY2h
	 qYJsorlmNqbLzkupPw5NlwLLICtFEVn3R+1fgnIAfSB7ReLNyHdALDGjd/U5DC4FPN
	 2+E2mAsz65SFw==
Date: Fri, 29 May 2026 18:43:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 1/6] net: airoha: Introduce airoha_gdm_dev struct
Message-ID: <ahnCPDuEATzJdln3@lore-desk>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
 <20260527-airoha-eth-multi-serdes-preliminary-v1-1-ec6ed73ef7fc@kernel.org>
 <433b9d9a-bd7c-44ad-b387-a789b326488e@intel.com>
 <ahhonoI-oJ6gJqZ0@lore-desk>
 <722f177c-0578-4b0b-b2fa-2acd45b2e299@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3d3Dnappu0EpMzD8"
Content-Disposition: inline
In-Reply-To: <722f177c-0578-4b0b-b2fa-2acd45b2e299@intel.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9E94605DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3d3Dnappu0EpMzD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Thu, 28 May 2026 18:09:02 +0200
>=20
> > On May 28, Alexander Lobakin wrote:
> >> From: Lorenzo Bianconi <lorenzo@kernel.org>
> >> Date: Wed, 27 May 2026 12:21:15 +0200
> >>
> >>> EN7581 and AN7583 SoCs support connecting multiple external SerDes to=
 GDM3
> >>> or GDM4 ports via a hw arbiter that manages the traffic in a TDM mann=
er.
> >>> As a result multiple net_devices can connect to the same GDM{3,4} port
> >>> and there is a theoretical "1:n" relation between GDM port and
> >>> net_devices.
> >>> Introduce airoha_gdm_dev struct to collect net_device related info (e=
=2Eg.
> >>> net_device and external phy pointer). Please note this is just a
> >>> preliminary patch and we are still supporting a single net_device for
> >>> each GDM port. Subsequent patches will add support for multiple net_d=
evices
> >>> connected to the same GDM port.
> >>>
> >>> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>
> >> [...]
> >>
> >>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/e=
thernet/airoha/airoha_eth.h
> >>> index d3781103abb5..c78cabbec753 100644
> >>> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> >>> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> >>> @@ -535,10 +535,15 @@ struct airoha_qdma {
> >>>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> >>>  };
> >>> =20
> >>> +struct airoha_gdm_dev {
> >>> +	struct airoha_gdm_port *port;
> >>> +	struct net_device *dev;
> >>
> >> Nit: we now have priv_to_netdev() (I hope I remember its name
> >> correctly), so that we no longer need to store a netdev backpointer in
> >> netdev_priv structures.
> >> Just an option, up to you.
> >=20
> > I think you mean netdev_from_priv(), right?
>=20
> Yep, priv_to_netdev() is something I used in the past locally, it went
> to the kernel as netdev_from_priv() from a different author.

ack

>=20
> > I guess I can fix if I need to repost, otherwise I will fix with with a
> > dedicated patch. Agree?
>=20
> Sure, up to you anyway whether to use it. Most drivers still use
> backpointers to netdev in their private structures.
> From the optimization PoV, netdev_from_priv() should generate a bit
> better code as it's then clear that it's just a fixed offset from the
> private structure, not a separate piece of memory.

ack, I am fine with that. I will post a dedicated patch when the current se=
ries
is merged (if there are no other comments).

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
>=20
> Thanks,
> Olek

--3d3Dnappu0EpMzD8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahnCPAAKCRA6cBh0uS2t
rAzjAQDaKZufazE0WT4IMiu3/d0c5nm66K6Tv59vaHCvvZ9EqQD+PXMx8the4UVh
QdwUfhAlYgeCwft32GFenWENmnYHzwM=
=EHuC
-----END PGP SIGNATURE-----

--3d3Dnappu0EpMzD8--

