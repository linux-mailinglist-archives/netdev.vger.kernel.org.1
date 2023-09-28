Return-Path: <netdev+bounces-36733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AF7B182C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 22C911C208B0
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8C2E656;
	Thu, 28 Sep 2023 10:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B023418E
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30361C433C9;
	Thu, 28 Sep 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695896425;
	bh=1Fx/lpeAsDZXfWVv9FZEZCoKvSS5OX8M+5Pu3qaE6Kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EMQRkxLE1Ha5DjqSg7GWCFM0sVdLYjEYn7ie4MBw8lXoO1BC4i3Sces9isPMA0sgH
	 ZuVuJb8rSeMXgMtqnU5/9u6UI8IV7ioNZx7n5pHGFW8BJPeVX4uzuTwqDqwRtaiI6n
	 Hyi1zRuRyhUTg+CMLggF6Tl07pd/2RQoJniykwilnNmDaCUsHz1FqQvMZo+zpGkEz6
	 PP7I3r3Y2oY1NBDvZecUdBmPbGtq2eHWppqSSbQpNJmXASIlSM8Ue7R95RjwJ8gJmK
	 qXmbISEh12uTyXDoJZazOaAlkufjyBGyNDIpKEN0pBbakGqfqbz6KHk8JmVKhjhaCM
	 LQysQKcXxhXGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19022E29B00;
	Thu, 28 Sep 2023 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethernet/intel: Use list_for_each_entry() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169589642509.32188.11314004773369005865.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 10:20:25 +0000
References: <20230919170409.1581074-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230919170409.1581074-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ruanjinjie@huawei.com,
 jacob.e.keller@intel.com, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 10:04:09 -0700 you wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Convert list_for_each() to list_for_each_entry() where applicable.
> 
> No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ethernet/intel: Use list_for_each_entry() helper
    https://git.kernel.org/netdev/net-next/c/c1fec890458a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



