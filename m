Return-Path: <netdev+bounces-208995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE323B0DF9D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802471C859C6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DB2DEA7C;
	Tue, 22 Jul 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKG6FrnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D21DA23;
	Tue, 22 Jul 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195789; cv=none; b=EN6T4uIN/BxZRCMTQU+Pp3rV5XkriDq72OzMj86q64vhOpyNZ7DL7dTjpinIzMGsCuOyqqsxyeoumTS4INOorbSY0FNZCW+QMOAahF3yogb7ypBXzG7GiqD0qNYJAjew6VMTYA3Lw3txA5IYV5DknCSYoNb+CUeaDCtLjdRqN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195789; c=relaxed/simple;
	bh=9KedupEOeC1GTtcgABYGZjT7vXJB5Z4qbLfJRo2EeH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1hqMk8b4VO1dMUwdhNR+rDJPUqnNb8RWUa5WvV3ZgfysS1D1JbGyeCD1baoapNr31BSUboRK7qAIqz9chWe6lNXhlI2n2joGzqkOmlSPoD5UtluuimL32hYVD9jnG5U5qzFYdToJcwCxRt9gM2KeP1/hX6J/Uo/bpiBfqWBz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKG6FrnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72BBC4CEEB;
	Tue, 22 Jul 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753195787;
	bh=9KedupEOeC1GTtcgABYGZjT7vXJB5Z4qbLfJRo2EeH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKG6FrnFv/rUuwUjHtYDCBgwjD/3x2Oy73jA9euVK96svtLdxnSkeHHbyLksF35Gk
	 i8wRhmjVlfrcbmyJQqHza3xohK2J/inQUf7GJWddHZBu2mC99YXAnbXXU0B/2XvoCT
	 3JYxHQ0H8ipa8LLGwGXJVgbq0mRhWCkll/3JzypW0C7wX3hx+62H8s2QaU64dGOSvm
	 +5pPQC7bk+ZT1e/FdO4xST++TVDObFvVXcQ9RC3YDvac41oAwpSxukbqWqh+BCUEe+
	 Y96BuhcN2yOHtokyemY6PtWObC+v++dUTYllHpA0p0ISCOCyIId+dl2z9PBlQR8gsn
	 VhsqK11okoVVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6B383BF5D;
	Tue, 22 Jul 2025 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add PA_LINK to distinguish BIG sync and PA
 sync
 connections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175319580626.844166.13673275741050259648.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 14:50:06 +0000
References: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
In-Reply-To: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Jul 2025 18:52:47 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> Currently, BIS_LINK is used for both BIG sync and PA sync connections,
> which makes it impossible to distinguish them when searching for a PA
> sync connection.
> 
> Adding PA_LINK will make the distinction clearer and simplify future
> extensions for PA-related features.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/1ffee96604de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



