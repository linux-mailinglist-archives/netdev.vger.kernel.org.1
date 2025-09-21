Return-Path: <netdev+bounces-225088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E5B8E106
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D292189AA24
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D02DA755;
	Sun, 21 Sep 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhivRKPT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F04257448;
	Sun, 21 Sep 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473706; cv=none; b=sZrOasf9sSuHtt1jtaNWBSkfiqN2ctk+A+2wUc0aww6AazVtjDzVrd0B7vmuO+x7P+hFxqgurGl11LwDXx+kv4Psdzaw2Cnds03R/2dmW/9ZqJMxNCLGHjzEmMbQCHvhytE/aewGWeEhzZEJmD0hbFaHL6dhTTVDNkjYxjBqxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473706; c=relaxed/simple;
	bh=3aqnxZVIrrJA4IYTRMrSAJlPuZKH6oOg92Ps9YHuKOo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=X9UG85TtdyzCoGPSvE/USbvFfDxCnTWCZM/O47WDT2/iXdw4QRaywOdW+S1pDkIZcFcI9QawFmsyfzdXL/WM/SRhjo/pswBfqZlWDgGda1TKFgT+f8pwfhIUNypkztRRWk+J1mTaDMQJWsbSSdNTqIxo9T+/g7fbpEz+mjFANyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhivRKPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496FC4CEE7;
	Sun, 21 Sep 2025 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473706;
	bh=3aqnxZVIrrJA4IYTRMrSAJlPuZKH6oOg92Ps9YHuKOo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fhivRKPTQpjyQvCukz6mNbeBb+f0jkamIDLH6FP2v2I/h/mesFb9sxNRpVcvZiss6
	 tZ65z7tmfYOPMm49Bj7XyIbfvUiqyDJA8iRvOX8hWu+qQlVOcYgketzhZzB2ri0X5u
	 WkIDK+ydIAmg4B12fI0cAIT78wV8DMOLh+EvSADAp2PUje/mGgTh3KjrxDgEoVaCo6
	 8oTd5b8Gbl8zm/320sB6S96FSb2Dbmrz5H6lK7k3tK8iPEeGHDhEClKklvTUoaAFxz
	 yZ3hrwPmV+G6qgmqK20sonQeomfyLPKmCRGoOrl6T0tyVhWvzekoyVkQLoEyFCmt9s
	 3+qA6hGHIExDg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-26-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-26-laura.nao@collabora.com>
Subject: Re: [PATCH v6 25/27] clk: mediatek: Add MT8196 ovl1 clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:55:04 -0700
Message-ID: <175847370443.4354.544247349627203501@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:45)
> Add support for the MT8196 ovl1 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the ovl1 clock driver via
> platform_device_register_data().
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

