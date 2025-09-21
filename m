Return-Path: <netdev+bounces-225087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E6B8E0FD
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC67189A980
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC622D94BD;
	Sun, 21 Sep 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsG08DTg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA7274B5A;
	Sun, 21 Sep 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473700; cv=none; b=PxK9i/Uu2iBJXGj8ZWRTnEK65amDDOCF6kDLI6oCQV6g0HoiuLRBK8/Y88JORn6SKOU57tcKEzkxGJRbLxmzQJ72pHfJZ0YbtC1y+vzlRiLQFAnjBuG/gu6YQB4grpOo0w4Tt+0S6Bylud93RSus1jj2crFnp1AxOFctwOshFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473700; c=relaxed/simple;
	bh=auNJPNuSwVxarXGnGQ8rrJJRGIFtxN0gXFYvvOj+Af4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=dCdC3DZhNF1eRhFU9lC3L6cOkzQN+oNcMlIxYr/oxJAphroHE5jyuwIfr3+V2DkdnG1DHi3W/gEyqQJdJSE+/krZKrJjsx4wvse1TFANEOuBU/eeXnCsIviRa/tuvs5mzS1CsVpQ1V2vinMVBlZ8lIeDFpzbsXaVSGO1X454UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsG08DTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDFC116C6;
	Sun, 21 Sep 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473700;
	bh=auNJPNuSwVxarXGnGQ8rrJJRGIFtxN0gXFYvvOj+Af4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TsG08DTgl4WqY2E4uWV/SI9YAVmr4FEdQN1bOzbMmI5/QrAaShSkbpBpVm5sgXFPb
	 okxcc3wIPD/RfytoYonoz56bagHIgSbZvnNJuu6e/d716pHWmIg25eScp1E2g8AFWK
	 3pT9Lt1vR+ojzj45ZxfZM4fRVrBo3/SNvLNjc4pEAMrrvn9KfBlFwHakFpc/wWlZBp
	 XyKGCm0ZjlpPa/j0bk/lAzDE+e+A9DE/rbZT/1Wa97sc0ZA0S6QQnpI1wUZ6HDp+Ld
	 rnmBOxE1THUM8OtC50437SEc46+TV2SCExjpPR24MJlH8W+DD2swI2+5xchJgN1eO7
	 uoz4RVYgYxHRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-25-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-25-laura.nao@collabora.com>
Subject: Re: [PATCH v6 24/27] clk: mediatek: Add MT8196 ovl0 clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:58 -0700
Message-ID: <175847369883.4354.14575336138362030084@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:44)
> Add support for the MT8196 ovl0 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the ovl0 clock driver via
> platform_device_register_data().
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

