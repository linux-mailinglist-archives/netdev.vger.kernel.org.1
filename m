Return-Path: <netdev+bounces-45302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9337DC022
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17BEB20AF8
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16C199CC;
	Mon, 30 Oct 2023 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKfWupyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BA199B2;
	Mon, 30 Oct 2023 18:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2910C433C7;
	Mon, 30 Oct 2023 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698692228;
	bh=9k52DOYv+u+3IPK7EG4bgquyoKZQQUrVAKtdXlb4WnM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bKfWupyHNM0c0QoHxSHWTIHGryzlBNN1nLRn4EySckDpioPM22Po1PkQfPwZqhv/H
	 K44hqIEEhFYSBsNw10RaA5fE0Kay4Xt9p1Bhtp552C6CPk62Th9dzQZqhAqADO6f9G
	 4AhnCEi2u4EEbUCLsqegrxWK4DV0FHra/UG03VA6h9IsmOqBEpLRibT6Sj4a29qqlH
	 jneXNE/sVmxjkH62aIoP5v8lV31VAmGkItEwkFk2X0rr1t28ff2wWc+SKeTI8BtNEk
	 vOXUVrn1LWZMYCpfseNwGmfINSptJKqPcWXzfmyyw0m1NRPz1OkyXaq5dINeavn/eg
	 ZcmQUAJlVVWDg==
Message-ID: <ac223f97efea0d5077a4e3e4dbd805b4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231030-ipq5332-nsscc-v1-4-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com> <20231030-ipq5332-nsscc-v1-4-6162a2c65f0a@quicinc.com>
Subject: Re: [PATCH 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Date: Mon, 30 Oct 2023 11:57:06 -0700
User-Agent: alot/0.10

Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:19)
> Add support for gpll0_out_aux clock which acts as the parent for
> certain networking subsystem (NSS) clocks.
>=20
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq533=
2.c
> index 235849876a9a..966bb7ca8854 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -87,6 +87,19 @@ static struct clk_alpha_pll_postdiv gpll0 =3D {
>         },
>  };
> =20
> +static struct clk_alpha_pll_postdiv gpll0_out_aux =3D {
> +       .offset =3D 0x20000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +       .width =3D 4,
> +       .clkr.hw.init =3D &(struct clk_init_data) {

const initdata

> +               .name =3D "gpll0_out_aux",
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                               &gpll0_main.clkr.hw },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_ro_ops,
> +       },
> +};
> +
>  static struct clk_alpha_pll gpll2_main =3D {
>         .offset =3D 0x21000,
>         .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],

