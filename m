Return-Path: <netdev+bounces-212743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B4B21B90
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011066809CD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B602E5417;
	Tue, 12 Aug 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3WWo78l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3672E540A;
	Tue, 12 Aug 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968807; cv=none; b=phm7lFu7jzOIlAdgNrVSMyCYWu2EB23y2GwpuAYAvWgSM+kIx8gKbY0g4SzhYrug+9UivRyDgXbCiVKuBh2XwZN/JCxwF8DgaPzRtnjEi5Unbt+9Uv8oGNd5JRNr1Vp6GY4OGjZengIqI53R/xhbw9NZwA1ufnPRrFtsO5xxxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968807; c=relaxed/simple;
	bh=ggu5r20BerVGhutHy6bJ0Rnt7bXNKLgQWbxaR70hhUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5tfUYqbTb6af2kEdU1DMDp+2OdBP2uGL3PeaLhbg2RVzSO+fnK7IDnH/4mDaIXhjDEJ2gYn8Ufxp/e4LSzdrexvyDTQu8+q0i5h4KZESyeZraip9K6KoHUqF0GfNKZOwjguV67hnv2OxDQ5TftHA2jqG5Ayu+8HZhzqgr4yG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3WWo78l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2481C4CEED;
	Tue, 12 Aug 2025 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968807;
	bh=ggu5r20BerVGhutHy6bJ0Rnt7bXNKLgQWbxaR70hhUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H3WWo78l8NizV1A5ju52yxJQEMHV1rjzaCzc1AKc60x1e3yXZCEPy1ckNEhrzllS0
	 YqHaaM/dHvGj1TYzWOlqanmdt+Y/1Whp5g7hMIJFQA3PdudAvk7emjmyTmjXSONb1k
	 CI//vvQ35HWbLLh7w/NgukzTnFvlnVKCxdx6L5zq/6b1ije/auC/N31j/eWNXjj6HL
	 Cr39yps97QdePyhruy0uPSLSD9CLwgUEiSVJ//CPSPg1xfuasNYTKg6Z3xuml6L5D9
	 LYZm8Q4HOwZFyU2opJIlSvST1Vwrot7up0ugJVJSkW8pox+eeq6AcgrXe7tBiusjwY
	 wXlnxXC/64g2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B66383BF51;
	Tue, 12 Aug 2025 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] ref_tracker: use %p instead of %px in debugfs
 dentry name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881924.1990527.9814669393920798955.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:19 +0000
References: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
In-Reply-To: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: akpm@linux-foundation.org, kuba@kernel.org, edumazet@google.com,
 kees@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 07:45:23 -0400 you wrote:
> As Kees points out, this is a kernel address leak, and debugging is
> not a sufficiently good reason to expose the real kernel address.
> 
> Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
> Reported-by: Kees Cook <kees@kernel.org>
> Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> [...]

Here is the summary with links:
  - [RESEND] ref_tracker: use %p instead of %px in debugfs dentry name
    https://git.kernel.org/netdev/net/c/52966bf71de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



