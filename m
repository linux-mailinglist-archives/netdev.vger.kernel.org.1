Return-Path: <netdev+bounces-306615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5dQkNfcLUWpc+gIAu9opvQ
	(envelope-from <netdev+bounces-306615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:12:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053E73C1E7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:12:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fhze5ooB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306615-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306615-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E8263017F9C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1C2DB7B9;
	Fri, 10 Jul 2026 15:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902B232395;
	Fri, 10 Jul 2026 15:10:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696238; cv=none; b=LI7z0u5eq9dMV5Ktnxw9lxabzEMZyXdHu/bFjicWLgyfRGUKiRA0pVGTij02cr0tafQowRxlZcM21OWq73/uKw1KyHJlzNc/Ff8yLNHgfhRqK49y0OHmGBnVnSfoGpZCNBSje4Zzs9X3KHJ3DORC3JWCk6Ey9AAUUeYkkictduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696238; c=relaxed/simple;
	bh=zTbPFAUykePEI/G+PLtbm8iQRnf6X8bZSSN4Z+V/iwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwr+/F9+Gtv/o9XdYYTOJN9Xt96XXsqI4wDGvJU1h58zRC/Ui9Rgv3K50F4PXUkXbMNSEhHYML1SYiJ7lpztLe0LZFJMjpBemvvcHyPSku1XmZkEe+gvpVl2dD/K6sYM72kvvVrAvI6/caN+v2i1yCTb8fg6MlBdePsAunlPK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhze5ooB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C31F000E9;
	Fri, 10 Jul 2026 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783696237;
	bh=gC5jTfqMU+segkDUVBoeanUAbrb2T6l0Jw9afD82M1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fhze5ooBnNbaaZlqkiII5FOcXtz3Y8g64w3sC8oZdBeY/o/btZK79ofmgg2NW5AQt
	 FIx8V5YuERdJPy9sQbba3etfcSMIxlCCsauN79OU7fSeBjXzKoniUsQKSW9WpNgk/s
	 79U/IbdvwPAnfggcS7bA05MnAHD6Aacx6ewWqL5M116YFzo+vdK9Imx9gnJ1xZIJtq
	 nz9lEIkd1aQyoB7HxOtHt1qvcm+zumeEmUvbl8Nx21siK94cuSLHnqhdzEe9fN90Ko
	 dlaXwjiIsUFsFNv4lDLCmTusSGJChc16wujUbg3km0e+4Z+zLKkWm3FDLgRBXjSp19
	 qZpCyO8ZRR3Dg==
Date: Fri, 10 Jul 2026 16:10:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v6 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <20260710-divinely-sharpie-1d415917c850@spud>
References: <20260709194125.2784507-1-jelonek.jonas@gmail.com>
 <20260709194125.2784507-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GKgxUeNZUVNU1rRs"
Content-Disposition: inline
In-Reply-To: <20260709194125.2784507-2-jelonek.jonas@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306615-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spud:mid,microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9053E73C1E7

--GKgxUeNZUVNU1rRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 07:41:20PM +0000, Jonas Jelonek wrote:

> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,=
pse-mcu.yaml

Typically, we want filenames that match the compatibles used within. In
this case, probably pick the oldest and simplest one?
>=20
> +properties:
> +  compatible:
> +    oneOf:
> +      # UART
> +      - items:
> +          - enum:
> +              - zyxel,gs1900-10hp-a1-pse

> +          - const: realtek,pse-mcu-gen1

IOW, this. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: changes-requested

Thanks,
Conor.

> +
> +      # I2C, SMBus framing
> +      - items:
> +          - enum:
> +              - zyxel,gs1920-24hp-v2-pse
> +          - const: realtek,pse-mcu-gen1-smbus
> +
> +      # UART
> +      - items:
> +          - enum:
> +              - zyxel,gs1900-10hp-b1-pse
> +              - zyxel,xmg1915-10ep-pse
> +          - const: realtek,pse-mcu-gen2
> +
> +      # I2C, SMBus framing
> +      - items:
> +          - enum:
> +              - zyxel,xs1930-12hp-pse
> +          - const: realtek,pse-mcu-gen2-smbus
> +
> +      # I2C, raw framing
> +      - items:
> +          - enum:
> +              - linksys,lgs328mpc-v2-pse
> +          - const: realtek,pse-mcu-gen2-i2c

--GKgxUeNZUVNU1rRs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalELZAAKCRB4tDGHoIJi
0sUMAQDVCOId/+vdce++tqBhHVU9kTHXueZF69RXZNoXQT5GjwD8CaRCWRJvoh9n
beqWV91JLItPuMTgygZ+aXXlNLxo+wA=
=ppob
-----END PGP SIGNATURE-----

--GKgxUeNZUVNU1rRs--

