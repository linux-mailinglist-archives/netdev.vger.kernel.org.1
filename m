Return-Path: <netdev+bounces-119079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58073953F7C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B35A1C20F6B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989646EB4C;
	Fri, 16 Aug 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnv2fOBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A76E619
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774836; cv=none; b=p6VafhWJs7IzsBDJa9GAMcjLlpvHqRTDaukAAoZHzoTlBbZhB99yVFyGsI7ZFnennJegA9/aYVJ6mfKbUBs3XmMIykn1MvMn8E9TlHxC4ulVytfarbzruFCnUnF8c3406ZH487FsMGGsq03cw6piN+ArbTucMW+46L65ZOA5XkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774836; c=relaxed/simple;
	bh=ItYy/20+EpDodnwRwCp81Kc/wRJK49Eo1EJRBRJfNiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D+6iTkgmZRX060JE4jp+waigK3xB8I1hrVD/38xdi51MXuJb1wE2iUXgQx9k8ATbVz6lb8wZldRbot3O8pDeXJvFdlS6AaC9jut5cEmSvI6usixDdfkAtFbkNEQxH5dycRwFdAzIMV41sZ8pMBhlP6AD7w+KiFz+038+7rZfndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnv2fOBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC7C4AF0D;
	Fri, 16 Aug 2024 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774836;
	bh=ItYy/20+EpDodnwRwCp81Kc/wRJK49Eo1EJRBRJfNiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mnv2fOBpQ1TDsjPtGTD7PAcSgF6XiR8OARiNFAiLaaysS0ku/WRt88HJ3QjJlV2GG
	 7a+HOD7Kg3WPSA9N1fP02gbFCee7IWmDYXDqroGll/pFOAQM28m000OlhN8PzpxucE
	 BoRhZALuVuXo1D8+ArEFII2Mwm3oV6wO/4VKpRSJ3DNAWuDQTflhAi7JWC4XaA8EcM
	 Bm0MzxrYu7r2XHmYwBc8Db4/WgPU4+d6X5/H4WNEm1hBIQXpfHJKJDUJBQn2ro1OUa
	 q83V4DOS/pUipfML7QZaMDEyi5OwnKEK0mNWZiI8/1kgcrfM5bYfSE1qlPZi5rKefm
	 9UMdeHtV0ShiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72A61382327A;
	Fri, 16 Aug 2024 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label counting
 in conntrack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377483499.3093813.15327738618411609051.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:20:34 +0000
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
In-Reply-To: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, ovs-dev@openvswitch.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 pshelar@ovn.org, i.maximets@ovn.org, aconole@redhat.com, fw@strlen.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 13:17:53 -0400 you wrote:
> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> label counting"), we should also switch to per-action label counting
> in openvswitch conntrack, as Florian suggested.
> 
> The difference is that nf_connlabels_get() is called unconditionally
> when creating an ct action in ovs_ct_copy_action(). As with these
> flows:
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] openvswitch: switch to per-action label counting in conntrack
    https://git.kernel.org/netdev/net-next/c/fcb1aa5163b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



