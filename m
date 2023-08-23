Return-Path: <netdev+bounces-29828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF26784DD1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A728120C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787E136D;
	Wed, 23 Aug 2023 00:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD09477
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B149CC433CB;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750624;
	bh=CoLz3mD8z3EEnrbY+VFjJFD64qCW/Afi2VmVdewI4/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFktCEzctW4y2wlIHFFSLqgvs8nF6H4/MQ0qiQbUQJQaBffabN1Q0a8OIZ7KGWKKo
	 RDWWy/buROKpjv0mRDtiCE4Rs9znIT46WTR3DzwjKMWKvcEjnWqu9yvjOT2fmMcGzn
	 BkchH9KiP4aQhRy2XBra5KLNT79lMLo/6g9L4swtYCCqj8sQPDcYAITtcip/Sia9C6
	 qKCwiDHNOR9/tnQFbNsBtv0M2Jk0qJ5KMCbFk0A1Yuh+NgkZX89MAbF7eRy5KhJupb
	 jnWF+F46LHMnODf2egESvoD1Ok8SDelwkRR8kM1jCNjhDZX2WDzBUNgqcoe4IGXeSO
	 sHQ1LkO2moqZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96E97E21ED3;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275062461.22438.15672454677210639225.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
In-Reply-To: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:48:48 +0200 you wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
> [...]

Here is the summary with links:
  - [net] batman-adv: Hold rtnl lock during MTU update via netlink
    https://git.kernel.org/netdev/net/c/987aae75fc10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



