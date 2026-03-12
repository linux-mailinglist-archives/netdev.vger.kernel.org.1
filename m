Return-Path: <netdev+bounces-267012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLfYHRyUsmnONgAAu9opvQ
	(envelope-from <netdev+bounces-267012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:23:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E9E2704DD
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3516302C5FF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794783B5312;
	Thu, 12 Mar 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXvpD/36"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440735A3A5;
	Thu, 12 Mar 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310951; cv=none; b=rGecPQoY5kqNimqikkHM7U1jV5adkSJ/4/TruDz7IfOdtROXWbBykLWf944rmQJspozYyfaGL8DciQ+EaehLHchFnPQ26ffi0iT5eH3QhbBUoZzUiKLiOiPCCYzxHYE0lFlMhuilRMG6pZcSGuk8XBiTX58yKTnv7XQ9bqg5xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310951; c=relaxed/simple;
	bh=h9YSKRTZGF583NYryI301XnKTB+VY4d9eZcYTI6L0mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwtRC6Fi8Qny9OO6m9/QmyB0Kr1lfDXpJKkcFn9qtMZVjiPLJRxLHNJ5vlsyW+cM9lbhIu6UypxzecRDcWUn7Lfs1/nH8iVFnV3i2EPSG0CoeMmYgGTNDEJbVQ3MyuHfFpscNNYoi2ukSF0m0kIsDXTE4yWXdDTgnK1vy24OTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXvpD/36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7284FC4CEF7;
	Thu, 12 Mar 2026 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773310950;
	bh=h9YSKRTZGF583NYryI301XnKTB+VY4d9eZcYTI6L0mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXvpD/36HWhV2uAFhkuL3LSram9ibN5VHQQFuIdI0m0rBaKsbneKQQcixQFgFyeGR
	 /ixKek6TghhDHQfK1toi4U8zUwd32mB7zh/FHRYI1qQH97AYgi8dp7q9I0Ty60SCFg
	 3pNGR20ixSJXmwSHC2wJL5Tap4s2uyDb5volkxAW4Y5YIVGt7z9TpYTLzrcJsZPtaz
	 jMJ/vdTC6kywXsyEGKMaAG6eBv+VJb0d9QbN1Unf7PnIdaW7cVQplCNrF/6D9aWKPk
	 Mszd/NZFisaur0v2WahAMwj1i6F8YXDCYY3mQJoqe0jWA730ku49FHPd6mqo5J+1I3
	 VZpuTIcy+ZBkA==
Date: Thu, 12 Mar 2026 10:22:23 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>, Ryan.Wanner@microchip.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v3 00/10] macb usrio/tsu patches
Message-ID: <20260312-fool-obsessed-3ba0a7c7cc37@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
 <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wg429xnLYxmYuNFe"
Content-Disposition: inline
In-Reply-To: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-267012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0E9E2704DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wg429xnLYxmYuNFe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:09:24AM +0100, Th=E9o Lebrun wrote:
> Hello Conor,
>=20
> On Tue Mar 10, 2026 at 6:17 PM CET, Conor Dooley wrote:
> > At the very least, it'd be good of the soc vendor folks could check
> > their platforms and see if their usrio stuff actually lines up with what
> > the driver currently calls "macb_default_usrio". Ours didn't and it was
> > a nasty surprise.
> >
> > Theo, you added eyeq5 recently. Does it genuinely have the same usrio
> > bits as the at91 devices?
>=20
> Sorry I missed your direct mention. After checking (because I completely
> ignored this part of the code before), the User I/O feature is disabled
> on EyeQ5 & EyeQ6H. It can be seen from DCFG1 BIT(9). It was invisible
> because the USRIO register turns read-only when User I/O is disabled.

Ye, my assumption was that on your platform and sifive it's not enabled
but didn't have the behaviour of np4 where accesses don't complete.

>=20
> 1. So I thought about adding runtime detection.
>=20
> 2. But then having eyeq5_config->usrio made no sense so I dropped it.
>=20
> 3. And then I thought that a config having usrio being NULL should
>    imply MACB_CAPS_USRIO_DISABLED to ensure we don't NULL dereference
>    the bp->usrio pointer.
>=20
> #1 is useless for EyeQ combined with #2 and #3, but it should be useful
> for the many compatibles that inherited the wrong default value of
> at91_default_usrio.

Yeah, that's a good shout. I never checked to see if this had a control.

> I am sending those three patches as a reply, feel free to pick them up
> if you consider them useful. They apply on top of your series and have
> been tested on EyeQ5.

Ye, I think they're a good idea. Thanks for sending em :)

--wg429xnLYxmYuNFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabKT3gAKCRB4tDGHoIJi
0thYAQDSnsVDrIoSK3oA+E80W/ccq+tdstmAM6a0wgF6piT8EgD/Vd4hV89FYGSa
JwJLyF8ZdrUYu6DQijMfSnjdpP6jcQA=
=ZCzG
-----END PGP SIGNATURE-----

--wg429xnLYxmYuNFe--

