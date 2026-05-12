Return-Path: <netdev+bounces-287261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFTjA1BuA2pS5wEAu9opvQ
	(envelope-from <netdev+bounces-287261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1B527299
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8789731C9C02
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA23DB96F;
	Tue, 12 May 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZe5/qGy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9283BB109;
	Tue, 12 May 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608341; cv=none; b=DoInsG5whx/Myx3eAvfiLoYgQk0kpVleoTiumYd3JGiKOV3MYSxgcdBGPufM02qx6wsjfnemsTs/7UvK1PV+gJjEhyNea/nfeK+3fEgymaPemzMgBR2FrGTD6Zc5Rk4XZWRANIW/YzAsZOo/0H34H0D8AeXnlJvmBWriZKmS5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608341; c=relaxed/simple;
	bh=D9vJ5HtkAGkOmshdUY3VVOptxWjNoXc69chOXvLAPTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7qegagzjABybZlsEwzxXRwEk4tzmopS/IaDHoqr9uwD/Fkv/jsgi4Z6wvC9VFT05VC+NI61C7TLdd5FqVJscOFbdTdMjVlf/FBebXPkR/D3j5MS0AXea65UkB5OOYzr9SVgKsSw0NHbY4wiEaMtXLYxeYcpnEnYQdR8BO7KYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZe5/qGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC43C2BCB0;
	Tue, 12 May 2026 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778608341;
	bh=D9vJ5HtkAGkOmshdUY3VVOptxWjNoXc69chOXvLAPTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZe5/qGy+4ZxN4txY/ngASb0BPodqfAE3oAry8WCNZ4tTh7NP23nLfetJWRgv9sEw
	 vGquvJWaLXigODNPXsr6YMIFSoxvrZYVRnMaDJ93sqFVJN18p+gZ1U4HnJ/ORXrmzF
	 PCmGJfLSk6nWJvJwm7qzwBBBQLMI9Rbq03PRDghT9KQMybvwjfZkMZUxNcShlpyCVA
	 BELn6KdBNo7EHQh/PHcc/Jz4vC+CFXc2P+KENa9JTZ6nEwgWTdlih/UA9X9FZ6D+Vz
	 nEnSiAFkI2k2UQqtj3KIyF7rR8JMGN8mHTP5SAo+XS3kOoVzWL50tF/3EmSTNOSfb4
	 uKlnffBwTpnIQ==
Date: Tue, 12 May 2026 18:52:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Ali Rouhi <rouhi.ali@gmail.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: Re: [PATCH net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
Message-ID: <20260512-cadet-overrun-c66bf033e024@spud>
References: <20260511211143.19792-1-arouhi@sitime.com>
 <20260511211453.20671-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zbnkNKaEdESDfcYM"
Content-Disposition: inline
In-Reply-To: <20260511211453.20671-1-arouhi@sitime.com>
X-Rspamd-Queue-Id: 5FC1B527299
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.68:email,sitime.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Action: no action


--zbnkNKaEdESDfcYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 02:14:52PM -0700, Ali Rouhi wrote:
> Add device tree binding documentation for the SiTime SiT95316
> and SiT95317 DPLL clock generators.
>=20
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit9531x.yaml        | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml =
b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> new file mode 100644
> index 000000000000..0b05f0de65b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiTime SiT9531x DPLL Clock Generator
> +
> +maintainers:
> +  - Ali Rouhi <arouhi@sitime.com>
> +
> +description: |
> +  The SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
> +  generators with integrated DPLL for synchronization applications.  Both
> +  variants contain four PLLs with automatic/manual reference selection,
> +  DCO frequency adjustment, and phase offset measurement via an on-chip
> +  TDC (Time-to-Digital Converter).
> +
> +  The SiT95317 provides 4 inputs and 8 outputs; the SiT95316 provides
> +  4 inputs and 12 outputs.


> +
> +  Runtime configuration (reference selection, frequency, phase) is manag=
ed
> +  through the kernel DPLL netlink subsystem; the device tree describes o=
nly
> +  the hardware wiring.

This is not relevant information in a binding FYI.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - sitime,sit95316
> +      - sitime,sit95317
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the chip's active-low reset pin.  If present, the
> +      driver holds the line deasserted at probe.  Optional; boards that =
do
> +      not route the reset line omit this property.

Description here shouldn't talk about what linux drivers do with the
property. Remove the second sentence please.

> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt from the chip's active-low INTRB output.  When wired, the
> +      driver uses it to trigger immediate status readback instead of
> +      relying solely on periodic polling.  Optional.

Same here. If you even converted "uses it" to "should" or "must" then
it'd be fine.

> +
> +required:
> +  - compatible
> +  - reg

Can you explain why there's no reference to dpll-device.yaml and none of
the properties involved are used?

Cheers,
Conor.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        clock-generator@68 {
> +            compatible =3D "sitime,sit95317";
> +            reg =3D <0x68>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        clock-generator@68 {
> +            compatible =3D "sitime,sit95316";
> +            reg =3D <0x68>;
> +            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;
> +            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> --=20
> 2.43.0
>=20

--zbnkNKaEdESDfcYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNo0AAKCRB4tDGHoIJi
0lPOAP9ihretCX9yInwgtx9p8/POA3mp/7NDnABT/m3kXEzL6QD+I4WSEDrkk0rl
PhNQOXngh8tOpbcP7MfMTnnwxtUuRQg=
=vrHJ
-----END PGP SIGNATURE-----

--zbnkNKaEdESDfcYM--

