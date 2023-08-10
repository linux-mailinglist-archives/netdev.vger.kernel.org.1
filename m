Return-Path: <netdev+bounces-26440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF9777C68
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242B51C214A6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE720C9B;
	Thu, 10 Aug 2023 15:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B7200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE9C433C7;
	Thu, 10 Aug 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691681975;
	bh=+RqZA0cX8VIY0s3e11+0Z9i6zfMLI9V7lSoagiXzHiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjxbKhdZqC5p2SHPbNZsipblSdM/awSjA5WKv4TzP1/gOuM327LgmV4K1MyB2FGm1
	 VwnxudQD81C4kPg9N1ZwuUQWnjnwhQM3uTknXSUuk3Y+YvY97Gec4bb2j+GM+mkSMc
	 N6n5rtiqcoF9F5nfCF85qQBT34ip9ySg1Yt2YUYJyUQATX6G89y1//KgxR+Yx1WI+y
	 LcV0w6CfzfiHlGjioxkW3EOAZtHbKmUIEqidUNu01UYNdEAsebCtWfYnKo/XAqNYAo
	 LDHGTKGwc/Hi9mwU9r4gTl0h4SGzWcMoZMEeVarCKWcwqAz76GbNZD+nb5MH5dqpv1
	 CiKiOa2yuI1aQ==
Date: Thu, 10 Aug 2023 16:39:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230810-avid-perplexed-0c25013617c9@spud>
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230810150328.19704-2-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MuZ3wrqm02dw4gEw"
Content-Disposition: inline
In-Reply-To: <20230810150328.19704-2-rohan.g.thomas@intel.com>


--MuZ3wrqm02dw4gEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:03:27PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for few initial tx queues, starting
> from tx queue 0.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..ad26a32e0557 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -313,6 +313,9 @@ properties:
>        snps,tx-queues-to-use:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: number of TX queues to be used in the driver
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues support TX checksum offloading

Either you omitted a "ing" or a whole word from this description.

>        snps,tx-sched-wrr:
>          type: boolean
>          description: Weighted Round Robin
> --=20
> 2.26.2
>=20

--MuZ3wrqm02dw4gEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUEsQAKCRB4tDGHoIJi
0iOmAQDn/yAcD1JLuhTNKcQin6nvPE+5IS9OqAUHFX4TkbFa9gEAgTyktV5zdQHm
uELPRWXyRAJCvDqDi2+ETRiC7hBXRAg=
=3asX
-----END PGP SIGNATURE-----

--MuZ3wrqm02dw4gEw--

