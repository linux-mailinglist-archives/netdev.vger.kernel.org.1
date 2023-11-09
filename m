Return-Path: <netdev+bounces-46745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F707E626B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36537B20F63
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54953BA;
	Thu,  9 Nov 2023 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utRq5nKD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A0539D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90BB1C4339A;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699498231;
	bh=rypF52HZNINO8JSuFL2z3jgwZ/ipWy/ErtNiJAhuVZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=utRq5nKDq3IoXhxsAxigIXknhBv4WKsc2hjxDOVZKfKMq0B2V2H065KYk64ecefIF
	 VWm3UcV1NDkOphIMK8vc0fyf1uV317U1t+JHyDXpYbCy9n2MWpwtNBE588Q6prhQLY
	 5n3OaDpz1N6gdbGGxGSU60UeYpaxFR86cQnEhwUMb+Zo3CtSAy8BsW2yH9lARe51ud
	 o2bwV3HjShcPLxseeynklTtZAOBv1Y7shhr1aJK8NstGDLhy3AwyXE/CHHerntPtZ6
	 YL8tfUm/NelYQGHRUfk5Mhn+LsUZtE96hSAUu+xa+e8OfFDHtxmX9hClEw+dG0UYgJ
	 4QsmNUlq6w32w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E511C3274C;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V9 1/2] ptp: ptp_read should not release queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949823151.3016.8717702673323836042.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:50:31 +0000
References: <tencent_18747D76F1675A3C633772960237544AAA09@qq.com>
In-Reply-To: <tencent_18747D76F1675A3C633772960237544AAA09@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: richardcochran@gmail.com, davem@davemloft.net, habetsm.xilinx@gmail.com,
 jeremy@jcline.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 reibax@gmail.com, syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Nov 2023 16:00:40 +0800 you wrote:
> Firstly, queue is not the memory allocated in ptp_read;
> Secondly, other processes may block at ptp_read and wait for conditions to be
> met to perform read operations.
> 
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> [...]

Here is the summary with links:
  - [net,V9,1/2] ptp: ptp_read should not release queue
    https://git.kernel.org/netdev/net/c/b714ca2ccf6a
  - [net,V9,2/2] ptp: fix corrupted list in ptp_open
    https://git.kernel.org/netdev/net/c/1bea2c3e6df8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



