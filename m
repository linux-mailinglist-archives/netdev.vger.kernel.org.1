Return-Path: <netdev+bounces-26542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C07780BB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF67281FFB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6092150E;
	Thu, 10 Aug 2023 18:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72D62A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A436C433CA;
	Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691693422;
	bh=83pI7ohsf9XQ96NY9vRh0auNjVEOrdk1c9s0zdDol+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l3ahX9KgKthfG7/mhbLFtUet5Thg/nytPpir8Y6ONdcI3tFlLpV8Cr7VNAzg3Kg29
	 FArdryOyCvw/izI8LPB9h1arKjkRZcVMY1iZX+hz/0H1B7ypayHraFUp0WLnHBLE8h
	 IGCghtFT2ydeyVi+T7oYvxEUeeewXcZAAcpWX5hr6nzwJHtbLD8lyNDdZA+3EBVXcf
	 BvTQi3zwpQFUuf0DDi4aW5Sxk05ZyubPGLIHnBSElZKKLVuYTCbRoqt/r5jHsjSY+L
	 vuHVitmNRn+1Gdm48f2WM7AMq+OHpsolPiP8EKMD6OD/NAXWbYLdg7wKqOdStmGIcY
	 3OsrXTtzGH+hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF37C64459;
	Thu, 10 Aug 2023 18:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169169342191.7825.8966149905125404687.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 18:50:21 +0000
References: <20230809020902.1941471-1-shaojijie@huawei.com>
In-Reply-To: <20230809020902.1941471-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 10:09:02 +0800 you wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> items to a string for content, and we add '\n' and '\0' in the last
> two bytes of content.
> 
> strscpy() will add '\0' in the last byte of destination buffer(one of
> items), it result in finishing content print ahead of schedule and some
> dump content truncation.
> 
> [...]

Here is the summary with links:
  - [net] net: hns3: fix strscpy causing content truncation issue
    https://git.kernel.org/netdev/net/c/5e3d20617b05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



