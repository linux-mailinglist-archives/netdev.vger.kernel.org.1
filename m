Return-Path: <netdev+bounces-225078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B059B8E0BB
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89847B0095
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9428469F;
	Sun, 21 Sep 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stU/VsM6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0A259CA0;
	Sun, 21 Sep 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473661; cv=none; b=rnNeyDHR2r4UMGfOk7wqgNxdswAHPA6lVOzY7wRFWOIF7RxYTcbOUiqfBoUisjvEdwnXPwoEygngEeMz8N7UjJ/a8wG5Qynn9/GhFQjawkyatJqS6EsL/w5Xcw/ygpHZ1Y7WHFyJbqsYxXnmP9vk0KHxqw7VrsTuXdmAm7o94Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473661; c=relaxed/simple;
	bh=8f/9G9mAreZymbDZirPomAxcYvgRWBMv/7B2LPxzobY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=tCzKvVyt/UcTBeAuMjkiR8HzlCyisTDWoNa9eKVwmbHbdBmdX0b0MVJzzcGBzsaQQtEpychCy9X8J8uksapvXrrfJKZGgQq2eGsxdVV13t7EBzePu03AZi3Nx0GOyjlF0jsZNXQ4X9QAeg7FOQ0zgeJDjx6C5YgAaDGJqPaFihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stU/VsM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC50C4CEE7;
	Sun, 21 Sep 2025 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473660;
	bh=8f/9G9mAreZymbDZirPomAxcYvgRWBMv/7B2LPxzobY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=stU/VsM6dRPxQnPfM4Z7X6DUADlhgxfa/ZpWxIXAIiOIB7PnVyCyMeIMAyh3yB5Aq
	 g2nQEMmPYYT8lWKjXwEY6us7O/GXtFnGAjW2fiJN0ZdOfNSDTipWbQRS7NHQLFUSuE
	 E1WBZmB/AcoUn08sH5D6ELxmQdlYKvPLQF+mgq+frkVMNmFto2qqtIRPp+hoxUEoI9
	 j4D4vdd153X/q555Kj6QZ2Eax57NWFW9Zl+k83eGeucYRJ7hGxng41A51G4S5+I5hl
	 uRr8oT7HWgqxSa/SW3XVwqUI3sAa+E+y6DFXK98GsdoG+dFdItPFOQMZwRfx3t0k6u
	 kBPwedCzgbQzQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-16-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-16-laura.nao@collabora.com>
Subject: Re: [PATCH v6 15/27] clk: mediatek: Add MT8196 ufssys clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:19 -0700
Message-ID: <175847365934.4354.12041857829986457329@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:35)
> Add support for the MT8196 ufssys clock controller, which provides clock
> gate control for UFS.
>=20
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

