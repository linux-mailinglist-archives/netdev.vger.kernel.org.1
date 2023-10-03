Return-Path: <netdev+bounces-37731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5A7B6D4B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 877102811C1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1D36B0D;
	Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8E36AF1
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EA2FC433C9;
	Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347626;
	bh=QWYGNwW/V1wgTpFxNGUJLG1mfQOTAYw6SAsIRoE2RfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6CeS+lYmvPOXnDYZZ57DjGCLW5MEq1zryjvdGyIuYNGAzTIhz+rKNY6DTeRwg7QF
	 o3+pissUnap5Ch9BLFkEk3rljDjtYq8fRWyO+WLx5EzgLXh5sw0Y188mAMOk3m4Vau
	 xT/Q1DRT5mxjJcq5uBRZBX+wzK0vd6YGD/4YxM5fuM+Fa3i88frJmh+1jIkuOlS6c5
	 4T0A3lzh6FTt+23O6jgcGYVRd5yAyJbTU1BQToRi5be+GmAeBeQw4NQ58gJfEjAQKj
	 OoLWD33YyfFuo+kmDkdxaBSI+FSJUO5AEYzHTlFmCUhTFrcYxCfzIK8Kfj3R2trkNk
	 FcsWYMQ5KUI5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25E82E632D0;
	Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169634762615.3806.18178372938217488177.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 15:40:26 +0000
References: <20230908235853.1319596-1-jeremy@jcline.org>
In-Reply-To: <20230908235853.1319596-1-jeremy@jcline.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Sep 2023 19:58:53 -0400 you wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> [...]

Here is the summary with links:
  - [net] net: nfc: llcp: Add lock when modifying device list
    https://git.kernel.org/netdev/net/c/dfc7f7a988da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



