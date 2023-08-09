Return-Path: <netdev+bounces-26095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EF776C89
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BDF1C2142A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A281E507;
	Wed,  9 Aug 2023 23:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8A1DDF9;
	Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438B3C43395;
	Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691622024;
	bh=SC28URfATJ/48zq55kLBaKJ4jexX3dzrTDKzwwnOLDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9rlgpJDHEMDOmZlpYkXRFJmV7mD4fSfy0yuGEem6gd3BThUduO4h+QFOdNB6ec4c
	 EohIwyW6oQ7Ox0Kk8Rge6Hdm1VH60dy1hmV51xivlK36zquJmbjyqxX8ngTV5SNFWr
	 efVZsgZG3S50EBhKkX9FiuZVt1QY8ZIlRINgbmIvjUJ4f+NveJlEJcbJZWV1uzjw2Z
	 GY206shRvfwsAHs4dPG9Ir31jWTCx7YTx+NHcSp6GbmH9a2mTo9Pbt52a/NlaHDq8Y
	 NTIXvT/YjLq3Pk2vTloVaCTBuyQeFaiBfLNzEy1of0LfMdmve1zxqNphhFH/IRINNJ
	 WdJ8kcNHD9gCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24041E33093;
	Wed,  9 Aug 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/llc/llc_conn.c: fix 4 instances of
 -Wmissing-variable-declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162202414.2325.16732635656228825555.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 23:00:24 +0000
References: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
In-Reply-To: <20230808-llc_static-v1-1-c140c4c297e4@google.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nathan@kernel.org, trix@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Aug 2023 09:43:09 -0700 you wrote:
> I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> bot spotted the following instances:
> 
>   net/llc/llc_conn.c:44:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_ack_timeout'
>   [-Wmissing-variable-declarations]
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:44:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   44 | int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:45:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_p_timeout'
>   [-Wmissing-variable-declarations]
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:45:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   45 | int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:46:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_rej_timeout'
>   [-Wmissing-variable-declarations]
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:46:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   46 | int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
>      | ^
>   net/llc/llc_conn.c:47:5: warning: no previous extern declaration for
>   non-static variable 'sysctl_llc2_busy_timeout'
>   [-Wmissing-variable-declarations]
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      |     ^
>   net/llc/llc_conn.c:47:1: note: declare 'static' if the variable is not
>   intended to be used outside of this translation unit
>   47 | int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
>      | ^
> 
> [...]

Here is the summary with links:
  - net/llc/llc_conn.c: fix 4 instances of -Wmissing-variable-declarations
    https://git.kernel.org/netdev/net-next/c/fa1891aeb762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



