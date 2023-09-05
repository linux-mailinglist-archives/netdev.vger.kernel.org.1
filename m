Return-Path: <netdev+bounces-32009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEC97920FA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D921C208CA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589582117;
	Tue,  5 Sep 2023 08:23:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D81FA4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 134FBC433C9;
	Tue,  5 Sep 2023 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693902230;
	bh=lXgtoW/7ZdWLp7FupnW2/nPdUn4Mb393H1EvaAlnsTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SUUG93egXO/DO13piGEm1UfiUSBNgLW9xLH8XL50Un5yjkOG0XZfJEzUrFxeRv+Ad
	 5LYN0R8VFlFRc+VDGsFU4BBHcWK3MZ/vDa1+LDJ8sfoyWqx+3Ljv1s2xMFf+epM5Gr
	 9I+Txcr5KyysFjenjHXeXYwtzjBP/iuHoY7OvYBikaMZdsfuAZKPgGRr3D0jCMsk0m
	 A7mqQ23SpwnSG1jKZ7bjibXOZvdjoiuQTVnYbe4beFd5h6/v1Gu5ATaJAqcq6eUX3U
	 XgUl49oR7ydL4yF2tUsV5g52erS2v4qCgeZnD2WnaQHVeE4ErfumS/58lRjCjCYqDo
	 U1sl3Kxtk1YTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9AADC2BBF6;
	Tue,  5 Sep 2023 08:23:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kcm: Destroy mutex in kcm_exit_net()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169390222995.8228.1309168830800797310.git-patchwork-notify@kernel.org>
Date: Tue, 05 Sep 2023 08:23:49 +0000
References: <20230902170708.1727999-1-syoshida@redhat.com>
In-Reply-To: <20230902170708.1727999-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Sep 2023 02:07:08 +0900 you wrote:
> kcm_exit_net() should call mutex_destroy() on knet->mutex. This is especially
> needed if CONFIG_DEBUG_MUTEXES is enabled.
> 
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/kcm/kcmsock.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] kcm: Destroy mutex in kcm_exit_net()
    https://git.kernel.org/netdev/net/c/6ad40b36cd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



