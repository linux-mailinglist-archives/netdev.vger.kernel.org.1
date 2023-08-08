Return-Path: <netdev+bounces-25592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AAA774DE2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75202813EA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04811BB21;
	Tue,  8 Aug 2023 22:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAD18007
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E0A3C433D9;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532022;
	bh=8YuuElbFwVlpduRXxYXvgNc6H3UQeAUu2HC/SZZwh4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XbaSIomfIhRup/KQc8pMzNMimKjUbow5eH+febLDSdUuXimO2o5qLrh9jDvYE/9gK
	 KUL/zJ1OVqYFlNy5jmGjkdYQp5blb45psNtfw10/IqhJ77Y8/6nla6O2dbWQ7kHq+e
	 0TIVAB5tHoh8BPgWBtYjVaGh+brja29z32i7oWNlZhZg7ZqBnE4CkOm+Co5MyBYGfh
	 8AlxCosNYDvAIHnNLkqvVNYL8xWe/xNMjZOUyKu7P9Cc7cN8S1SkyLjrO7U82y4Y0k
	 4rWVsBGsjKcSaQnrysEvxK1dKy53u10yw0u53ltbiUXuwzJ7fJ0KwkvmURsny7Wrc5
	 Ac+3f3SolTn8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86C30C64459;
	Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ixgbe: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153202254.6931.1809745921138635353.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:00:22 +0000
References: <20230804125203.30924-1-yuehaibing@huawei.com>
In-Reply-To: <20230804125203.30924-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@veobot.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 20:52:03 +0800 you wrote:
> Commit dc166e22ede5 ("ixgbe: DCB remove ixgbe_fcoe_getapp routine")
> leave ixgbe_fcoe_getapp() unused.
> Commit ffed21bcee7a ("ixgbe: Don't bother clearing buffer memory for descriptor rings")
> leave ixgbe_unmap_and_free_tx_resource() declaration unused.
> And commit 3b3bf3b92b31 ("ixgbe: remove unused fcoe.tc field and fcoe_setapp()")
> removed the ixgbe_fcoe_setapp() implementation.
> 
> [...]

Here is the summary with links:
  - [net-next] ixgbe: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/ac0955f0ccb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



