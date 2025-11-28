Return-Path: <netdev+bounces-242483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9BC90A12
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C00834C775
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B22BEC32;
	Fri, 28 Nov 2025 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV8Zxqae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1A2BE7AB;
	Fri, 28 Nov 2025 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296613; cv=none; b=c4qBtEMs0wh4Jfme7ClpZOfZuH52QHyFqcX53F0mEYdPuMyhJaKCNIzBDJTRZIFMNVdrMmFLdj5nskqKrSZfb1nMRYofYCOOGsK1ctpdvQP/tW3ZluQJzu6Qs0+v2Jls9QZwiU6ptUtqDjLWmbgdJduYUuWWR6BQ/mfW9i3bmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296613; c=relaxed/simple;
	bh=ChUH8LPVvpu+YFf5NJXvaYDaDj9IA+nJru/MRF/7aKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mHEeKzL9ttUkw6PPKuW5XrkgGHNQ5eRwTvrFGhCw8lUjk0AbqnsQCDh/4IZ8x8coiJTtOce/CsmLH1FgtwFfCMnsifyQXZ4obfjPUzq4XOIscyMppSZQH9v/H/41oRb8YXEVAQcAUaPSosXp+4FhtnpHQ3+UkOo38hq8U+S12L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV8Zxqae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0454C4CEF8;
	Fri, 28 Nov 2025 02:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296611;
	bh=ChUH8LPVvpu+YFf5NJXvaYDaDj9IA+nJru/MRF/7aKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cV8ZxqaevY15CIQe9453djrCDf3a22nWbecJNvG4zM0kzkjl1jbslQOBuONINl+kA
	 Z0Fmj7y5BnRusg5HL8Ze7Ha6CMsWfwQl0UiO0tUV+n1qmvNPg8abbf22TTUhty63/+
	 DKJ8UVT3jBtJO6doXpE7O9+bufM7CqLpbWdQBRAwT0YGM3SuEUg3B29REs00dqqPqM
	 BGNYndKucYjKxG6eX55tpN6xxuZnS+dsrDHnkDe0MMRvuoDbFZ8y6jrL1HVCMGrexu
	 HtPs8P825Lj1uLGSzaxXDxRhJ1mu8/fBoJCt4zNrR9aKb4jbPA6xQ3tq6cU4WheXcI
	 y5kjjlQv8HcOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7E43808204;
	Fri, 28 Nov 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] r8169: add DASH support for RTL8127AP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429643377.114872.4982489725923066240.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:33 +0000
References: <20251126055950.2050-1-javen_xu@realsil.com.cn>
In-Reply-To: <20251126055950.2050-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 13:59:50 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This adds DASH support for chip RTL8127AP. Its mac version is
> RTL_GIGA_MAC_VER_80. DASH is a standard for remote management of network
> device, allowing out-of-band control.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] r8169: add DASH support for RTL8127AP
    https://git.kernel.org/netdev/net-next/c/17e9f841dd22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



