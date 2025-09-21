Return-Path: <netdev+bounces-225074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1DB8E073
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52618440060
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE92690E7;
	Sun, 21 Sep 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOZkPckf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE125A34F;
	Sun, 21 Sep 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473640; cv=none; b=X8ik0KLeOGUiF1b9DgXkrTnFXda/vQ1EUoBToEYZuvK33Ma6fJzKLSvGlxMOBp9CYH1a2/Z94yX5IhP9BHg2Gcc3VjE3KjZboXxBqWTqipdAS9DZOIGFNXAWsUf7ST20X7b/IiZj9c6M5S6lMuASl/+m5y4RAUO5JAtAMiiu7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473640; c=relaxed/simple;
	bh=8Xa1VwxwUjh3fMqDPnJkTYMgQnd/q0xRrpB4zEKiWyY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HxERVyBjbkGyL8vHJMdyHdd9bDRIx5wcNMxwLd+G/MhUJISjIqtW1dJOoChZOtEFQvFrxMACgWnBCrAouVh7P6CyIoLfb3ZPQJqVxyGXhb5X+uL4L1D6q3UIPy9Ya5oLOZsy+SQoieSGXOxe8tPMwA7nM6z+oN410mOMV+FMq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOZkPckf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63827C4CEE7;
	Sun, 21 Sep 2025 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473639;
	bh=8Xa1VwxwUjh3fMqDPnJkTYMgQnd/q0xRrpB4zEKiWyY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WOZkPckfpJ/4SNxxHyGPCd9Mr2anUsb3R0qvU2qunlKrB6xvUfXJLFddUNhzafsnL
	 LB5UcG0uFegzEJ/BsM15we2sXuYN1g9xCPfZbGI9yrWzaL3RCILM4kkYKTgQyVYIDe
	 aoHc7Ff6CO2eExjDtKqGD+R0HClhbUl6Nzj/tnJXIDlZhjNcSJr9YPkNTATSPzTUwr
	 UHofxShRHx6wWJ3PFIA8XUU/bo2mNto47ohvvLT+VOMgUlXjBgmxiD4fcdAr2rADPY
	 NVy9BqxA34tW834i0JYTRXT1L54qg7VHyOF9bAG/57Rgg0+iCPQNuLkqQ/JTV5TD+7
	 B4NE9oTu16mYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-12-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-12-laura.nao@collabora.com>
Subject: Re: [PATCH v6 11/27] clk: mediatek: Add MT8196 topckgen clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:58 -0700
Message-ID: <175847363821.4354.1814125440725649399@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:31)
> Add support for the MT8196 topckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

