Return-Path: <netdev+bounces-57199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D7812559
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113791F21A67
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D29FA4F;
	Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfUdeNx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48139803
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7F58C433CC;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521626;
	bh=fcmVYsAFPbN+vFBSLQZk+/wH+VgdVHaVWHJ4heWgIwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfUdeNx6h9JCx0puAY6h3TOZfTtZckU6Byd4O/qae+R7gYXV2KReBQW/LQpaDvjNg
	 5OPOn5lcqZ57h/Bq021C8E0FxNFjd0ZqcdECQtrL64/UmgMuDyJfBJSAWGIJ2lNgbG
	 3CqJ4r5Bs2eU0yupHekB2Y08m0IQ7sUq83pCLY+tWsr1B21DFKofPE5jj7C7Q2mbos
	 nYbi7PDPMtG10nE54ZYuOgXf92PRD7YgVwiZ28WPNNRF57Pv8AR6Wk2DzlH0Heujp/
	 ASvzAgiaqg3HtGEY8qqI32LZ+mOWwYycZLuzW1rPkto3/y7ltDx+XP28pqTDquO7nU
	 Jqz0ApsEHqqaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9ACBDD4F06;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252162582.2494.4618960892199478913.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212145550.3872051-1-edumazet@google.com>
In-Reply-To: <20231212145550.3872051-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 14:55:50 +0000 you wrote:
> For some reason sctp_poll() generates EPOLLERR if sk->sk_error_queue
> is not empty but recvmsg() can not drain the error queue yet.
> 
> This is needed to better support timestamping.
> 
> I had to export inet_recv_error(), since sctp
> can be compiled as a module.
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
    https://git.kernel.org/netdev/net-next/c/4746b36b1abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



