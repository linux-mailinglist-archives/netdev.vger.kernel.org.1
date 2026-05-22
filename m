Return-Path: <netdev+bounces-290914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHGdMlOuEGqPcQYAu9opvQ
	(envelope-from <netdev+bounces-290914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:28:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46F5B9705
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E09300F9CC
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C8379C35;
	Fri, 22 May 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds6ZMMcg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969F2BFC60;
	Fri, 22 May 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478030; cv=none; b=Tifet1NdcU7cvcSheyNzUwSDJVWJ0skqiUwkQUtcVKwVd4z2yK+XOto75VYjlvLzjbutUJa+gi0CffSNT0PA0XRm5bpovLqJMXZ5hQUcyyXk9pwx+xbHh2MfVNWaWsHqZQ6ddM0gupk09atpd9THF1OMLfMbJ9m0b3ZELbsCQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478030; c=relaxed/simple;
	bh=IGMQNUimH8l7rxqgopJApvlEAnOyx7C3tZgxMYyTmLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i26UxWNQ+OwZhYd4KeHuhb54g4ets2GQ1p6i9koIcZ3kaXOkpi9lPedY/mpjR/nPSGNlPuqHN3GxAHUKJRM3HDTKqwUJUbeSNZ3NkaAInE7LTVY+KhL0FlPG3v2RQDo3b6Bn9+B6uGgnLfXZax4LYvaiPi5da6oCpMxQrM8nWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds6ZMMcg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483F1F000E9;
	Fri, 22 May 2026 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478029;
	bh=FCl2h1w1gG7xQ2IOq1++c0XrFQCqGCY1qfeW5ss3aJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ds6ZMMcgx5EDAgUl1oWgYyadlaRI2Wa4jbbhZo8AQztef+B93krJNaxzks2mO5nGN
	 zs3brK3XUN3Vkp7C69SA4iKK0s59G61zOndjX8ehKMihlTbCJyLAatdcDbqsjdswgF
	 yd/SApE5kY4Y8oQhvlSUYujUIEvHc2S+06ugEXPAMAx8i7bS+ba85G20ioe/s1AoVa
	 4jN4HvjZ4qUijyR5GPyHyYif4NaXLCivIk7qhJiirKJQcd9u999dSwTrR8+m5VVcvS
	 3d3zfANxA6AE7SjyUCYvMqzgPTfTNkjy8qosxmUDrPtZX4BpfwZ81971jS1Z0/Qfdt
	 KtTHxsV04Ln4g==
Date: Fri, 22 May 2026 21:27:07 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v8 01/10] dt-bindings: net: airoha: Add GDM port
 ethernet child node
Message-ID: <ahCuC3TgK3Pnuz_w@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
 <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qZn/vsQETJzcLfna"
Content-Disposition: inline
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290914-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.1:email,0.0.0.0:email,0.0.0.4:email]
X-Rspamd-Queue-Id: AE46F5B9705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qZn/vsQETJzcLfna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM ports and
> net_devices.
> Introduce the ethernet node child of a specific GDM port in order to model
> a given net_device that is connected via the external arbiter to the
> GDM{3,4} port. This new ethernet node is defined by the "airoha,eth-port"
> compatible string. Please note GDM1 and GDM2 does not support the
> connection with the external arbiter and they are represented by an
> ethernet node defined by the "airoha,eth-mac" compatible string.

Hi Rob, Krzysztof and Conor,

do you have any comment about this patch? Thanks in advance.

Regards,
Lorenzo

>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 56 ++++++++++++++++=
+++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml=
 b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index fbe2ddcdd909..17fe2edf4886 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -130,6 +130,42 @@ patternProperties:
>          maximum: 4
>          description: GMAC port identifier
> =20
> +    allOf:
> +      - if:
> +          properties:
> +            reg:
> +              contains:
> +                items:
> +                  - enum:
> +                      - 3
> +                      - 4
> +        then:
> +          properties:
> +            '#address-cells':
> +              const: 1
> +
> +            '#size-cells':
> +              const: 0
> +
> +          patternProperties:
> +            "^ethernet@[0-5]$":
> +              type: object
> +              unevaluatedProperties: false
> +              $ref: ethernet-controller.yaml#
> +              description: External ethernet port ID available on the GD=
M port
> +
> +              properties:
> +                compatible:
> +                  const: airoha,eth-port
> +
> +                reg:
> +                  maximum: 5
> +                  description: External ethernet port identifier
> +
> +              required:
> +                - reg
> +                - compatible
> +
>      required:
>        - reg
>        - compatible
> @@ -191,9 +227,27 @@ examples:
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> =20
> -        mac: ethernet@1 {
> +        ethernet@1 {
>            compatible =3D "airoha,eth-mac";
>            reg =3D <1>;
>          };
> +
> +        ethernet@4 {
> +          compatible =3D "airoha,eth-mac";
> +          reg =3D <4>;
> +
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          ethernet@0 {
> +            compatible =3D "airoha,eth-port";
> +            reg =3D <0>;
> +          };
> +
> +          ethernet@1 {
> +            compatible =3D "airoha,eth-port";
> +            reg =3D <1>;
> +          };
> +        };
>        };
>      };
>=20
> --=20
> 2.54.0
>=20

--qZn/vsQETJzcLfna
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahCuCwAKCRA6cBh0uS2t
rFFmAP9bCqqNxm9iUo7L09S4mXpuCBZOetsy0kzJc0wz9A/t/QEAheGcPN75acWD
xrt8EQrZhwP7W2N6/vJzmXpYge3IQQQ=
=NoQd
-----END PGP SIGNATURE-----

--qZn/vsQETJzcLfna--

