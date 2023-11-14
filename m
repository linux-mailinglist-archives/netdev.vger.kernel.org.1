Return-Path: <netdev+bounces-47644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7867EADA9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9B31F22643
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAAB18652;
	Tue, 14 Nov 2023 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuB+0l0s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1601863F
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F230BC433C9;
	Tue, 14 Nov 2023 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699956623;
	bh=OaJc768p/TfNTHeRrgysLojXYfuqN+drG0p5UWrxU2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nuB+0l0sDMogYhXFl41leVaGbIwl90MCwokJRm7+lIoZPCsQOOth0eWsFiilYafKP
	 w6TahPW7WfCNqK9KjrGwFQ793uT8+PBX9SHwgHiLvdvGsugA+34LA2nffENCTSDYms
	 p5d9BhyNQEKOe2Pt0P/9kx48BIQg+FvOTml60NuYH1OzfIMK52mW/pOj0+qLag5AAX
	 QvY//wxBMCFxWzboIc8K/H67a1RRHPSpRzqSMt1NcORXyUngst7H89OJTJ0p8o+iFh
	 s8XwP6aZddeWTqO5CxkQZ9u1WZBck9vgWxerPtkuAV6ALaSIFmIXdVr/C9v1lgg/LQ
	 x5OoNfMGwajcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAFAAE1F676;
	Tue, 14 Nov 2023 10:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_unix: fix use-after-free in unix_stream_read_actor()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169995662289.4194.12253465317532052618.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 10:10:22 +0000
References: <20231113134938.168151-1-edumazet@google.com>
In-Reply-To: <20231113134938.168151-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7a2d546fa43e49315ed3@syzkaller.appspotmail.com, rao.shoaib@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Nov 2023 13:49:38 +0000 you wrote:
> syzbot reported the following crash [1]
> 
> After releasing unix socket lock, u->oob_skb can be changed
> by another thread. We must temporarily increase skb refcount
> to make sure this other thread will not free the skb under us.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net] af_unix: fix use-after-free in unix_stream_read_actor()
    https://git.kernel.org/netdev/net/c/4b7b492615cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



