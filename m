Return-Path: <netdev+bounces-263385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VD7kOec3p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:35:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDA1F6171
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1509C3047F89
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EC3845A7;
	Tue,  3 Mar 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfxUiYUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA7384257;
	Tue,  3 Mar 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566350; cv=none; b=u016NSMLT9JQTn5WemzDdMo0Nt+Da6PURyFQVVarEkjusXC/2T1aakIQYpcMoCIe/hJPa153NaZkC6GtePhP98KtQJUM0RHGps00yXYlcVeJBNEQjF7yU4N8SMmsiYi87iKuTYQYEm7pCCKtwdOov4ozUvAFCXRtmXRgpKsP9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566350; c=relaxed/simple;
	bh=CHI37TAlRt74v8kYs6Ao/TCdBlNOLQeXQREAOrlX3qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS0RJbEUxTsv49uj1vHa1WXQ7oHeYIJTcG4sNfLhqe0P2NQsOJZadkAi0Z3Y8bM2SThVKWr9DFc7oK5QyMmSM7FUja/CwwftsMckW13S5f8zrgdxOBaOqwkOOnQmjJoYhcPh8ERdtawRHfi96Z9IkpvDDJTwrGRBfFddik2yr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfxUiYUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE72DC116C6;
	Tue,  3 Mar 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772566350;
	bh=CHI37TAlRt74v8kYs6Ao/TCdBlNOLQeXQREAOrlX3qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfxUiYUIBLhW5yBuVp/9P+fe+CdpgdaXNxHYgS8NyEFuDBSz03sqth5svjVWdAexc
	 Xh7fRVZgx6iMd3O82dfySxgSBLIMuYdURYiuOTlKLY/vmdNr3DTWP07qO08wre0xMg
	 GG6ueWm7cZtCnZ+6rPysGFygfMXJ54jY8RXIP9FfCMX8iqZK6Qhpxxmvuqva2p4qXF
	 AAfXGR6czlk47LOQG7cXUQnQ2mLJ7Vcc3qZd/UyIisP1qk8+v0C0767YNkuxhACVsl
	 feJaUewYBAbRe04kpK4mNXXIcTvVidZuZU2Ne0IlswxMbqF0+jGVYgUeC3KEm9cHp8
	 F4tNj0UMXuzpA==
Date: Tue, 3 Mar 2026 19:32:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: cdns,macb: add a
 compatible for Microchip p64h
Message-ID: <20260303-emperor-childlike-6c43d8a91753@spud>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-2-charles.perry@microchip.com>
 <20260303-primal-cradling-f600faca8504@spud>
 <aacuSRxLktvCBaNK@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFfwmOCZdM0xtUN3"
Content-Disposition: inline
In-Reply-To: <aacuSRxLktvCBaNK@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 97BDA1F6171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263385-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


--BFfwmOCZdM0xtUN3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 10:54:01AM -0800, Charles Perry wrote:
> On Tue, Mar 03, 2026 at 06:18:48PM +0000, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 10:03:15AM -0800, Charles Perry wrote:
> > > "p64h" is shorthand for "PIC64-HPSC" and "PIC64HX"
> >=20
> > No, sorry. If these are different SoCs they need to have SoC-specific
> > compatibles, particularly since PIC64HY could be something that is not
> > compatible with these devices. It'd be fine to add
> > "microchip,pic64hpsc-gem" with "microchip,pic64hx-gem" as a fallback
> > though, since they do appear to be very very very similar devices and
>=20
> Yes, "very very very similar" is the right term.

FWIW, if the only difference was binning or fusing, having the same
compatible for more than one device could be okay. But these are
actually like polarfire-soc and rt-polarfire-soc, where they look very
similar to software but the rt process means that they're physically
different, right?

> > can clearly share the same match data in the driver. That's what pic64gx
> > and mpfs do.
>=20
> Ok, no problem. Like this? :
>=20
> ```
>       - items:
>           - enum:
>               - microchip,pic64hpsc-gem
>               - microchip,pic64hx-gem
>           - const: microchip,pic64h-gem
>           - const: cdns,gem

I was thinking
- items:
    - const: microchip,pic64hx-gem
    - const: cdns,gem
- items:
    - const: microchip,pic64hpsc-gem
    - const: microchip,pic64hx-gem
    - const: cdns,gem

And getting rid of the "pic64h" that may end up not being sufficiently
common in the future.

> Also, how important is it to use "pic64h" vs "p64h"?

Oh I didn't even notice that tbh, I just have "pic64" muscle memory from
the pic64gx, and the pic32mzda also spells it out. My OCD says says "pic",
and the fact that all the marketing stuff uses "pic" kinda votes in that
favour too.

> Much of the downstream development uses "p64h" in compatibles, file names,
> function names, etc. and it would create some overhead to rename
> everything.

This is probably one of the easiest things to absorb from a
up/down stream perspective, you could (and probably will on other
submissions) get far more disruptive feedback than something that's
effectively cosmetic and can be solved by adding a single line to a
driver. To be honest, I don't care if you rename functions or filenames,
it's only devicetree related things that I personally care about.

> Although, as I think of it, it might not be a bad thing since it would
> allow to quickly identify the mainstream from the downstream code.

--BFfwmOCZdM0xtUN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaac3SAAKCRB4tDGHoIJi
0tILAP4tyjUnQe2461tFZYPURM3iwxfZBL/Ke1P6j1CfiXiXnAD+P0AkUSNCjc/U
O1m93hJu5nKnmFrfpqVC7nZ2S91VEwY=
=sLAw
-----END PGP SIGNATURE-----

--BFfwmOCZdM0xtUN3--

