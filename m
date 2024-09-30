Return-Path: <netdev+bounces-130632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71698AFC7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E59283557
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35616188596;
	Mon, 30 Sep 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMRAW2Sj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2B15E97;
	Mon, 30 Sep 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734849; cv=none; b=GfvFCJKuGij1sBgFeAz1PUVvsBqa93j/h+bmka0/9V8aaUYpsCGpynaFzmr4KVLnO6mI2MzN1qvUpAtgdQrmEYTPSowORp9MZxTCxDYp9UvxiKJHztuZ1CRGS9ENMmvASsoeNEXOIJUNEAuqOtZJeMQTLCEz7Mt8SMVa0BzqExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734849; c=relaxed/simple;
	bh=h+kptMDd8OFDZwYoRg44FvEUq5MMRV1dFKa3fH2hs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZjAfmBsG82ZInhjTTTcLWCRrDujR7tDdENUzgBusPcTXO19FyftfFfonoUKDjjYHaqvk0SWb3Fs/3uYQeTGTblIDCzaj8KAKtAN3RVt8heCD2tmRhMjHfci4MNa2PqZtnFckvU2avV/GOdh0c3rNmttbS3K5vU5rxZSQ2CG8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMRAW2Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F61C4CEC7;
	Mon, 30 Sep 2024 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727734848;
	bh=h+kptMDd8OFDZwYoRg44FvEUq5MMRV1dFKa3fH2hs8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMRAW2SjUTR1VOj8+HnjNPlAEfjW/Yoce7VbCB19eCTUeRmtiqh305Vec+IAydo73
	 ZLzXQOMYNsdumse75fGuxXf5uGQD7w1N5acipeolR7ZcxIkC209RECpQEYPTPziNi+
	 znnS4oG/E0q1I6UHL1mdJAjYPM3TiWEKvOjG1XKDdn22TcSzX8TqZ+BuICZ5VqVqfa
	 DHGxScur8mF0357SwzCog+C41vlmH0aUZ0EvaiGlhIwEvyV8hN3C2LVUeaK0Xuytzw
	 UXbzhftyUwS4jNIRaGkl0NDCgprcvor8ryVlHXCE4IrEhyBOjH80dvqaQcSypGY/r2
	 vDepQstTO65HQ==
Date: Mon, 30 Sep 2024 23:20:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org,
	linux-kernel@vger.kernel.org, krzk@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Update core.c
Message-ID: <20240930-plant-brim-b8178db46885@spud>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
 <7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wEGPIiq33+tRNw/F"
Content-Disposition: inline
In-Reply-To: <7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>


--wEGPIiq33+tRNw/F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 04:12:41PM -0600, Shuah Khan wrote:
> On 9/30/24 16:06, Okan Tumuklu wrote:
> > From: Okan T=FCm=FCkl=FC <117488504+Okan-tumuklu@users.noreply.github.c=
om>
> >=20
> > 1:The control flow was simplified by using else if statements instead o=
f goto structure.
> >=20
> > 2:Error conditions are handled more clearly.
> >=20
> > 3:The device_unlock call at the end of the function is guaranteed in al=
l cases.
>=20
> Write a paragraph - don't use bullet lists.
>=20
> Please refer to submitting patches for details on how to
> write shortlogs and change logs.
>=20
> "Update core.c" with what? Write a better short log.
>=20
> Why do you this 117488504+Okan-tumuklu@users.noreply.github.com
> in the list? It will complain every time someone responds
> to this thread. This is not how patches are sent. Refer to
> documents in the kernel repo on how to send patches.
>=20
> You are missing net maintainers and mailing lists.
>=20
> Include all reviewers - run get_maintainers.pl

And consider whether the patch is a trip up the garden path, or
actually worthwhile.

Why would if/else be better than a goto?
What's unclear about the current error handling?
In what case is the device_unlock() call missed?

Maybe there's some value in using the scoped cleanup here (do netdev
folks even want scoped cleanup?), but this patch may not be worth the
time spent improving it. +CC Krzk and netdev, before more time is
potentially wasted here.

Cheers,
Conor.

>=20
> > ---
> >   net/nfc/core.c | 28 ++++++++++------------------
> >   1 file changed, 10 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/net/nfc/core.c b/net/nfc/core.c
> > index e58dc6405054..4e8f01145c37 100644
> > --- a/net/nfc/core.c
> > +++ b/net/nfc/core.c
> > @@ -40,27 +40,19 @@ int nfc_fw_download(struct nfc_dev *dev, const char=
 *firmware_name)
> >   	if (dev->shutting_down) {
> >   		rc =3D -ENODEV;
> > -		goto error;
> > -	}
> > -
> > -	if (dev->dev_up) {
> > +	}else if (dev->dev_up) {
> >   		rc =3D -EBUSY;
> > -		goto error;
> > -	}
>=20
> Did you run checkpack script on this patch? There are a few
> coding style errors.
>=20
> > -
> > -	if (!dev->ops->fw_download) {
> > +	}else if (!dev->ops->fw_download) {
> >   		rc =3D -EOPNOTSUPP;
> > -		goto error;
> > -	}
> > -
> > -	dev->fw_download_in_progress =3D true;
> > -	rc =3D dev->ops->fw_download(dev, firmware_name);
> > -	if (rc)
> > -		dev->fw_download_in_progress =3D false;
> > +	}else{
> > +		dev->fw_download_in_progress =3D true;
> > +		rc =3D dev->ops->fw_download(dev, firmware_name);
> > +		if (rc)
> > +			dev->fw_download_in_progress =3D false;
> > +		}
> > -error:
> > -	device_unlock(&dev->dev);
> > -	return rc;
> > +		device_unlock(&dev->dev);
> > +		return rc;
> >   }
> >   /**
>=20
> thanks,
> -- Shuah

--wEGPIiq33+tRNw/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvskPQAKCRB4tDGHoIJi
0tbmAQDg9JEINw94BV/ssP4fgELMXaH0zKhqEjpblWaUymVl9AEAoxJXxnnQ1SSi
P2qIs4zoFSHZA6MEz8KGNJmxKkRkMgw=
=y9nV
-----END PGP SIGNATURE-----

--wEGPIiq33+tRNw/F--

