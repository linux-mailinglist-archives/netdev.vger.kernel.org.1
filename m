Return-Path: <netdev+bounces-188475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60BAACF02
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE7B1C206A1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6972638;
	Tue,  6 May 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSiCuEEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DD4B1E40;
	Tue,  6 May 2025 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564776; cv=none; b=f1EQLPMELfmip/CNVpIFzZ5it3yUdkTcuJ7+T9LGfeJvfDQ1ZI2v1x+zBKVlCOORmV8ZjUXWMfXlL+KXSP5icxck1+y/Atv9vtxlbGhEoH6Nyv/kam72WQBY4RS6ZJkjraySlNyi5JAVoJrBggNa7ZOkYN8AK6YZzGDe2KNCbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564776; c=relaxed/simple;
	bh=jDpjut5yZbPYQqWysbrjFer9JWIn4EfR+KwSTgBSyEw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ME+s9/2un1xQ/AfJwFrgPv0IznFAbBI5xo9qxb6Gkru1VmhLCGD0gOwzIXfC/DfRRaHcuZJ8/3Z9fdPgZCsdzRvNmNKVpDb5HNwX22RjELxbBg7NBzchi+BSlkA9Xl7xJUQTe7Ei+qvfpEi4VPSMUvgObZS7hbnINvxanZ394io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSiCuEEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB57DC4CEE4;
	Tue,  6 May 2025 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746564776;
	bh=jDpjut5yZbPYQqWysbrjFer9JWIn4EfR+KwSTgBSyEw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BSiCuEEcgXyVBYtUpe40CwBT19C9Gu8LXL8jdNrWsZgpP2RVPq6un7a8digHrbATh
	 vaWjJ8FAyaAAdUG4yCNHb2FOgTC2YnRK9G9tzpdqzkq7x9suLsoP2m1I7D/GxqY7BU
	 /wu9rbNOr93+c59X3zAmc2bkcRfJb+kHDdo4gcevhaNwJjZiZLPveeN8js4YN9teX7
	 ns84ynVkOmpECByky/6SdMGH3O3Ugxxd67x7HvMJLrVYULQQpmFqQpsmYlEjMgoUfd
	 9Wxi3wQ9AMfF/ANvhEVgxHR3OyypyUc0B6W11/AppbNWgsfw3M1Jg38kCAYISVXN6d
	 jAcjJp1BfAc/Q==
Message-ID: <1f9856930efce8b52f3abbc17fb4d3ca@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250417145238.31657-1-matthew.gerlach@altera.com>
References: <20250417145238.31657-1-matthew.gerlach@altera.com>
Subject: Re: [PATCH v4 RESEND] clk: socfpga: agilex: add support for the Intel Agilex5
From: Stephen Boyd <sboyd@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, Teh Wen Ping <wen.ping.teh@intel.com>, Matthew Gerlach <matthew.gerlach@altera.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>, dinguyen@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, netdev@vger.kernel.org, richardcochran@gmail.com
Date: Tue, 06 May 2025 13:52:53 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Matthew Gerlach (2025-04-17 07:52:38)
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform, so
> it is reusing most of the Agilex clock driver code.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> Changes in v4:
> - Add .index to clk_parent_data.

It's useful to link to the previous round with lore links. Please do it
next time.

>=20
> Changes in v3:
> - Used different name for stratix10_clock_data pointer.
> - Used a single function call, devm_platform_ioremap_resource().
> - Used only .name in clk_parent_data.
>=20
> Stephen suggested to use .fw_name or .index, But since the changes are on=
 top
> of existing driver and current driver code is not using clk_hw and removi=
ng
> .name and using .fw_name and/or .index resulting in parent clock_rate &
> recalc_rate to 0.
>=20
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> index 8dd94f64756b..a5ed2a22426e 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gat=
e_clks[] =3D {
>           10, 0, 0, 0, 0, 0, 4},
>  };
> =20
> +static const struct clk_parent_data agilex5_pll_mux[] =3D {
> +       { .name =3D "osc1", .index =3D AGILEX5_OSC1, },
> +       { .name =3D "cb-intosc-hs-div2-clk", .index =3D AGILEX5_CB_INTOSC=
_HS_DIV2_CLK, },
> +       { .name =3D "f2s-free-clk", .index =3D AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_boot_mux[] =3D {
> +       { .name =3D "osc1", .index =3D AGILEX5_OSC1, },
> +       { .name =3D "cb-intosc-hs-div2-clk", .index =3D AGILEX5_CB_INTOSC=
_HS_DIV2_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core0_free_mux[] =3D {
> +       { .name =3D "main_pll_c1", .index =3D AGILEX5_MAIN_PLL_C1_CLK, },
> +       { .name =3D "peri_pll_c0", .index =3D AGILEX5_MAIN_PLL_C0_CLK, },

The index doesn't work this way. The number indicates which index in the
DT node's 'clocks' property to use as the parent. It doesn't indicate
which index in this clk provider to use. I don't see any 'clocks'
property in the binding for this compatible "intel,agilex5-clkmgr", so
this doesn't make any sense either.

If you can't use clk_hw pointers then just stick to the old way of doing
it with string names and no struct clk_parent_data usage.

> +       { .name =3D "osc1", .index =3D AGILEX5_OSC1, },
> +       { .name =3D "cb-intosc-hs-div2-clk", .index =3D AGILEX5_CB_INTOSC=
_HS_DIV2_CLK, },
> +       { .name =3D "f2s-free-clk", .index =3D AGILEX5_F2S_FREE_CLK, },
> +};
> +

