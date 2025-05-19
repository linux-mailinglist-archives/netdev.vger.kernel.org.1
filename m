Return-Path: <netdev+bounces-191497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA0ABBA63
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0BC3B5BA8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0926A0BA;
	Mon, 19 May 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/cLnuA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E126B08D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648549; cv=none; b=ltUhlynLrBYb9/hPKr5RlNqYIqjDXJOgZ50mB8rKR/eJzDOW1w+TZXPVbhv0N0C3/QX8FACdQ3tHOC3YNnC+Chq8/MwVH88KDkxGwN4lvnxT/H1IFW3oxkM8hme3XKUN8IQGlwAxdwk6rr2+MIwoIK4dM6g1jrT2IdW+lCgmFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648549; c=relaxed/simple;
	bh=1gyL+vrxbsBYRCwZKWk0gs+Rz8se3eZcKW+Y/YzScNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+tvRCfyX/xhX3SyhT/p6AMDaxSvvesJ1bkZMxj3FZnxmdrw8poix4rmgHPEZH/9+tteOhsa+8etBS61WE9ivsn4kOdrI0VlSYHS7eWEndz+nKPvavb+yxdROL97ZhjTju8XqmhUxzUPWYVBsBhkoFqyqgDiX1lM7LghHJkpuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/cLnuA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA9DC4CEE4;
	Mon, 19 May 2025 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648549;
	bh=1gyL+vrxbsBYRCwZKWk0gs+Rz8se3eZcKW+Y/YzScNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/cLnuA6AiEs68MXWG0pQ/rNAeCn7a2p9BCf2491gA4iDqmLNKlu3yxeL6yT+TW49
	 VrH3051VL3g2VmOlAc9L84pbux6/li3Xp3cfC5PMaJkP5luRYzyxyL5rB4JYh6gktq
	 2+vTxN7iY1wMRyAlm1qEt6zADj5pAPCRiCGz19rh0dJn0y67W3civrUQXJZgROdbDm
	 tJ9A9V2yedQ/IX3UM97KqQ3xrgY6Uzk9sL2Nmv9h99tEDb718vp4U5oD8ylH1in6Uy
	 vTczFZ+yBC9x56CaNY1UHB1YJDfXkUX9uFdmIM9y4KXYM555QuEBbnaO2mzpIXhAg3
	 8KhrfcTZFrcDg==
Date: Mon, 19 May 2025 11:55:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: airoha: Add FLOW_CLS_STATS callback
 support
Message-ID: <aCsAItPcz_9CuxaP@lore-desk>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
 <20250516-airoha-en7581-flowstats-v2-2-06d5fbf28984@kernel.org>
 <20250519094637.GE365796@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22rIDOGjvi50b705"
Content-Disposition: inline
In-Reply-To: <20250519094637.GE365796@horms.kernel.org>


--22rIDOGjvi50b705
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 19, Simon Horman wrote:
> On Fri, May 16, 2025 at 10:00:00AM +0200, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > @@ -1027,6 +1255,15 @@ int airoha_ppe_init(struct airoha_eth *eth)
> >  	if (!ppe->foe_flow)
> >  		return -ENOMEM;
> > =20
> > +	foe_size =3D PPE_STATS_NUM_ENTRIES * sizeof(*ppe->foe_stats);
> > +	if (foe_size) {
>=20
> Hi Lorenzo,
>=20
> It's unclear to me how foe_size can be zero.

Hi Simon,

foe_size will be 0 if you disable CONFIG_NET_AIROHA_FLOW_STATS since in this
case PPE_STATS_NUM_ENTRIES will be 0.

Regards,
Lorenzo

>=20
> > +		ppe->foe_stats =3D dmam_alloc_coherent(eth->dev, foe_size,
> > +						     &ppe->foe_stats_dma,
> > +						     GFP_KERNEL);
> > +		if (!ppe->foe_stats)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	err =3D rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
> >  	if (err)
> >  		return err;
>=20
> ...

--22rIDOGjvi50b705
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCsAIgAKCRA6cBh0uS2t
rJHLAQC5nraKiJNubcnetLu9Dj8Wy6ZjmcTZ2WQrOWpbqVK3gwD/RIds/1GtCN6H
P9fdLBbCOVtpI90ToEihRNwIyKt1ag8=
=XYLC
-----END PGP SIGNATURE-----

--22rIDOGjvi50b705--

