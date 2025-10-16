Return-Path: <netdev+bounces-230051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B546BE344A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1EBA3580AF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B232C306;
	Thu, 16 Oct 2025 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCGlCg3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A132BF4E;
	Thu, 16 Oct 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616713; cv=none; b=EdA4v/uRIlZBZUUmZXFRK9g+Qk0Hxo0hPh66iRDEq9du5my8Wd979UiMPnFkWukNvPCUldWGafhrJjB2WZUj7LHqqD2MEVGUbSF9NY+h4tLF9N4kKTx8hP90YX9GoBRvX57vk6vjNbmAyHXxr0LxmZtFRnr5KPw8cSX9B1CTtDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616713; c=relaxed/simple;
	bh=fXQW5LlY3uriTrQKws57EZgohSd4auvpbv1xc5ox9X8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SQHIiPesggPqOvg+rEUZaY6CtQT0miG6dbMoq+7/ly42guBX93SuQC4lS8XiQLVDVcW4PV158y/KOf1R0edxAP/E96sirijKa+1hBtCO1lrmb5+ZFK44APvdjnEs+bY88CJPP8n5IEfUtlgPuNV3qXn6PxWlhpuGo4rGS2igGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCGlCg3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B81FC116B1;
	Thu, 16 Oct 2025 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760616712;
	bh=fXQW5LlY3uriTrQKws57EZgohSd4auvpbv1xc5ox9X8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eCGlCg3KYMaFDE2I2HYQ7UC4kwzdvab0JbYJVvZAIfFSwgJmC0SB5HqFzEGD9ZZqp
	 jb/4lrvvl2gEnH2Vghh5t2+K3E+ZRQGeKQucfabea2klGQZcznjEk6dzgAGmFPUTxJ
	 VTI+W/ZI/mayVy6PKH65vrqZaaPD+aruuabmgxuQmi76C7T5OUyL0OcJZ9tngqCPhl
	 3pYB3ttdZvDvWPoqfhueWGjBZXkYMCD4CHHM9+ZBFTI4MYxmHPp5JuZkhGv+GU/ojH
	 VWGulZT4+pnvDgwrO8dYGkY0qwv+Yjb6Zpck1/Au5A+AowNEUEXA+VoCVqL60veqzz
	 9gToVZtXMD6WQ==
Date: Thu, 16 Oct 2025 07:11:51 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, davem@davemloft.net, richardcochran@gmail.com, 
 Frank.Li@nxp.com, vladimir.oltean@nxp.com, andrew+netdev@lunn.ch, 
 kuba@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, claudiu.manoil@nxp.com, pabeni@redhat.com, 
 edumazet@google.com, xiaoning.wang@nxp.com, netdev@vger.kernel.org, 
 conor+dt@kernel.org
To: Wei Fang <wei.fang@nxp.com>
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Message-Id: <176061621269.2563112.3282967985432898709.robh@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: enetc: Add i.MX94 ENETC support


On Thu, 16 Oct 2025 18:20:11 +0800, Wei Fang wrote:
> i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> can be used as a standalone network port. The other one is an internal
> ENETC, it connects to the CPU port of NETC switch through the pseudo
> MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> the IERB ETBCR registers. Currently, this patch only add ENETC support
> and Timer support for i.MX94. The switch will be added by a separate
> patch set.
> 
> ---
> Note that the DTS patch (patch 8/8) is just for referenece, it will be
> removed from this patch set when the dt-bindings patches have been
> reviewed. It will be sent for review by another thread in the future.
> ---
> 
> Clark Wang (1):
>   net: enetc: add ptp timer binding support for i.MX94
> 
> Wei Fang (7):
>   dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94
>     platforms
>   dt-bindings: net: enetc: add compatible string for ENETC with pseduo
>     MAC
>   dt-bindings: net: ethernet-controller: remove the enum values of speed
>   net: enetc: add preliminary i.MX94 NETC blocks control support
>   net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
>   net: enetc: add standalone ENETC support for i.MX94
>   arm64: dts: imx94: add basic NETC nodes and properties
> 
>  .../bindings/net/ethernet-controller.yaml     |   1 -
>  .../devicetree/bindings/net/fsl,enetc.yaml    |   1 +
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       |   1 +
>  arch/arm64/boot/dts/freescale/imx94.dtsi      | 118 ++++++++++
>  arch/arm64/boot/dts/freescale/imx943-evk.dts  | 100 +++++++++
>  drivers/net/ethernet/freescale/enetc/enetc.c  |  28 ++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |   8 +
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  32 ++-
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  37 ++--
>  .../ethernet/freescale/enetc/enetc_ethtool.c  |  64 ++++++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
>  .../freescale/enetc/enetc_pf_common.c         |   5 +-
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 202 ++++++++++++++++++
>  13 files changed, 574 insertions(+), 24 deletions(-)
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20251015 (exact match)
 Base: tags/next-20251015 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20251016102020.3218579-1-wei.fang@nxp.com:

arch/arm64/boot/dts/freescale/imx943-evk.dtb: system-controller@4ceb0000 (nxp,imx94-netc-blk-ctrl): 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






