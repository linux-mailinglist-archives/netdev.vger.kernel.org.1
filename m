Return-Path: <netdev+bounces-225086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9274B8E115
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8684162991
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDD2D838E;
	Sun, 21 Sep 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj0rfkbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3E274B5A;
	Sun, 21 Sep 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473696; cv=none; b=QVVVj0peDT45jiXyqGYNSjF6r75abpR4hMzKH6QMQgRmWiloZCXMV0j3NNi+W21opVuzU7GYhZY7SNO5zS8guzximrP0ZEENJHwjAYir7ifYO9ETetZ+3DEjxE9z513GhyY0BNrd6jZW+UYSr7xJV1HA5dFyc4C3Gr4fFc6/kkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473696; c=relaxed/simple;
	bh=0g9njdnLEl5mydRLxaH3jvOFTeBYgSNJqOzh79cP6TY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ORwHxSPY1wuf0Yn/Q23qzX8qsxvlRcDtSqKL7tcO7C2e9RzBPuzTmyoHUZch582FEqNrPBwlBdf4f9M1pRrk7kB0Wtesd23PmgLLkfaFjJzAr4GWFNxjuHdh4k47rQwjAneQUjy5VW2rLuDVx9WElzgTujFWesU4/ZwTSmHr0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj0rfkbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BB9C4CEE7;
	Sun, 21 Sep 2025 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473695;
	bh=0g9njdnLEl5mydRLxaH3jvOFTeBYgSNJqOzh79cP6TY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Mj0rfkbgZrPNLDegjH7Ma9euYqpgtpGYTjp+Sk2PpeWEcgCBTk6YjBOeAMxrY8mo+
	 oA/WB0M+2j61a2sxJVJYW+ygsixSY525TQbVSvT84HnmlrnECEYNHH4WBxxKwxR1PU
	 SoAuqD6AVddqZhMOO1flfo4wFbAsXIflLUf304Zr65T/hYRCW0eE7i+YViKIXRQLip
	 B6CqwusNYpeijrp7/hSyuLedPvkG1bdi/bP6tJPV5qbRtqkmZlHqaclUMsGCV+/hoM
	 /C0JR3vP2bvUkYFAyykcxw1hjj42tkGyHZ07gc3uuUjDSHgLOnSJ3blrEtadw8e1nE
	 8TuzZOAFn/9jQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-24-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-24-laura.nao@collabora.com>
Subject: Re: [PATCH v6 23/27] clk: mediatek: Add MT8196 disp-ao clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:54 -0700
Message-ID: <175847369425.4354.9985195366751682469@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:43)
> Add support for the MT8196 disp-ao clock controller, which provides
> clock gate control for the display system. It is integrated with the
> mtk-mmsys driver, which registers the disp-ao clock driver via
> platform_device_register_data().
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

