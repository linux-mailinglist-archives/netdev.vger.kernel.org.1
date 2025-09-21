Return-Path: <netdev+bounces-225085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DDB8E0F1
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D233BFBE1
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6015274B2F;
	Sun, 21 Sep 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN0mQN0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40A25E448;
	Sun, 21 Sep 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473691; cv=none; b=mba1CLtXNwMXxVC6yo41jkBPmnxq0UQO+I/puV0nu3iRQ2AadPgq8rl3kJ5nUrnj4Zxe4cNmL+qbO70vCkq30RbyjqwIiUOpimJ2S/pHLzUGNgpHzSSuSCT7nm3KApTi7s0bc7hhEAWlHukfJAiLO2xpyXI//pL8H6GndO1huxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473691; c=relaxed/simple;
	bh=iOHJwh1s0NuamW/p2z4BcgkGlddB15OwH2HIIS5GZeY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=SeY3C25D6tmRsRo1wTNEOPmJ+yO0V3LA5Fei7NT3xmbiD4wqzm0IpRXlWmVWSgWxEroQ3OBWbXQJV/rnfJUYyM+Olv4u0aid27z6sali9PYyLkZ8v8ojjRfHZ3hR2BCCxsJdWNyb3pQ/z8N4kPuNib3p0Z20kB/uSl4MzR7OhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN0mQN0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E4C4CEE7;
	Sun, 21 Sep 2025 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473691;
	bh=iOHJwh1s0NuamW/p2z4BcgkGlddB15OwH2HIIS5GZeY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VN0mQN0ZX/QKnwQqCXdFSTjON+UfALxUPNmvvDkgHgn1eH2HzXhwNV3jvTdp8ct1o
	 VWYcfA1nvZy7+MDQ9POlp/Br2ldLcNYYCPPWLIFuyyFiwlRGfhoWcp96ngzq3qqlPE
	 u2cV3kfjuGmg0LwvJBfmHqXd/ie5QhfGWFE1GX7a7M8U+OVsjh/mt1MNQIqja7AgDH
	 H3+yj0Ld8ntTsg11oCLYgzcf3s1fu3VTxsVDjIT7C0sOG2+3YDAXZZDeViFlmtgmWI
	 dwcpYfDt9y3mPnGSxqExInZtG3Cj1Gr80S9hxAQbnLCnBuZvuY1LKtFNmmkqvtOh2U
	 v3GpPX4SCfXjQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-23-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-23-laura.nao@collabora.com>
Subject: Re: [PATCH v6 22/27] clk: mediatek: Add MT8196 disp1 clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:50 -0700
Message-ID: <175847369007.4354.11383510254378857738@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:42)
> Add support for the MT8196 disp1 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the disp1 clock driver via
> platform_device_register_data().
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE re=
moval
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

