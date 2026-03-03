Return-Path: <netdev+bounces-263362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INgkCzUmp2k3fAAAu9opvQ
	(envelope-from <netdev+bounces-263362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD11F52BF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9F843046109
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD053AE1A3;
	Tue,  3 Mar 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8BV0yC8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89466351C07;
	Tue,  3 Mar 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561933; cv=none; b=j7iFTUOda3bFHMnfA4r57zqBOsAueV3Tt8gVkTPTcQasRSUw5NA5ZdtwN/5Zs4hQ/bmcF1NvnzIzGuKIupEEePkHauEraCmyQAx8nuzZStgA3Whom4u9FaW40Xn2z3hSIC8Kc3jc2I0dy2Dk0Jh2zdCilFeZzG/8UsMDLXelE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561933; c=relaxed/simple;
	bh=SM+jZI63dNdVLMvcOHx/WqNU31IFrfLU5vn6bAy1b3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzyVilEfoFn0fPSwDkBKKZPLgEUq3epe83mNJPr3ga+NHeZdlQgdWUlxra+lo8LZ27tduUDJhdjQ1iAvXlHTn/kYbhf3OUooWt9NEEm265YgCnAlAcmElCNPE/wqdzCsqTdqAQ6Bh87YQrw4r1bGFGhI/ePH9ziPfhegBdzmZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8BV0yC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DC3C116C6;
	Tue,  3 Mar 2026 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561933;
	bh=SM+jZI63dNdVLMvcOHx/WqNU31IFrfLU5vn6bAy1b3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8BV0yC8S40AbCxEpu7L5zuZro86kHVqxeAUIAvi0Hu9ZjFw9V1B55f/tsbGFqQcJ
	 6hfJpQ0VIlNbFbhvcFTxJCei/BXuaR8cyz4xVC9Joia0J/qCYloQfxG0sUe2C53v67
	 Og4iDxyZ/psTaBQUckzF9k70Ow8Bo+BHqUIM5dCP+vTrc+v/WY+O+8S/JK9gyjOE0W
	 SEbOsDu3yH2IFckIO3sfQvdix/6DSJlarCpKmXQLryjdqb7Qrc9GrU9arTY+mEMqH2
	 TCqAb+J7ZuGBJ1cRPizRxZ2OQkL14CVaBCoD0yyC0kaCRBtlQg+9ZZFLoMTd8x+CR5
	 oS8Dd31fNGKCQ==
Date: Tue, 3 Mar 2026 18:18:48 +0000
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
Message-ID: <20260303-primal-cradling-f600faca8504@spud>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drzg1Fc/DuwteNHg"
Content-Disposition: inline
In-Reply-To: <20260303180318.1814791-2-charles.perry@microchip.com>
X-Rspamd-Queue-Id: C8DD11F52BF
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
	TAGGED_FROM(0.00)[bounces-263362-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action


--drzg1Fc/DuwteNHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 10:03:15AM -0800, Charles Perry wrote:
> "p64h" is shorthand for "PIC64-HPSC" and "PIC64HX"

No, sorry. If these are different SoCs they need to have SoC-specific
compatibles, particularly since PIC64HY could be something that is not
compatible with these devices. It'd be fine to add
"microchip,pic64hpsc-gem" with "microchip,pic64hx-gem" as a fallback
though, since they do appear to be very very very similar devices and
can clearly share the same match data in the driver. That's what pic64gx
and mpfs do.

pw-bot: changes-requested

Cheers,
Conor.

>=20
> The generic compatible "cdns,gem" works but offers limited features.
> Keep it as a fallback.
>=20
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index cb14c35ba996..dff350302098 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -27,6 +27,7 @@ properties:
> =20
>        - items:
>            - enum:
> +              - microchip,p64h-gem    # Microchip P64H SoC
>                - xlnx,versal-gem       # Xilinx Versal
>                - xlnx,zynq-gem         # Xilinx Zynq-7xxx SoC
>                - xlnx,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
> --=20
> 2.47.3
>=20

--drzg1Fc/DuwteNHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacmCAAKCRB4tDGHoIJi
0l3UAQCCIKP8RxLT65VuuEMKQq4z1/lpEVVT5IF2iEVqZIB/oQEAzI3zRvW2ETP2
VGuuC2HYMUn1wMaIZZI2Fsfv4EZI1gs=
=tp4E
-----END PGP SIGNATURE-----

--drzg1Fc/DuwteNHg--

