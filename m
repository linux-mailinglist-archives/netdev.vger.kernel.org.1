Return-Path: <netdev+bounces-25593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7B774DE3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B271C21076
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D251BB49;
	Tue,  8 Aug 2023 22:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1A17FF3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93BCCC433C8;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532022;
	bh=/ectyVaXd9Zis7G/opRD/OZEU4xVFxCrxvK+dcca9K4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hKcYuR6iuskB/rAYjPA6l3fgF3f+BjYY6ckcEg+oAsfaFhmHeMJTLVH7viogcBQvU
	 cQZ4Rj/+b8/Bcjp8A7bXprcZHdy8C3BRE4dvH4oAp+VTmqeM9MPL8c4I+Hj2m5lwEi
	 dmvsHAd7FBKu9YYMCNW2sqVt7awYxSzXR7Cku9zrhiwCXQ35wYt3q0D2jwAV8hwuVW
	 fuh+rRZO1T/y/ZQ6zBHL+53lTUYjgx29sUzyQ7HdSHlWvmJo/OSfHC2Q2IVt6VQW3B
	 PuQElRescXWKziFaD75pdlJGrFJNFVOQ4ug6xHzwMbbKjUnQcDrkYP2gGQnsrhLImM
	 Oda7mXNjNdjsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D8AEE270C1;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] i40e: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153202250.6931.1664624518645907875.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:00:22 +0000
References: <20230804125525.20244-1-yuehaibing@huawei.com>
In-Reply-To: <20230804125525.20244-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jan.sokolowski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 20:55:25 +0800 you wrote:
> Commit f62b5060d670 ("i40e: fix mac address checking") left behind
> i40e_validate_mac_addr() declaration.
> Also the other declarations are declared but never implemented in
> commit 56a62fc86895 ("i40e: init code and hardware support").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] i40e: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2359fd0b8b1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



