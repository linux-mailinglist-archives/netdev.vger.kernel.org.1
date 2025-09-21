Return-Path: <netdev+bounces-225080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E0BB8E0B5
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703A63B1870
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5028751E;
	Sun, 21 Sep 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxzgxrJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B8271A7B;
	Sun, 21 Sep 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473671; cv=none; b=axDbsaPmBaM4YQ/dRE77ui8k/SeF9LAP+28oBMJ/t8RC3Rihh20SJVjVbqzOAwsya0YYN57h8D9P+z7SXxlITFbOIlr/M8C1gHPHLqq69/PPNBKQmuMWPotbLOeFt36QUB0Jzub1RSz4LztuYlPZy25kn1LRYyeUMjk3cqS1JAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473671; c=relaxed/simple;
	bh=a1G7Idd1jXSeydVO9+p6aQflLNNbJDkn7NEgXhDdDu4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=js/7fw9fuglvtxkyt1nDF34UhkxSKUT9+9YbytPxs2AbFuNVS6wCxWWyFaBh4ijmyGdUHbN9nXwBZsyeJVxFrBhzW38birzoYis7TzNsJ17V0fr0C7DhWgPpgSHm5prgkI0N/yxnUXew1DB89YE8cWwaq1G4CqCJIH8GHYp6ODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxzgxrJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E63CC4CEE7;
	Sun, 21 Sep 2025 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473670;
	bh=a1G7Idd1jXSeydVO9+p6aQflLNNbJDkn7NEgXhDdDu4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oxzgxrJmM6nGWeWDtDfVDCugmZzdBDSprGCTSya6OE+eWxRZSQs0eZuVfAJjgf9kZ
	 zDOWbhtsDDo74T8nEnHUazZrejTq0eFVatl+1B+EFZk+mA1Y41NwBPKobdX3JSwW1/
	 MBsr5IZ62P+mESbxsNmCY2fSbFl+wmJvi1k7Do/l9jtMswzGSJem5gk7c6Z006FS4u
	 9oAf/4LA/j5I8SrjBPO5Ri5FqSlt8LY/0FUgSwghqSoE2I7TAA1h1RQ59UujRhzdav
	 ombLVsRD8bFXCd+ousnDGjUw5VNqBibytDcvXjxQM8CcREdOqzjXJIFp1Ig/fJ7a0J
	 5cnnJoR7+J1UQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-18-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-18-laura.nao@collabora.com>
Subject: Re: [PATCH v6 17/27] clk: mediatek: Add MT8196 I2C clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:54:29 -0700
Message-ID: <175847366920.4354.9675172258834502280@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:37)
> Add support for the MT8196 I2C clock controller, which provides clock
> gate control for I2C.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

