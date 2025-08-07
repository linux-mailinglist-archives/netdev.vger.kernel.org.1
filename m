Return-Path: <netdev+bounces-212012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B523B1D2C2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73DC162DF3
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CF223DF5;
	Thu,  7 Aug 2025 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP3KnmTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67C4A06;
	Thu,  7 Aug 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549894; cv=none; b=PSVErpeSzVqNSCvIJ+PUMY+CrEzYQrYfrKVEoBGSdZYYE2pFTW2OPSuOwrDmsaWHm0eGX1h60h2o0/6ujUMI1K/ddSdPniEMgIgC/V4Sw+nszIE360/LWxG64FZkhZxtX9CAdvieXmdN3fv7gPyfYjPoVVJ4I9CtXcAa2v1a5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549894; c=relaxed/simple;
	bh=4Lbxqf6/CNfYbxwExDCoo3uJIOj0YFPbDWdDOOzBd+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfi2vGCA37Yvv7mCBYq2TgzWXTodWwnYJLpsv36Mc2ldcipfutH90peOUcnyr2s8X/7oPvhQPLbeAgx7Q0n+rRuiXRexuJUZdoQUfEjijorPp65M0ZSeqiCaHrMwtP+vsCm+Pmb1YSON3jGPi7O1XKtrREY7fk0EHL69+AnpIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP3KnmTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B2C4CEED;
	Thu,  7 Aug 2025 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754549893;
	bh=4Lbxqf6/CNfYbxwExDCoo3uJIOj0YFPbDWdDOOzBd+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP3KnmTsJ4qGJUkalbyFcJijelz6GMzVGQpnWnmLXSurp7VH0OhgS8lu531eKvWYq
	 VslWvZqel4mtXyc864qUuHh63fHF6GYmgl8qQDjOB5GTsrsP8BndJ6JRc2yLli3Tih
	 k6lJZHVZVW6zcZ4gi3s86ADgfInhNM27RINr2UcX5wByJbgyaNB4wYbie3EEISfN8P
	 uRE//alEFxenHMiFBR2g/YQs95fDhEsJ8vPT1SjXtrXHOUS8IYA3O1tLXYhInEmF1/
	 7iomM0GXm+ou4Lp/6u4PZZUYkJThMmPsIn6qaY/PC6+CmdSTLqyNq12WKlrRncrLJB
	 6RNKYRG3Rhw9g==
Date: Thu, 7 Aug 2025 08:58:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, richardcochran@gmail.com, 
	guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, 
	=?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v4 09/27] dt-bindings: clock: mediatek: Describe MT8196
 clock controllers
Message-ID: <20250807-smoky-mature-eagle-a0feae@kuoka>
References: <20250805135447.149231-1-laura.nao@collabora.com>
 <20250805135447.149231-10-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250805135447.149231-10-laura.nao@collabora.com>

On Tue, Aug 05, 2025 at 03:54:29PM +0200, Laura Nao wrote:
> Introduce binding documentation for system clocks, functional clocks,
> and PEXTP0/1 and UFS reset controllers on MediaTek MT8196.
>=20
> This binding also includes a handle to the hardware voter, a
> fixed-function MCU designed to aggregate votes from the application
> processor and other remote processors to manage clocks and power
> domains.
>=20
> The HWV on MT8196/MT6991 is incomplete and requires software to manually
> enable power supplies, parent clocks, and FENC, as well as write to both
> the HWV MMIO and the controller registers.
> Because of these constraints, the HWV cannot be modeled using generic
> clock, power domain, or interconnect APIs. Instead, a custom phandle is
> exceptionally used to provide direct, syscon-like register access to
> drivers.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


