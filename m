Return-Path: <netdev+bounces-225077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99335B8E0A3
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EE6166711
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DB1283FE8;
	Sun, 21 Sep 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB7ybL9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B6259CA0;
	Sun, 21 Sep 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473654; cv=none; b=MMNqN2TBe/5ala0rm0RBmaDRkWzhZ+1v6jEatknQnAFwkUXFD3msCvvMKKwgCayTY1AoyOedMFX/oxLft08d31H8B3cBgj5xgiX+96ayT9u3ZxUN2NgQeYAqqMipIFpuqYUhqbB3Va1HI2HEXovRnYz6eECyCcWu6ZRWe4bLp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473654; c=relaxed/simple;
	bh=tjbJUAsOJvnVsSkd0SpD92Mad+1i6cHrk6TaHi8r1M8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RWkhRqznQZWV9UoNw+lEpjpxql8uUP3A48mPwTda5+TTjtEHfEf6Ej1mRqLPfdcXll4UycdE+ekI4qGsn+7GSCCuYyVvbMLXdsP7ecwapwMWqVURJTrBmsWYNPgN4e0l2FSrAKT93aYYnu712Z/iPk5CDuE8K8F2jTserRrf7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB7ybL9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF58C4CEE7;
	Sun, 21 Sep 2025 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473653;
	bh=tjbJUAsOJvnVsSkd0SpD92Mad+1i6cHrk6TaHi8r1M8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pB7ybL9Vkw4nqdkgFs0jz7QXCnZ82eQzv1+zQa6q9fbcFWLuuZiFdKjyP2p3CeYy7
	 W3Rlk4MWstDnKXN6b5zF0N2LNLysS6a3dVc1SBbMsZciesqoQ8DCkQJ6pzhT5riDan
	 vIAjU2FTC0o2zbAixzqJQXIP2B9WztZeUbVkp8nUOSB3pyNIM9Owvuf4X2BYRHWRTf
	 cHEn05/TGEDijOgkZbvJXiOVeN1R3vnTOv2S8K/uYG0RFB3I5Bvs+YKkmlM1kSknOm
	 8s/aJcrOvx0GkLRecod3r6lqcsjSCSiIQ6ooVHIVx7TPHY/c5x9CE7WazihHHw0atd
	 holo21/5h/4qg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-15-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-15-laura.nao@collabora.com>
Subject: Re: [PATCH v6 14/27] clk: mediatek: Add MT8196 peripheral clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:12 -0700
Message-ID: <175847365240.4354.11730843899669937671@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:34)
> Add support for the MT8196 peripheral clock controller, which provides
> clock gate control for dma/flashif/msdc/pwm/spi/uart.
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE ch=
ange
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

