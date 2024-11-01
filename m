Return-Path: <netdev+bounces-141076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC19B9650
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D161C2108A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48C1C9DE5;
	Fri,  1 Nov 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6gxk55o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD619F430;
	Fri,  1 Nov 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481296; cv=none; b=rIvJcZ/wDKwmon5wBQDxux/5FGx877bhc/DvGMtA4Zbse1hJPqWiwS9/CIgdSmPFt28sYJdxChRgTco822k7ZAWFCfC/ruy9ZdThDB0CmWLsyWR5kVtfiWu8839KEvNM2A8EzxyORM8gEKmj8zVCdTuKB4kX0ICl1DVECXHks+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481296; c=relaxed/simple;
	bh=8PQtSQtI2CnGXoc91N1O+lH/gZDi0mLFYKuOeJ3uXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3v18WcQKYO+PseLkreJyNHzTeYpCWEREHPXA462+XodGXdgnpASJSCFeqzRUQZCiziYgfn9U9/KRocp4ztqLUjl3Adsbvrl7HxghfFoPXmJF+HBURW7kBb2WCKFGtW8IB4D4WW+6eHOOupM2ErBAYfGOHtnCmlj2NUr83qV7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6gxk55o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5331C4CECD;
	Fri,  1 Nov 2024 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730481295;
	bh=8PQtSQtI2CnGXoc91N1O+lH/gZDi0mLFYKuOeJ3uXlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6gxk55oOasN96QdE6pIPL8XeM+bZZjNFhozsbBCu8O3G5PJZ+tIMGN3JA1/7irku
	 LB7tMIrId1BdjgITf1p83aLxtzdt853gruWbUz8KL6M3Zv/3ZEB0jsIug84MQPRzPy
	 ev4LsO2Rdvus8hduw+k2fJe0gP8JOAxOSs7gS0NzjWmGm6WR8zhol4EBkSdv55p0Nr
	 wMTbwaO4vrBWg99/Cqb/uTniJafRfyhW0GlIiMhhCzYITtSgFFgsEqRO/tKKqwk/sN
	 t3gjs4IIOBkic2xPuqQskljRpsYz2UQBALwtD1IJQmpOiBru8WxqaUcXLhk8uzeVBh
	 cMFapqj+Yjqwg==
Date: Fri, 1 Nov 2024 17:14:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Suraj Gupta <suraj.gupta2@amd.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct
 phy-mode property value
Message-ID: <20241101-left-handshake-7efc5a202311@spud>
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
 <20241031185312.65bc62dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4wu+VIv2GgdEYoAq"
Content-Disposition: inline
In-Reply-To: <20241031185312.65bc62dc@kernel.org>


--4wu+VIv2GgdEYoAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 06:53:12PM -0700, Jakub Kicinski wrote:
> On Mon, 28 Oct 2024 14:42:14 +0530 Suraj Gupta wrote:
> > Correct phy-mode property value to 1000base-x.
> >=20
> > Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bind=
ings document to yaml")
> > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > ---
> >  Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.ya=
ml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > index e95c21628281..fb02e579463c 100644
> > --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > @@ -61,7 +61,7 @@ properties:
> >        - gmii
> >        - rgmii
> >        - sgmii
> > -      - 1000BaseX
> > +      - 1000base-x
> > =20
> >    xlnx,phy-type:
> >      description:
>=20
> Can we get an ack from DT folks?

I dunno, the commit message gives no detail at all about the impact of
changing this, so I don't want to ack it. I *assume* that this is parsed
by common code and 1000BaseX is not understood by that common code,
but...

--4wu+VIv2GgdEYoAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyUMigAKCRB4tDGHoIJi
0i2GAQCuoR/upzZy1sxES575nS/BSelCvFz2AM3Cj92y894zLwD/ZQg/jXivbBWs
IxMNq6HKt9TBMnZSC0zFLZ6yQoDIag4=
=RM9+
-----END PGP SIGNATURE-----

--4wu+VIv2GgdEYoAq--

