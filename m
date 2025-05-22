Return-Path: <netdev+bounces-192523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6EAC0333
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35A04A84CC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D619E82A;
	Thu, 22 May 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEffVIE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72E19DFA7;
	Thu, 22 May 2025 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885818; cv=none; b=Y81AABEV0qifj6RwXSO+rNqXbzOhfyUl/91twqRAhpL0rpxaepOL5BB2TQmDGYBt0G5vKVbBxlH0C29EZqPz2dcdwnm4r784iF4FrR7bVCQYzy4hveaXXQyVGw0H5k62C4UCvKmOAQUs3hael9QlpaIDzukSxBYvo72HZbfqlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885818; c=relaxed/simple;
	bh=p22G2JBMta/6iH6dP8U1a3F9uRlC3jbI5Wr2sWdOGF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+IRGWyxYlFOOGMJvbdJKzdOH+HUfUDPQBhZ54XL1UIQjkTVSTipSc/fnJ66HlkyJW7O4b+lr8rdxahxCOpOyEAthzOFosErucFxXcvQIVVROEiC/ETcYiFOxvnTjnBan2RLoF7dC2zamZyNByOIkqbLi38AZhqMdY+NrkVvzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEffVIE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAB4C4CEEB;
	Thu, 22 May 2025 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885816;
	bh=p22G2JBMta/6iH6dP8U1a3F9uRlC3jbI5Wr2sWdOGF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEffVIE9+yJUE7xH8jg4ks6LXjL4O2jNGMQwaEKF2XRYajBFdd+8fjJA2Jytu9+Sr
	 1Bgtl++9dPQ/cx3HxOAy1qGOBBoghtmWyV5t6awwhMhxA4ZgrSS5tkBosVfoOItsTA
	 Ysw85psBlCMu+gd6k6kiAS1cxuSUMVKIqPbCFr922UCDayFPwj+AX2gxqX69UMdsEW
	 lmL0w6VGwDQyobgCeDUMyjchtuLTq3ZhQho+Ro1DYY6MhNVVZHRJJr4mfGrevTiMaG
	 7/WDcqR/RBppAEiuICYYaKC4S0g0y6XX6k/5njA4y/xFxXU1aDBDCY4FO3J+gC5xi2
	 pGZwXydgAoTfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D40380AA7C;
	Thu, 22 May 2025 03:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] nfc: Correct Samsung "Electronics" spelling in copyright
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788585174.2369658.2328362066344139918.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:51 +0000
References: <20250520072119.176018-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250520072119.176018-1-sumanth.gavini@yahoo.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: krzk@kernel.org, bongsu.jeon@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 00:21:19 -0700 you wrote:
> Fix the misspelling of "Electronics" in copyright headers across:
> - s3fwrn5 driver
> - virtual_ncidev driver
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v3] nfc: Correct Samsung "Electronics" spelling in copyright headers
    https://git.kernel.org/netdev/net-next/c/bd15b2b26c98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



