Return-Path: <netdev+bounces-225067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4DB8E022
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501743BEEB1
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BD26A0A7;
	Sun, 21 Sep 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxGJoJpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D025A655;
	Sun, 21 Sep 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473605; cv=none; b=jZwptIgA2DMqVDgiFqodQJ7O21k+HWisBFnoAb1Hiw3wut9kRRJ57qbqmhS0v60/DHL6Q64pGypHb/BEhihnPg2FEok9uKmT7OM5qlqC7AhuBFPh1yGGCNx3N7ZlsbwTKChluV2hfgbPK3pS2hEtQ404tx+xA1xC4I2rmjpHbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473605; c=relaxed/simple;
	bh=IIiAxC/XQi5kAsbB5RMAD24FdJ00xv/HkAENco6zOtM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=BNhthb3RM6lth0So2I1ebVktsjuakrMD8EcXiQfntMElyy0rjEJQtjxxPtTDVzz9nrld1qhijtsl2+rKyTJi1oOacgK2bE0yg4E9Ae60x9FsYk9+9xMrQWg8TiPhAEDODlpycixByMY0JjYUJwopyZsHVMWdbUNbzRgxe20Gsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxGJoJpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F59C4CEE7;
	Sun, 21 Sep 2025 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473604;
	bh=IIiAxC/XQi5kAsbB5RMAD24FdJ00xv/HkAENco6zOtM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZxGJoJppRCzkQdYXNUS8VZy45a058m4wsFOfd/pae4xdXeSlPzACaLdfJjIo8Ewt3
	 TQBM8NJPRDAcZ3ZUzGPJH05PguSjHbAnM/raja0b3GrGv2p1XLkDJy4TOOYsUAOtrx
	 c5AWHOGzXJLeW2kb/Un1N8sj39bdvPYbI99NLOJvnNuW3Yen7lnpbsT7Qbyd32spHS
	 kxZ2S/0+hM/BNc/jn1NNGQRJVzh9FqngiMJhkGaAvy3Ygq3/3LVxF673PWp7q/HRpE
	 LGdMWAvM0WT6kdupb5qkxfpR77UfJLG0pv9+uJsrKwqAlhBUSbKZ5KHCFNPqqY6YSw
	 y9s/IYi17gFCA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-5-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-5-laura.nao@collabora.com>
Subject: Re: [PATCH v6 04/27] clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:23 -0700
Message-ID: <175847360333.4354.3214551525095431061@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:24)
> On MT8196, some clock controllers use a separate regmap for hardware
> voting via set/clear/status registers. Add=E2=80=AFmtk_clk_get_hwv_regmap=
() to
> retrieve this optional regmap, avoiding duplicated lookup code in=E2=80=AF
> mtk_clk_register_muxes() and=E2=80=AFmtk_clk_register_gate().
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

