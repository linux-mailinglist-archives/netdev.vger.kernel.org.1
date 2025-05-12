Return-Path: <netdev+bounces-189748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2AAB37BC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2D860632
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD72951C3;
	Mon, 12 May 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUkjBnBP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FB29375A;
	Mon, 12 May 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054173; cv=none; b=KNhAZakfqPnLaHqyigpxXx3ka28ceS5o2ncVEERDYpUUR+s2aYn7A/gOlX1MbY5+FwVxCnDAFJta9zEyH5KzNwvVCfsbhmUdrnIkwofspK3dt+GQFANHBQNVMVKcZ9rHPvXevrxce41GR0hbaXBplBYooM8SpcEpkYvP4QDNUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054173; c=relaxed/simple;
	bh=Xul2N5TZdLPJDaY9qEes+2SrQ7lCw1Xec9sr/RkvLPI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=It0EqYWHbjOkxCMKS0wdrIjd9SZE6bL2UvUkSjBZypPKwhI+ptao4tbPO4c7Ovp3jbJ/rsxCy5gy15K1CejrLJcKBbV+1UVjwYj3KKJbksAn0VQQTzn7lL/y+BPXKwIWJAvdwj00VUaauqxFQFhqMoz9IYLHQzJkENROsj5lgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUkjBnBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0539C4CEE7;
	Mon, 12 May 2025 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054173;
	bh=Xul2N5TZdLPJDaY9qEes+2SrQ7lCw1Xec9sr/RkvLPI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HUkjBnBPVRlfJwgczJvIz95ZeTA0Zc56cGxjb8KjZS+WMVCE9EiSSeUG9GURRr1m+
	 9AlggNLcLnqOSv15GWgnmv9xxRTneOuVXX6fhrR7bPfM4BsQqRekdx+At9paamyIjv
	 OBbsV9kP34hDxnAuOCRI4T1d9IkMFDTpa2yFKBL6GjrBaHmU4oev+ZxBN0VrgUS/Rm
	 b7/BE8fHI9CjGp+t+sI7MEGxHTnhtEbPFXcEth1fy7Y0wVWlwuwfH/2T8HLXq1Pjd0
	 jyg5n0RIj1AT3WGQ+9GDOspK9Jxd6mx/ZEMzz2W+Gk5U1lwWLxIRpGNOkCzoFyjplh
	 k4uiNPp+SJXpg==
Date: Mon, 12 May 2025 07:49:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, s.nawrocki@samsung.com, sboyd@kernel.org, 
 mturquette@baylibre.com, linux-clk@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-samsung-soc@vger.kernel.org, krzk@kernel.org, cw00.choi@samsung.com, 
 richardcochran@gmail.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
To: Raghav Sharma <raghav.s@samsung.com>
In-Reply-To: <20250509131016.3173048-1-raghav.s@samsung.com>
References: <CGME20250509130035epcas5p36c784dcbbdcfb708c12fdfc67eecfb49@epcas5p3.samsung.com>
 <20250509131016.3173048-1-raghav.s@samsung.com>
Message-Id: <174705404323.2941293.7491177381588935328.robh@kernel.org>
Subject: Re: [PATCH v1] arm64: dts: exynosautov920: add cmu_hsi2 clock DT
 nodes


On Fri, 09 May 2025 18:40:16 +0530, Raghav Sharma wrote:
> Add required dt node for cmu_hsi2 block, which
> provides clocks to ufs and ethernet IPs
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynosautov920.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.15-rc1-6-gaa833db4b822 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/exynos/' for 20250509131016.3173048-1-raghav.s@samsung.com:

arch/arm64/boot/dts/exynos/exynosautov920-sadk.dtb: /soc@0/clock-controller@16b00000: failed to match any schema with compatible: ['samsung,exynosautov920-cmu-hsi2']






