Return-Path: <netdev+bounces-24598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C31770C06
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F712827C7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983426B03;
	Fri,  4 Aug 2023 22:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1089253A2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB41BC43397;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188824;
	bh=evxm0groU6hWtBA+U5OubSlnQW/H8Sr7BBorrpcJ97w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GDy+fLUdswiRvWUByp/1FEewsj3Jp9Ao30B6rVafEKFjExPLbktezzWz2Fnk2zFla
	 6y+6WnL7I8FqxD0/AkoElIctDvC5SOddmv40koVJjn9MxfdEjHLwVcOzSMbl7i6cq3
	 a2iPBNWqe3w/2Cz0yVZCLFosN5BtnHZQGWITnBQPwR4v6EP+pJGptLzGhiwlYx3sC0
	 Bt/o8plimVFNcZxYKUjm80igebXxjw1ynXrFzbPZeb8x8s5Kv9mHKZL8rOMC2NyL4I
	 bd2cc6SedMn6r2UHHndCsslQTs92zWlldrX+6XfsvTmo0VCsfI8PEIgQkkyU8yPSc2
	 xvr5A1PLxeP2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0476C64458;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: llc: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882384.4114.10170437589941606899.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:23 +0000
References: <20230803134747.41512-1-yuehaibing@huawei.com>
In-Reply-To: <20230803134747.41512-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 21:47:47 +0800 you wrote:
> llc_conn_ac_send_i_rsp_as_ack() and llc_conn_ev_sendack_tmr_exp()
> are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/llc_c_ac.h | 1 -
>  include/net/llc_c_ev.h | 1 -
>  2 files changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: llc: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/57ecc157b68e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



