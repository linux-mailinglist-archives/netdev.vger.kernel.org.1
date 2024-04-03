Return-Path: <netdev+bounces-84330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2808969C9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701781C23E5D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46516CDDB;
	Wed,  3 Apr 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLIP43B8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1B5C61A
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134828; cv=none; b=JDlwPKLPFMkRmWITZKGYiyqThaEZFBV2jDxwimpWWTvsvkPJ4mFohiii9T4qfcT6y/1gUj7BMcZR9zG43YHhJ++RbnywcX2v7HsQCzBTmejiIr0da1qo2HDfS8bk0Lu74EWICb5bM1jeI51a1EV464xi0gomW6t9WAE9sv5Cqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134828; c=relaxed/simple;
	bh=gGNehVJMwaoSU81LlgjhV2VnnOFC9syG/Gy08hILAY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aAl6uxB2sTk+HdZjb7AnchS+Fw4nX0/Ko12wH0mVMcWJpvfSGocG7xo4xJ+x6c05JGJ2frZqDhOnbbbvk+zGD036jE4/CABxsVBBP6oUr9acK/vHb6jkqE6EBXS8qDVGnGDZz2vQkNknAH+otbw4+Vj+L1dhq2/lYHDKrAIl5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLIP43B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C237C43390;
	Wed,  3 Apr 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712134828;
	bh=gGNehVJMwaoSU81LlgjhV2VnnOFC9syG/Gy08hILAY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLIP43B8CcqG5zF/JtVRY4pITEHcKRuv9193/Iu8mM8AnD4qu1J1OAhUjUOcYDI9I
	 ckG+3S7vunvouVsx+/kU9NYo1NXJ9NxCRk+yLc1XC9BNYYThGCM9GEpz2lDISkAcs6
	 UdMNpMwURrSkRyuqkq5jO5dKI13t1mCY3d5B2HC7uAB2eW9/kwUANyvIUJk16KT+P5
	 TTKPLFNAQ8IeD9+FUpTClcXeziMSwJkXjEP8P9LNpvOUQ8El4tdGHmReJdVwQtx8dn
	 6Ub69BATnIznVaGss3jcCWWEQzcrCQJmCdB28ZIQtV4Z//0dyRfsVRnpAMHfcbivrG
	 tRH+8G2rI/HlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38817C43168;
	Wed,  3 Apr 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] rtnetlink: add guard for RTNL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213482822.8514.9847706746678108403.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 09:00:28 +0000
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
In-Reply-To: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 victor@mojatatu.com, kuba@kernel.org, pctammela@mojatatu.com,
 martin@strongswan.org, horms@kernel.org, johannes.berg@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 28 Mar 2024 08:27:49 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The new guard/scoped_gard can be useful for the RTNL as well,
> so add a guard definition for it. It gets used like
> 
>  {
>    guard(rtnl)();
>    // RTNL held until end of block
>  }
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] rtnetlink: add guard for RTNL
    https://git.kernel.org/netdev/net-next/c/464eb03c4a7c
  - [net-next,v2,2/2] netdevice: add DEFINE_FREE() for dev_put
    https://git.kernel.org/netdev/net-next/c/b1f81b9a535b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



