Return-Path: <netdev+bounces-138156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E689AC6EE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BD61F21534
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386219CC1C;
	Wed, 23 Oct 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUyufz5i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52C15CD52;
	Wed, 23 Oct 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677024; cv=none; b=S/YpzcU4l0JfgtbrKUTGjeo/MPJT1MXa9JaXFo+U6i8ixcbZXg2IPAW+m7GXb0zj2y7aqKxJ0oS0GkKkjnH+NdBBOQFSK/xM/+ZlEOKhe3Uqm6xjWGHzBLXyWbejM3LKsCrslxKsElBcq6JfqLBSBQtuGs1HMxr9Q1bNEQ5/Qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677024; c=relaxed/simple;
	bh=x5rmvMVzsRx5KvZu9QpnHlKVCLg9IFQn6uBblif8raQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GblyOInSsXOFb+2tszoONdUBxGntgZCcGKEeqTb0TN8YL/iPf7HTKtCWFS6nvc8IdpC6ul3Qhyg3j6hdrzVOG+igJ/KwR1xtYBqW8lr40+2hE0R1NxGLS7IUV6JN7VPLskvHrw0UbjWg7FccywqFU/Q4ekH1kIjIX7ftnjaL0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUyufz5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7B3C4CECD;
	Wed, 23 Oct 2024 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729677023;
	bh=x5rmvMVzsRx5KvZu9QpnHlKVCLg9IFQn6uBblif8raQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUyufz5iZcULnPU3dTNqV66+SNlH7HHcK/5tJ6zV84kxeW9ZrmLPwhTg/SP28jfZe
	 zCecGGRWgtl/YHDWIPJC8oCeLPZFAVG/SVbpsXaChpRmYP8nVcvsU7uY7HFuxjzOBI
	 1yvUMDAzfUVrp6fUp3lJMFpDyZztde2r3bRLRQMlCx4EIGomXXN+T89Ofbd/rUxMEu
	 b/NHsMJUbTTkDelNlh0XTEdz4hJrc3xDIpLpsoCCnBA3nSh6VhKZmQAaN4ufsMAdvP
	 /jSRIEHPrCRSN8lpdb9qXyn8GBjZ8bcf4AGA74W2oZzceSXGaB8RgeyEQOR713nRvR
	 AeFr3oxMb20+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCC3809A8B;
	Wed, 23 Oct 2024 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw flags
 for actions created by classifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172967703002.1543230.10059293201947964995.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 09:50:30 +0000
References: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, petrm@nvidia.com,
 idosch@nvidia.com, vladbu@nvidia.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, baowen.zheng@corigine.com,
 horms@kernel.org, pctammela@mojatatu.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 19:10:48 +0300 you wrote:
> tcf_action_init() has logic for checking mismatches between action and
> filter offload flags (skip_sw/skip_hw). AFAIU, this is intended to run
> on the transition between the new tc_act_bind(flags) returning true (aka
> now gets bound to classifier) and tc_act_bind(act->tcfa_flags) returning
> false (aka action was not bound to classifier before). Otherwise, the
> check is skipped.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers
    https://git.kernel.org/netdev/net/c/34d35b4edbbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



