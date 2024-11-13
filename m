Return-Path: <netdev+bounces-144385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CF9C6E93
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4181F21A94
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC82010E4;
	Wed, 13 Nov 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUhuN9hF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCD206071;
	Wed, 13 Nov 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499225; cv=none; b=GCvh8ebV7u7GE0yUh66tmM2pbVdnSOGy+m3OPYuROQGeDclcixTX9mQXX7/KDuRvNBqLf0juZTvdxNMyhImLrhQs/xWq3Z8TZ4RKb7LdzWHpuDs/3I3eIssLwv3JqIokzkP0h8Sn1iUzSg+8vHxvql9c28vuaPJeq/TJ27qSmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499225; c=relaxed/simple;
	bh=THI3YLBzXVja+TcFlUWeFwf4xpf6z18cL1jh+zfVypY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qnce3I5wBUyw2Mw4QA6m7QXSgVBF/8AnqQ/LfBRDNvau74BxNB4gFCIRoWZF1TfUHRWJz1/Lod1DzDxvHF7SFGbWqtwsNJPIUPyLXx/crrdh8c4c5xkMIZBezj53YuxprU24336RqLW+sty8z8eG8oJBGNBwIc6teyl8xdtMCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUhuN9hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E3C4CECD;
	Wed, 13 Nov 2024 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499224;
	bh=THI3YLBzXVja+TcFlUWeFwf4xpf6z18cL1jh+zfVypY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUhuN9hFEeo7b725W8ffKt4JqVNuKS6YltTF3ubb9VnGMjiPs2rRqttQbvEh50la8
	 AIpgdAFHs65SfXrxlGzGCamHOP7yZx6v8mCP0R+uB/v9YMrxxTn4N1tpYOQSQO+I3l
	 hpfmkNdgd/0hM3LXVwy+PDJmjyHTOwc0FRnY8doNtW1uFKL8HLTtlTLBug0zDLl6sh
	 Z1z1gJEDIJB4i5VPv6ZB86S/VeenrfHFj3SgwdB9nf6CRJurzgzqd7hlQNxbQyavDH
	 E8auEoGJqtFaiqqJoh2GAFkt77rTLJP4BslagGldx6INHbHZ//QsQ1ulg6VJf/FORj
	 rmVs6trt+M60g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF03809A80;
	Wed, 13 Nov 2024 12:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v12 00/12] Introduce RVU representors  
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173149923475.1192742.13198903073889976671.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 12:00:34 +0000
References: <20241107160839.23707-1-gakula@marvell.com>
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
 edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Nov 2024 21:38:27 +0530 you wrote:
> This series adds representor support for each rvu devices.
> When switchdev mode is enabled, representor netdev is registered
> for each rvu device. In implementation of representor model,
> one NIX HW LF with multiple SQ and RQ is reserved, where each
> RQ and SQ of the LF are mapped to a representor. A loopback channel
> is reserved to support packet path between representors and VFs.
> CN10K silicon supports 2 types of MACs, RPM and SDP. This
> patch set adds representor support for both RPM and SDP MAC
> interfaces.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,01/12] octeontx2-pf: RVU representor driver
    https://git.kernel.org/netdev/net-next/c/222a4eea9c6b
  - [net-next,v12,02/12] octeontx2-pf: Create representor netdev
    https://git.kernel.org/netdev/net-next/c/3937b7308d4f
  - [net-next,v12,03/12] octeontx2-pf: Add basic net_device_ops
    https://git.kernel.org/netdev/net-next/c/22f858796758
  - [net-next,v12,04/12] octeontx2-af: Add packet path between representor and VF
    https://git.kernel.org/netdev/net-next/c/683645a2317e
  - [net-next,v12,05/12] octeontx2-pf: Get VF stats via representor
    https://git.kernel.org/netdev/net-next/c/940754a21dec
  - [net-next,v12,06/12] octeontx2-pf: Add support to sync link state between representor and VFs
    https://git.kernel.org/netdev/net-next/c/b8fea84a0468
  - [net-next,v12,07/12] octeontx2-pf: Configure VF mtu via representor
    https://git.kernel.org/netdev/net-next/c/3392f9190373
  - [net-next,v12,08/12] octeontx2-pf: Add representors for sdp MAC
    https://git.kernel.org/netdev/net-next/c/2f7f33a09516
  - [net-next,v12,09/12] octeontx2-pf: Add devlink port support
    https://git.kernel.org/netdev/net-next/c/9ed0343f561e
  - [net-next,v12,10/12] octeontx2-pf: Implement offload stats ndo for representors
    https://git.kernel.org/netdev/net-next/c/d8dec30b5165
  - [net-next,v12,11/12] octeontx2-pf: Adds TC offload support
    https://git.kernel.org/netdev/net-next/c/6c40ca957fe5
  - [net-next,v12,12/12] Documentation: octeontx2: Add Documentation for RVU representors
    https://git.kernel.org/netdev/net-next/c/6050b04dca8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



