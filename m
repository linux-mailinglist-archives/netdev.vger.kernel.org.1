Return-Path: <netdev+bounces-34333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B657A3514
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D961C208CB
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4264723A3;
	Sun, 17 Sep 2023 10:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B31FB3;
	Sun, 17 Sep 2023 10:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52139C433C8;
	Sun, 17 Sep 2023 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694945041;
	bh=Gso6S/NadZnbLvgrACDdGV3yKQ0lDXCmgQv0+9JSmeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5bdmq+S8UpnPJnPiePBHbssJs5tcLQYAfJy3MYqUbj4Z1ggrkoekIJNTi+fW/cGS
	 SJpPDQ2WOXZQwUrLeAia9CsGSQW1AjPjrb6Q5R6hJ1gujm7EteVVQzaeedetIM3jdx
	 3xxQis3riBr6+R2kTADEeXAsBA7lewPP8EAHAEg3g4Ono+D9dbGgpbYGAaR+37VhgR
	 ZR6jqzDXReYg3cqVFmpmf6MIsQzUUnFN4wggJeBxJHDo5d3N/disihdWZ/K6ZxnE9g
	 ZcpajpyxaZr9kilkPrnNNINqubQMErLDjlYI0RxwgMciiC5e8iYUbcODsg6wPCntRY
	 wunFLDNXQSYlA==
Date: Sun, 17 Sep 2023 11:03:56 +0100
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
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	fancer.lancer@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] dt-bindings: net: snps,dwmac: Tx coe
 unsupported
Message-ID: <20230917-figurine-overlying-f5a0935af5ea@spud>
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
 <20230916063312.7011-2-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfl5dMioS+61NyiC"
Content-Disposition: inline
In-Reply-To: <20230916063312.7011-2-rohan.g.thomas@intel.com>


--sfl5dMioS+61NyiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 02:33:11PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for coe-unsupported property per tx queue. Some DWMAC
> IPs support tx checksum offloading(coe) only for a few tx queues.
>=20
> DW xGMAC IP can be synthesized such that it can support tx coe only
> for a few initial tx queues. Also as Serge pointed out, for the DW
> QoS IP tx coe can be individually configured for each tx queue. This
> property is added to have sw fallback for checksum calculation if a
> tx queue doesn't support tx coe.
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..5c2769dc689a 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -394,6 +394,11 @@ properties:
>                When a PFC frame is received with priorities matching the =
bitmask,
>                the queue is blocked from transmitting for the pause time =
specified
>                in the PFC frame.
> +
> +          snps,coe-unsupported:
> +            type: boolean
> +            description: TX checksum offload is unsupported by the TX qu=
eue.
> +
>          allOf:
>            - if:
>                required:
> --=20
> 2.25.1
>=20

--sfl5dMioS+61NyiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQbPCwAKCRB4tDGHoIJi
0jpOAP0Rec+DYUN9Tx+3DSmk0L8jcQbqesqX7hzjoxzMCmsBwAD+LoOp6/jRtBiP
ZD5abXvbAPNK63Z3f0NgpMoHlrqdKQY=
=Te+k
-----END PGP SIGNATURE-----

--sfl5dMioS+61NyiC--

