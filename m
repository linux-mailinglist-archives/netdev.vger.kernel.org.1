Return-Path: <netdev+bounces-264514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDlOB6bOqWk+FgEAu9opvQ
	(envelope-from <netdev+bounces-264514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:42:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F1217131
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5E53075EBA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE23E95A7;
	Thu,  5 Mar 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaL/avDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18A3E7162;
	Thu,  5 Mar 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736145; cv=none; b=UR3yjQTEzBaVUWKrqTimkYfDALHzqcZJsaCEj5uJTA1f2cUqCUldEjN19MHzuEubM0Keh+antcfdsW3vIjPVwirOTPcITLFtaP9XfXG1n3RnY4dp8V0meHn/qpgFfPcpq899xM9RvJzJbLC25loUHZnuZt/bmm6nEFSLawF3Ehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736145; c=relaxed/simple;
	bh=mFBLekNu0pFh38RoS+ly8NDtbNgs1xYCpIaBJhYLK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7nh6+fdAtQamUCzdyMTKhkfaPKxCdUblcN0RRWFTsLo3maEJCGS2Eh6VnuZ44tSI2m1hVv0RRfro+dmBYIM/z/saV6AUT1jdOmHLC2WB4D22RilpGgtq7UfikG/W9uGB8cEccDmNnv+fKV6egMdO7cyCCsbR/OSypl52i3cJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaL/avDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA36C116C6;
	Thu,  5 Mar 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736145;
	bh=mFBLekNu0pFh38RoS+ly8NDtbNgs1xYCpIaBJhYLK6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaL/avDCoUq1hdotZkUw4/COICPIBYrMTm9k+d4uRIetbmtsqV+GciipM7MHurTLs
	 xHKY4E1BNjwJGd2GYjVAnecZv+VegXt/ug1yhqZmDzUTKSpx7rTJHNSrEBGXXySL/W
	 kyIxF8P7MJ11z1jrIc2AUjshfmglqddtat59eBfoN0Oi8qusPMCySS3Om/bmYQra1a
	 lA5GxnsDdMfBVF1ZqNLyQfG6boF98td58zsHVg7txsiJ7vE915l0hsQz3+JNEcWxDZ
	 M/Fr5jz9XHNktZEpxJSj5qc6+1mX8szkHIZfo3b32soS53mwKvluR2akgE776dmWg/
	 7iBc+LfwGFkvQ==
Date: Thu, 5 Mar 2026 18:42:17 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: krzk+dt@kernel.org, Bo Gan <ganboing@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	robh@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add
 clock sampling control
Message-ID: <20260305-goldsmith-omnivore-21958a41ff48@spud>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
 <20260304-regulate-verdict-c3a361d2dc83@spud>
 <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
 <20260304-capable-setback-908ba5b5c858@spud>
 <9eaad6e.4df8.19cbbe95b3c.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9LdxKbp5rG3ADm6j"
Content-Disposition: inline
In-Reply-To: <9eaad6e.4df8.19cbbe95b3c.Coremail.lizhi2@eswincomputing.com>
X-Rspamd-Queue-Id: 706F1217131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-264514-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--9LdxKbp5rG3ADm6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:52:38AM +0800, =E6=9D=8E=E5=BF=97 wrote:
>=20
>=20
>=20
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Conor Dooley" <conor@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-03-04 17:30:57 (=E6=98=9F=E6=
=9C=9F=E4=B8=89)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Bo Gan" <ganboing@gmail.com>
> > =E6=8A=84=E9=80=81: "Jakub Kicinski" <kuba@kernel.org>, lizhi2@eswincom=
puting.com, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@daveml=
oft.net, edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt=
@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gma=
il.com, alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, wens@kern=
el.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghi=
ti.fr, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormrepl=
y.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =
ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfo=
chips.com, pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
> > =E4=B8=BB=E9=A2=98: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: =
eswin: add clock sampling control
> >=20
> > On Tue, Mar 03, 2026 at 05:23:18PM -0800, Bo Gan wrote:
> > > Hi All,
> > >=20
> > > On 3/3/26 16:47, Conor Dooley wrote:
> > > > On Tue, Mar 03, 2026 at 04:38:46PM -0800, Jakub Kicinski wrote:
> > > > > On Tue,  3 Mar 2026 14:16:37 +0800 lizhi2@eswincomputing.com wrot=
e:
> > > > > > There are currently no in-tree users of the EIC7700 Ethernet dr=
iver, so
> > > > > > these changes are safe.
> > > > >=20
> > > > > What do you mean by this sentence? The commit under Fixes was par=
t of
> > > > > Linux v6.19 already.
> > > >=20
> > > > The "funny" thing is that caring about users doesn't even really ma=
tter
> > > > on the devicetree patch, except for this hunk:
> > > > |@@ -81,7 +99,9 @@ properties:
> > > > |                          or external clock selection
> > > > |           - description: Offset of AXI clock controller Low-Power=
 request
> > > > |                          register
> > > > |+          - description: Offset of register controlling TXD delay
> > > > |           - description: Offset of register controlling TX/RX clo=
ck delay
> > > > |+          - description: Offset of register controlling RXD delay
> > > > |
> > > > | required:
> > > > |   - compatible
> > > > And it only matters here because an item is injected mid-list. If t=
his
> > > > was moved to the end with the RXD delay, the **dt-binding** changes
> > > > don't have issues with safety. I've not looked at whether there are
> > > > knock-on concerns about users in the driver or whatever yet, but fr=
om a
> > > > binding POV only that hunk can break something that currently works.
> > >=20
> > > This was already discussed here in v1:
> > > https://lore.kernel.org/lkml/e7183ae1-8b8b-4e77-9f4e-3bc1b4b63556@lun=
n.ch/
> > >=20
> > > The device-tree is not checked in yet by ESWIN folks, so there's curr=
ently
> > > no user of the dt-binding. No need to worry about backward compat.
> >=20
> > The binding and driver exist, there doesn't need to be a dts in tree for
> > there to be potential users. If the break was important I might not
> > care, but this seems to be a gratuitous break, since the new items could
> > be added to the end of the list and compatibility maintained without
> > incurring any more difficulty for you.
>=20
> Hi Conor and Krzysztof,
>=20
> Thanks for the reviews.
>=20
> - The next patch will fix the property order to avoid any breakage
>   with existing DT bindings.

Good, thanks.

> - Eth1 does have a timing issue in silicon, as discussed here:
>   https://lore.kernel.org/lkml/32a1f814.2c79.19bfe173225.Coremail.linmin@=
eswincomputing.com/
>=20
> =C2=A0 Based on this, and according to the advice from Andrew
>   https://lore.kernel.org/lkml/59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.=
ch/
>   https://lore.kernel.org/lkml/bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.=
ch/
> =C2=A0 adding a DT property is not a reasonable approach.
> =C2=A0=C2=A0
> =C2=A0 In the next patch, I will improve the description/paragraph and pr=
operly
>   document the timing issues.

I personally don't mind having two compatibles, but I might be more
clear about what device the new one refers to (so something like
s/clk-inversion/eth1/g). But Krzysztof was the one who objected to
having multiple compatibles, so it's worth waiting to see what he has to
say.

--9LdxKbp5rG3ADm6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaanOiQAKCRB4tDGHoIJi
0kTVAP9/DDa/WZb3rTbhG6Imf28y6B3b5r9J/wxYjlBtYoF2VAEAq36UpKZJpbys
a5AO5ebrLpv/DEjmj/ymz2YiZYHVtgw=
=oXU3
-----END PGP SIGNATURE-----

--9LdxKbp5rG3ADm6j--

