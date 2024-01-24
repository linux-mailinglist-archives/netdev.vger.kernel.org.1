Return-Path: <netdev+bounces-65288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05E839E5A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723EE1F2A729
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985F137B;
	Wed, 24 Jan 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY00+xXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5315A5
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060426; cv=none; b=NOLb2k7ryp1Iebtfn8N3MRymyktKFR8aLrzjm/1VeY0cxk8Hkc4UJh5wduaJYi9wIhbRxMqBhpVg27Hm98fgXuecQ9F2RoI2ZspLl3WBltjsBivT/8Hfdhw+XL6U/JryPF9w61HI7jJJvKGsBCC5rtgsuI72yiZII3r4+TW74UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060426; c=relaxed/simple;
	bh=GnF8eX5gfSgCNa1WA85iTyrdcD67LE9/VIDrsqeOo1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ae/+CgFk2wJTxlp5v+WV8V1rsVaCxm+RrmHzyxcl9CzyMmW2+dRJyeYMU7zPV7137AL94zm+E8myq6hB5CWO8cML0ugY4HXk23rnZWHHqlowoEU32pAqMYTE6mIfh3RC2zO/mMxS1EhHj94PaDAbFO34cUO0/DTNkAj2hpU+K3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY00+xXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45CC9C43390;
	Wed, 24 Jan 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706060426;
	bh=GnF8eX5gfSgCNa1WA85iTyrdcD67LE9/VIDrsqeOo1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DY00+xXhk+rENMNU0l1U6JDM8Ew7RFUPfqb1ZwH3E7Acnd879IzmliD2bsT17QyN/
	 dk0ArfduutW5iocrc7d1FT9GrYBL1DwzyUZwdYdOa1f8byYgJq3304n9ClTbIV2q8K
	 2lO14VPbc2hPunlbNMXFVLc2Xh+tdE1NcRiRMJNE1wObiYF2p9V5uuS0WvKiJyBoMh
	 Yl7SkfrZoh4BDpWMniVJz0HDKcUdBZf3JxCi/JbvmRxUgpVZsY2uDpZJG5gLx1K07m
	 c6uVfZtJUc2UrdWSy4gAnYvQW0oFx7fQ1ZoWw+3klBRBMy7LSPtmlBdHVd5o8HqZIz
	 dFs9bQd1grNbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 310D0DFF767;
	Wed, 24 Jan 2024 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: flower: Fix chain template offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170606042619.21423.2701759768654289445.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:40:26 +0000
References: <20240122132843.400854-1-idosch@nvidia.com>
In-Reply-To: <20240122132843.400854-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, vladbu@mellanox.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Jan 2024 15:28:43 +0200 you wrote:
> When a qdisc is deleted from a net device the stack instructs the
> underlying driver to remove its flow offload callback from the
> associated filter block using the 'FLOW_BLOCK_UNBIND' command. The stack
> then continues to replay the removal of the filters in the block for
> this driver by iterating over the chains in the block and invoking the
> 'reoffload' operation of the classifier being used. In turn, the
> classifier in its 'reoffload' operation prepares and emits a
> 'FLOW_CLS_DESTROY' command for each filter.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: flower: Fix chain template offload
    https://git.kernel.org/netdev/net/c/32f2a0afa95f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



