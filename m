Return-Path: <netdev+bounces-182382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F65A88999
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA49D7A9920
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016A289350;
	Mon, 14 Apr 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ8f2c9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395571F236B;
	Mon, 14 Apr 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651188; cv=none; b=UvC30c+BF0elcM4NUSeaUBaozCaNSsJw6AySu6YNL5oMqlX6aB3o5qoti4j2JrHWd0YZV0DL1K67O8ryh9Y0/xRqhNjqf4Meh/M6r43hKkWH94UlkANzhmp3rhakXfqT4u+m+OP0DSt6+zGsTBkJVOq5TJ4hvXVtqLM0m/JcJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651188; c=relaxed/simple;
	bh=z37GMPLQfQqtOQrNOtRcvsIzo/ZNg3+Bc9JSK7Jgb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jylm6NB7eI/TvUC3ChU4FTrYAU1pip7n8ANijToTvFcrvOgY1qCfFuiISFjc2qOCF/KrG+RU8Gp/8xZI9Y1Nsf3Zcm5Gal/tFcJrlt+jLX8olI5HMUQJ0OJS43wkorImg/DieyEzZ/W3YxMUb9OlbTvuZbGl/PetOhvi6TcruG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ8f2c9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C958C4CEE2;
	Mon, 14 Apr 2025 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744651187;
	bh=z37GMPLQfQqtOQrNOtRcvsIzo/ZNg3+Bc9JSK7Jgb08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZ8f2c9lqfQZuQfWRr3KwemWv7exS/LcHLgCoLIJY1DNeczSaMQ2+K/p3z/mVRHXf
	 5fYgsygYh/xIH5tIyU6QCvN2kjL9ycG1XsUaTCvSMyNM4nLwmEiQOuIVQJBGnIU6Wi
	 eH72/9HbUpRpNs98Zbzt7Vw2DVusLEdBAFtqH9l7CD88Y6x5GgcdBgeL04Bde+YmwC
	 uvjY5W2kBUh85KIg46dZSjcc6e1uqYGFbQIOnKSpCtulOiaTYwdjG2KKrMZ9DZebqt
	 cv8y7JFEPsnuR9d4g+wONPywfX0U+hqROxapwUq2PEVZlBBIUUt0Kmcio/GxuCMMnk
	 0927u0k2ScVQw==
Date: Mon, 14 Apr 2025 18:19:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Prathosh.Satish@microchip.com,
	krzk@kernel.org, netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, jiri@resnulli.us, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
	kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
	mschmidt@redhat.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Message-ID: <20250414-residual-unblended-c21c7bc6eeb2@spud>
References: <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
 <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
 <7ab19530-d0d4-4df1-9f75-060c3055585b@redhat.com>
 <4e331736-36f2-4796-945f-613279329585@lunn.ch>
 <7e6bf69b-0916-4ad9-b42f-8645f5c95d5d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2OKUgsrCAQgxlv5y"
Content-Disposition: inline
In-Reply-To: <7e6bf69b-0916-4ad9-b42f-8645f5c95d5d@redhat.com>


--2OKUgsrCAQgxlv5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:56:15AM +0200, Ivan Vecera wrote:
>=20
>=20
> On 10. 04. 25 11:12 odp., Andrew Lunn wrote:
> > On Thu, Apr 10, 2025 at 08:33:31PM +0200, Ivan Vecera wrote:
> > >=20
> > >=20
> > > On 10. 04. 25 7:36 odp., Andrew Lunn wrote:
> > > > > Prathosh, could you please bring more light on this?
> > > > >=20
> > > > > > Just to clarify, the original driver was written specifically w=
ith 2-channel
> > > > > > chips in mind (ZL30732) with 10 input and 20 outputs, which led=
 to some confusion of using zl3073x as compatible.
> > > > > > However, the final version of the driver will support the entir=
e ZL3073x family
> > > > > > ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc
> > > > > > ensuring compatibility across all variants.
> > > >=20
> > > > Hi Prathosh
> > > >=20
> > > > Your email quoting is very odd, i nearly missed this reply.
> > > >=20
> > > > Does the device itself have an ID register? If you know you have
> > > > something in the range ZL30731 to ZL30735, you can ask the hardware
> > > > what it is, and the driver then does not need any additional
> > > > information from DT, it can hard code it all based on the ID in the
> > > > register?
> > > >=20
> > > > 	Andrew
> > > >=20
> > > Hi Andrew,
> > > yes there is ID register that identifies the ID. But what compatible =
should
> > > be used?
> > >=20
> > > microchip,zl3073x was rejected as wildcard and we should use all
> > > compatibles.
> >=20
> > You have two choices really:
> >=20
> > 1) You list each device with its own compatible, because they are in
> > fact not compatible. You need to handle each one different, they have
> > different DT properties, etc. If you do that, please validate the ID
> > register against the compatible and return -ENODEV if they don't
> > match.
> >=20
> > 2) You say the devices are compatible. So the DT compatible just
> > indicates the family, enough information for the driver to go find the
> > ID register. This does however require the binding is the same for all
> > devices. You cannot have one family member listing 10 inputs in its
> > binding, and another family member listing 20.
> >=20
> > If you say your devices are incompatible, and list lots of
> > compatibles, you can then use constraints in the yaml, based on the
> > compatible, to limit each family member to what it supports.
> >=20
> > My guess is, you are going to take the first route.
>=20
> Yes, this looks reasonable... in this case should I use
> microchip,zl3073x.yaml like e.g. gpio/gpio-pca95xx.yaml?

No, please pick one of the compatibles in the file and name the same as
one of those.

--2OKUgsrCAQgxlv5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/1DrQAKCRB4tDGHoIJi
0tgQAQDiMG2LA+SQ4PGFUrDaU4IzQmjpflF0phs6a37CN+1gnwEA/FHtd04YGCSz
Oc9nrC2QJLVRLTQhkJ6c3IA9ypnSrwU=
=DfiI
-----END PGP SIGNATURE-----

--2OKUgsrCAQgxlv5y--

