Return-Path: <netdev+bounces-263375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCTQClgvp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:58:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE61F58C1
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EBE3018296
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB337266C;
	Tue,  3 Mar 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0xM2dWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1437266A;
	Tue,  3 Mar 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564216; cv=none; b=rfdhH8RjxKYqtM2bQvPJn/dtudtCGDQfZI+C5jeHqYD3qcL40HCugWip1nwZPmsP8NBWwZWulXhdDxmuKANy3aGU6WqNCTlLfM6akixwxmxEwLFxR18CMzuYMY6dp4s7BmkhaEQeXjsh6z4fYPTDGlFlh4whXOtQpu65Tkj5ImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564216; c=relaxed/simple;
	bh=iXuJ6jrIMc8vUo4bmDyoU9g0WgoxoOXxdn9TI36tKtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV0tsTz8SQyvyB2+hyHhlEgwd3SLpxLL4wBGiEdVdmgPccml5+zMF74Zo62+tRtROxeU0ykSP8dZcYqIzQwOq5z6AOGszlwbD0Tg2KiLGcxUIgnJywizgwkO8Hd0743DGQ7pgbLOUA54AwIVebpQB64sojEd/tqVj41dMhdPjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0xM2dWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D940CC116C6;
	Tue,  3 Mar 2026 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772564216;
	bh=iXuJ6jrIMc8vUo4bmDyoU9g0WgoxoOXxdn9TI36tKtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0xM2dWGmanHTN3RnnfEHQ2D4PxoDe5X2Bxq+YDnHnj6FW+Ug/LYzC79RkL1LYBWu
	 tMbqu6DE5MYteOn75j2DezgJUWXq9P1Ypwdy/xso1RUPWkpwdkZ2ta39xAF5tDj/cp
	 9tFbhH4HuHCanb2bNA+aBoNxNbfFRvFqWujcsmVrio7bOsJ7on6fmO0mYMuOgYHX8D
	 E+4YBHc5uyVxhcLRU8HYkifT7/WatcRR83aMhmTXpd6mp9BAPTiUUTpwNLe69ogC1S
	 kT5bqSqolfq1wWQWdkG5MZ9tTMvj6D6K3fzf95wedXirQ5GUmY9/1+9tDVOeXU5xB4
	 wGs5LeHpme+Lg==
Date: Tue, 3 Mar 2026 18:56:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260303-disperser-clone-512efa99f26c@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DxAMpvw6uOMHTAr9"
Content-Disposition: inline
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 7FDE61F58C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263375-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.0:email]
X-Rspamd-Action: no action


--DxAMpvw6uOMHTAr9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =D8stergaard wro=
te:
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +      ethernet-switch@0 {
> +        reg =3D <0>;

Also, this is an odd example, why are you at address 0 on a "soc" bus,
which usually means that this device on an AXI/AHB bus, and 0 is very
unusual for that. Obviously the example doesn't have to match the real
user, but this stands out.
I may have some follow up questions I think depending on your answer.

--DxAMpvw6uOMHTAr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacu8gAKCRB4tDGHoIJi
0kg2AQD6rLgs5PT8EdYn5iTW/nA7IABp3cWyFcsd/SZhzre/IAEAqTdeclhF5ETN
hdLH66EImbh6UOw15KTW69WNDzHGaA4=
=+eOC
-----END PGP SIGNATURE-----

--DxAMpvw6uOMHTAr9--

