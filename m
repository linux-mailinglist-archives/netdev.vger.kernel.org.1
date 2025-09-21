Return-Path: <netdev+bounces-225082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F21B8E0D0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC1A189A5FF
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC628C5A3;
	Sun, 21 Sep 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI1FTQdf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1827381E;
	Sun, 21 Sep 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473679; cv=none; b=iQ2de+bRexBEVOx0ZUnvmFwLiP/31EiXXEXq0kvFklqz6LXi4udB9+l7B7/zL7tcD0fjaVTPbTmAO1HhEmGzu2fN9CAQSioUio4G2oTcjBob7UPYH4zsopUyx3hgCzeLuzv1Pbs4/rdYhHA8duBmXgN76+1gEsnVVJbA0m8rJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473679; c=relaxed/simple;
	bh=ublLJ4/bfMGhwpiuCF/yslXA8jsHoGDaWOd0K/G9R7w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Ly5wl7R7pkfbhJ2Zzng/FDJV0xu2bFxP5nKSq+qYQj10Q6XIFCadKhvK3iloD7HPsPgov9v5Uyue1Z3mUUJxi99rl4xNEAAtUWevk9MQV18luN7gQLMdlgRuUWfvQbT4KENTEfXcw1//azCLZorDMVSA2V/1KB6U5mqaoNwpRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI1FTQdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC691C4CEE7;
	Sun, 21 Sep 2025 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473679;
	bh=ublLJ4/bfMGhwpiuCF/yslXA8jsHoGDaWOd0K/G9R7w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GI1FTQdf6qQ85FG+A5Tt3YRi/YypsGb4ecGPA/rYtiErouPlUtaOEvtju8/n5hwR5
	 2K1ptSj7OtJqpdsgGkw4LU/lmtXaDiKfXhSDw6E/l9Q0SE4qs6k4qZzeGbtpqknJff
	 1dpPXedBKELfjLGphd+iQcdawG1tysAzTzczCStZ83Qs/DC1AsJfBf7FSXL9KkWBG4
	 zlNVkxjNq6lSM/vn26bRF+rnjs9v+xAIGytriijetSfHNVUtYe5YBHLb9LuQBMmFu9
	 5ohkR47GE4w7vRpA2z7YRcyc3xV2K+5WRJUpG8JWKgyT96QU80XC9MEXJn7jaGY4CQ
	 fSUIbHl5eocqg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-20-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-20-laura.nao@collabora.com>
Subject: Re: [PATCH v6 19/27] clk: mediatek: Add MT8196 mdpsys clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:37 -0700
Message-ID: <175847367763.4354.10505203948558114838@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:39)
> Add support for the MT8196 mdpsys clock controller, which provides clock
> gate control for MDP.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE re=
moval
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

