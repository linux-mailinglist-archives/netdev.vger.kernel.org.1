Return-Path: <netdev+bounces-44111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDC7D6513
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBB4281941
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF5748C;
	Wed, 25 Oct 2023 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snQUTp10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F891CF8B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 657C2C433C8;
	Wed, 25 Oct 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698222627;
	bh=KhKMCCb4QBZPaGwVmy7RtOb486ioereUy6ga837nVik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=snQUTp10aZphyIsvSkmlpRgEcZpt9XkXiZ+gQoUmc9l+nDd6gIzSR56XQZGaXsoYS
	 QPHu113j7HRjP/qJPiQKM/xgiuGGJcv2kKAPAtA0cuOj+6NcDUt7S1DU8VeXZHZGpM
	 hpRtb420d05mqn6QPt6PyrjM+IJOLGTx/v9OuZyXECvqYx1wvPTm13U1Su6WKGJlXb
	 6UEOPXFqWMNwJi65ZO7+v2d9yA0cS1PN9CuBr6bl0NPDRG0DNnDlopXuw3KadeehPk
	 lbMRZlw3yAbBVie+HFwj3DqmzPHpRSuxlvpGHkdMY1UFEBlwl3777EEyu6ke5dpEpq
	 uJiyjvrMSOdnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5024CE11F55;
	Wed, 25 Oct 2023 08:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: hns3: add some link modes for hisilicon
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169822262732.22461.9007651558470445369.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 08:30:27 +0000
References: <20231024032034.417509-1-shaojijie@huawei.com>
In-Reply-To: <20231024032034.417509-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, shenjian15@huawei.com, wangjie125@huawei.com,
 liuyonglong@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 11:20:34 +0800 you wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add HCLGE_SUPPORT_50G_R1_BIT and HCLGE_SUPPORT_100G_R2_BIT two
> capability bits and Corresponding link modes.
> 
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: hns3: add some link modes for hisilicon device
    https://git.kernel.org/netdev/net-next/c/8ee2843f4d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



