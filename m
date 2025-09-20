Return-Path: <netdev+bounces-224942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01734B8BAF5
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F20F1C0593F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4C1C5F27;
	Sat, 20 Sep 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMcU0aNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACB140E5F
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327623; cv=none; b=J6YyKwsr4r4X/gg9k5eCP6l5em38jWpUTr8JPpUMyoVKiUyXnlnrSo5ZzY57yyuHONvCV5CnrIn/ylenDuIxl5dJa63bnTE0s+f4zsCfClz0P7KECuabNxh0YHdsxHUxzn/TBic3ByNln404zj3VdJ2NslggAkPmMedHR87lFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327623; c=relaxed/simple;
	bh=Tl2jXcULFLGLncDajHf8ZsJd15BIkcEsyjvp+nhAmWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alW7DUxiQ1sxetqBBKRmJJfwDD6GXZtXy8gawyFgW6Q3IZ6Uyqk5IVELcECJwERFX7k4GM33O74Mh9K4b9TAkisY74cuMhO+/t1auHxmBQukJFL558wEjkFe+DqHERBdscudQ58d7aM8mTG7dVkU6QOf5k0HW02vQHQZu9j4RBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMcU0aNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B43FC4CEF0;
	Sat, 20 Sep 2025 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327623;
	bh=Tl2jXcULFLGLncDajHf8ZsJd15BIkcEsyjvp+nhAmWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMcU0aNUXrY2pX3BcLcOb+bkNKQ+VkcFl27cMuIc1MZ4Emb5MZK3wdw1OKvSA5M6x
	 ZyDaNEMBzBzXF5X0jev1ZWXGeyG4jZ2xzas4JZP7kPUuB8/U996njtnaT4nDuoGgVX
	 VdaETft9ksOn0y11vi2MYwIEEMuNUUvJaZzuBkvtWbjvGzrbm7U2kqDZYT86Zq7JKV
	 tnEujzdtoMzoUweDvw8+q90U0AUot8wO/IMI8oqkKUrFVCLwd4Z4eetjulhzl80gUi
	 xKFY89njs9aNP2j36x0JsobHLg9x91RUIw3q9wS4XicFZqHaLWwcWRVSfVsyOt5I89
	 tNWwBCdEHhzjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE31939D0C20;
	Sat, 20 Sep 2025 00:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp_ocp: make ptp_ocp driver compatible with
 PTP_EXTTS_REQUEST2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762224.3747217.15356389072519324130.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:22 +0000
References: <20250918131146.651468-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20250918131146.651468-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 13:11:46 +0000 you wrote:
> Originally ptp_ocp driver was not strictly checking flags for external
> timestamper and was always activating rising edge timestamping as it's
> the only supported mode. Recent changes to ptp made it incompatible with
> PTP_EXTTS_REQUEST2 ioctl. Adjust ptp_clock_info to provide supported
> mode and be compatible with new infra.
> 
> While at here remove explicit check of periodic output flags from the
> driver and provide supported flags for ptp core to check.
> 
> [...]

Here is the summary with links:
  - [net-next] ptp_ocp: make ptp_ocp driver compatible with PTP_EXTTS_REQUEST2
    https://git.kernel.org/netdev/net-next/c/d3ca2ef0c915

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



