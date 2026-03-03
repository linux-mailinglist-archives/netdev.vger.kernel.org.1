Return-Path: <netdev+bounces-263370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NLCM08tp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:49:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE71F5796
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70E803040065
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AD39B95F;
	Tue,  3 Mar 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3l1b5wm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D33D75B9;
	Tue,  3 Mar 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563787; cv=none; b=dzBgDndmL2Vd3AyHOBy1MFMuRTq+2Pw2P5X2PeNpU4B4LwaGiiYaRJDUCeWBgTeaunRCmoNE0a24TglYyyAVwA3yuy0obA1X5V4p1spqP4YXlv9dlw4oZ7pid7RdMG0rpBJ2v+o7VwfujNIwekTdYrL9TL69G1niBn813Orxi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563787; c=relaxed/simple;
	bh=0WlC4XoIlGALIhUZv1G/NtRKkcFAo2neEeU8mwP7WoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3OfrQ+U2tsDPxdoBv1LFWSEjdiiux0WI6uuaQ4b6KKr+CS6ghOszTivo5q09psX+uYBJRlqD3S0NklGHYXdtQpGs7lG9IKORfyYIRQ/JGoAfOvOXtFoS5uFgUF/YUKtpuPZB5600m/y2SI0HE8ERx4/+YNAjHp8T8QoHoBD71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3l1b5wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EADC116C6;
	Tue,  3 Mar 2026 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772563786;
	bh=0WlC4XoIlGALIhUZv1G/NtRKkcFAo2neEeU8mwP7WoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3l1b5wm0xPMheN1Sf4uterwdI3o8tIkSfrzy5SC/6MwfVbZnyDqWt5bcU83Y7DVr
	 pe/TJD0EP2st6eRcAtpo3L27qrO/1X386FfVOBUohhMKLcTFEAGP8z0EcPFDXYlzBz
	 iz8OKPzyp2XHdXswRZytHI574KvB/8qGnajjtXCmQa/u90Zm8CS1AdpJ9vSBH/mNBC
	 RT1bKfJywvRmdnpQ4zeZzuN5sbBOeN3vbDCIilnFG71Eng+2mwYgqhbUFKkbSskuyG
	 m/ZpWuARMcc3Eq8f+ccM1EYTdU7O0j1jjxr7lujqWv5NTdCtXYC5RGgeyzAtYr9Ly/
	 i+Ux4UxdGqOWQ==
Date: Tue, 3 Mar 2026 18:49:40 +0000
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
Message-ID: <20260303-iron-swarm-53248ddd25df@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GwVaQj5pnrQyytIm"
Content-Disposition: inline
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 77EE71F5796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263370-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email]
X-Rspamd-Action: no action


--GwVaQj5pnrQyytIm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =D8stergaard wro=
te:
> Add bindings for LAN9645X switch. We use a fallback compatible for the
> smallest SKU microchip,lan96455s-switch.
>=20
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz =D8stergaard <jensemil.schulzostergaard@m=
icrochip.com>
> ---
>  .../net/dsa/microchip,lan9645x-switch.yaml         | 137 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 138 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x=
-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x=
-switch.yaml
> new file mode 100644
> index 000000000000..4a19dfa7e9d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-switch=
=2Eyaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/microchip,lan9645x-switch.yam=
l#

Just name the binding microchip,lan96455s-switch please, to match the
standalone compatible.

--GwVaQj5pnrQyytIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaactRAAKCRB4tDGHoIJi
0kyXAP9N+lJXIBVmEGoF26C5HrWbYgmxDOCvDX3hlyYFEPHVvQEAoGSFKf2KDWlZ
m7jA1+++yThCCx5WlPNJ5H39AYosWgs=
=NFRQ
-----END PGP SIGNATURE-----

--GwVaQj5pnrQyytIm--

