Return-Path: <netdev+bounces-108188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D191E44A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C466285771
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61C16D300;
	Mon,  1 Jul 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkJaksBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68816CD2C;
	Mon,  1 Jul 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848256; cv=none; b=ec4XR00+aVkGsMcS3LtjnAHBkg3XQGLckyLuYq/Am/pPdeXZnsgdgBDj/3gbvHIurWksDzvpaD8GtTq28tMNtJ2w3OVl2VHekg3VN9DINGFYel7iJEahnf+i8imglpmxZw5TfaC0hfpaOefrPuH6HbovLBWaPVqkit5cPcPROHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848256; c=relaxed/simple;
	bh=6xLG9gejykXLJ01LV0GBV05fGjC37m1kgN/owrHxuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRxYolFwyy9EoyCXipQPyi5FrzDModNlQA/JQxLnYVO6ktdjX7BvwKvtZxgOIa4RT5dDXLEtLc6Tp8RQJkpfduG7zXr+5VYgeu3qBGCQIc/fVUzdNRmzSleVVKB05eud1IgM+IsLkk3+meBIBSDN7pPhdKLbsHPr3TW+k7kjSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkJaksBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E27C116B1;
	Mon,  1 Jul 2024 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848256;
	bh=6xLG9gejykXLJ01LV0GBV05fGjC37m1kgN/owrHxuZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkJaksBEx4Hz4oBkA8Le19qm36sNpHmyaRMTPPREUG0cenY5pUw6iQEjIk1ndnjbY
	 YevL3J2kqkzbO4dg7l9T3DCC5Nnk8SFMD31ogvUrvrFuNnF/OctJ70f6OeJEA/hO51
	 Sm/oqcyEfQd6JkIe9/ZOuOonA3BZXfK3DjOE6bGl0TPvtzkgknvZ6Agia3dTjDJGaX
	 bkCk/hPMOWqpcBnKP787wPQ9YQmWmQroUYBSGaSjaFMFch6IXbk4wrGv6h5KS87W64
	 7LZ4E4835Sy5lowLQHyr5HgMKFd1/tBoHZlp9WRv+jHrdH84RBQ+eypRYzt60ugdk9
	 O4MUIDInOJPyA==
Date: Mon, 1 Jul 2024 16:37:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dwmac: Validate PBL for all
 IP-cores
Message-ID: <20240701-concierge-goofy-dbed136abe4b@spud>
References: <20240628154515.8783-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XLWvfM11bBx7ol4T"
Content-Disposition: inline
In-Reply-To: <20240628154515.8783-1-fancer.lancer@gmail.com>


--XLWvfM11bBx7ol4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 06:45:12PM +0300, Serge Semin wrote:
> Indeed the maximum DMA burst length can be programmed not only for DW
> xGMACs, Allwinner EMACs and Spear SoC GMAC, but in accordance with
> [1, 2, 3] for Generic DW *MAC IP-cores. Moreover the STMMAC driver parses
> the property and then apply the configuration for all supported DW MAC
> devices. All of that makes the property being available for all IP-cores
> the bindings supports. Let's make sure the PBL-related properties are
> validated for all of them by the common DW *MAC DT schema.

I'd been leaving this one for Rob, given the earlier discussion - but I
had one (minor) comment about the commit message here. I think it is fine
for the kernel to unconditionally read a property if present, with no
regard for the compatible in question, and to rely on the binding
ensuring that the properties are not used where invalid. IOW, I don't
think that that is a relevant justification for making the properties
available on all hardware.

However, as you say, it seems like all versions of the core actually do
support the features the properties control and therefore the patch is
perfectly fine. I just wanted to ~comment on~nitpick that portion of the
commit message.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> [1] DesignWare Cores Ethernet MAC Universal Databook, Revision 3.73a,
>     October 2013, p.378.
>=20
> [2] DesignWare Cores Ethernet Quality-of-Service Databook, Revision 5.10a,
>     December 2017, p.1223.
>=20
> [3] DesignWare Cores XGMAC - 10G Ethernet MAC Databook, Revision 2.11a,
>     September 2015, p.469-473.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>=20
> ---
>=20
> The discussion where we agreed to submit this change:
> Link: https://lore.kernel.org/netdev/20240625215442.190557-2-robh@kernel.=
org
>=20
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 80 ++++++-------------
>  1 file changed, 26 insertions(+), 54 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5a39d931e429..509086b76211 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -447,6 +447,32 @@ properties:
>      description:
>        Use Address-Aligned Beats
> =20
> +  snps,pbl:
> +    description:
> +      Programmable Burst Length (tx and rx)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,txpbl:
> +    description:
> +      Tx Programmable Burst Length. If set, DMA tx will use this
> +      value rather than snps,pbl.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,rxpbl:
> +    description:
> +      Rx Programmable Burst Length. If set, DMA rx will use this
> +      value rather than snps,pbl.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32]
> +
> +  snps,no-pbl-x8:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
> +      rev < 3.50, don\'t multiply the values by 4.
> +
>    snps,fixed-burst:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> @@ -577,60 +603,6 @@ dependencies:
> =20
>  allOf:
>    - $ref: ethernet-controller.yaml#
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - allwinner,sun7i-a20-gmac
> -              - allwinner,sun8i-a83t-emac
> -              - allwinner,sun8i-h3-emac
> -              - allwinner,sun8i-r40-gmac
> -              - allwinner,sun8i-v3s-emac
> -              - allwinner,sun50i-a64-emac
> -              - ingenic,jz4775-mac
> -              - ingenic,x1000-mac
> -              - ingenic,x1600-mac
> -              - ingenic,x1830-mac
> -              - ingenic,x2000-mac
> -              - qcom,sa8775p-ethqos
> -              - qcom,sc8280xp-ethqos
> -              - snps,dwmac-3.50a
> -              - snps,dwmac-4.10a
> -              - snps,dwmac-4.20a
> -              - snps,dwmac-5.20
> -              - snps,dwxgmac
> -              - snps,dwxgmac-2.10
> -              - st,spear600-gmac
> -
> -    then:
> -      properties:
> -        snps,pbl:
> -          description:
> -            Programmable Burst Length (tx and rx)
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,txpbl:
> -          description:
> -            Tx Programmable Burst Length. If set, DMA tx will use this
> -            value rather than snps,pbl.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,rxpbl:
> -          description:
> -            Rx Programmable Burst Length. If set, DMA rx will use this
> -            value rather than snps,pbl.
> -          $ref: /schemas/types.yaml#/definitions/uint32
> -          enum: [1, 2, 4, 8, 16, 32]
> -
> -        snps,no-pbl-x8:
> -          $ref: /schemas/types.yaml#/definitions/flag
> -          description:
> -            Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
> -            rev < 3.50, don\'t multiply the values by 4.
> -
>    - if:
>        properties:
>          compatible:
> --=20
> 2.43.0
>=20

--XLWvfM11bBx7ol4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoLNOwAKCRB4tDGHoIJi
0qAoAQD5uIvD5Yo0jgNBbfMZUUoUe3osh0lslMQBRktekRB+5gD/ZeKGDTzVMx6q
WuSXdcuPPsnwUY+MrnknFBDdwPiwiAE=
=QoSx
-----END PGP SIGNATURE-----

--XLWvfM11bBx7ol4T--

