Return-Path: <netdev+bounces-274515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNI0ItFdzmnvnAYAu9opvQ
	(envelope-from <netdev+bounces-274515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1F388ED6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1768D301CF8F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB23D093E;
	Thu,  2 Apr 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqIp9oK/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DC3DCDA6;
	Thu,  2 Apr 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132092; cv=none; b=WMf6sRHJEOLH+Z3OpEm3+6Uku4gmgNHjrD5hfS3UYEfn/nKjBsw2usMXsge4aSzyu1XNzJ+Asc/0xddu+m1y09YxCNk96PB2iyUUWC84eVSEbSIRebGCs5Q82sqPX3HePJcDaDkM718i07b+qgbTS16GpJ07VIHdL49kwgfwwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132092; c=relaxed/simple;
	bh=EqYl1q6OHzj9GF2+s+7JBq9ShRG/TNsV61jcIPYVR9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZlo2Z4CFJ9EP3rfiFTBiEQ5+Lya3qMMD5Eh2OTDPGsAbFi5WfZivw89FGH5fMvFXiV7PtcPX7hxdjtI4QLqsQZhtfjcFGy1eZFeX8YpUz3p200oXCvInoL+sy9TMN9sLyvsn9Zzw64M4MYmhwsTlaEL6YIWH8KzAasgR30RdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqIp9oK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59337C19423;
	Thu,  2 Apr 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775132091;
	bh=EqYl1q6OHzj9GF2+s+7JBq9ShRG/TNsV61jcIPYVR9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqIp9oK/CmPGFtTrYHBXVTt3YRR7hvL/Lj8X/qA4v6UR4032SX75xrawsWktC3F/k
	 DqXrln9xWd7/rAYk5YlSaKL2NorONWEC7QstrmLMww5lHQv+fYRj3rw39v7b2uk+e4
	 hZ/8+zV6pf/uLAXgGLuW5mJg5Oz2wRmYs/UUPF+oy/TETpwV0KVuo1s9+dj9fiQ9Ed
	 YiojNiERmlBXh/fSNwIqZpk5tnX5IUGwLeIFo4P+8wtPr09MIGImnfaWcEmEbPj++/
	 +ftgRIUYnchCsI2dhmx3SiJ4kcLBqa/DyTzBJpSAxvDX44c38LX0eexi21Fs/Wuu0+
	 GQrx7liM/DJ8w==
Date: Thu, 2 Apr 2026 13:14:44 +0100
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
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 22/22] riscv: dts: starfive: jhb100: Add clocks and
 resets nodes
Message-ID: <20260402-fox-overhand-9a45ec670bce@spud>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
 <20260402105523.447523-23-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i9/X0Hs31jPOYl+N"
Content-Disposition: inline
In-Reply-To: <20260402105523.447523-23-changhuang.liang@starfivetech.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com,vger.kernel.org,lists.infradead.org,starfivetech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BF1F388ED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--i9/X0Hs31jPOYl+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 03:55:23AM -0700, Changhuang Liang wrote:
> Add clocks and resets nodes for JHB100 RISC-V BMC SoC. They contain
> sys0crg/sys1crg/sys2crg/per0crg/per1crg/per2crg/per3crg.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jhb100.dtsi | 198 ++++++++++++++++++++++-
>  1 file changed, 195 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jhb100.dtsi b/arch/riscv/boot/d=
ts/starfive/jhb100.dtsi
> index 4d03470f78ab..700d00f800bc 100644
> --- a/arch/riscv/boot/dts/starfive/jhb100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jhb100.dtsi
> @@ -4,6 +4,8 @@
>   */
> =20
>  /dts-v1/;
> +#include <dt-bindings/clock/starfive,jhb100-crg.h>
> +#include <dt-bindings/reset/starfive,jhb100-crg.h>
> =20
>  / {
>  	compatible =3D "starfive,jhb100";
> @@ -268,12 +270,96 @@ pmu {
>  			<0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;	/* Event ID 34 */
>  	};
> =20
> -	clk_uart: clk-uart {
> -		compatible =3D "fixed-clock"; /* Initial clock handler for UART */
> +	osc: osc {
> +		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <25000000>;
>  	};

Is this really on the SoC?

> =20
> +	pll0: pll0 {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <2400000000>;
> +	};

What's providing all of these PLLs? Are they all fixed-frequency on-chip
PLLs without an off-chip reference? I find that somewhat unlikely.

Since devicetrees are now being imported into U-Boot, it's important to
make sure that I'm not merging fixed-clocks that later get replaced by
dedicated drivers that U-Boot won't have.

To that end, I won't apply the series this depends on without this patch
being applied at the same time.

> +
> +	pll1: pll1 {

Also, none of these follow the preferred naming scheme for
fixed-frequency clocks. Go look at the binding for how they should be,
if they are too be kept.

> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <1000000000>;
> +	};

Cheers,
Conor.

--i9/X0Hs31jPOYl+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCac5dtAAKCRB4tDGHoIJi
0uQHAP0WzBeqVfuYIxoQ5RQ7zJEaN6Xi9MLvyjrUg80WfHDtYwEAlx6dQ13WnFUI
p3u5nsP2s7rO8KPeaaFAN2sMynSwWg4=
=1yvc
-----END PGP SIGNATURE-----

--i9/X0Hs31jPOYl+N--

