Return-Path: <netdev+bounces-200747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE2AE6BD8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06AE188B53E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E8274B2D;
	Tue, 24 Jun 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="Mf+1u2nZ"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA522D9ED;
	Tue, 24 Jun 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780179; cv=pass; b=pG+IC5mvWGewOKtkxmTT2lcds1gmEkCiKyaMZwNPgpUp3arwXyfXcF4jjkSLtAO7xGCwcXaBliEmRd8wGJuZ08OnHOTtZzz1MdBJkG60gYFz5bfLrjjeHWyh+OhjqmDjC2nUmgUYz3ZyFkmJpvz5fBSJ95ujQgx0ygLv7IMyNMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780179; c=relaxed/simple;
	bh=3+XTKpEiNYrYrQNEx7zBBd9tGAKVmroU4kJyUaRvTlY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0wHNjNZ9s5rxg8SZZMVrCoHWHSWAdKEOv2lXFmuX/tkl1KdbBGCa0gilSDWCuCVzkWGQ2QamjcxRANSQGUdwIdfzCW/GbtTapWQCZCJTOulXrwu/FAE+fR2B3kceru7M11JaGRDbEqvMmkwoxtuIySbb0eIh9X0w3+Oo8/UF6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=Mf+1u2nZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750780152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nhM6xzFKQLignkPZ/NGXslADyUBs01OBDRtEGhcYbEZLQGf8X++La8SK8bC4+Ep+pG4NDeBk7ldt/PmAcUwHLQAhHIBkrJl+G2icqEjZGA88um/8uXeLESnCeveaO2Sqlx2ssV+EZHeA04IQK4nTIlbJQ+7JJzoWL2lDvcLidTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750780152; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3+XTKpEiNYrYrQNEx7zBBd9tGAKVmroU4kJyUaRvTlY=; 
	b=fslOD0wYoTicBABQ5dKJGop85WUGIP8Gf7QKyA66Q36NNT+f9XEPfE6a9cQpNesBZuqe2kgLSDPkO+dfvDn5u9qbPyRpHBivsWb0QxEAVyKVGmpCEzrib0a75B05/cYjHkJhNxrq1JkFsVCMmbClNIhuL/wQtsLnpwLAcWK3ocE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750780152;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=3+XTKpEiNYrYrQNEx7zBBd9tGAKVmroU4kJyUaRvTlY=;
	b=Mf+1u2nZer5UaeOmVDDAG1ecTp+wTtSEGZa9C3cYt9i/q4ByEvX5DGQq90zHOwAn
	2/GOLXkRK5exFiNuHju7XzqZIHCmL20orHuNSEIRGWVBLR9FlyMSJlOokbhtLDnXggx
	bYiEGIiz6n8lHpUWi/XVRSNEguEbKc1oG0rnjXyc=
Received: by mx.zohomail.com with SMTPS id 1750780149757734.6410007359632;
	Tue, 24 Jun 2025 08:49:09 -0700 (PDT)
Message-ID: <c05ff44f1df5276a0a548cbfc7589d45520a54bb.camel@collabora.com>
Subject: Re: [PATCH v2 00/29] Add support for MT8196 clock controllers
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,  netdev@vger.kernel.org,
 kernel@collabora.com
Date: Tue, 24 Jun 2025 11:49:07 -0400
In-Reply-To: <20250624143220.244549-1-laura.nao@collabora.com>
References: <20250624143220.244549-1-laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2025-06-24 at 16:31 +0200, Laura Nao wrote:
> Add support for MT8196 clock controllers
>=20
> This patch series introduces support for the clock controllers on the
> MediaTek MT8196 platform, following up on an earlier submission[1].
>=20
> MT8196 uses a hardware voting mechanism to control some of the clock
> muxes
> and gates, along with a fence register responsible for tracking PLL
> and mux
> gate readiness. The series introduces support for these voting and
> fence
> mechanisms, and includes drivers for all clock controllers on the
> platform.
>=20
> [1]
> https://lore.kernel.org/all/20250307032942.10447-1-guangjie.song@mediatek=
.com/
>=20
> Changes in v2:
> - Fixed incorrect ID numbering in mediatek,mt8196-clock.h
> - Improved description for 'mediatek,hardware-voter' in
> mediatek,mt8196-clock.yaml and mediatek,mt8196-sys-clock.yaml
> - Added description for '#reset-cells' in mediatek,mt8196-clock.yaml
> - Added missing mediatek,mt8196-vdisp-ao compatible in
> mediatek,mt8196-clock.yaml
> - Fixed license in mediatek,mt8196-resets.h
> - Fixed missing of_match_table in clk-mt8196-vdisp_ao.c
> - Squashed commit adding UFS and PEXTP reset controller support
> - Reordered commits to place reset controller binding before
> dependent drivers
> - Added R-b tags
>=20
> Link to v1:
> https://lore.kernel.org/all/20250623102940.214269-1-laura.nao@collabora.c=
om/
>=20
> AngeloGioacchino Del Regno (1):
> =C2=A0 dt-bindings: reset: Add MediaTek MT8196 Reset Controller binding
>=20
> Laura Nao (28):
> =C2=A0 clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable
> control
> =C2=A0 clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and
> FENC
> =C2=A0 clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and
> =C2=A0=C2=A0=C2=A0 FENC
> =C2=A0 clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
> =C2=A0 clk: mediatek: clk-mux: Add ops for mux gates with HW voter and
> FENC
> =C2=A0 clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use
> =C2=A0=C2=A0=C2=A0 mtk_gate struct
> =C2=A0 clk: mediatek: clk-gate: Add ops for gates with HW voter
> =C2=A0 clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
> =C2=A0 dt-bindings: clock: mediatek: Describe MT8196 peripheral clock
> =C2=A0=C2=A0=C2=A0 controllers
> =C2=A0 clk: mediatek: Add MT8196 apmixedsys clock support
> =C2=A0 clk: mediatek: Add MT8196 topckgen clock support
> =C2=A0 clk: mediatek: Add MT8196 topckgen2 clock support
> =C2=A0 clk: mediatek: Add MT8196 vlpckgen clock support
> =C2=A0 clk: mediatek: Add MT8196 peripheral clock support
> =C2=A0 clk: mediatek: Add MT8196 ufssys clock support
> =C2=A0 clk: mediatek: Add MT8196 pextpsys clock support
> =C2=A0 clk: mediatek: Add MT8196 adsp clock support
> =C2=A0 clk: mediatek: Add MT8196 I2C clock support
> =C2=A0 clk: mediatek: Add MT8196 mcu clock support
> =C2=A0 clk: mediatek: Add MT8196 mdpsys clock support
> =C2=A0 clk: mediatek: Add MT8196 mfg clock support
> =C2=A0 clk: mediatek: Add MT8196 disp0 clock support
> =C2=A0 clk: mediatek: Add MT8196 disp1 clock support
> =C2=A0 clk: mediatek: Add MT8196 disp-ao clock support
> =C2=A0 clk: mediatek: Add MT8196 ovl0 clock support
> =C2=A0 clk: mediatek: Add MT8196 ovl1 clock support
> =C2=A0 clk: mediatek: Add MT8196 vdecsys clock support
> =C2=A0 clk: mediatek: Add MT8196 vencsys clock support

For the whole series:

Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

(as I internally reviewed it before submission)

--=20
Thanks,

N=C3=ADcolas

