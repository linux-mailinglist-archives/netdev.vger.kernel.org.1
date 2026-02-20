Return-Path: <netdev+bounces-259673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGFTEREomGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:23:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB5166280
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49AB33005AA4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA831CA7B;
	Fri, 20 Feb 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyv6KPsN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA965314A94;
	Fri, 20 Feb 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579404; cv=none; b=GgvvDtaRvIdpAmsJyUuNfRIUV6oW8CPSsoNyz8Jq1QeyiPtkrgEved5RVyaTRT0JH9SlPydAIfj5h7ozBFY0yuyDTuv9/WokN0T86sMb/N4vm+48wZg4mWYEhebJM7kA2coO5n6XH3wpXZJ1YgZe3EO/5bnX/HHi/XrN6uYPKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579404; c=relaxed/simple;
	bh=ZVuv+x9tPz+fDZyhArJNw6i1SChHYu51WPdKwBP8+Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syGH7X4FT2axJgcpMA16au1raOFOXaHgMk2hE7+Dk3LzH6JrVl+oQqUX5fFXhO8tpRDqAHwqDC+XEyO4QJskWz4Jhbm2J/2R2qeImTkRBmENk5XApO0fPkZRIwwfiWNC4XBx2Y7d9B9W/uOEDABIhS11E1S7kGgZWWIzHWFaG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyv6KPsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E031C116C6;
	Fri, 20 Feb 2026 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579404;
	bh=ZVuv+x9tPz+fDZyhArJNw6i1SChHYu51WPdKwBP8+Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hyv6KPsNMuwhEbvzZUJbwLNH0LcFZBIWp64TFIMsMaQcjJy2M3zCIwNREfnyporKy
	 kFOOZRxjAoYtnAIlYeyS3+fcuY8pRih7PfL5ZR7k5dF8WBDEAwzpVdC80pnPTO2s0O
	 6RbqyrKQlnKidPOjyuTTJjrxlZs8vnLZQE13kiuTrjkAtXmZeR8fQK6ZGp/0IhW6SW
	 tg/csmgsV1lSz/gBE91qjXkaAKxDJRe0C6m9z5gnN4lL4RBXPp7WJXnZ5vPoxg8KVW
	 j/OG3ZcT6rvz/BoDP+YvC/BTT8fOGozqViAdbfj7ABjxoC/LrO+AyTdRY4hGiY9QKU
	 nh3IEhKMLGkvw==
Date: Fri, 20 Feb 2026 09:23:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Max Hsu <max.hsu@sifive.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/5] dt-bindings: interrupt-controller: Add SiFive
 FU740-C000 PLIC
Message-ID: <20260220-contest-ambiguity-1a4099520bdf@spud>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
 <20260220-fu740-v1-2-c8af54130c58@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mSZIL8+HAWfjN46u"
Content-Disposition: inline
In-Reply-To: <20260220-fu740-v1-2-c8af54130c58@sifive.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259673-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8EB5166280
X-Rspamd-Action: no action


--mSZIL8+HAWfjN46u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 04:27:06PM +0800, Max Hsu wrote:
> Add the SiFive FU740-C000 PLIC compatible string to the binding
> documentation.
>=20
> This follows the SiFive IP versioning scheme which requires SoC-specific
> compatible strings for proper hardware identification, even when the IP
> blocks are functionally identical.

So do the general rules for devicetree bindings, that's not something
SiFive specific FWIW.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml     =
 | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index e0267223887e..351d26ab1956 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -63,6 +63,7 @@ properties:
>                - eswin,eic7700-plic
>                - microchip,pic64gx-plic
>                - sifive,fu540-c000-plic
> +              - sifive,fu740-c000-plic
>                - spacemit,k1-plic
>                - starfive,jh7100-plic
>                - starfive,jh7110-plic
>=20
> --=20
> 2.43.0
>=20

--mSZIL8+HAWfjN46u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZgoAgAKCRB4tDGHoIJi
0iyBAQD6/QrKP5wWk8N0yZGMywRDF9hJKlEcvyWXA/wDi+YeYgD+NOLhtmQyyOmQ
LB+WDVS88sSEEulhWbQdhniOZQPG/gc=
=DGDe
-----END PGP SIGNATURE-----

--mSZIL8+HAWfjN46u--

