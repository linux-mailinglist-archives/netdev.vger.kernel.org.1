Return-Path: <netdev+bounces-229351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC6BDAEA5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9F3AD534
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF630748E;
	Tue, 14 Oct 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfHtZUaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64632F5A37;
	Tue, 14 Oct 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465548; cv=none; b=jsaFm4PrQuJX+Il0SJI2qyeTyHKA4KnvnPKn+nL2THGIXTcZWvIFDWzRotjRXyW/Z/4oHT79wezluWY3p6QnD6c3rSB69J+du0WMZI+GJ8KfekR4U1ujIRug3MR0TYX2zpf8v7JVJcXrvNsaQLk56hwkfDn64aqYSJLnlRyih1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465548; c=relaxed/simple;
	bh=Pqcib0WjbsS5HXmt5nz+n1gNtS1aHnpdeM+eaWk0/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdMjO7fmKoBc0yXgaTTR06LIItpnnfuyG1y3ChMJdS096Q+ZBBC+SXMXq58kKf5F2CvDF2spkR/eFSiq2WqG0ghqxbPuvoZTxXx2BSGnIOY4R0tnbYps30od4RsTQ+OIW2dj3joHa2R84w5qZS/jwOg4fPM7LUf1BkBHo4XW3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfHtZUaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB69C4CEE7;
	Tue, 14 Oct 2025 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760465548;
	bh=Pqcib0WjbsS5HXmt5nz+n1gNtS1aHnpdeM+eaWk0/tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfHtZUaP7Xv+2c8o/IN5J369CD5NfIElsWrVENcfHOkKhaxXBQVlpFB3ZW+ceoGS6
	 JgDtjUxARywZWBIC1eXwIGfaryQ1ocVy1UG3FLRA5V0AJT/qko5QCkCrKMIQyvWLuc
	 RSUfChW40u6gLhyqRUy7rIlfQNWCK7KBM3VkiIH8dyg2gqtRAXkDu6Kz357OU5vIqY
	 Pcjt7xDuZsmzCEWsnJPS6pcc1sP4SwwF+NgjZbSs1BvO9Xsdfz4UOPJa6txSVy5+mb
	 KwfWEFS1aZbt91ZkNngSTahCKA38gVjoTRepoOBXXjGf715Mbv8uBuJ2YFdies8G8Z
	 UYoP2Vqi16Wdg==
Date: Tue, 14 Oct 2025 19:12:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014-projector-immovably-59a2a48857cc@spud>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
 <20251014-flattop-limping-46220a9eda46@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dNGbIiFgaQ40TQAb"
Content-Disposition: inline
In-Reply-To: <20251014-flattop-limping-46220a9eda46@spud>


--dNGbIiFgaQ40TQAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 07:02:50PM +0100, Conor Dooley wrote:
> On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote:
> > Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
> >   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q):=
 Unevaluated properties are not allowed ('clocks' was unexpected)
> >=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Hmm, I think this pw-bot command, intended for the dt patchwork has
probably screwed with the state in the netdev patchwork. Hopefully I can
fix that via
pw-bot: new



--dNGbIiFgaQ40TQAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO6ShwAKCRB4tDGHoIJi
0vWaAQCzkRMH+0Oz7FRQT7PW4SO9mUoYYstikY/KIQg56FyuwQD/SSOUBbG+ssoH
+/o68oUVn7ns7Mg+yge4k1PI35BS3Qw=
=qaS9
-----END PGP SIGNATURE-----

--dNGbIiFgaQ40TQAb--

