Return-Path: <netdev+bounces-285443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOJiGrzK/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D42284ECD2A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF2AB301A29C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E963D6697;
	Thu,  7 May 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdswB355"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D202E1F02;
	Thu,  7 May 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174648; cv=none; b=ByWON6QJ+ZTAR/oUauDWIyCaC+a+KFN2Eib4Oz30xMLIqX39myzD5UudzRsVVD2JDmetbPbM3cvapZI6z0yU5J7/njcDgwa2gxYb54AxkxaUrYG3EkmIwJcL8Eht7KvVB2M+H8q2DF3qu++F+QC8POF9q6F3XH9P7baLj504nRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174648; c=relaxed/simple;
	bh=/sS7TF2P2okui5cV7b+Als4wJCVp4SLHRLCa7RkEj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqmwpPFMTDAylVNfi3qK2QVp/EICh2s9lMkZE3hy8NGM/BbKYbXTCyjyIqgf2IR9Bvjwz2yUw9J3e3TwMya2d2P1Zw/pUIjgnyygMGx3tlaqmyDm9iMA2W7wkzwAUQBv50FVRp1hW9uVemiZZW4jlnRf5Tgnqf/GVoEfcDUS0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdswB355; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D79C2BCB8;
	Thu,  7 May 2026 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778174648;
	bh=/sS7TF2P2okui5cV7b+Als4wJCVp4SLHRLCa7RkEj1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdswB355jFD2zrL4Pa+3RgmzzXRASCQOfMaY250v5ADrpPwzKPyQ1reRgmi8vIUZX
	 jg78dR41y+75bhPNSSaT/tDhc3FnIAYrUQw+F5xWj7EYJscwL6jV6nc94PiCzcApH6
	 T1hWAFr/JRX2P0n8P1LCU0LZuDvk+gGlWW5pe1X2IvGG7H4ZvNlPkX7CkPpISf8wWJ
	 0Fr4DKckV79NbiPyAipnYFyv9zmJ6TZ1MIBZUNwUbZKEYuptfOieHc2822Y3Bcs80P
	 9KpiTUmdyD88nqopJAO7X7HE7VgsCKFawK4wJ8lzjPwpUaMwgc7plAmtM3VncEmcfA
	 ES7AXyQilubfA==
Date: Thu, 7 May 2026 18:24:02 +0100
From: Conor Dooley <conor@kernel.org>
To: lizhi2@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine delay
 model and HSP register description
Message-ID: <20260507-mural-moocher-ad6e07ef8ae0@spud>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083136.175-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75aYy/57ywRVeCVd"
Content-Disposition: inline
In-Reply-To: <20260507083136.175-1-lizhi2@eswincomputing.com>
X-Rspamd-Queue-Id: D42284ECD2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285443-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,3.1.11.0:email]
X-Rspamd-Action: no action


--75aYy/57ywRVeCVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 04:31:36PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
>=20
> Refine the EIC7700 Ethernet dt-binding based on observed hardware behavior
> and clarify the original delay model for eth0.
>=20
> The previous binding used an enum-based definition for
> rx-internal-delay-ps and tx-internal-delay-ps. Replace it with a
> range-based model using:
>=20
>   - minimum: 0
>   - maximum: 2540
>   - multipleOf: 20
>=20
> This better reflects the actual hardware implementation, which
> supports 20ps granularity delay steps in the MAC RGMII interface.
>=20
> The tx/rx internal delay values are clarified as MAC-side programmable
> delay components applied on the RGMII clock/data path, representing
> the effective delay seen at the MAC interface.
>=20
> This does not change the intended hardware semantics, but aligns the
> binding with the actual hardware implementation.
>=20
> These properties are optional and only required when MAC-side fine
> tuning is needed; otherwise delay alignment is provided by PHY or
> board design.
>=20
> Depending on the selected RGMII timing mode, delay alignment may be
> provided by the PHY (e.g. rgmii-id) or by board/MAC-side configuration.
> When PHY or board design already provides the required delay, these
> MAC-side properties may be omitted. When MAC-side fine tuning is
> required, they should be provided to describe the internal RGMII
> timing adjustment.
>=20
> Additionally, extend the description of the HSP subsystem register
> layout used by the MAC glue logic. This includes explicit TXD and RXD
> delay control registers to ensure deterministic initialization and
> to override any residual configuration potentially left by bootloaders.
>=20
> Add reference to the EIC7700X SoC Technical Reference Manual,
> Chapter 10 ("High-Speed Interface"), Part 4 for background of the
> HSP CSR block:
> https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual=
/releases
>=20
> There are no in-tree users of this binding, so no ABI impact is
> expected.
>=20
> Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 =
SoC")
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---

While this is v1, it's really v8 and there should therefore be a
changelog that explains where my ack and the new compatible went.

Cheers,
Conor.

>  .../bindings/net/eswin,eic7700-eth.yaml       | 50 +++++++++++++------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml=
 b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> index 91e8cd1db67b..fab95603bd82 100644
> --- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -63,16 +63,39 @@ properties:
>        - const: stmmaceth
> =20
>    rx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2540
> +    multipleOf: 20
> +    description:
> +      RX internal delay in picoseconds applied on the RGMII clock at the=
 MAC
> +      side. The hardware supports 20 ps steps.
> +      This property is optional and only needed when MAC-side delay tuni=
ng
> +      is required.
> =20
>    tx-internal-delay-ps:
> -    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +    minimum: 0
> +    maximum: 2540
> +    multipleOf: 20
> +    description:
> +      TX internal delay in picoseconds applied on the RGMII clock at the=
 MAC
> +      side. The hardware supports 20 ps steps.
> +      This property is optional and only needed when MAC-side delay tuni=
ng
> +      is required.
> =20
>    eswin,hsp-sp-csr:
>      description:
>        HSP CSR is to control and get status of different high-speed perip=
herals
>        (such as Ethernet, USB, SATA, etc.) via register, which can tune
>        board-level's parameters of PHY, etc.
> +
> +      Additional background information about the High-Speed Subsystem
> +      and the HSP CSR block is available in Chapter 10 ("High-Speed Inte=
rface")
> +      of the EIC7700X SoC Technical Reference Manual, Part 4
> +      (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf). The manual is
> +      publicly available at
> +      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference=
-Manual/releases
> +
> +      This reference is provided for background information only.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
> @@ -82,6 +105,8 @@ properties:
>            - description: Offset of AXI clock controller Low-Power request
>                           register
>            - description: Offset of register controlling TX/RX clock delay
> +          - description: Offset of register controlling TXD delay
> +          - description: Offset of register controlling RXD delay
> =20
>  required:
>    - compatible
> @@ -93,8 +118,6 @@ required:
>    - phy-mode
>    - resets
>    - reset-names
> -  - rx-internal-delay-ps
> -  - tx-internal-delay-ps
>    - eswin,hsp-sp-csr
> =20
>  unevaluatedProperties: false
> @@ -104,24 +127,23 @@ examples:
>      ethernet@50400000 {
>          compatible =3D "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
>          reg =3D <0x50400000 0x10000>;
> -        clocks =3D <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> -                <&d0_clock 193>;
> -        clock-names =3D "axi", "cfg", "stmmaceth", "tx";
>          interrupt-parent =3D <&plic>;
>          interrupts =3D <61>;
>          interrupt-names =3D "macirq";
> -        phy-mode =3D "rgmii-id";
> -        phy-handle =3D <&phy0>;
> +        clocks =3D <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> +                <&d0_clock 193>;
> +        clock-names =3D "axi", "cfg", "stmmaceth", "tx";
>          resets =3D <&reset 95>;
>          reset-names =3D "stmmaceth";
> -        rx-internal-delay-ps =3D <200>;
> -        tx-internal-delay-ps =3D <200>;
> -        eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x100 0x108 0x118>;
> -        snps,axi-config =3D <&stmmac_axi_setup>;
> +        eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
> +        phy-handle =3D <&phy0>;
> +        phy-mode =3D "rgmii-id";
>          snps,aal;
>          snps,fixed-burst;
>          snps,tso;
> -        stmmac_axi_setup: stmmac-axi-config {
> +        snps,axi-config =3D <&stmmac_axi_setup_gmac0>;
> +
> +        stmmac_axi_setup_gmac0: stmmac-axi-config {
>              snps,blen =3D <0 0 0 0 16 8 4>;
>              snps,rd_osr_lmt =3D <2>;
>              snps,wr_osr_lmt =3D <2>;
> --=20
> 2.25.1
>=20

--75aYy/57ywRVeCVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzKsgAKCRB4tDGHoIJi
0kXYAQDSJ5Nb/+ywgAZ6JhcPy0ioHT02zVbqxDPEW5juK6NEAgEA3mw2372IXYbh
JQseHS5qL3qXMdFwjwp4T713jZ3Ybws=
=kGYF
-----END PGP SIGNATURE-----

--75aYy/57ywRVeCVd--

