Return-Path: <netdev+bounces-23460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85476C050
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5171C210EF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A21275D1;
	Tue,  1 Aug 2023 22:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F724DC94
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D38EC433CA;
	Tue,  1 Aug 2023 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690928421;
	bh=gvrHANUhyG5qfJqmhlNSzZ4lRv6L05JbiYxsWgvbkvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLMuH5IqNcHlZTt2G+XJqSxPns1J3f+bKSrOYOSRDela7Beso+KynY199NcomK1jz
	 bOjrl2Z0bVOt75Mj+VH+jPdTl51VoC6doROTbo4jz9gz8sb9YWQUG6IdQG0cspat8i
	 E8RWHMepJoioMduZyuaQTTrWcKB3uhEjQc8ZqdGCwpTAMKu9FydIHmKdmpsgd3w8we
	 q3zSlJJvczO+Qj0zbD0kaohsWcBb1ZwEVzlXxgTxyvLo8gRyknTb8keduSs3UgZ0jj
	 EdzU0JjEEUgf2pYzjJjlybJsnh40sSWdT5UbnpnRDyVZ0/N8+lDp883hDCZfKhWI5O
	 5hhioz93WfptQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4344BC691E4;
	Tue,  1 Aug 2023 22:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet6: Remove unused function declaration
 udpv6_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092842127.23766.3395318483569328627.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:20:21 +0000
References: <20230731140437.37056-1-yuehaibing@huawei.com>
In-Reply-To: <20230731140437.37056-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 22:04:37 +0800 you wrote:
> This is never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/transp_v6.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] inet6: Remove unused function declaration udpv6_connect()
    https://git.kernel.org/netdev/net-next/c/999d0863ff64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



