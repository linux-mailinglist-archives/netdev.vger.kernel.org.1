Return-Path: <netdev+bounces-198832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2BADDF8E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1932400370
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA582DBF4E;
	Tue, 17 Jun 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX2L5TdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BD2D12F1;
	Tue, 17 Jun 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202405; cv=none; b=In9GhjP5ClJJSHWvbqGPRYjBivLKxRuBLS6HY5ZAC1Ef40JdBmBTkrNzgXTeY2KAObhzIL0mt7TeN2wSUOAILdV6ZXw/0g/eI8pj73Xl8oAz3+rG8H3lmDiGi3sm2J5AyhsSThRPv8op7Q999kifuZ0o8fxwv69XugdfNd3/+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202405; c=relaxed/simple;
	bh=i9TKNdIlWuBqyoNihNjsATzBaXsZQKN09WakJmYXqYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SE9P+q/JHt9H7CbCdXPOX8nGzEPq663tEdasiHTfc0mizDcZcnxrhE7RtC4tulryb1jx6pLrarsGFIYeZxEbFTFZuFujN5avRq2XyNvnau7HtWbgAGUY6hep2tKrLk2hdwQDPAb/XYLslOxPKsWnhF4lV2kG32qIcT29U8eNDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX2L5TdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FDC4CEF0;
	Tue, 17 Jun 2025 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202404;
	bh=i9TKNdIlWuBqyoNihNjsATzBaXsZQKN09WakJmYXqYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gX2L5TdOdQW2Zl9FmwXUp8+gwBLmfd4XX74XkFdUFJHAq4AX3qzY1kmDQfM7bLZYK
	 jFooWESdRqbloEzGG5mZND6LIB8px8U0iJ1TjlIFVlnb57gFb+rePP1f9PEFLLgfw3
	 m6M+Ab1Fffuns8EeZ9OWqjM8m83Z1YMgkDxM+zzFX5Ag4BexFrjJwegXfpuvYXCbro
	 AqSVlZ/d3jT05NrkAMNQ+Zwgz6GhsJkGx9B2vaXsJN3jxMzh4qE8OvZ9Z9986jYpIZ
	 sRMNypTJNSViwB40SV7RMB6ReEYAMFvDVCiCeeuq8Z/6IL3e1awoPnWacDxV3vPWl0
	 ZQFaZwojqEkDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8E38111DD;
	Tue, 17 Jun 2025 23:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: liquidio: Remove unused
 validate_cn23xx_pf_config_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020243324.3732875.171242718895048477.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:20:33 +0000
References: <20250614234941.61769-1-linux@treblig.org>
In-Reply-To: <20250614234941.61769-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Jun 2025 00:49:41 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> [Note, I'm wondering if actually this is a case of a missing call;
> the other similar function is called in __verify_octeon_config_info(),
> but I don't have or know the hardware.]
> 
> validate_cn23xx_pf_config_info() was added in 2016 by
> commit 72c0091293c0 ("liquidio: CN23XX device init and sriov config")
> 
> [...]

Here is the summary with links:
  - [net-next] net: liquidio: Remove unused validate_cn23xx_pf_config_info()
    https://git.kernel.org/netdev/net-next/c/5216b3b25018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



