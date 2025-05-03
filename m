Return-Path: <netdev+bounces-187616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2EAA8185
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AF01B64311
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B969265CC6;
	Sat,  3 May 2025 15:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E421DB346;
	Sat,  3 May 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746287769; cv=none; b=oTUvIvaLFhjCVWzUQc7ecVzRFC0YVzeQoLisQQdbcqtQA8w1dniukkaf36fR2m4rgt6tv3dfViDzaISZ4zeuHvfZE9zvxbPyyjVC/Bwzok5FP8KMrCDgQpp5SPHEoEIBWXEyNjhOMC6EA62el9DzmdkwALTuf3a3PIdYQzUaNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746287769; c=relaxed/simple;
	bh=MlN4CjpXi3IaHN/bNJWMD4qf9bbw2w3cGlsMeSf7fgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U7dGALoHgdAubArjk2fhNPMm0P5RzgG7TAg10zKKuRNS6Bn7d9Mb4CRwdKPUGbWDwDI3Y/vQ08HHxPvH2Rz3caDCmSYA4GTHVoFtjS9T4ynFuR2GImwhywTBw8pgfnjHZXTatCbTtlJNSz8t7l/3yROUpaSmd+lgUrvdHCcrBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FADC4CEE3;
	Sat,  3 May 2025 15:56:08 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 822275F863;
	Sat,  3 May 2025 23:56:05 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
Subject: Re: (subset) [PATCH v3 0/5] allwinner: Add EMAC0 support to A523
 variant SoC
Message-Id: <174628776539.3898418.13280613195656914749.b4-ty@csie.org>
Date: Sat, 03 May 2025 23:56:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 30 Apr 2025 13:32:02 +0800, Yixun Lan wrote:
> This patch series is trying to add EMAC0 ethernet MAC support
> to the A523 variant SoCs, including A523, A527/T527 chips.
> 
> This MAC0 is compatible to previous A64 SoC, so introduce a new DT
> compatible but make it as a fallback to A64's compatible.
> 
> In this version, the PHYRSTB pin which routed to external phy
> has not been populated in DT. It's kind of optional for now,
> but we probably should handle it well later.
> 
> [...]

Applied to sunxi/dt-for-6.16 in sunxi/linux.git, thanks!

[1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
      https://git.kernel.org/sunxi/linux/c/02f27ea7fa02
[3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
      https://git.kernel.org/sunxi/linux/c/56766ca6c4f6
[4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
      https://git.kernel.org/sunxi/linux/c/acca163f3f51
[5/5] arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board
      https://git.kernel.org/sunxi/linux/c/c6800f15998b

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


