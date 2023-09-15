Return-Path: <netdev+bounces-34006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7487A1648
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACB71C20C9B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267F611F;
	Fri, 15 Sep 2023 06:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD96119
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 113CDC433C9;
	Fri, 15 Sep 2023 06:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694760027;
	bh=AKtSZuhG68YUzjrrS6Z1ZvHc8FlliGSLNhxkbIGDhZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KnBkuSJouB7llWw7CoAx4mbz/v81c33IYMDJgZ1ATQuLBOJtYGTcHYBNALxy5tK1L
	 SExDZFDQI5hWQan6GCEsyLWHgLbtaBh6IFK8tFXkbusLVNZFGq+IUg9doWItLtb1Qa
	 uaVGo4Zq5+Y1RdAuw8W/I7hOyAfF3FOD93AVcDNAlNkkO3a74IRQZFE4u3NrPwqgRn
	 toE5c3WEs3SljP+ObZNBOyh0cZdiDVTN5Xq6AYbQjF/fujYe5+HMXeSKFUTa0OBwUg
	 GAyTXMjfPoFpbK4u1SDlYNn449nOqMYdBG26HGzeOHEs42ZhCWj69EY6/NjpuQt5fs
	 jt7PyZGWt3vUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E941FE22AEE;
	Fri, 15 Sep 2023 06:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/5] net: microchip: sparx5: Fix some memory leaks in
 vcap_api_kunit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169476002694.380.1388330794320058224.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 06:40:26 +0000
References: <20230912110310.1540474-1-ruanjinjie@huawei.com>
In-Reply-To: <20230912110310.1540474-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 19:03:05 +0800 you wrote:
> There are some memory leaks in vcap_api_kunit, this patchset
> fixes them.
> 
> Changes in v3:
> - Fix the typo in patch 3, from "export" to "vcap enabled port".
> - Fix the typo in patch 4, from "vcap_dup_rule" to "vcap_alloc_rule".
> 
> [...]

Here is the summary with links:
  - [net,v3,1/5] net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_keyvalue_test()
    https://git.kernel.org/netdev/net/c/f037fc9905ff
  - [net,v3,2/5] net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_actionvalue_test()
    https://git.kernel.org/netdev/net/c/39d0ccc18531
  - [net,v3,3/5] net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()
    https://git.kernel.org/netdev/net/c/89e3af027738
  - [net,v3,4/5] net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()
    https://git.kernel.org/netdev/net/c/20146fa73ab8
  - [net,v3,5/5] net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
    https://git.kernel.org/netdev/net/c/2a2dffd911d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



