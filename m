Return-Path: <netdev+bounces-27687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79FE77CE00
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D242814C4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196CE134CB;
	Tue, 15 Aug 2023 14:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1E111B0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE06C433C7;
	Tue, 15 Aug 2023 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692109411;
	bh=G0wLK5bMRBZ3biEchEhetIoIiQUxmKkj//WHJ7fAgPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayT/rgQZ9gf6TrxVQT3sc+8xiMemB0kYDYqjjBJ4oZG7/pyrNlqvKMsiJacV7sfuw
	 N1hyx9+1O7GWZYe3bMlssVLZsrWObOOFiammzaUsX+qM0eMBK5U62HwAfMjzTwnMm9
	 Qs4kjUCb7YLtciKzj80gSQ1/wYb4i4nROV8qB+bpBYWe1oObvjTthdrEFTKppgVe4J
	 bKAMp1vYydharH/5fI4ceiiGT+53TK0DBtWLkQOtaF8edOWmrHmwmErF2+MUleGEij
	 FRMuREKDjQ+LutI+xUzfvqnZ+lNqHr8wytA4wc9lDJbMlfGDETJlUlFyE2duviPPJv
	 uFClPDn9XM4kg==
Date: Tue, 15 Aug 2023 15:23:25 +0100
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
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230815-reconcile-reshoot-1dfc9ab4a60f@spud>
References: <20230814140637.27629-1-rohan.g.thomas@intel.com>
 <20230814140637.27629-2-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="31EWOSqhpz72Q0+j"
Content-Disposition: inline
In-Reply-To: <20230814140637.27629-2-rohan.g.thomas@intel.com>


--31EWOSqhpz72Q0+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:06:36PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for a few initial tx queues,
> starting from tx queue 0.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..0c6431c10cf9 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -313,6 +313,9 @@ properties:
>        snps,tx-queues-to-use:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: number of TX queues to be used in the driver
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues that support TX checksum offloa=
ding
>        snps,tx-sched-wrr:
>          type: boolean
>          description: Weighted Round Robin
> --=20
> 2.19.0
>=20

--31EWOSqhpz72Q0+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNuKXQAKCRB4tDGHoIJi
0kNYAQC89tAi2N1i1739qtPj8asdT8XtPs5imJ8IXuR77su/SgEAtdnyhxQ9FezS
87c/00tTpw4Xbqxwe7wmDz5Hf5pSlAM=
=gfdG
-----END PGP SIGNATURE-----

--31EWOSqhpz72Q0+j--

