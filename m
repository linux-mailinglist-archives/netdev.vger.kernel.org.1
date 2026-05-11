Return-Path: <netdev+bounces-286602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMtYOy20AWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4AA50C308
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E309D3029A4F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6D3D9051;
	Mon, 11 May 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDSaqUMn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4253D093F;
	Mon, 11 May 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496263; cv=none; b=E12/0WWP31dnBSwQm884elgp+PcEQKXxMvSWYBwclgkRamBkrHmTMA7jKYfqv8QrGzI7MMBRhmxeE3j8gjqIXDeMxJdIm7GbQfRIc3mwi+pLcBtxaBcQOxMrQTzu8nnXPtLwjEQM2S5yj6lv7cByCm5qvdlFc5wlKjyQmlwmLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496263; c=relaxed/simple;
	bh=hz1q+4NUU2V+NicWNZbe3cANGe42RkOrxqmFgGggUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFUo25cEa/w/Sm+gjbdySC9MNEjmm1fqQl+2NYAk9toVV09S6maA9zLUCsUJnrM0sdHBINPkvo5NZtIQLYAAVOLub/P5pzJOfsADmDYq5WaZaQ1o6dSEdTIx+8Q0+8mNLJJBpOw7uhkJ7KtXeAOL4FfPlNEJSe8DUevPHNmnBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDSaqUMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB1C2BCB0;
	Mon, 11 May 2026 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496262;
	bh=hz1q+4NUU2V+NicWNZbe3cANGe42RkOrxqmFgGggUZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDSaqUMniI8GuuoBfidhvPghubLZVt7Jfu5s/MmW10k5tnSRtuDCpZQHttXjbILJx
	 1XWPCwmxZEnw8eSqxTSrLK2iXxLLxeYSjYXjg7euZGdQhUc0Sk5Zf/HLDwBogrx4eM
	 c1Q6ZE8kX0KASNZlzDTtORi7BjrZC0e+ErOCuf1Ln/arnQQtICRdYNfAOCUvagAH34
	 9Z8cYkm9HDHNw7AhixkLxT4jZxyxyNgKRpQ34UgnmIGjokp+mf0xmpgU2KCoZLf/Ly
	 J9jL/GUhCmFmFdIOSSXJfoRhh2cXCICQFIDPo3U/TLH5OB0jqJnb+F+LRiM/xt3bTu
	 01yVAtA7CqXTw==
Date: Mon, 11 May 2026 12:44:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/12] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Message-ID: <agGzBKLm1rlGLNwv@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-1-805e38edc2aa@kernel.org>
 <20260510140501.AF190C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75R9xbSTaatBEu1s"
Content-Disposition: inline
In-Reply-To: <20260510140501.AF190C2BCC9@smtp.kernel.org>
X-Rspamd-Queue-Id: 6A4AA50C308
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--75R9xbSTaatBEu1s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] The `reg` property check in the conditional `if` block uses an i=
nvalid JSON schema sequence that will always evaluate to false, causing val=
id device trees to fail validation.
> - [High] The `ethernet-port@[0-5]` nodes model a `net_device` but strictl=
y forbid standard network configuration properties like `mac-address` and `=
phy-handle`.
> - [Low] Missing `#address-cells` and `#size-cells` in the `required` list=
 for conditional child nodes.
> --
>=20
> commit 270a641148bef0e32520efd84b62bf6b97aa5a63
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
>=20
> This commit introduces the ethernet-port property for EN7581 and AN7583
> SoCs to model multiple net_devices connected via an external arbiter to
> GDM3 or GDM4 ports.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> [ ... ]
> > @@ -130,6 +130,38 @@ patternProperties:
> >          maximum: 4
> >          description: GMAC port identifier
> > =20
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            reg:
> > +              items:
> > +                - enum:
> > +                    - 3
> > +                    - 4
>=20
> Will this schema condition evaluate as expected?
>=20
> In dt-schema, reg properties are parsed into a matrix format, which is an
> array of arrays of integers like [[3]]. This schema checks if the first
> element of the outer array matches the scalar values 3 or 4, but since
> the first element is an inner array, it won't match a scalar.
>=20
> Could this cause the if block to always evaluate to false, causing valid
> ethernet-port nodes to be incorrectly rejected because the parent node
> sets unevaluatedProperties: false?

ack, I will fix it in v6.

>=20
> > +        then:
>=20
> Since #address-cells and #size-cells are needed for the ethernet@[3-4]
> variants to act as buses for the new ethernet-port children, should they
> be included in a required list within this conditional block?
>=20
> Without them, an incomplete device tree could omit these properties and
> silently pass schema validation.

ack, I will fix it in v6.

>=20
> > +          patternProperties:
> > +            "^ethernet-port@[0-5]$":
> > +              type: object
> > +              unevaluatedProperties: false
>=20
> Does setting unevaluatedProperties: false here without referencing
> ethernet-controller.yaml# forbid standard network properties?
>=20
> Since this models a net_device, driver code often expects to parse standa=
rd
> properties like mac-address or phy-handle. Device tree authors might not
> be able to configure them without triggering schema validation errors.

ack, I will fix it in v6.

Regards,
Lorenzo

>=20
> > +              description: External ethernet port ID available on the =
GDM port
> > +
> > +              properties:
> > +                compatible:
> > +                  const: airoha,eth-port
> > +
> > +                reg:
> > +                  maxItems: 1
> > +                  description: External ethernet port identifier
> > +
> > +              required:
> > +                - compatible
> > +                - reg
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D1

--75R9xbSTaatBEu1s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGzBAAKCRA6cBh0uS2t
rBZ/AP46ekX8PHt/fV44JNuazuFfnPxwV0ywUdUIHKOWKpN02wEA4KhdOe/Ec2Mb
KOaTypuBMGwQFs92Gl0hMwHuOrfkQgE=
=tFn6
-----END PGP SIGNATURE-----

--75R9xbSTaatBEu1s--

