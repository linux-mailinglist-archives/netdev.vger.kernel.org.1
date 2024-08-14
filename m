Return-Path: <netdev+bounces-118260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDF951185
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC336B23F21
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99DE57E;
	Wed, 14 Aug 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1NJt4ku"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5BC2FC;
	Wed, 14 Aug 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598431; cv=none; b=HgLabJA6kVAyUjcBYm+ku5bQvz3ZEkiw72P4fzjkuA3+lDUGtCg6juZeEjB624XgvGYO+8QeTckS1qPNLGesp8ZLAQp0H4TB5cPN5Q2LRuy/L14VioHPF1zYrO0//wvDBxCtwhsbNQChp4KNyF3zP+pjw1IDsG4dI1lb40UD8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598431; c=relaxed/simple;
	bh=W6swBgT80tmBDtSPDAhEwgWUWAIf8rwbd06ukImaqK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ei5fV9zge8SLn+GiAUfz/Hs9F0/IGzo4/VtyaCiFdchC1TqrSK38sy7bxwivMpuLuZ902e23tkvm7qkY7YPkI8A0JKVNj8AmI7O6yaU3Gm+Qx6oSKSeTlq0lWoqofCAfha9wAGzI8Vy75kfaXvBtmTyobKiZTUsbOEEkhXMTjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1NJt4ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD8C32782;
	Wed, 14 Aug 2024 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723598430;
	bh=W6swBgT80tmBDtSPDAhEwgWUWAIf8rwbd06ukImaqK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t1NJt4kumuVDt6o9p2JCfz3Uur4zKNxcpSFohuOOAQHTfwEpz+JhOQ5WnG0cmaeCe
	 ElDbj2NtWJjiDI9f+ZQ6gGpoMwkivOJyuS3jMi9ySiuOLNi+fGyBX3LqxndA7pwKJZ
	 xT3N0Ug7XMLQ6WrT9ztm6ibB4kN8lj4jAib2yAH3iCX3TuBxZj+E6jM+1sz1JSD5tb
	 eTC+JA6ysGWfEh4rVJ87xkGoGqawHHQZPxvYYoTqYokZDkfHMdaatOGZoAV9OLiAln
	 3RCxCWIDajfyslG6ZKDigdxsD3n4GHJ10HzmzmtyBeosqdAUA4gyd+dm49aM7Sg4Ej
	 4M0/VSfE5nL6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA53823327;
	Wed, 14 Aug 2024 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Documentation: networking: correct spelling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172359842926.1830772.9207347240431343352.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 01:20:29 +0000
References: <20240812170910.5760-1-zoo868e@gmail.com>
In-Reply-To: <20240812170910.5760-1-zoo868e@gmail.com>
To: Jing-Ping Jan <zoo868e@gmail.com>
Cc: horms@kernel.org, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 01:09:10 +0800 you wrote:
> Correct spelling problems for Documentation/networking/ as reported
> by ispell.
> 
> Signed-off-by: Jing-Ping Jan <zoo868e@gmail.com>
> ---
> Thank you Simon, for the review.
> Changes in v2: corrected the grammer and added the missing spaces before
> each '('.
> 
> [...]

Here is the summary with links:
  - [v2] Documentation: networking: correct spelling
    https://git.kernel.org/netdev/net-next/c/baae8b0ba835

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



