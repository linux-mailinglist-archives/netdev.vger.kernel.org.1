Return-Path: <netdev+bounces-24597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB10770C04
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CA728279B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD6263BC;
	Fri,  4 Aug 2023 22:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B207C13F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A76C433CA;
	Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188824;
	bh=mxsKvA9/7heqPYL8fnfzZYkEEMp9SezTt+GufC6mYOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iCGmBHWHmlVLc+M7fxYxNuGg3oWGUi0tN3+eCO1T6AdnIXObuLYSoOQ8tT4g9yR/u
	 k5YU96rRRlVS6Q/H72WFWOo5fM7r6RwMDsPn9ND0W2pPsAxabP6FQ2uvWXQ2t87I+F
	 l7YhLAt07n9Bt8p6WvUrThOHH+0s4E8B58JaNOeQybSwQe2T3auJ7M60MlC4/vFtYS
	 529SrNhDtW3WPE9UIrtU5cvNJfkC1tEilGmZ0INwenTXZPiwQoAjz4w4SrfTWLfJ4O
	 WwBeUUWG06aeFZ+7oevpHg/+swzPSE+/tym8zKymA0vSKirZ5BIAsxmxRqDyL4oh5H
	 yLKcLcvh+5waA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E37B1C691EF;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns3: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882392.4114.12261365568934089190.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:23 +0000
References: <20230803135138.37456-1-yuehaibing@huawei.com>
In-Reply-To: <20230803135138.37456-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lanhao@huawei.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 21:51:38 +0800 you wrote:
> Commit 1e6e76101fd9 ("net: hns3: configure promisc mode for VF asynchronously")
> left behind hclge_inform_vf_promisc_info() declaration.
> And commit 68c0a5c70614 ("net: hns3: Add HNS3 IMP(Integrated Mgmt Proc) Cmd Interface Support")
> declared but never implemented hclge_cmd_mdio_write() and hclge_cmd_mdio_read().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: hns3: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/faa9039161ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



