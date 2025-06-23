Return-Path: <netdev+bounces-200252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C04EAE3E0C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DE97A525B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131023F295;
	Mon, 23 Jun 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jOvyQqig"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B721ABCB;
	Mon, 23 Jun 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678501; cv=none; b=KFdjH1PL5UVm01/k+QVNEpC3dGDLJ2dyY7fkqynNxyCS1PT6oHc638K75eHQJOuKGsP17u+HmpqxhFA6IW0ioKmuSRmCEiMgkFaBrvWmt2zIoZjdnXhYQB+bzPadqwLczIhBsnIsID9r1eAjWBJWHeJz8NqBAOnupMwkjPoTcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678501; c=relaxed/simple;
	bh=T5SUbISDYE0U3ndj/fUfEJmuuEiLHNdsAPnultnjOuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5HwHDqTkz0icEpFgDrqMUcgMasXjmpHjMvKXgZL4TQCfN/boTU+F7mDqm+z17mluKUGfbW1aEAuUnigfUtnsO+TnsoRLcCJrX7xnCh/5UPqaWf3EhsNu5nHfNVCgloUBBwQe/qOZfasLoRTAEdarTtfLk2A++0Cu6jN4WPU8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jOvyQqig; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750678497;
	bh=T5SUbISDYE0U3ndj/fUfEJmuuEiLHNdsAPnultnjOuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jOvyQqig1PXeIOkhqzTJgc7CWTlzPM9KLhSl2nLshTqwFckdzO+82Np+/okVsuEaX
	 5kkdlePa/8gq1xcYhx+xs0XRxM9TBlpYMfTmHGgC4QVU5il9u35gKo8H3+XHY2dGQH
	 nRfSi33UNd/LdXQfyNrhinj0JYL6FlfqbrjH0qM37dOvlEjx7/HlbSXPLZQvadz3r8
	 Pf2ZRjUCWnjjEZSLL+ML+7Qlo+OpizSOXDkNpCA2b16A3gqSogfQNiRdxmD7oHjcRh
	 p8TwbTE1zl8jbXlb3WdhPMul2g/UpyNCqEK3rTC8bjXtzE0Xx/yTaPBJ4kjl9x1zf3
	 kmW+TX9FPCPTQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2598217E0184;
	Mon, 23 Jun 2025 13:34:56 +0200 (CEST)
Message-ID: <88a04bcc-b287-432c-b309-5c76259ceda3@collabora.com>
Date: Mon, 23 Jun 2025 13:34:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] Add support for MT8196 clock controllers
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250623102940.214269-1-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250623102940.214269-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/06/25 12:29, Laura Nao ha scritto:
> This patch series introduces support for the clock controllers on the
> MediaTek MT8196 platform, following up on an earlier submission[1].
> 
> MT8196 uses a hardware voting mechanism to control some of the clock muxes
> and gates, along with a fence register responsible for tracking PLL and mux
> gate readiness. The series introduces support for these voting and fence
> mechanisms, and includes drivers for all clock controllers on the platform.
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

(as I reviewed this entire thing internally and before submission anyway :-D)

Cheers,
Angelo


> [1] https://lore.kernel.org/all/20250307032942.10447-1-guangjie.song@mediatek.com/
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: reset: Add MediaTek MT8196 Reset Controller binding
>    clk: mediatek: mt8196: Add UFS and PEXTP0/1 reset controllers
> 
> Laura Nao (28):
>    clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
>    clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
>    clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and
>      FENC
>    clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
>    clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
>    clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use
>      mtk_gate struct
>    clk: mediatek: clk-gate: Add ops for gates with HW voter
>    clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
>    dt-bindings: clock: mediatek: Describe MT8196 peripheral clock
>      controllers
>    clk: mediatek: Add MT8196 apmixedsys clock support
>    clk: mediatek: Add MT8196 topckgen clock support
>    clk: mediatek: Add MT8196 topckgen2 clock support
>    clk: mediatek: Add MT8196 vlpckgen clock support
>    clk: mediatek: Add MT8196 peripheral clock support
>    clk: mediatek: Add MT8196 ufssys clock support
>    clk: mediatek: Add MT8196 pextpsys clock support
>    clk: mediatek: Add MT8196 adsp clock support
>    clk: mediatek: Add MT8196 I2C clock support
>    clk: mediatek: Add MT8196 mcu clock support
>    clk: mediatek: Add MT8196 mdpsys clock support
>    clk: mediatek: Add MT8196 mfg clock support
>    clk: mediatek: Add MT8196 disp0 clock support
>    clk: mediatek: Add MT8196 disp1 clock support
>    clk: mediatek: Add MT8196 disp-ao clock support
>    clk: mediatek: Add MT8196 ovl0 clock support
>    clk: mediatek: Add MT8196 ovl1 clock support
>    clk: mediatek: Add MT8196 vdecsys clock support
>    clk: mediatek: Add MT8196 vencsys clock support
> 
>   .../bindings/clock/mediatek,mt8196-clock.yaml |   79 ++
>   .../clock/mediatek,mt8196-sys-clock.yaml      |   76 +
>   drivers/clk/mediatek/Kconfig                  |   78 +
>   drivers/clk/mediatek/Makefile                 |   14 +
>   drivers/clk/mediatek/clk-gate.c               |  106 +-
>   drivers/clk/mediatek/clk-gate.h               |    3 +
>   drivers/clk/mediatek/clk-mt8196-adsp.c        |  193 +++
>   drivers/clk/mediatek/clk-mt8196-apmixedsys.c  |  203 +++
>   drivers/clk/mediatek/clk-mt8196-disp0.c       |  169 +++
>   drivers/clk/mediatek/clk-mt8196-disp1.c       |  170 +++
>   .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    |  117 ++
>   drivers/clk/mediatek/clk-mt8196-mcu.c         |  166 +++
>   drivers/clk/mediatek/clk-mt8196-mdpsys.c      |  187 +++
>   drivers/clk/mediatek/clk-mt8196-mfg.c         |  150 ++
>   drivers/clk/mediatek/clk-mt8196-ovl0.c        |  154 ++
>   drivers/clk/mediatek/clk-mt8196-ovl1.c        |  153 ++
>   drivers/clk/mediatek/clk-mt8196-peri_ao.c     |  144 ++
>   drivers/clk/mediatek/clk-mt8196-pextp.c       |  131 ++
>   drivers/clk/mediatek/clk-mt8196-topckgen.c    | 1257 +++++++++++++++++
>   drivers/clk/mediatek/clk-mt8196-topckgen2.c   |  662 +++++++++
>   drivers/clk/mediatek/clk-mt8196-ufs_ao.c      |  109 ++
>   drivers/clk/mediatek/clk-mt8196-vdec.c        |  253 ++++
>   drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |   78 +
>   drivers/clk/mediatek/clk-mt8196-venc.c        |  235 +++
>   drivers/clk/mediatek/clk-mt8196-vlpckgen.c    |  769 ++++++++++
>   drivers/clk/mediatek/clk-mtk.c                |   16 +
>   drivers/clk/mediatek/clk-mtk.h                |   23 +
>   drivers/clk/mediatek/clk-mux.c                |  119 +-
>   drivers/clk/mediatek/clk-mux.h                |   76 +
>   drivers/clk/mediatek/clk-pll.c                |   46 +-
>   drivers/clk/mediatek/clk-pll.h                |    9 +
>   .../dt-bindings/clock/mediatek,mt8196-clock.h |  867 ++++++++++++
>   .../reset/mediatek,mt8196-resets.h            |   26 +
>   33 files changed, 6814 insertions(+), 24 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-disp0.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl0.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-venc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>   create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h
> 


