Return-Path: <netdev+bounces-29584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A470783E4C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC5C1C20A85
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EF9447;
	Tue, 22 Aug 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38528479
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DC2AC433C9;
	Tue, 22 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692701422;
	bh=CH4qI6lnmD8k/tSVu+AnqbRi0a34eJdMTltkb/mszUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i4N/ZSZk6ryQekpxHYWZ6dph6GenS542CIK3x/0WkX7n5vw9MgjzMaq5Ovx7bDQ+a
	 Vwhz305q7nFkc4Mrfnk7BDg31qlu8kc6mGiV43HiUapHeVrnwmjCpJfaSiAVD8V+TN
	 hWNHGkzd76x+B8GceNwzBzseRB41tAm8hJ0Ekh32vcZPezzBieWgdeBYYCXxGw0Epr
	 tZFmt878V5+NaDQxcOz7wzpKO2dBZXdLaVIgmE7sP2A12TJBrT1HZW5Sxs3Rp3srwo
	 BDrSBnBfVKlen6g43YQ1ib4qR88GgBuopSEsSJU8/qlQa1dKg/xjS38CoHV7X6yzdC
	 /rplZtS+bW7WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4265EE21ECD;
	Tue, 22 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] alx: fix OOB-read compiler warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169270142226.5727.3369298753541384409.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 10:50:22 +0000
References: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
To: GONG@codeaurora.org, Ruiqi <gongruiqi@huaweicloud.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org,
 gustavoars@kernel.org, gongruiqi1@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Aug 2023 09:32:18 +0800 you wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> The following message shows up when compiling with W=1:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
> ./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] alx: fix OOB-read compiler warning
    https://git.kernel.org/netdev/net-next/c/3a198c95c95d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



