Return-Path: <netdev+bounces-54251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D78065D9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032891F2169C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE8D524;
	Wed,  6 Dec 2023 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjbrmU/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F9DDA6
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A8CC433C9;
	Wed,  6 Dec 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701834623;
	bh=XyQIABCNi5zpRVstxuXOFJ+WV83AbjHAvJa3U9iW7QE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fjbrmU/1FaZ/D2I8gDXv/NiU/+DM6VuxFi/YiAmceHGX2ljpmtYyZ8J8UY+eeyDUG
	 OEv6Nhvpk7VeESnZd3/DbZzWE9QMzJLYJr5ojGzzVS1i6j+ckYJDzN90L+Oi9kTdix
	 l+kRHX8EShwl9u03DLWANFW+0VdjLuO7ouRD1F4SvVmJ+b1Jz4MUp8PjNO2lUACLvI
	 K83dCdEuNVBImY21ulqI6IUdc5Ri7YWpxFoHFRacEI+kKBdbye0ZbZm3h6oA5b3agf
	 g5R+esy3tkqu1W8pTBJOT2gJUzc4ftNwr51eAxh36lZW5BPmnao6QRg5sd8cWca7CE
	 xs2aA694oIFZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B493C41671;
	Wed,  6 Dec 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bnxt: fix a potential use-after-free in bnxt_init_tc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183462343.27566.10798748391554489332.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 03:50:23 +0000
References: <20231204024004.8245-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231204024004.8245-1-dinghao.liu@zju.edu.cn>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sriharsha.basavapatna@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 10:40:04 +0800 you wrote:
> When flow_indr_dev_register() fails, bnxt_init_tc will free
> bp->tc_info through kfree(). However, the caller function
> bnxt_init_one() will ignore this failure and call
> bnxt_shutdown_tc() on failure of bnxt_dl_register(), where
> a use-after-free happens. Fix this issue by setting
> bp->tc_info to NULL after kfree().
> 
> [...]

Here is the summary with links:
  - net: bnxt: fix a potential use-after-free in bnxt_init_tc
    https://git.kernel.org/netdev/net/c/d007caaaf052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



