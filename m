Return-Path: <netdev+bounces-19541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95175B230
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A411C21450
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F018B0E;
	Thu, 20 Jul 2023 15:15:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E11772A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F333C433C7;
	Thu, 20 Jul 2023 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689866131;
	bh=04mRcNWXgjQaxb3drv8PqaZhrLgEK17mnXzAi5oyt+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZ7zi/YChc7USpnQSp5T0WNJP3whsLqNWbYH0AXGbZ+OPIel3HkL12V4RKtTgkT3q
	 12cinlCgxfelVNBEDAe/C0Nug7zGF65Y84fptydiaXuEy/BOgWQmMqwP3Vk3usLG7u
	 3miKCy4dtQr/lMDbN52RFCxGfNngX2QivUxp114Tc6xZ2qBGdMQLKmuJTze6tSUeSA
	 t1s8ShqnRBSwyTwAM+xWRnykyxYYelnnPwhfWr7DhahqaYfd2teQXHFSN7bOVgrJj0
	 z4jdKRMjh1U/oMSe6H9AvAsgbvJy/MGYoL5COk72Gbzu/sIgrRNmoJYLy53QDhrCSF
	 aJNHRycL1Vrzg==
Date: Thu, 20 Jul 2023 16:15:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
	benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230720-proxy-smile-f1b882906ded@spud>
References: <20230719183225.1827100-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d/z8QjQ7RZYLewHr"
Content-Disposition: inline
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>


--d/z8QjQ7RZYLewHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 19, 2023 at 11:32:25AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
>=20
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.

Thanks for writing this up, it's great to have this stuff written down.

I had one minor comment from reading through things...

> +Responsibilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon promptly.
> +Even when a particular driver only sees one patch a month, or a quarter,
> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the response time will vary by subsystem.
> +The patch review SLA the subsystem had set for itself can sometimes
> +be found in the subsystem documentation. Failing that as a rule of thumb
> +reviewers should try to respond quicker than what is the usual patch
> +review delay of the subsystem maintainer. The resulting expectations
> +may range from two working days for fast-paced subsystems (e.g. networki=
ng)
> +to as long as a few weeks in slower moving parts of the kernel.
> +
> +Mailing list participation
> +--------------------------

> +Reviews
> +-------

> +Refactoring and core changes
> +----------------------------


> +Bug reports
> +-----------

=2E.I noticed that none of these sections address actually testing the
code they're responsible for on a (semi-)regular basis. Sure, that comes
as part of reviewing the patches for their code, but changes to other
subsystems that a driver/feature maintainer probably would not have been
CCed on may cause problems for the code they maintain.
If we are adding a doc about best-practice for maintainers, I think we
should be encouraging people to test regularly.


--d/z8QjQ7RZYLewHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlPigAKCRB4tDGHoIJi
0vo7AP9SiCGy+w1ylCijiSy5SGDnWjSKXk19XlvB6y46RGchEgD/eDPkXorZb8NH
dbM/yc7dITacGo/AZysVMhOVCS2KYA4=
=umN0
-----END PGP SIGNATURE-----

--d/z8QjQ7RZYLewHr--

