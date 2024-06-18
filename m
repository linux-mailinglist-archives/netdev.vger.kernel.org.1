Return-Path: <netdev+bounces-104638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E9790DAF2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F631C2372D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1014884D;
	Tue, 18 Jun 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKChmAEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612D1CAB3;
	Tue, 18 Jun 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732856; cv=none; b=oAlllr4px283nZi4WfTeAVqchX8t7QhIH3BPOfCA7aYsUkCKJiJQJHd3mxt3vjQAHho8V8H7EySkMZ1faXckdR/s+TluYUuFofdhOlFo5pVZommmofc9s/6P06VmKP6IuiZCWbVYff5buR+NVrtQIUsGwJ8SLtKNdEo338HrxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732856; c=relaxed/simple;
	bh=G+uoL6mBMnnxqKc7tmPC/DmWA5qbYFGwxL9z4TpIRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBNUTiAjbo0Y9s/hGKVa5IopVgocFLJwS2FmPpjuJcROHVZ39w8cQyRpFPCs/sfacprL3g2KG/TJznHhLVlP7PR4FuO24T3YpqCyJvZZIZlqtcNnvAy8Trnpoz61xmNMESQAyPaAFvmtNOrH5+5N1E8AkUF8hduixz6+Cg6V5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKChmAEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811BFC4AF48;
	Tue, 18 Jun 2024 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718732855;
	bh=G+uoL6mBMnnxqKc7tmPC/DmWA5qbYFGwxL9z4TpIRUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKChmAEiuyOV50r44YzFyLj+BTIDFCeePXXplCpjFUQFn+35D8ADDQK8nAyxLu4Wu
	 Tt89UPq7T/Zeh9LwzofF53KmsNRAW7MxsfWdIVDspUX2XrSC7xOq2B2Z5aIiPeAShg
	 gFtGEslZrgOb6OPy/GK8nfR2k750a8qovdjzpMr4zUp7ti6+H6jpnz8rrZrQcSuXeO
	 1VnsNPSPyDxyuLZOXOtnDnP559jLrDeNFIZLb0YuRR1Z5b9/Bqh2FRZe55m7+fFbN2
	 j4jw5W4O/7LtqBlC7g59Vnw4s+nEFfQjsH5qC7CNPUVk6tQXVbbFjyeniLmM1Dfyw9
	 zvPaC4l9b5H4w==
Date: Tue, 18 Jun 2024 18:47:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <20240618-subpar-absentee-c3a43a1a9f5e@spud>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IVXoJjWBysv/457P"
Content-Disposition: inline
In-Reply-To: <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>


--IVXoJjWBysv/457P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 09:49:02AM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> This patch is based on the following one not applied yet on clk tree:
> dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
> https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428d4=
c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/
> ---
>  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b/D=
ocumentation/devicetree/bindings/net/airoha,en7581.yaml
> new file mode 100644
> index 000000000000..09e7b5eed3ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml

> +properties:
> +  compatible:
> +    enum:
> +      - airoha,en7581-eth

Actually, one other thing - filename matching compatible please.


--IVXoJjWBysv/457P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHIMQAKCRB4tDGHoIJi
0n2HAQDeMQN4/+RLDEpD+PHgpRtQS2SO15QUUpcKLP10MltACQEAw5k3GqAbdps6
JsoZfBwB4+yMUAvEfc1qZdDfb5KpdwM=
=CIoQ
-----END PGP SIGNATURE-----

--IVXoJjWBysv/457P--

