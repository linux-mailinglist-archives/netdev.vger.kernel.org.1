Return-Path: <netdev+bounces-275066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KGfFDDKz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D8394FDD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF2F301B928
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF83BE14A;
	Fri,  3 Apr 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkUY/4mA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC93AA4F3;
	Fri,  3 Apr 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225034; cv=none; b=qD2xWQb3ZTgPoCnL9479wzLWz6HJWGLxqWrOkbUgyplJ5HoIGTheXn+pRZ51xIqJ9M4BrxTkAmEoER8vaIm5WP+bv9hDx49fjgl7ZigNP1Hc66GvE9mD3o1B8R6nzrHn3DRwC9HQPM3je1+iiw2Cu5GTa3mYXI/MWuGLCFkoqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225034; c=relaxed/simple;
	bh=4RCGYKzKvjqw6dRyZ1WZ1cabXeFnkUPkqKqCAUHF/Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1dAijum8MHafEO5Gqu0kZrlpliXFIbi36RcPAmMV3iyTCUZrvbqiixpVq+T5PfXK+s5rNUyyrHo1kfy0+dOs7OuTaTC7GcACbABTARrBYiQ2RQoNnpk7WUcRI4qdhxUvWEkXU5RBh1J/U//hlnLBGHl3zQSYSeJjff+NPeF5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkUY/4mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC9BC4CEF7;
	Fri,  3 Apr 2026 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225034;
	bh=4RCGYKzKvjqw6dRyZ1WZ1cabXeFnkUPkqKqCAUHF/Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkUY/4mAIPXiVTcRvDpQiusVSAIqL5ZhjMjkbMe+epj/H9B7YUb2fdN3TBU0S3/nt
	 94M/L5pTBpiYQCtBQV4dVmecQti3kRCbmX0tIrHZ3nCDq3yyqGvPPNmAq5+aIrRq9S
	 hdr8BNSvBAS9HBeM1GXCV9i4ujgjM646YgHBktXfdb354iV+5JPSzGaCSlCOHA4pCV
	 vKaoPSJRVF6drMXBr+7p1CD9Zu15UmW/kuAX9s/g/zPed4VDCJOfjvXvksKSqL2cpm
	 25nFNUtxRkrXq5tr+4JNKmseqHc8f4oluvHSV5Kpr+qipPLPXrTSmYCQhckf2Sd3xv
	 g4hM2qdw47Vlw==
Date: Fri, 3 Apr 2026 15:03:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	JeeHeng Sia <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 22/22] riscv: dts: starfive: jhb100: Add clocks and
 resets nodes
Message-ID: <20260403-composed-overvalue-f6bf1a1fc220@spud>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-23-changhuang.liang@starfivetech.com>
 <20260402-fox-overhand-9a45ec670bce@spud>
 <ZQ4PR01MB12025313E4A491A86580558DF25E2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A6JRgh3YACkqS410"
Content-Disposition: inline
In-Reply-To: <ZQ4PR01MB12025313E4A491A86580558DF25E2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275066-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com,vger.kernel.org,lists.infradead.org,starfivetech.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[24];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A56D8394FDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--A6JRgh3YACkqS410
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 01:07:48AM +0000, Changhuang Liang wrote:
> Hi, Conor
>=20
> > On Thu, Apr 02, 2026 at 03:55:23AM -0700, Changhuang Liang wrote:
> > > Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
> > > sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.
> > >
> > > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > > ---
> > >  arch/riscv/boot/dts/starfive/jhb100.dtsi | 198
> > > ++++++++++++++++++++++-
> > >  1 file changed, 195 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > > b/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > > index 4d03470f78ab..700d00f800bc 100644
> > > --- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
> > > @@ -4,6 +4,8 @@
> > >   */
> > >
> > >  /dts-v1/;
> > > +#include <dt-bindings/clock/starfive,jhb100-crg.h>
> > > +#include <dt-bindings/reset/starfive,jhb100-crg.h>
> > >
> > >  / {
> > >  	compatible =3D "starfive,jhb100";
> > > @@ -268,12 +270,96 @@ pmu {
> > >  			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event
> > ID 34 */
> > >  	};
> > >
> > > -	clk_uart: clk-uart {
> > > -		compatible =3D "fixed-clock"; /* Initial clock handler for UART */
> > > +	osc: osc {
> > > +		compatible =3D "fixed-clock";
> > >  		#clock-cells =3D <0>;
> > >  		clock-frequency =3D <25000000>;
> > >  	};
> >=20
> > Is this really on the SoC?
>=20
> This is not on the SoC.
>=20
> >=20
> > >
> > > +	pll0: pll0 {
> > > +		compatible =3D "fixed-clock";
> > > +		#clock-cells =3D <0>;
> > > +		clock-frequency =3D <2400000000>;
> > > +	};
> >=20
> > What's providing all of these PLLs? Are they all fixed-frequency on-chi=
p PLLs
> > without an off-chip reference? I find that somewhat unlikely.
> >=20
> > Since devicetrees are now being imported into U-Boot, it's important to=
 make
> > sure that I'm not merging fixed-clocks that later get replaced by dedic=
ated
> > drivers that U-Boot won't have.
> >=20
> > To that end, I won't apply the series this depends on without this patc=
h being
> > applied at the same time.
>=20
> I am preparing a PLL driver series, but PLL0 and PLL1 will still retain f=
ixed frequencies.=20
> The reference clock for each PLL comes from the osc. Perhaps I can use "f=
ixed-factor-clock"=20
> to indicate the relationship of the reference clock.

I'll reserve judgement until I see that series so, but it wasn't as if
any of this was going into 7.1 anyway (or maybe even 7.2) so not a
problem.

--A6JRgh3YACkqS410
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCac/IwAAKCRB4tDGHoIJi
0qWuAP45kSoUpbgjkvCJMmJeVgPQwqzykf0EcvPgM4HWcs0dDgEA8YZtZ6Vyulfg
x37EvusJc3nMGl8IOH7sy2iN3jGeUwg=
=LpLD
-----END PGP SIGNATURE-----

--A6JRgh3YACkqS410--

