Return-Path: <netdev+bounces-31683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252F78F890
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697931C20BA1
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A581FA2;
	Fri,  1 Sep 2023 06:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E4946B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF840C433CA;
	Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693549825;
	bh=9qjZVeqjy8hpxcG9RxQsQ/fVBfG5fWXQxyyLRdn6/eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6ov+WaTkdPnr/AsCXzqx5opI6D9E7TGYIibTVhigbp8ig7c3yH1okzd5wbHnjA0a
	 n0UOqPSsYGbmerv2atBYHbqN8Of5e7OoWV06L9CldUd/ev3ZPO9HONqapqB6DLeL0u
	 4X6jxK4GNwJrSJICDmuCsvGmxzW1SVx365Q0VbQcaLKEFIqkg7coUQNGvWLPa8KW41
	 MyVfnn+mIfIEeE53MTShACei3Kmv1jt3F95sgTimTRh7l4VaHzGO0lcGPY+bBeIRXR
	 Q+rDIFDKkTgSQYtzCMC4If0MdWi5PysoMD9lVfsUsfyrZGvjM9rdNTEy+3zVOFDWF9
	 Sz1t+z4ua1aGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95608C64457;
	Fri,  1 Sep 2023 06:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/handshake: fix null-ptr-deref in
 handshake_nl_done_doit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169354982560.31046.16261510126804963761.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 06:30:25 +0000
References: <20230831084509.1857341-1-edumazet@google.com>
In-Reply-To: <20230831084509.1857341-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 08:45:09 +0000 you wrote:
> We should not call trace_handshake_cmd_done_err() if socket lookup has failed.
> 
> Also we should call trace_handshake_cmd_done_err() before releasing the file,
> otherwise dereferencing sock->sk can return garbage.
> 
> This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local variable")
> 
> [...]

Here is the summary with links:
  - [v2,net] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
    https://git.kernel.org/netdev/net/c/82ba0ff7bf04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



