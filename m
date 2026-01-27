Return-Path: <netdev+bounces-253991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAugK18UeWl3vAEAu9opvQ
	(envelope-from <netdev+bounces-253991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:39:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5E9A068
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3119030AFC3C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F32236E48D;
	Tue, 27 Jan 2026 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us1RXAi/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83836CDE9;
	Tue, 27 Jan 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542375; cv=none; b=fhhf6Y4aGHj/G536GzAkBOEX8ODhztqtXTbGYC4Qtr2U+M5mEnrD3O4qTRHx7Bngs49SlcCM8QxXV0+Aap2WqqzFgTS9wNt+XDuJBryEyL/oIfd/dAtwB3ldUEzPPOp0RakPJPUAxSW24pnfqJhwNpmVCmBFKk5sFWYyIbT3CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542375; c=relaxed/simple;
	bh=c8lDWX4D3RavtMw9/plTwOleLSxCRDavxuXHfl8Y4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7qlAJLGfN7DQjcd6m0+z4cKae/MNcVWO92oxosYRwVM6UNPks4nQegT77kkECOZjtOghDBb7ddHe9KZF71yeMuTg6PE6pAU9v/Dpxkl1yOEb3JKS7IeflU/PtbrM6/jJN/6Pck43D1tUkB1PAUgl6XGzumVW778hqY+R0I9Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us1RXAi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E238BC116C6;
	Tue, 27 Jan 2026 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542375;
	bh=c8lDWX4D3RavtMw9/plTwOleLSxCRDavxuXHfl8Y4Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Us1RXAi/IEvWuS9/cJUHqRKGTDB/ch+lkjjBuCKN1HTYGwxxBh3UH14PJFLIbcRrS
	 5yIV+yXpYK/FKWIm2D2hKKrJ+Wh61IO55bd+rVTgZeX+UE3M2ppjvB1zFE3OjN8RIM
	 12qYoEfhc9J69L5n4UBuT8O7n98rkvpaNhSgwtIH11ToI6Esj7DjGBgJp7l2y75BWx
	 mKuNhCLTWN5CJaCnvtH6/QnXZnJ8BjBnPS7hzd2jK1FGTYEAGMzacgILU8XhUKwOuj
	 +H4kW9QMyvDcJBcC407wtZQOEd7822/MUB6jZBNsO6GFmJ9MobEMcbzsvv8bv3ENEo
	 4VPeO1aqPngUg==
Date: Tue, 27 Jan 2026 19:32:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <20260127-crock-catty-e62e4f699f5a@spud>
References: <20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com>
 <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>
 <20260123-dinner-aloft-e57deb6c546a@spud>
 <aXdiNb92B4HH+ZFt@lsv051416.swis.nl-cdc01.nxp.com>
 <20260126-blinker-secluding-a745f60caccb@spud>
 <aXi07hPBrl7EYezi@lsv051416.swis.nl-cdc01.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WkvxyB8JqVtHXRO6"
Content-Disposition: inline
In-Reply-To: <aXi07hPBrl7EYezi@lsv051416.swis.nl-cdc01.nxp.com>
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
	TAGGED_FROM(0.00)[bounces-253991-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 59F5E9A068
X-Rspamd-Action: no action


--WkvxyB8JqVtHXRO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 01:51:58PM +0100, Jan Petrous wrote:
> On Mon, Jan 26, 2026 at 08:00:33PM +0000, Conor Dooley wrote:
> > On Mon, Jan 26, 2026 at 01:46:45PM +0100, Jan Petrous wrote:
> > > On Fri, Jan 23, 2026 at 05:13:03PM +0000, Conor Dooley wrote:
> > > > On Fri, Jan 23, 2026 at 11:09:55AM +0100, Jan Petrous via B4 Relay =
wrote:
> > > > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > > > >=20
> > > > > The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lin=
es,
> > > > > set them to allow using Multi-IRQ mode when supported.
> > > >=20
> > > > The binding only supports s32{g,r} devices, why is the existing min=
imum
> > > > retained? What devices are going to not have all 11 interrupts
> > > > connected?
> > > >=20
> > >=20
> > > The original idea was to support backward compatibility, as older DTs
> > > didn't contain queue-based interrupt lines described.
> > >=20
> > > But now, when you asked, I started to think it is not needed,
> > > the requirement for backward compatibility is managed inside the driv=
er
> > > and yaml shall describe the hardware not used configuration.
> >=20
> > Just to be clear, cos the last portion of that "yaml shall..." isn't to
> > me, you mean that the driver will support 1 or 11 interrupts but you
> > will make the binding only allow 11? That would be fine.
> > Just note in the commit message that all of these devices have the 11
> > interrupts.
> >=20
>=20
> Well, all those supported devices have 11 interrupts connected (1x MAC),
> then 5x RX (queue0..queue4) and  5x TX (queue0..queue4).
>=20
> Until now, the driver was using on MAC IRQ, so the only one shared line.
> Now, we are enabling support for per-queue interrupts, what means for
> supported SoCs up to 11 IRQs as the DWMAC IP on S32G/R has 5 queues.
>=20
> The driver can still opearate on this one shared IRQ mode, but
> if the DT node configuration describes all IRQs, then the driver switch
> to multi-IRQ mode. What allows better distribution of processor core
> load.

> So the 11 IRQs are the maximum value, in the case when all queues are
> used. But I can imagine some other use-cases, when not all queues
> are enabled, ie. only queue0 and quque1. In that case, the driver will

Since all of the devices have 11 interrupts, this would be software
configuration and the devicetree should contain all 11 even if shared
mode is desired, to reflect how the hardware is configured. I think
minItems should be changed to 11, unless another device gets added later
that does not have all 11 connected.

> use some subset of all IRQs.
> That means that DT can contain only lesser interrupt list then maximum.
>=20
> I feel like having "minItems: 1" shall cover such use-case.


--WkvxyB8JqVtHXRO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXkS3QAKCRB4tDGHoIJi
0jI2AP0WP0sgcNZESXVAvwbBqgu4z6UoHTvYjGRucW4qVxBD2AD+LhuETgd5tQxm
i4Feuiwe6K3mZ5APrN+lkwC0B8lkkg4=
=nLqP
-----END PGP SIGNATURE-----

--WkvxyB8JqVtHXRO6--

