Return-Path: <netdev+bounces-289522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OUALwKVDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:51:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9F582A51
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B23130EFDCB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3D3ED3D0;
	Tue, 19 May 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRinJTw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE6408036;
	Tue, 19 May 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207984; cv=none; b=rujgiThiLx9DZ2Z5m2r/B7LtoKiYJGGWY7bUkM0Bf2TD83NKrtuB0111q44YWoFiTDeYXwvZ6SFaT/tnhbrDb2X/vkjTH6FUWDPHpNCrbNbZju8wW7W6tYAeriKZWqXYZE7zp18RZdHvpdrDd2zFu4z1K0gpCUkeunAUwS5/7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207984; c=relaxed/simple;
	bh=Qy8QoqcoKmC+wIgqZfA1zyTVHnYh+FOeAPm5arCsYp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hruaWzsm+B6xQBY9cpTmOSGSPWcc9yJ2vDSZXF+6Tz2+IMXltoJTytVj4OGZBysooVuORqTqFCNIFy0La6ClGelMDFHjGj+1b6aLYESSSydQhse1fqQS6ZH2mRnQSOM4+pHAbBPMGtlxPq8cKRi4gNB2d4L4zPDTMAQyxwsTLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRinJTw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FDCC2BCB3;
	Tue, 19 May 2026 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779207983;
	bh=Qy8QoqcoKmC+wIgqZfA1zyTVHnYh+FOeAPm5arCsYp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRinJTw+v12QFhn920KBVhuNR6fkaX0Oedb+lxn663iShQNZAzFOzLkkWuZfxFrKq
	 GnnlaBL5vrv1ULvSS3lNSEGO7412CrOfWcmkbwq3QX8DnR7TgZEU4j/EVkvUbtt3z/
	 rrp5ZJ3p8vH/3H5drTsTq/MDcqk8dgvc5OltqScXp8UQfPTfethD9A+SZ7HqJt42Sl
	 +pzjKx7hWynYsu+UV9Rrp3+A1PubnedhgK0hbJt2avrrIyIpSsjoroyVx7xyvspaFd
	 JlpYnUJxJOuMtiF8e3qjHyTwKt+Yfwc1a68k655NbkKVO0Xfug555iTIJDCntq0xNF
	 1uqsJppbYkNXw==
Date: Tue, 19 May 2026 17:26:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v4 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 support
Message-ID: <20260519-darn-defile-a3d944c0dba3@spud>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
 <20260519101436.111476-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HT5hQBTU+Tnwer0i"
Content-Disposition: inline
In-Reply-To: <20260519101436.111476-3-minda.chen@starfivetech.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:email,microchip.com:email]
X-Rspamd-Queue-Id: 2BE9F582A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--HT5hQBTU+Tnwer0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 06:14:33PM +0800, Minda Chen wrote:
> The jhb100 GMAC still using Synopsys designware GMAC core.
> hardware features are similar with jh7100.
> Add jhb100 GMAC compatible and reset, interrupts features.
> jhb100 dwmac has only one reset signal and one interrupt
> line.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.=
yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 0d1962980f57..06aeaa0f6f00 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -30,6 +30,10 @@ properties:
>        - items:
>            - const: starfive,jh7110-dwmac
>            - const: snps,dwmac-5.20
> +      - items:
> +          - const: starfive,jhb100-dwmac
> +          - const: starfive,jh7110-dwmac
> +          - const: snps,dwmac-5.20
> =20
>    reg:
>      maxItems: 1
> @@ -107,20 +111,39 @@ allOf:
>            contains:
>              const: starfive,jh7110-dwmac
>      then:
> -      properties:
> -        interrupts:
> -          minItems: 3
> -          maxItems: 3
> -
> -        interrupt-names:
> -          minItems: 3
> -          maxItems: 3
> -
> -        resets:
> -          minItems: 2
> -
> -        reset-names:
> -          minItems: 2
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: starfive,jhb100-dwmac
> +      then:
> +        properties:
> +          interrupts:
> +            maxItems: 1
> +
> +          interrupt-names:
> +            const: macirq
> +
> +          resets:
> +            maxItems: 1
> +
> +          reset-names:
> +            const: stmmaceth
> +      else:
> +        properties:
> +          interrupts:
> +            minItems: 3
> +            maxItems: 3
> +
> +          interrupt-names:
> +            minItems: 3
> +            maxItems: 3
> +
> +          resets:
> +            minItems: 2
> +
> +          reset-names:
> +            minItems: 2
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.17.1
>=20
>=20

--HT5hQBTU+Tnwer0i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagyPKgAKCRB4tDGHoIJi
0sJbAP9qcQjjYmdzs3mA7s2jgBwSRmbrpPIutubexecBL2+LAQD/Tubz2r6RkcOF
8ENzU9A2gnZrpCSUsB7rCh4vpTVEMAw=
=w5ur
-----END PGP SIGNATURE-----

--HT5hQBTU+Tnwer0i--

