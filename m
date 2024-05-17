Return-Path: <netdev+bounces-96835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAF48C7FF8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A291F22765
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457508F55;
	Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po7b/PJj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE48BEA;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=Pcnd/yOorbxkga7rmgtMNpPFI8bXsqM/3BKIbQjGAdy1QzA21KhD7BPLXbaZgzjOLseWE4/62XdPYL+LPEODx2QFxP/ONytJzm367Xw4AJEBWrOdtyY4Jx4uOGTM8jjUzXGUs6wl4PGr81JJiOApQtblKK2IkmZq+11Aj9jsLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=oAldkRBtUxjPHDz+AtQSCkvv5HrTRcyLzu2sgj+V6CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhAv1Kmgq3oba4v4RuegdF+ouBUoVS9NFE/liafkBPRP1VyV2ruAbVcK+gUU/WG+27/L5GKJtgpuFfno0aR1E/dNwTlz6uESuqQIQYlW0Rr0bXIrUs4+cLg0xs2iABEMC+PbR4Q3nh7CIfFBigUSc4CBXpOyfBwCzi/blIr4+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po7b/PJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA83EC4AF09;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=oAldkRBtUxjPHDz+AtQSCkvv5HrTRcyLzu2sgj+V6CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Po7b/PJjbga8YLbQ91PEeWQTMfzL+gsYjTRbxSiaCpHKD6mbY65iDu8VzPAs63Sg4
	 lwvCpiGLeiL/zJWB0V7IcALX72M9hew2QFrzCdBrtG6C4YfxxpCxbZwINHDwFoHTHT
	 lkud9BSAfpUxeWnjIs2v4J/qo1dqWSelAZNtLVAQrM0aw9UMikAkDySLm5eZ98UWe4
	 DDo/rjYw1XhfvOfwuww0BpSHpEYBvOv+OHrZMBL6TfyOTfT7ao6z9J7rllFhLCZLJW
	 vo6jLHwibzCNOPV/2YlUkWALuo7tDIPw5htyp30ZIqNY+CXkA5U4BcoiqQKWq7xRur
	 8i6Xp8MufyFhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB8DC54BBB;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH=5D_net/ipv6=3A_Fix_route_deleting_failure_when_m?=
	=?utf-8?q?etric_equals_0?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363070.2697.1355959441685915624.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn>
In-Reply-To: <20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn>
To:  <xu.xin16@zte.com.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dsahern@gmail.com, fan.yu9@zte.com.cn,
 yang.yang29@zte.com.cn, si.hao@zte.com.cn, zhang.yunkai@zte.com.cn,
 he.peilin@zte.com.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 20:11:02 +0800 (CST) you wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Problem
> =========
> After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
> we noticed that the logic of assigning the default value of fc_metirc
> changed in the ioctl process. That is, when users use ioctl(fd, SIOCADDRT,
> rt) with a non-zero metric to add a route,  then they may fail to delete a
> route with passing in a metric value of 0 to the kernel by ioctl(fd,
> SIOCDELRT, rt). But iproute can succeed in deleting it.
> 
> [...]

Here is the summary with links:
  - net/ipv6: Fix route deleting failure when metric equals 0
    https://git.kernel.org/netdev/net/c/bb487272380d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



