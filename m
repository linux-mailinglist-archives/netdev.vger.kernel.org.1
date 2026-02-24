Return-Path: <netdev+bounces-260509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JKrLSCdnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:44:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC0187226
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DB1C310A605
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2839A7FD;
	Tue, 24 Feb 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="MV5O3D43"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760A39A7EA;
	Tue, 24 Feb 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936853; cv=pass; b=Ros5iwWQTekectT0q2NHNaGxWyZbmm4olwEhH7Mc3dlTTdnwpd3D35y9uhN5T2GwcBBnAq/mFfOWf+v1LC0j4iKzVAkg8/WCGoHi/CTJYC2s/Zgj157u/1buJBe0fogFa87mmJ8d3gNnXFEchnPW+ccD6zTbkoYpRbVqvvwkjVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936853; c=relaxed/simple;
	bh=DBE/hOYm2uxq8ao7TJcQpf3nluCraOjknYn0QORUTTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkAlRx0vrjmW/kD8JmOxwTFNJDkmvrgai61DDo6cbb4RDfyUpf7A0fuS10GQkKzuD/SMgRmw8BH8PrxZUoupEJgd23n2TmLV0nZoJufoBrS/f/zRJuottDhiaxhbwJfdk6687EMYms4VMKIGuMqhS+kcv6VB9M5DEBeJU5Af6Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=MV5O3D43; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1771936826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SqUdUsUQcnjO0yJANGrZuNzL9PCGuKWgRkHOd2/Z1f0X6hYFcX0dLEnGZcUyC6V5WJhUZvuts6fzKYwWnh4i5ahw7QrjjcUAu1EUjgeRD0oYGW4icYnXnrP0evXZzKSOtv4RKPR2eip6HIieZgIIZg1lUf3tmCFaMLPcboRKqQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771936826; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eOZEdnbp46Z76LsK49tdtTNIOhWoViPgM8WCccLIHUE=; 
	b=jnHZYsjvx4bgXFj2fwDjKLViSY7aFM9q4NORoOs0BAUUhH/SRf432yZgbOHMaP/PWKFYrOKUhOqShxi+hn8sMixSYSQ5r232ekx4Orp0a7vhLE8ba6JnaFAmyXM4VP48oRJY/JdmRYwaBbXUp3EWi/K9jqTUw5YT7cYLBEcRR4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771936826;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=eOZEdnbp46Z76LsK49tdtTNIOhWoViPgM8WCccLIHUE=;
	b=MV5O3D43ndbEy9mp7nq8rtLMNyNdMG8MnNEj8pZPqcPhftte69WLFJV/+8o398ir
	hnrOTRXSzormLfL1sqLDROsM6DuSbgYyrUldvmoXs9AKEKiYHyLHp7IgeqoP0ObRD+6
	16nALCxSkfRZeVakaq7j3J69dFlLJpiwcMVvkiJM=
Received: by mx.zohomail.com with SMTPS id 1771936824130242.17321167502485;
	Tue, 24 Feb 2026 04:40:24 -0800 (PST)
Message-ID: <ba9d9132bab9d897b89bd686192693ef22bd2923.camel@collabora.com>
Subject: Re: [PATCH v5 06/18] clk: mediatek: Add MT8189 vlpcfg clock support
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>, Michael Turquette	
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>, Bartosz Golaszewski	
 <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, Miles Chen	
 <miles.chen@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, Qiqi Wang	
 <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, 	jh.hsu@mediatek.com
Date: Tue, 24 Feb 2026 13:40:16 +0100
In-Reply-To: <20260202062840.342707-7-irving-ch.lin@mediatek.com>
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
	 <20260202062840.342707-7-irving-ch.lin@mediatek.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260509-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: 6EAC0187226
X-Rspamd-Action: no action

Hi Irving-CH,

On Mon, 2026-02-02 at 14:28 +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>=20
> Add support for the MT8189 vlpcfg clock controller,
> which provides clock gate control for vlp domain IPs.
>=20
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
> =C2=A0drivers/clk/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/clk/mediatek/clk-mt8189-vlpcfg.c | 111
> +++++++++++++++++++++++
> =C2=A02 files changed, 112 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
>=20
> diff --git a/drivers/clk/mediatek/Makefile
> b/drivers/clk/mediatek/Makefile
> index 3b25df9e7b50..d9279b237b7b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -124,7 +124,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) +=3D clk-
> mt8188-venc.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) +=3D clk-mt8188-vpp0.o clk-
> mt8188-vpp1.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) +=3D clk-mt8188-wpe.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8189) +=3D clk-mt8189-apmixedsys.o clk-
> mt8189-topckgen.o \
> -				=C2=A0=C2=A0 clk-mt8189-vlpckgen.o
> +				=C2=A0=C2=A0 clk-mt8189-vlpckgen.o clk-mt8189-
> vlpcfg.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192) +=3D clk-mt8192-apmixedsys.o clk-
> mt8192.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) +=3D clk-mt8192-aud.o
> =C2=A0obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) +=3D clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> new file mode 100644
> index 000000000000..2b9c3101f2b4
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +
> +static const struct mtk_gate_regs vlpcfg_ao_reg_cg_regs =3D {
> +	.set_ofs =3D 0x0,
> +	.clr_ofs =3D 0x0,
> +	.sta_ofs =3D 0x0,
> +};
> +
> +#define GATE_VLPCFG_AO_REG(_id, _name, _parent,
> _shift)		\
> +	GATE_MTK(_id, _name, _parent, &vlpcfg_ao_reg_cg_regs,
> _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +static const struct mtk_gate vlpcfg_ao_reg_clks[] =3D {
> +	GATE_VLPCFG_AO_REG(CLK_VLPCFG_AO_APEINT_RX,
> "vlpcfg_ao_apeint_rx", "clk26m", 8),
> +};
> +
> +static const struct mtk_clk_desc vlpcfg_ao_reg_mcd =3D {
> +	.clks =3D vlpcfg_ao_reg_clks,
> +	.num_clks =3D ARRAY_SIZE(vlpcfg_ao_reg_clks),
> +};
> +
> +static const struct mtk_gate_regs vlpcfg_reg_cg_regs =3D {
> +	.set_ofs =3D 0x4,
> +	.clr_ofs =3D 0x4,
> +	.sta_ofs =3D 0x4,
> +};
> +
> +#define GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift,
> _flags)		\
> +	GATE_MTK_FLAGS(_id, _name, _parent, &vlpcfg_reg_cg_regs,
> _shift,	\
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mtk_clk_gate_ops_no_setclr_inv, =
_flags)
> +
> +#define GATE_VLPCFG_REG(_id, _name, _parent, _shift)		\
> +	GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +static const struct mtk_gate vlpcfg_reg_clks[] =3D {
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SCP, "vlpcfg_scp",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_scp_sel", 28, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M,
> "vlpcfg_r_apxgpt_26m",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 24, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRCK_TEST,
> "vlpcfg_dpmsrck_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 23, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST,
> "vlpcfg_dpmsrrtc_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 22, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRULP_TEST,
> "vlpcfg_dpmsrulp_test",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "osc_d10", 21, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST,
> "vlpcfg_spmi_p",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_spmi_p_sel", 20,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST_32K,
> "vlpcfg_spmi_p_32k",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 18, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS,
> "vlpcfg_pmif_spmi_p_sys",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwrap_ulposc_sel", 13,
> CLK_IS_CRITICAL),
There is no such "vlp_pwrap_ulposc_sel" clock defined in your mt8189
clock driver patch series. The parent clock should probably be
"vlp_pwrap_osc_sel" (that is defined in clk-mt8189-vlpckgen.c) instead.

Same thing for vlpcfg_pmif_spmi_p_tmr, vlpcfg_pmif_spmi_m_sys and
vlpcfg_pmif_spmi_m_tmr below that have the same parent clock.

Best regards,
Louis-Alexis

> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR,
> "vlpcfg_pmif_spmi_p_tmr",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwrap_ulposc_sel", 12,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS,
> "vlpcfg_pmif_spmi_m_sys",
> +			"vlp_pwrap_ulposc_sel", 11),
> +	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR,
> "vlpcfg_pmif_spmi_m_tmr",
> +			"vlp_pwrap_ulposc_sel", 10),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DVFSRC,
> "vlpcfg_dvfsrc",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_dvfsrc_sel", 9, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PWM_VLP,
> "vlpcfg_pwm_vlp",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_pwm_vlp_sel", 8,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SRCK, "vlpcfg_srck",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_srck_sel", 7, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F26M,
> "vlpcfg_sspm_f26m",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_sspm_f26m_sel", 4,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F32K,
> "vlpcfg_sspm_f32k",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 3, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_ULPOSC,
> "vlpcfg_sspm_ulposc",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "vlp_sspm_ulposc_sel", 2,
> CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_32K_COM,
> "vlpcfg_vlp_32k_com",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk32k", 1, CLK_IS_CRITICAL),
> +	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_26M_COM,
> "vlpcfg_vlp_26m_com",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clk26m", 0, CLK_IS_CRITICAL),
> +};
> +
> +static const struct mtk_clk_desc vlpcfg_reg_mcd =3D {
> +	.clks =3D vlpcfg_reg_clks,
> +	.num_clks =3D ARRAY_SIZE(vlpcfg_reg_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8189_vlpcfg[] =3D {
> +	{ .compatible =3D "mediatek,mt8189-vlp-ao", .data =3D
> &vlpcfg_ao_reg_mcd },
> +	{ .compatible =3D "mediatek,mt8189-vlpcfg-ao", .data =3D
> &vlpcfg_reg_mcd },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt8189_vlpcfg_drv =3D {
> +	.probe =3D mtk_clk_simple_probe,
> +	.remove =3D mtk_clk_simple_remove,
> +	.driver =3D {
> +		.name =3D "clk-mt8189-vlpcfg",
> +		.of_match_table =3D of_match_clk_mt8189_vlpcfg,
> +	},
> +};
> +
> +module_platform_driver(clk_mt8189_vlpcfg_drv);
> +MODULE_DESCRIPTION("MediaTek MT8189 vlpcfg clocks driver");
> +MODULE_LICENSE("GPL");

