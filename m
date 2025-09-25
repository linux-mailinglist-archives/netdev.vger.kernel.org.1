Return-Path: <netdev+bounces-226152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E40B9D04A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D4619C2319
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FB27FB34;
	Thu, 25 Sep 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjAHkXhB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603F2580FF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763813; cv=none; b=GBeeh/17OIWsF1UoHniXFHwa6VobkEDLZwcvU78d2loyLrHoPWObVIJIaz6UdBuw+Gs0drUStUmd1dffeKEIusEIOujzhZUSnmTMB9wQ9E5f6J8HQKFqOE8pxxdcL1Ot/E/V9tZCpejC8ri3oAV6zaDRNHSIvbsSAnZZ4Z4so90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763813; c=relaxed/simple;
	bh=Y+JudV86/Qs6cWbndqn1mTFlu5+eF47Nhl6LU+Q9fOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGXnxiRULAZs3luXiRBr0mtrRboZ7ljxaAL9XkPDt5y010kIu0ADCxGon7OjUtZDx+Co3rs7GfQKB2L/vrRiHUPGdrYXNFUDkjMdtmxJnhNXJre9NV3+I2S9BhIyl59TyYMPha2k2vQjBfpHJbK0rrtbn5sqf9Npd54F4DoPBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjAHkXhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E43C4CEE7;
	Thu, 25 Sep 2025 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763813;
	bh=Y+JudV86/Qs6cWbndqn1mTFlu5+eF47Nhl6LU+Q9fOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OjAHkXhBE8KlkELLysYfGl1gyMWpjRVH79o4krKWx1k8N8QEO4uzSVUH5QD9cUeaX
	 UTswiizdCp/3kbwqmJ3UA1t9vt8ZIaQBuhmB6GruqmQmP51lajqDAiWNBRIpkE6KGb
	 +tCqSo+bGYOcgKSUPZjswpAjGrNAgETdtZKfyiDIvuSckhT8a+9I4TXR+ozfT+zY9E
	 /Qtmxkmm7NZA9R+JoH405yOHDJBgHRfT5ptGnIo6k9brYZ/zuDMVqPQafvXQwTfFXO
	 qnASq/4Fn6RazBbtqw1Ox0tWV0da2CF/+9r52Ml88XNyWxlXY+2tRQMFPVj45BOwj0
	 8iO9UoSkeFRtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8039D0C20;
	Thu, 25 Sep 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] convert 3 drivers to ndo_hwtstamp API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876380945.2770609.10010157855430136200.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 01:30:09 +0000
References: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, tariqt@nvidia.com, saeedm@nvidia.com,
 mbloch@nvidia.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 17:33:06 +0000 you wrote:
> Convert tg3, bnxt_en and mlx5 to use ndo_hwtstamp API. These 3 drivers
> were chosen because I have access to the HW and is able to test the
> changes. Also there is a selftest provided to validated that the driver
> correctly sets up timestamp configuration, according to what is exposed
> as supported by the hardware. Selftest allows driver to fallback to some
> wider scope of RX timestamping, i.e. it allows the driver to set up
> ptpv2-event filter when ptpv2-l2-event is requested.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/de0aa209b935
  - [net-next,v2,2/4] bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/bd94c3649b6b
  - [net-next,v2,3/4] mlx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    (no matching commit)
  - [net-next,v2,4/4] selftests: drv-net: add HW timestamping tests
    https://git.kernel.org/netdev/net-next/c/b9c8a2c5670a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



