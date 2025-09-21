Return-Path: <netdev+bounces-225072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406BB8E05B
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 041424E1359
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5EE2777EA;
	Sun, 21 Sep 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3VPWGCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D265292;
	Sun, 21 Sep 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473629; cv=none; b=sVjDftLjDRrCHcQFQV/yOFd/laJKRYUociJ17e/fPqu8/TTQCR+CjIBM1FEReFC0qR+RDSwycsfiook5G9IOQIBBPjYGYeQOay3VFVFC9rPAcZxxtwBq+z6+aBQhTcV6daaJK/HRXvoGROqmkYaRBmHo4lPCFAch8A9MLGQAZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473629; c=relaxed/simple;
	bh=gVO5xNIVYqZvF4xlVxFswaKEPI9bsSAehw30odPu6KU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=O2w7mNCKALlhJSaNh3UBBVaciM3EOEYL7jjGoyyASVV2Vh6FtPSig7bpj+UygXuQX5dYiSLCLW/pa8xfjFiTz6AjuV503KHY7Mhg+8l8asCG/fYu2E/Et/8foRpa0S2dLHYfqP08h9Z51KZar6xJcPuREpIAb9bS3v4iuadEyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3VPWGCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B882C116B1;
	Sun, 21 Sep 2025 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473629;
	bh=gVO5xNIVYqZvF4xlVxFswaKEPI9bsSAehw30odPu6KU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=i3VPWGCnokTLF7UHMmnVfu0S0pp9LJ0vefynAk4f6dzG88dnSzlnA6Vz3nlhO8E9s
	 dZpvFHbrUyx/m2YlHUZGAkvLR5/N0xM3OwmGUhIZuvFNxl69kFoRNm/2+DhRxdnRrm
	 Y4ivXeq9Jdn1u/Dw4XyML3CUrUGY7KO2/Q3bePNEPlplch1M0w/nw2faZp7rwcIpWi
	 Ccr8wjs0Te/UykGsAD0M4O2qxovAfggprGSLC4Na48DyW2bPxn3sTQzxtcqQAPdygo
	 f/DY/YIrYPBs/lNfgZETgbvlKK1+zauHGbdLS5RmVWcV4ug1SzsvoBgCbYSS/mpghm
	 /ZznKWkCIY0KQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-10-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-10-laura.nao@collabora.com>
Subject: Re: [PATCH v6 09/27] dt-bindings: clock: mediatek: Describe MT8196 clock controllers
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:47 -0700
Message-ID: <175847362784.4354.9605164942435120239@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:29)
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
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

