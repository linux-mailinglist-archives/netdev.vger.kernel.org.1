Return-Path: <netdev+bounces-228650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63576BD0CEF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 054474E2628
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF62032D;
	Sun, 12 Oct 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4kMghQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269E3C2F;
	Sun, 12 Oct 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760306420; cv=none; b=YABaYyDJo0OKITVFBvUnHAs47evd9CfBgaBIEDTebDmpgGvhEPr/zIl+AfWikN2tGUS1p6XUb/YlSPjU+NANgeffbieZdkOwHzMZL5KLB+Ja5hQbpwEiw9sReqeaPK5w+0PZlUDB/ea080NTuRaW6Ps/Dr1YZD0nCLuyY9AR+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760306420; c=relaxed/simple;
	bh=MEt37s10fc0acs6bkYsfOAKQzMq+imWU1mojesdNlfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ux4jhYTK1jyQigwixjfhOn6Zpo9QjVM8VLxGxU+naMpOUgfiGM6q+CcdYfOLsyD2MpdfqsYQmHxSwzKA4ZSC9QhdKh1ApBeBenB8JielkfNal8KQpdfEvrxutJ30HDLauqNP9XpfEPMkg+TG05jAya5bzcerBfPD0VPPDE5SPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4kMghQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA31CC4CEE7;
	Sun, 12 Oct 2025 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760306420;
	bh=MEt37s10fc0acs6bkYsfOAKQzMq+imWU1mojesdNlfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4kMghQEmDu2UgOvCHHoCp/ReCaPofo2ZVbn4HmlgRl6TkQnS0WsCCWwmKG/kH5Tz
	 jtokNIhAmGQc9v72hBbtdXvtKkr3kjQxUluytOG6lpwsa0YItj2e4/g8zn8t50Kn2N
	 7Q63ljYgxTNXPb7FG020/HUq8riZ66sxn+6iehCP+BaUhJkEYX8CUnRpMpI3oexBji
	 MhegAKzlajpO7vNpM0RH6j7ZxGZWzMekVaBWVuzPQQJudf9zO5cUDm5mT3HYtvQKdH
	 qqZD6wV4qbtC9au8qKafTF/D2E3unkQEhDSGv97Mqe+dxXTUPk8RQXqpan3shQnuFy
	 FPw0RdrpYy2ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F253809A22;
	Sun, 12 Oct 2025 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] doc: fix seg6_flowlabel path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176030640626.2146012.58643743912095856.git-patchwork-notify@kernel.org>
Date: Sun, 12 Oct 2025 22:00:06 +0000
References: <20251010141859.3743353-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20251010141859.3743353-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, philippe.guibert@6wind.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Oct 2025 16:18:59 +0200 you wrote:
> This sysctl is not per interface; it's global per netns.
> 
> Fixes: 292ecd9f5a94 ("doc: move seg6_flowlabel to seg6-sysctl.rst")
> Reported-by: Philippe Guibert <philippe.guibert@6wind.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  Documentation/networking/seg6-sysctl.rst | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net] doc: fix seg6_flowlabel path
    https://git.kernel.org/netdev/net/c/0b4b77eff5f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



