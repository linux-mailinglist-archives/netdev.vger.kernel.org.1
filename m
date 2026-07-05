Return-Path: <netdev+bounces-304786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id olWyDqhuSmoPDAEAu9opvQ
	(envelope-from <netdev+bounces-304786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E677770A618
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:48:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bDUNe3Ip;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304786-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304786-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9332B301828A
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC33803DD;
	Sun,  5 Jul 2026 14:48:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2733347C6;
	Sun,  5 Jul 2026 14:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262883; cv=none; b=n67Rh+FnfzD0EkOzeM2tOx7L8cc3JMGhnc/D1paHzDzsHoNEWmS6FO+ztXkApQ/f/cO8Wq1eiEiBYC8B6nuD5GXUkqw2toer9TlUUEMuxp+illBP9g8RU4UnCUBnLoHcuLxavrSpPGfHvBIC82EUubr38NiLTBJxMAsJU9hT794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262883; c=relaxed/simple;
	bh=IapWGt1veNqxOIcHGcw94j5cPhf1WPHsmmBl+M8Db4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX5fNwx+6o4+ql16Xy7Fi216PuW6pDDpUhsGZeFBueSY2HdhtOKWtWvCbbkJFVKKMFAeNaq2Zseb+Dj+EbrSBeEdB/KuUYvISJPkZ5gpqzn/HJKFAHq+tImsc75oPDDcBTnxv/JMURkYhnUZfsYMvmODlIbD17tM/x5VS58Dtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDUNe3Ip; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B881F000E9;
	Sun,  5 Jul 2026 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783262881;
	bh=UlYXU1qS0vwP6GO5xRuEl/y/r2Ay40eklzolqAObtF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDUNe3IpRspasOsPMBHBgoZ855b66W41bax3jiC36Iueoz09A5EoPkDC5Qc4epFUp
	 qu2Q2N6vb40+k+xLSJLif37mLqpZKId3tg88JCH1C76A+CJ1cXy7BUlEAYGXq4izDx
	 lIGtvdnOu4uPFKg99O3jFGgsRgeLY9N6tBDScvzQbvO8iqa0kNjYiB8ZXN/cTVQ638
	 J/zJtqvuc0DdZyqjZ/LWMWu9Tyu3GgsetA5HjvtS3dba8OkDzBdNp4zeRjSd3pRnQz
	 egA9Wu/EaGOOyj491/BrN8PvCiP0fBSOszvkQHwpsaGm1nf/PMocwHsM20GX5fjn+F
	 dVRExXQd44rbw==
Date: Sun, 5 Jul 2026 15:47:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: nfc: samsung,s3fwrn5: add
 S3NRN4V and clk-req-gpios
Message-ID: <20260705-panic-reviving-993142677f47@spud>
References: <20260703202601.78563-1-jorijnvdgraaf@catcrafts.net>
 <20260703202601.78563-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DwWmt+Yvmo67xykl"
Content-Disposition: inline
In-Reply-To: <20260703202601.78563-2-jorijnvdgraaf@catcrafts.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:jorijnvdgraaf@catcrafts.net,m:krzk@kernel.org,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304786-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spud:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E677770A618

--DwWmt+Yvmo67xykl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 10:26:00PM +0200, Jorijn van der Graaf wrote:
> The S3NRN4V is an S3FWRN5-family NFC + eSE controller found e.g. on the
> Fairphone 6 (SM7635). Add a compatible for it and document the optional
> clk-req-gpios property: when wired, the controller drives this line to
> request its reference clock (needed to generate the poll carrier), and the
> driver gates the clock on it instead of leaving it always-on.
>=20
> The line is modelled as a GPIO rather than an interrupt because the driver
> reads its level to (re)synchronise the clock state, not just react to its
> edges. It is only meaningful on the S3NRN4V, so it is restricted to that
> compatible.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
>  .../bindings/net/nfc/samsung,s3fwrn5.yaml     | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.ya=
ml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
> index 12baee457..3ebcd0933 100644
> --- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
> +++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
> @@ -14,12 +14,20 @@ properties:
>      enum:
>        - samsung,s3fwrn5-i2c
>        - samsung,s3fwrn82
> +      - samsung,s3nrn4v-i2c

Why does the compatible contain the bus? The s3frn5 device probably only
has it because it's an old text binding, your new device shouldn't have
that.

pw-bot: changes-requested

Thanks,
Conor.

> =20
>    en-gpios:
>      maxItems: 1
>      description:
>        Output GPIO pin used for enabling/disabling the chip
> =20
> +  clk-req-gpios:
> +    maxItems: 1
> +    description:
> +      Input GPIO pin connected to the controller's clock-request output.=
 When
> +      present, the reference clock is enabled in response to this signal
> +      instead of being left always-on.
> +
>    interrupts:
>      maxItems: 1
> =20
> @@ -58,12 +66,25 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: samsung,s3fwrn5-i2c
> +            enum:
> +              - samsung,s3fwrn5-i2c
> +              - samsung,s3nrn4v-i2c
>      then:
>        required:
>          - interrupts
>          - reg
> =20
> +  # The clock-request handshake only exists on the S3NRN4V.
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: samsung,s3nrn4v-i2c
> +    then:
> +      properties:
> +        clk-req-gpios: false
> +
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> --=20
> 2.55.0
>=20

--DwWmt+Yvmo67xykl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakpunAAKCRB4tDGHoIJi
0gVgAP4tvuqBhaZ228L0ROWRbnr758cpA1W497SNJSZp97YOfgD/Trxth7/GTRpQ
B9ciLo62hZ3odzTxSB0TJN6vCPwdSg4=
=SnpT
-----END PGP SIGNATURE-----

--DwWmt+Yvmo67xykl--

