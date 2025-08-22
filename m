Return-Path: <netdev+bounces-216050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F910B31BEF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886296465D0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170A33A03C;
	Fri, 22 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKYiqPK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA1312828
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872770; cv=none; b=IvnOKErffdhc96dHy4ALzV5h+cM8e+pfHxNaArX8/MO3Te/Shuh5lRjJKEGBhTQr4ZJx21p+ffOf//Gvqc6oz1seFoz6gC5NLLk9BbmRN+90xDjS4dOBm+sQBhp0aNRFnpJoMIMIDsI1Skbf3wxqR5PLu8Eu1Eg43Gr1E+fT8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872770; c=relaxed/simple;
	bh=WSF2R7E4Mb2/hL4j6g0FeimKbh0L3weVkjdBGHjZ/88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0b+EKMZney/dImvXNdv3WOICsf1FB5aVXq5AKvxK8tahKYjyPd2Qq88X9FkfIs4kWRFVAlj77TZIoS8RFcAMAVQma4pmV4xlcGnTSeeT6rHoalcb3fuOfdDTSgOjXZWNttie/1aGZycx1oQfTbXTMQbzwm/VxFBiggJ27j0MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKYiqPK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A1C113CF;
	Fri, 22 Aug 2025 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872770;
	bh=WSF2R7E4Mb2/hL4j6g0FeimKbh0L3weVkjdBGHjZ/88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKYiqPK7OLe2vlUs8QaWsL9uZ17hNWV3VpK1Dz+4uMqooYDmgqakRouxbyZ0NDdcn
	 ymEPZ1K4L/2FgFj3XapO7ZBwbphFXhaa3q7Q6WBMrKwTh8Shf4gEYxZQiTGm5poCro
	 mBMSkX/JfXnrqH+0Zsl83jLLbKndT9DAxSxxDuftsEl155MOIcxsAGhbmdnfVyfvEA
	 fPxh6VV0yn2S0D/llpfhk0Bjkayu/Ywi09DSwAuIxiAhf9GQ/wBPXXTjJG3OwLfc6x
	 mSg5eQg0duAwyHupXZnrfSAzE+qRtvaqFr5nQpMdw1Ajv12glzCSRA8PlL9xTTp7BY
	 fNI3MCwLRvKdg==
Date: Fri, 22 Aug 2025 16:26:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <aKh9_g7mgvFxMdAz@lore-rh-laptop>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
 <20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
 <20250821183453.4136c5d3@kernel.org>
 <aKgVEYMftYgdynxw@lore-rh-laptop>
 <20250822070440.71bdd804@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FXbdwn9GJNlxMjEH"
Content-Disposition: inline
In-Reply-To: <20250822070440.71bdd804@kernel.org>


--FXbdwn9GJNlxMjEH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 22, Jakub Kicinski wrote:
> On Fri, 22 Aug 2025 08:58:25 +0200 Lorenzo Bianconi wrote:
> > > On Tue, 19 Aug 2025 14:21:07 +0200 Lorenzo Bianconi wrote: =20
> > > > +	pdev =3D of_find_device_by_node(np);
> > > > + =20
> > >=20
> > > did you mean to put the of_node_put() here?
> > >  =20
> > > > +	if (!pdev) {
> > > > +		dev_err(dev, "cannot find device node %s\n", np->name);
> > > > +		of_node_put(np);
> > > > +		return ERR_PTR(-ENODEV);
> > > > +	}
> > > > +	of_node_put(np); =20
> >=20
> > I moved the of_node_put() here (and in the if branch) in order to fix a=
 similar
> > issue fixed by Alok for airoha_npu.
>=20
> Ah, didn't notice it in the print..
> maybe remove the empty line between the of_find_device.. and the null
> check on pdev then?

I am fine with it. I did it this way just to be consistent with NPU code:
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/airoha/a=
iroha_npu.c#L403
Do you want me to post v3?

Regards,
Lorenzo

--FXbdwn9GJNlxMjEH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKh9+wAKCRA6cBh0uS2t
rCjXAQD/CFY6FZBfBcRt+bN2UykwgbP/5hNbqWoPrdltuQ8VKwD/VlSEjpbCiIVN
JTzElzSc2kYY+9A/Of88HRuL0KmM2Q8=
=/jOx
-----END PGP SIGNATURE-----

--FXbdwn9GJNlxMjEH--

