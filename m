Return-Path: <netdev+bounces-83440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC13892449
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B37E1C223E4
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA27E13AA24;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRYCLbQO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF513A240
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=qN1KEkVcFUaRBRKW9hXFV+ookY2Mq+wqIfAw7T0+JXaRBOPPBRRORMFf78Jn+7BEPjQ+ptVcgHv51Zz0UAMOB3ZuJ4B+NDsu130yghVISBgrRTXdfLkNp0zBROuPKUHIlIK57szvdZLSL8DpY4F6wGx9m1kXVAnD0tdUcNeRYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=9K9jHAb1/caMCJpem0FTGPVVty+RcRzJmgotHuKfOgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kgexq7cv4/fsvUo0kLTFYFUZORttChlNS63YCOCQMFnI/en/aeg/Ed3RD22l2Dv+c7hQPKtND1CmzBnu7opL8GrgyFg87jahjdXzo8tj+gEwvLDhnt2f9fxf/DSGjCk5TmLdjxFHFO7Z31Sbm0ux/WAgk/3nUB8LEpUtJgdzlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRYCLbQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40441C433B2;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=9K9jHAb1/caMCJpem0FTGPVVty+RcRzJmgotHuKfOgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iRYCLbQOf3QkW5ns+QyMYuCr5O63XQSL1zXJBx6Yo1uu7pXI9bJCbvaRD7A5yy872
	 wKXQFO/9w1q0l0/eZ4q9ALoVPMCYqzxHaACxbEVAhCZDvHEZJgo7fwiWy6fiSRHqdD
	 jxBA/W0ucvloqEizfuSy2RGYU56eeWuFBC1U0uWepRu+wJKVBrJLIENyJ/w00Gf6LL
	 XAPlOYoWCbgMlq3t73FjUVzxKDgenyWNcfi+l9zPZs1IsnGFpfSwaYPSb5Dxj/qBp4
	 pQoH+4+f2c+P0B4YEwG1w+OuhLzS7vZpIqDC64qSKP6R4u4tdZnJOIr5ROqdwsFyK/
	 jPLovO+87w99w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30EC7D8C965;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tools/net/ynl: Add extack policy attribute
 decoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063319.18563.15467171911509067118.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <20240328155636.64688-1-donald.hunter@gmail.com>
In-Reply-To: <20240328155636.64688-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jacob.e.keller@intel.com, sdf@google.com, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 15:56:36 +0000 you wrote:
> The NLMSGERR_ATTR_POLICY extack attribute has been ignored by ynl up to
> now. Extend extack decoding to include _POLICY and the nested
> NL_POLICY_TYPE_ATTR_* attributes.
> 
> For example:
> 
> ./tools/net/ynl/cli.py \
>   --spec Documentation/netlink/specs/rt_link.yaml \
>   --create --do newlink --json '{
>     "ifname": "12345678901234567890",
>     "linkinfo": {"kind": "bridge"}
>     }'
> Netlink error: Numerical result out of range
> nl_len = 104 (88) nl_flags = 0x300 nl_type = 2
> 	error: -34	extack: {'msg': 'Attribute failed policy validation',
> 'policy': {'max-length': 15, 'type': 'string'}, 'bad-attr': '.ifname'}
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tools/net/ynl: Add extack policy attribute decoding
    https://git.kernel.org/netdev/net-next/c/bd3ce405fecc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



