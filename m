Return-Path: <netdev+bounces-14310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29CC74017D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774072810D0
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAF1373;
	Tue, 27 Jun 2023 16:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057613060
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89248C433CA;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884023;
	bh=qhrqoZJFyYeTAaz2UcFPn+tuC4Uk12bbLWZIw6uJLXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EQvvOvi+96/TuRH9LmV8Y1eNJvyjEYMhPLpj7laewCMm6GM8uAdqfdvwoCCZrpHLk
	 GYGf5ZGxhgfYW+KOEEc2/8THrJG9UMidHdommOF9qgIFHhhLhnfWZ7wh81uzu+2W0v
	 Sh2VSNtQYMvlsLtNlUKXuTuUUnex+CCx8JWqX59XC1tXBmPxiF5mvA6kBr3KC6NJpf
	 6U0kZjLJnMGFettylShCCnz5l0V1+dRXnVooV0V5uzQyu329seMXlDkjOH4YsNKuN6
	 teWvGrbTtcJjjiLbiUvKCZ+a55BYIVBYFtHjRJ1KJYFNis6IwGRUiX0/g+vIdv9+cp
	 oN6PhlkjjHbBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E6D3E53800;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to support
 MSG_SPLICE_PAGES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788402344.21860.17593461290392483933.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:40:23 +0000
References: <3199652.1687873788@warthog.procyon.org.uk>
In-Reply-To: <3199652.1687873788@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: idryomov@gmail.com, netdev@vger.kernel.org, xiubli@redhat.com,
 jlayton@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 14:49:48 +0100 you wrote:
> Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
> checking of the source pages (which might have come from a DIO write by
> userspace) by partially reverting the changes to support MSG_SPLICE_PAGES
> and doing things a little differently.  In messenger_v1:
> 
>  (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to use
>      that.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] libceph: Partially revert changes to support MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/5da4d7b8e6df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



