Return-Path: <netdev+bounces-84949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B1898C59
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B239288B7E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E021C697;
	Thu,  4 Apr 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm0Rf+ax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900918654
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248831; cv=none; b=ECckS7FhijcrYuFit9TKtaFZEHT4KEG5BBo63AcHceEzXTWuqh6t9BYghOZGoyg88cDMlKmF+/Zcz88hCgwoBEf6mAq87mh2VGpibqh8xDLU6zl8odXOwaBku96qJm3vzq5z6OhZLcXFg8bfFZ4laIYsDQZQJliuCN0BIf92mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248831; c=relaxed/simple;
	bh=1rmAEojuM047sjHg/ifB3TPYo5yb3OeNGCzL9M9ypRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jb4QbhJCzV2ib30Z/ghSfamUChWcxt1rHJb7dbPf/zq5urSgRbp5sOBbK7ROvEoXyZODDcft+kexciYM3CWvgqKw5tSgCUdpwg3SKdOYQxI/iZkK3XL+byKKfb5J2gmRERNmNPkN3ee5CQc9SZzJzs5rPWuetB0PJkcNgFDc4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm0Rf+ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC4FC43390;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248830;
	bh=1rmAEojuM047sjHg/ifB3TPYo5yb3OeNGCzL9M9ypRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nm0Rf+ax5ZYDvgF4cPIE23ZB8gnHjnIpRZVYE1ZoqYExHEA9KhcV00rRPneJslNGV
	 SDmd0VGk+aGXuCWbI/LwfUWziPtJOzLPsxeKZsEZrG+Tobtf5D691CjNtLIvFDTh33
	 aWDvX0O6e88yjPoE0YeHqKHZenEE4k1lF45cZV+cQ2jHMHDZZsptvb9d4sJdPD0+UR
	 jODT+rDg8ZyUXVlFNopamHh5680zy4oBFTtJ+NmwQbEYBZVbysdZOJgZ9033ESTHXp
	 eWgaEQFYlQPOn5Ews2Uo2h67gvbrAAtYWtWPf0NSYAs0iMyosZhHeWJct8jBlwa6Zl
	 FOj4CIquccK5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 800D4D9A150;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_skbmod: prevent kernel-infoleak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171224883051.6883.16026339785530412403.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:40:30 +0000
References: <20240403130908.93421-1-edumazet@google.com>
In-Reply-To: <20240403130908.93421-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 13:09:08 +0000 you wrote:
> syzbot found that tcf_skbmod_dump() was copying four bytes
> from kernel stack to user space [1].
> 
> The issue here is that 'struct tc_skbmod' has a four bytes hole.
> 
> We need to clear the structure before filling fields.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_skbmod: prevent kernel-infoleak
    https://git.kernel.org/netdev/net/c/d313eb8b7755

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



