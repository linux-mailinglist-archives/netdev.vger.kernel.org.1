Return-Path: <netdev+bounces-36836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5547B1F72
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 47A0F282469
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CE3F4BC;
	Thu, 28 Sep 2023 14:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA838DF6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91E5C433C9;
	Thu, 28 Sep 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695911424;
	bh=RBs/98aNEPBKyZe+6xdz8cTv406TH+8Ve6nylO+STvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ae996TvB2SCWVs5UJsewEJiAf2Y61yyAxaPHQ4rUrBqjg6Pt5ilfpl0pNHaaaCU3r
	 aGRusI0BlPRWvFUI+5dE82skixwA9yh6IKl3QweZEZQydP//hqt2WHvyotuKf6YsUn
	 gC/WdT/GLy5KszE/Ngp3mHbvzNhToEL4IhXyv+XIcYAR034i63/0fnXn+UujFXVj/i
	 UpmpVrDELMfJQJCDklGDm6fiuvKhQzdjiuwKB6faUfLSKQSARlYN3talSceI+K1Mo0
	 ue/HhyiFnjDo5T8QsB2CI1Kpl/0aUyVSxs54DDL6jMvYc8xIy7hsGVDYcCjD6nIeuT
	 /auq1cxXj+2Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF6DDE29B00;
	Thu, 28 Sep 2023 14:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/2] pktgen: Automate flag enumeration for unknown
 flag handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169591142384.17211.5726031155414419334.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 14:30:23 +0000
References: <20230920125658.46978-1-liangchen.linux@gmail.com>
In-Reply-To: <20230920125658.46978-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bpoirier@nvidia.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 gregkh@linuxfoundation.org, keescook@chromium.org, Jason@zx2c4.com,
 djwong@kernel.org, jack@suse.cz, linyunsheng@huawei.com,
 ulf.hansson@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Sep 2023 20:56:57 +0800 you wrote:
> When specifying an unknown flag, it will print all available flags.
> Currently, these flags are provided as fixed strings, which requires
> manual updates when flags change. Replacing it with automated flag
> enumeration.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] pktgen: Automate flag enumeration for unknown flag handling
    https://git.kernel.org/netdev/net-next/c/057708a9ca59
  - [net-next,v5,2/2] pktgen: Introducing 'SHARED' flag for testing with non-shared skb
    https://git.kernel.org/netdev/net-next/c/7c7dd1d64910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



