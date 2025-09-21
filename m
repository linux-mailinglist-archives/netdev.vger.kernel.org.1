Return-Path: <netdev+bounces-225076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EFB8E09D
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9467AE817
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2127F749;
	Sun, 21 Sep 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tan27LcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2026C3BE;
	Sun, 21 Sep 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473649; cv=none; b=soPWvppsMp76ARHBpWph0qX64UzO/0CitPdnlPq0m8fNDqnBr361Xi1y3XhkjHUaXjZApFTLGtOZ+xL9M2MWrTAwCX4ksgpycFKTV+9UB2HrC/0sG64rhlF6t5yyn2lAz6m1gSAgq0MP2E8Av2c2NfBYXc5rqIUwzP48twAt3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473649; c=relaxed/simple;
	bh=OLzCUaPNQnZMBywzeMC2KTO9NhwhrbpjSGWQN5QYMcM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=BUpzh5b5qv8HgV0wOTTpB12b49C6GtRsXoen77Go10rxaMshHg4zXG+6tWP6OuO0lbNowFonhzUblVXaYFYOUFC0oMsqk06Evc0YgXekyZyHM4NZpu6twD4TUeOX8q0UKtBCxK2IHqu7swGF8RH2ClM4E7LOK3YXs+Q2Udrdblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tan27LcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34CCC4CEE7;
	Sun, 21 Sep 2025 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473648;
	bh=OLzCUaPNQnZMBywzeMC2KTO9NhwhrbpjSGWQN5QYMcM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Tan27LcBErW5Xh4n+sGEYXLm9huWdK6jT2ZJt3b8qh+tDvzRXdXgDE/+HlkPbeVXv
	 8GiVkVxnZryvp/K0MDoI5qqNJU/twJrJXiPsgttMkOSYR1GyFie/VdM1xFUrKVXF+6
	 p2jlmeDTzkkJcMuAFqWgaSOHQT3NAuybn5UwV0x68oTzzfSs1kRTfr3KiZNU2eQ5rB
	 Jjw6cOvesUf6RwcH2edkuAUBjdyuiX3Ijw37OLRrD7NWkUXPoZxO0gzzcGCjXfdFDF
	 C/EZN8h/khDcWw9yYO1WwDUda2aGE7q2YXIJHo6A/p8p1AgyDlN53a/CxaTlHK1L5v
	 XLf9tXQC0e9Uw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-14-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-14-laura.nao@collabora.com>
Subject: Re: [PATCH v6 13/27] clk: mediatek: Add MT8196 vlpckgen clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:07 -0700
Message-ID: <175847364755.4354.7139891669335992142@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:33)
> Add support for the MT8196 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

