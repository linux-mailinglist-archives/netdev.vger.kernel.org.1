Return-Path: <netdev+bounces-92060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5E8B53DC
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E321F220CB
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A691B809;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG1ZBpe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7AB12E7F;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381829; cv=none; b=pVbR6vfkvJaPtsHQ95vAaqj58wUnszsbShsMVXuDgza+VzAucFjGSolrkerdeax0WszT4ASObRbVFOa5YuQGVQBhbNN+ObS5GklanNCt5SK6nVu4HTwsfoFEdpdU4VO8XLFItoRmWah50A1Iy2gUA1Dh5K4nx2UYViJ/h6bFF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381829; c=relaxed/simple;
	bh=2ZOwBi1bLN1GydEEabiJFZtOvm/gOwFGlQjUadolQVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgz3TDF1buqmOgT4vnFlYibmrWOzBi4P/nTRsUb/Hmh31oP24w0Hfw0mVKBX4ryy3b70cUpLZM/4npZ9vJlFgFD25/1T+DFToAMFnyrRaVEIE3LGUS8Gcq8el1kK6YEsCND9TZvbDcCaDKuAvwsg8AWUdqsXWs6BUNYwn/DIpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG1ZBpe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C2B7C4AF18;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381829;
	bh=2ZOwBi1bLN1GydEEabiJFZtOvm/gOwFGlQjUadolQVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DG1ZBpe15l0dezW8vkiQl/ByqLuqylrRiSFvbQQhNSHfmvAofLzo2noJvr3dnSKSX
	 On27/D9J/zrUCIsB2xZSLs7dsT/wIf5D8w1uHKJ0M80baH+AA7L+n8Z6E4EsvY67Xi
	 /6fV2HvYV/sq8nCO3fsDobQ3+8K4vPpt4Hlr7U6+Ll0GxnPzn01fKzZbAGFl1MQ66q
	 cNuGoZmdbuZk+scuAqD6d7jKWpS99/gZWxUdSkoQHCZKv8KJHaWa6C6lLZh8jyogcU
	 fTGVtUIx6bxHp8MHdI6xKk/+dDt9EsVnMGJA7jH9SHe1TLuST3i8Ki59fDtC0AyL7N
	 O0jb8IpCBI4Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B923C43613;
	Mon, 29 Apr 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: qede: avoid overruling error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438182910.25540.13824156194602052978.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:10:29 +0000
References: <20240426091227.78060-1-ast@fiberby.net>
In-Reply-To: <20240426091227.78060-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, aelior@marvell.com,
 manishc@marvell.com, jiri@resnulli.us, pablo@netfilter.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 09:12:22 +0000 you wrote:
> This series fixes the qede driver, so that
> qede_parse_flow_attr() and it's subfunctions
> doesn't get their error codes overruled
> (ie. turning -EOPNOTSUPP into -EINVAL).
> 
> ---
> I have two more patches along the same lines,
> but they are not yet causing any issues,
> so I have them destined for net-next.
> (those are for qede_flow_spec_validate_unused()
> and qede_flow_parse_ports().)
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
    https://git.kernel.org/netdev/net/c/e25714466abd
  - [net,2/4] net: qede: use return from qede_parse_flow_attr() for flower
    https://git.kernel.org/netdev/net/c/fcee2065a178
  - [net,3/4] net: qede: use return from qede_parse_flow_attr() for flow_spec
    https://git.kernel.org/netdev/net/c/27b44414a34b
  - [net,4/4] net: qede: use return from qede_parse_actions()
    https://git.kernel.org/netdev/net/c/f26f719a36e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



