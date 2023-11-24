Return-Path: <netdev+bounces-50880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C294C7F7712
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8B51C2092A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1782DF7D;
	Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4B6+Mjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC1A5A3;
	Fri, 24 Nov 2023 15:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66F2C433D9;
	Fri, 24 Nov 2023 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700838026;
	bh=V+EF64XIiJz+6JrAd40V/n3zZjFbI/vKNPVT3Fd3Axs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q4B6+MjjQHGeFjASnhbIJcIKaiU+I8nNbvlGNzY5KrHcVvfk9kmERv9MmLXB/gfts
	 4I5aj6qbZ6bgY0O55v9KDI1S34/Yd0iBUWp2l1wI9H0CjdthwQWxOwqdRrdwVo75YJ
	 KNAdNThg8e7vQyDMq+X81tOKSgdC6jrM2KcDzQp+nThVhqcuwIYtQVThsB5/ezSrGE
	 Enq2dwePO8n0GL81uZvwgCSHgYRacKfMwJHs0W1iTpr/tkFiDHO4dSOX5ZDZwlRD78
	 +I7MANT6AJaPw7b5edCVxwVqdMUlwvmD0HbmzugmU79PdjAI1mKgZnbGmZZb91f2ZI
	 sCxYI4d+4UB3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8219E00087;
	Fri, 24 Nov 2023 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083802675.22904.16498084605139747713.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:00:26 +0000
References: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
In-Reply-To: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 09:23:39 +0800 you wrote:
> Added initialization use_ack to mptcp_parse_option().
> 
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - mptcp: fix uninit-value in mptcp_incoming_options
    https://git.kernel.org/netdev/net/c/237ff253f2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



