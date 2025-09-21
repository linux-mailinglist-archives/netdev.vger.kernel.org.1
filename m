Return-Path: <netdev+bounces-225089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DCB8E12A
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963D71883645
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029D2DC332;
	Sun, 21 Sep 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upxuLHQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F4258CF7;
	Sun, 21 Sep 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473711; cv=none; b=f1Rsq57i8IGHiDTdq6YIMXmntklEcp4P3HfVM1GtenLe/5NyVnsOzlCn6qYID2q1PIXAOF9efKrBPkxlfoWAAIAZEoT4bOg5Cjb+7fiBFbMNQGkwHdjcEDc5eZyrS5lNxjWLGsHlGPQ2YkmpUNDWRlA/799FR8ROLHebMwLgA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473711; c=relaxed/simple;
	bh=RhEmqjeU+NFYOyr5HyHp4DAurnHJrTWvo0NLRrLiAm8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=u50zRNWAEVEOeG7j4SjbgXebGG1TxBORO0DmBUg/I9PvmLyoP3OgKYQDcbLpQfGfrXbUz/B6visuOiw6x+rhLlopYKeEbrmQ8+mJL8/tCpMAJIU76OQjjRJa+qGswsvftPPnoIsq9By84wyUgUQVdEkFCmOuiUCXWu8YCaBbs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upxuLHQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64081C4CEE7;
	Sun, 21 Sep 2025 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473710;
	bh=RhEmqjeU+NFYOyr5HyHp4DAurnHJrTWvo0NLRrLiAm8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=upxuLHQdf+8AkBm8lnvTyDs+oIG9n2JAkPKQQ2YiUnkzomDTx7qaXo+84br1bWqB9
	 rrb1pPoFHO7gWKSE4j6aKTGq/zQGtVKhDLtR/e/oTGA89uTk40i/oUjoJCKKugyMbO
	 tVdjpJlNB5wWgo9ZejhkK5A03kuVWTfUGuZrA0CiH73yByNe294XDTOQLxeRDDwLjf
	 yRjCAXqDxDfnFMRXUqKHWMn/b4Tc+9DB6FNZNSZfyjRR3Cjq1a8DOW6hvVy2gPkkHd
	 IVIOT6PaPQihGYkGFdk3xokR8ZKo/3VILV88MDyPvMk4RAsHF1TyR5FqgXaJuliw8P
	 li5aXiYPLIVDg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-27-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-27-laura.nao@collabora.com>
Subject: Re: [PATCH v6 26/27] clk: mediatek: Add MT8196 vdecsys clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:55:09 -0700
Message-ID: <175847370918.4354.1172258827335473725@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:46)
> Add support for the MT8196 vdecsys clock controller, which provides
> clock gate control for the video decoder.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

