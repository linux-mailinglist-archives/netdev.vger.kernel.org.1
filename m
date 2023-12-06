Return-Path: <netdev+bounces-54397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4623806F66
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AC72818B0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E6358A8;
	Wed,  6 Dec 2023 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do+BQYA2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB234552
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093FC433C7;
	Wed,  6 Dec 2023 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701864277;
	bh=hf0wwGoj3vFrFNGbV6LvWeYIVPa195ZSUjfPzyMczCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do+BQYA2BbTAupbDP9XR8jO2ohSeFNqxyzegnLwHKShStnB6/e5XbUuBKdETV0Nih
	 iflDUYbuMxd6iYNeQg/ADATBJIKCUEDrRdrsHHQD6YcUcWxwb/1oo5tvmmRVQE5/b/
	 euGknZhN9/euy2ebbbNktSs4uYl0+3xKa4vPoB74SaOtoVZ2rUi9SzUW/+LjzgPHQZ
	 cwDEJp2bOjXOCUD2DpR37PHPhHnK9UECvC2cMP0Tv3h5HbSmklrNiizF1z5DpGCNua
	 r7xxW2WzVCrO5D8yeFvouk7DJQJYk5OE4yZXBJs5QtN0FqItlF1l7hGR8wTyDRtNFl
	 2y4U65ty/SXKQ==
Date: Wed, 6 Dec 2023 12:04:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231206-sacrament-cadmium-4cc02374d163@spud>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
 <20231124192407.7a8eea2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q7cAzhk5In1+P+K8"
Content-Disposition: inline
In-Reply-To: <20231124192407.7a8eea2c@kernel.org>


--q7cAzhk5In1+P+K8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 07:24:07PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> > Jakub could you create a stable branch for this patch and share the bra=
nch
> > information? This way other Maintainers can then pull the patch.
>=20
> Tagged at:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loa=
der-add-upload-error

It's taken me longer than I would like to get back to this, sorry.
I tried pulling the tag today and I think there's been a mistake - the
tagged commit is the merge commit into net, not the commit adding the
firmware loader change:

commit 53775da0b4768cd7e603d7ac1ad706c383c6f61e (tag: firmware_loader-add-u=
pload-error, korg-kuba/firmware_loader)
Merge: 3a767b482cac a066f906ba39
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Nov 24 18:09:19 2023 -0800

    Merge branch 'firmware_loader'

commit a066f906ba396ab00d4af19fc5fad42b2605582a
Author: Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed Nov 22 14:52:43 2023 +0100

    firmware_loader: Expand Firmware upload error codes with firmware inval=
id error

I'm going to merge in a066f906ba39 ("firmware_loader: Expand Firmware
upload error codes with firmware invalid error") so that I don't end
up with a bunch of netdev stuff in my tree.

Have I missed something?

Thanks,
Conor.

--q7cAzhk5In1+P+K8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXBjUQAKCRB4tDGHoIJi
0vHBAP0cRxI/7yWoWbLPFAqgbREYK80xk0WLfy3vuYw0StDJ7QD+IWVoxwm4FoLI
0/P0tJpoFx+o2qU0EjYb3/YzT1/s+gE=
=WDQi
-----END PGP SIGNATURE-----

--q7cAzhk5In1+P+K8--

