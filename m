Return-Path: <netdev+bounces-102098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D9901668
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C384B20D01
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D744597A;
	Sun,  9 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMwaGkJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E87446D1
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945232; cv=none; b=Q0LXkN9SJHHS59o7cM4KGZ7V6KL53/qMrz+kwZfqOTBCbWP006Xten/G2dMI/fyHayqns8Ee4tN0P1P8OBuR10h3pswIIc8R5oTL/Dbz3pcYkOs+3mcGq8fx9Z8sFs2lFgL3WfIj3M51eEp9CtdmSaSLKl3CCle+JFtNDJN6gdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945232; c=relaxed/simple;
	bh=4ZAOmDV66cfz4q/IcjqPGOqPjQ7l8EN8IxGXzXeF87I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzZC6RnrECjySBWsbZhRNCg/iv9LKXhpUQ8ZQbWoMBmUNcSUi9XN3Nd3BUBZsWQfRYySl3MIiKK5bzH6sEQ0RUIJRUq/SH4imTjY9ipJp9RCQ4bpz2gOnuWCP9CW8fTxofRTeWHotKUe85nv8ky0XDo6wvUnGademWWc/QxF4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMwaGkJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A1D3C4AF52;
	Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717945231;
	bh=4ZAOmDV66cfz4q/IcjqPGOqPjQ7l8EN8IxGXzXeF87I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WMwaGkJFXu3sJulA6e6W5gfZSZaHyo5nTvOlVELFJJkW/Fq54xN11rN4vYTm87z2T
	 q0s4zfat0drN65302xkspuBaaSckNKb4qVg1wL1pJ+ffApuCiOr8W0oFP7CMOFZrzL
	 Zndyb0ME1hPSp9Xld9n+wbzzaxs8MwC/aFXGYcYxZxYGvaeyYbxtd5f2sJOF8nzgo9
	 NYtEkhQVrWOZEFs8zYqGjCc4Z27O0QqF78ZsRyZRdIWxsEpKsNNL/gMVPfTeNQMv5o
	 9niCASVfal/eJ86N9EUypdi3cK0J3CsihknRiVwPi6I4/1y69hogaHpyRQOwRmur7F
	 ppDMzsJoQvg3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EF85C41621;
	Sun,  9 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: make user space policies const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171794523158.27019.9221396665554895004.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jun 2024 15:00:31 +0000
References: <20240605171644.1638533-1-kuba@kernel.org>
In-Reply-To: <20240605171644.1638533-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dmm@meta.com, donald.hunter@gmail.com,
 nicolas.dichtel@6wind.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  5 Jun 2024 10:16:44 -0700 you wrote:
> Dan, who's working on C++ YNL, pointed out that the C code
> does not make policies const. Sprinkle some 'const's around.
> 
> Reported-by: Dan Melnic <dmm@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: nicolas.dichtel@6wind.com
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: make user space policies const
    https://git.kernel.org/netdev/net-next/c/924ee5317548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



