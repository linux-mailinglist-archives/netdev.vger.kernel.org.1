Return-Path: <netdev+bounces-225083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02362B8E0F4
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E13417F4CB
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38542949E0;
	Sun, 21 Sep 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8qReoNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9B273D7B;
	Sun, 21 Sep 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473683; cv=none; b=OeTK8QAHlMYlEE2zYI0q8oQFyfG6JHscx2qzq/7Jspg3CqU0jOD7Ra/5RWpRDyTbfSOwiN5ach8sn5lhKRBnHeFef5zI3mqVD9EMoK4P3vbQpKi0aCrFTpeWQchVTxX45ylNmB8XfQPxZJA+pdC0asKMLAENOLyU4jtsaUGOoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473683; c=relaxed/simple;
	bh=jUJ3QTE5SKSMJ7av9qqcw/J10K5MvzFo+ogFOfZXTM0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=MVL8aAGKFRDZe34hSOoaexvuA58Hg68HnXFp5c7uP1PwGc7cjoRk2cog+XbzFvddqdl50/Bm1YH8t85vxrYcXbarVgPDH17UfmvehQNgn4rtk3i34U8SD3G8s2GiNglx1XncnQujntn3qGoiXM3IAP3DaUMVVeiLIJ0gkPrMvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8qReoNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E39C4CEF7;
	Sun, 21 Sep 2025 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473683;
	bh=jUJ3QTE5SKSMJ7av9qqcw/J10K5MvzFo+ogFOfZXTM0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W8qReoNU/pgcmYsfUAQvRCy3+8vQtXKM9xWomvoR2HSXOEJx7egiLXPl6J7D8Y3zx
	 AMy6GmNCeSAjNID6JolZvUqx/DV4968w5CX9t8q8qQBEmYZjrMZCZy2wEgqad0SYn0
	 WJr0exZOYnWqYEzwvTOJDifR0f7z9B34dzsYAftypbPu9x9L9V5mlKEl6nNV3J4aIe
	 RDI5/rtrFkDvLDiCpjSIDSB52Vpq7ZN0aW3N1gexc6dIMJ0lOolsUo315Tiyy5ls6X
	 bRd4vH3Mf2TB5vh7Bglwogg6wuF0kMpgiLFNGpMrdFNGsJ1SxIWdAfVcomuKCinJWE
	 oNFAhJzo9DssA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-21-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-21-laura.nao@collabora.com>
Subject: Re: [PATCH v6 20/27] clk: mediatek: Add MT8196 mfg clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:41 -0700
Message-ID: <175847368181.4354.17704668308510890460@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:40)
> Add support for the MT8196 mfg clock controller, which provides PLL
> control for the GPU.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

