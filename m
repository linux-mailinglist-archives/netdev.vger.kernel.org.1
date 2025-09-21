Return-Path: <netdev+bounces-225064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF1B8DFFE
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376EA1745CE
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B65257452;
	Sun, 21 Sep 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnvdXyr2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FF34BA47;
	Sun, 21 Sep 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473586; cv=none; b=XAZU1Awuw2QlBZ1yraD8ia/nkvwG3JvbP/clf+shr0Asg+Cce0BFPAkkgJ4ZTThNW9xDW2A8ty6u8r6OZefWGENrVF+4tdlRC3Ryz46Oz031DRgqtHmv7zIOmsJDCSmE9X+3JDcUvbpX/dVL28kkYA1Rf6LH8lFZ5xpzRU4JXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473586; c=relaxed/simple;
	bh=pOC1FJ1dZ8Ed5BFxEGVeWgL22mKSWnuTkoOTFE8Asdk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=YIfdl4KIXQAJcRuCztlSULDhHBw2XPWW3pHyfpIcscNip09DjUSpkT7JonxoTfvMTOUQ2tVTE7DDwSqbpOEaQI48qe5I6rL00AlKdRGtB9DHtSwvrprPURDR2WB3+3o5AcAXhwzVvvYCJjoIjPbnCUtaP3Svh7VoEhQh5tFrd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnvdXyr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF85C4CEE7;
	Sun, 21 Sep 2025 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473585;
	bh=pOC1FJ1dZ8Ed5BFxEGVeWgL22mKSWnuTkoOTFE8Asdk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hnvdXyr27NfEjzQxiAYLEySASSRxwYe37YWbHTqXGkPN78k7AO8RST6bORNKi2nt/
	 AIuCCOTCDXQx69JULbDh4v/wIRNFElzKjmxuPx2Qk92hx4wapgdKzzkGSfVHfiZTZ+
	 8CRFb+Ojo4mSorbJmEjof4hBptpZ0rH70t7pIlmFWNi08cpmZqpl1l0+mJ/M4tITUO
	 QM5XKF10LHf9BrWaW50hM+A4FMWJLWCF23pgBkMaRs1rCr2HNj384F4nb8AyAWCwY+
	 Dyr2Bvgek+nVmxOdyXo3DDH/sf1+jRIXaAZQc9lYjuMPd1ZSowMB7dnjvtFNXPKvPR
	 04giQeGuNtR7g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-2-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-2-laura.nao@collabora.com>
Subject: Re: [PATCH v6 01/27] clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:04 -0700
Message-ID: <175847358414.4354.6792968051513586535@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:21)
> On MT8196, there are set/clr registers to control a shared PLL enable
> register. These are intended to prevent different masters from
> manipulating the PLLs independently. Add the corresponding en_set_reg
> and en_clr_reg fields to the mtk_pll_data structure.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

