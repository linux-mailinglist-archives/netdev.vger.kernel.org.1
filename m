Return-Path: <netdev+bounces-294298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J4k5CSMIH2pRdwAAu9opvQ
	(envelope-from <netdev+bounces-294298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:43:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2906304EF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:43:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iv46Vtxk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294298-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294298-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 880953026F15
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06337206A;
	Tue,  2 Jun 2026 16:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CF373C0B;
	Tue,  2 Jun 2026 16:42:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418545; cv=none; b=La6UGB5bq6fymIBPzfEuLWm913S4l+lwnJt+SqZb4E3UN3OvmKeD70VUcE+LyG8IC2lRLLPkEcvUns0hSj/ijH9/z7aCLGZb+64sKMKPcVf4KN30j6dao5v0AuFvyz/bEfmcV2E03BtzzocEMjUItRgkwggqMe2uauVd+8u9szY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418545; c=relaxed/simple;
	bh=yLdicBgS31OJfnOdnD0/nzXfokLDi5J65GXJQ4Bg20E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMSCzN7o25FADF4wUpLaUgQHpo7zfBg6EHuLzGokAr0Z01/VoPHMx28wlUh876WcyQ4ZrDYEhUo1VaulUixq4cSR+p93PTPMiXHy3Np39gF1iUbZuMFoe+rBDSumYnngE4dm4gi5SiPCSUhyll4PtwmQ8bpcKK4ZJTomh8FJjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv46Vtxk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BED21F00893;
	Tue,  2 Jun 2026 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418544;
	bh=h2HNNcTXQQ1ElFj6ti8K+wpHo4Vef84XqqU/ALIDgeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iv46VtxkDFnHUaiUstW8bszL/YRknzjeFzxwmdL3NeMojogpjQYuGgWcwn4sOTHgI
	 /lKjFOWWkZieiR/Hi70x/EmUxb3bW6ND3OvEmPkga13x4G+wPSM1Ca32RevnE78P/z
	 BhwoqfxXftRIR1qd6cGCr+pHPfrDdPlY29esXIJCu5Ov+coXjMajaFyisiQapNNsrB
	 qEyR84Y1DLSspywklJV5MYNBBBSPRVyaU6SwB0m6/7eujPRJ3+2/COz4b1ppR0aCza
	 sVYoVcOAiNC4uN1vXlzadhtiwsOxp3Ojh/J7fXqEu+P5umfAC9PhrGi6T1QazD9UL0
	 /IN5MRbdE1MhQ==
Date: Tue, 2 Jun 2026 17:42:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Selvamani.Rajagopal@onsemi.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260602-rebel-snide-5036c97e410d@spud>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HZ1WWXngKVTnQZQS"
Content-Disposition: inline
In-Reply-To: <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pier.beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA2906304EF


--HZ1WWXngKVTnQZQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 09:07:19AM -0700, Selvamani Rajagopal via B4 Relay =
wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
>=20
> According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> specification, interrupt type is active low, level triggered interrupt.

Have you checked the documentation for this device etc to make sure that
the device actually follows the spec?
Maybe Parthiban can confirm this for us?

Cheers,
Conor.

>=20
> Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1=
S MACPHY")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml=
 b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> index 61e11d4a07c4..766ff58147ae 100644
> --- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> @@ -67,7 +67,7 @@ examples:
>          pinctrl-names =3D "default";
>          pinctrl-0 =3D <&eth0_pins>;
>          interrupt-parent =3D <&gpio>;
> -        interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
> +        interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
>          local-mac-address =3D [04 05 06 01 02 03];
>          spi-max-frequency =3D <15000000>;
>        };
>=20
> --=20
> 2.43.0
>=20
>=20

--HZ1WWXngKVTnQZQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8H6gAKCRB4tDGHoIJi
0pUqAP0fkQ62LhS6blqCX8hY60sRpZKoie/VLRfv42S128j1ZwEAmBOhV1ChSOm6
A9xNSy+Fi+Um/tjHu605U8g+8yZF1AU=
=nOV4
-----END PGP SIGNATURE-----

--HZ1WWXngKVTnQZQS--

