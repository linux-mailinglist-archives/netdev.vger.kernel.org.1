Return-Path: <netdev+bounces-263354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE5fE6clp2mrewAAu9opvQ
	(envelope-from <netdev+bounces-263354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:17:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45771F5236
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079ED3014BCE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1193537D6;
	Tue,  3 Mar 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLgxNHN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B41351C0F;
	Tue,  3 Mar 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561508; cv=none; b=ph+ht7RaeDrrUK/quJMAX0SdgytofpIcarM6b+9FcmVhi1pOELPlM48qMMiVGJ1l3kmgw76ezT3Too5wRsFyzCmbjfUd5xNtwWgzAJ1oDLJF2MUhqt6It6FH1TJ2FnojY9sHeY3db2sx8GjGzvCCrXvsC0R+wPtf2JBiAnt/UaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561508; c=relaxed/simple;
	bh=ooftv9lYM0YxXQ/qu8gsttncrPPQ7/k8pB7S7dbDKXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryMHWRgaseWE7Zc9WHPdvMtHS6PbDJVXC69Km5wpETnaJxaCct8nZZCcalQvDDaxiyWPnSYXH5wbmkez7ukLxSn50kJtfZQd1vgZi8LYUbMK6JCOrni1V6zBvWrllMO2dyXw1VX9y7D+Rt3WQQcndEdNK9T4dsTl5D7G6E/YGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLgxNHN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2DAC116C6;
	Tue,  3 Mar 2026 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561507;
	bh=ooftv9lYM0YxXQ/qu8gsttncrPPQ7/k8pB7S7dbDKXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLgxNHN0OgfoenWoM/vJ497zA6eUGYMgLkikAIIwGbqPDSKLsCydLdkWvbD6b3erz
	 JkaISw+TFKiYt+6X8yvt/iWqbTgfiOKeVXxGi1Yo1V2WbFanddBl/44WULbAp9+nNu
	 LQY+7f3FStO74Cro7F30NFIbOvGLaiEq3SbVDNuyA1hwb/2UqKydQcjj6cLrrbDusV
	 22gL4fPmXKaAQ6axo2FHkmm6YqeQ/uFBKlX/PCipVi1PknCAjGc8MrcXewax2RfaO6
	 NQ0a8V7LrQGfCSA3LCCekqSneDDGsWTGIOveoisinBMUCDuWRu4IKki9LmF/tUj1Ry
	 NOoSncHIX/T3w==
Date: Tue, 3 Mar 2026 18:11:42 +0000
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
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: cdns,macb: forbid phy
 nodes for Microchip p64h
Message-ID: <20260303-curse-shudder-9bd286fa6cd0@spud>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kVYLEYPFNlPTY8zB"
Content-Disposition: inline
In-Reply-To: <20260303180318.1814791-3-charles.perry@microchip.com>
X-Rspamd-Queue-Id: E45771F5236
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263354-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,80.111.88.32:email,microchip.com:email,0.0.0.0:email]
X-Rspamd-Action: no action


--kVYLEYPFNlPTY8zB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 10:03:16AM -0800, Charles Perry wrote:
> The GEM IPs within Microchip p64h have their MDIO controllers
> unconnected from any physical pin.
>=20
> When compiling a p64h device tree with a phy on a GEM node with
> CHECK_DTBS=3D1, this generates an error like:
>=20
> ```
> linux/arch/riscv/boot/dts/microchip/p64h-hb130x.dtb:
> ethernet@40004180000 (microchip,p64h-gem): ethernet-phy@0: False
> schema does not allow {'reg': [[0]]}
> 	from schema $id:
> http://devicetree.org/schemas/net/cdns,macb.yaml#
> ```

This should just be part of the patch adding the compatible. Adding it
incorrectly only to fix it up one patch later doesn't make sense.
Additionally, remove this information about the error adding this
produces, all you need here is the justification for it.

pw-bot: changes-requested

>=20
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index dff350302098..be66cc9a42fd 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -197,6 +197,17 @@ allOf:
>        required:
>          - phys
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,p64h-gem
> +    then:
> +      patternProperties:
> +        "^ethernet-phy@[0-9a-f]$": false
> +      properties:
> +        mdio: false
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.47.3
>=20

--kVYLEYPFNlPTY8zB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaackXgAKCRB4tDGHoIJi
0mEFAP4x/utBAYjtDikgFeZ09Z1bpUmjAVX6LWWhhf6+IjNITAEA8pui39GfmaF7
oDKupcUfRRsbTw6GX3RpDguW8JnWrQk=
=TfYY
-----END PGP SIGNATURE-----

--kVYLEYPFNlPTY8zB--

