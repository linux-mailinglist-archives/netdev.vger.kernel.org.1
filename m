Return-Path: <netdev+bounces-193798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D12AC5EBC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233947B124F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE91EBA09;
	Wed, 28 May 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5qffMAr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A51EB5FA
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395219; cv=none; b=tSdMzpg2csWgWfp5gnawJgyRfQ0Yz0MUAQd233mqzAKX8UjQSzSa8vBAwlP+ZQ4aglDsNGHAUcPUI9H0++rZhksn0IJnp5qQHmQ3pFlmGo+HINagdLmMzPxQXLXYVN3w9q/74CBlmf95QyJ1YpCUNIJTbCazOfM/BCw/4EZgjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395219; c=relaxed/simple;
	bh=hxheQ6GezQnrgL3/ejq9KHWUbtlHkM3LJftjJd8S0Ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mERJMSzHcHRij7JoCCNxaSr4wEVMEQL1Fhdf0IO/743ZBIysK82uFl5o6o+4csj1NeW/WwTLeyVzP8YJYJRhGy1j+RtgDYIA4ypSWbAgP8fIDiPCEn7fm1bHAtuwQUIPZVDhlNrQ6smqkPWGLFhEmzE5068DAagUtlEsZv1ians=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5qffMAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59838C4CEED;
	Wed, 28 May 2025 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395216;
	bh=hxheQ6GezQnrgL3/ejq9KHWUbtlHkM3LJftjJd8S0Ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y5qffMArE1Dr5MXHAcKhZuTQgn/QV0/1M7TnDHhRFVT6GhDWnCtHkrlOg4Bv0zPLz
	 SXu+EX4Uu/9IzJiEx7KwsWq6Eb2BGCMepsqO0anU4Y5A0gbrDs/VfMIYXIf8qKIMwy
	 s1GRX4ykTTVUEMwJs8wkcdMWMrRNVpg6lPFEBTLv4PxeBja7KGgpOoyGBsbf/K/bXy
	 Kd9L1FSriHEJDi8h5/tILDa7P06KRUSZKITVBDg1/jMlSUqWoZvC24iAP9p4+RHnBJ
	 tGlR276jhZ8pW+QvPREjMy+8I+WH43Dd+VakqodsGO5ELX0SbMvYbgczRY3qJiJQWm
	 E93QVYRgyWGRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15F380AAE2;
	Wed, 28 May 2025 01:20:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: libwx: Fix statistics of multicast
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839525024.1849945.16012384212405372898.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:50 +0000
References: <F70910CFE86C1F6F+20250523080438.27968-1-jiawenwu@trustnetic.com>
In-Reply-To: <F70910CFE86C1F6F+20250523080438.27968-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 16:04:37 +0800 you wrote:
> When SR-IOV is enabled, the number of multicast packets is mistakenly
> counted starting from queue 0. It would be a wrong count that includes
> the packets received on VF. Fix it to count from the correct offset.
> 
> Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: libwx: Fix statistics of multicast packets
    https://git.kernel.org/netdev/net-next/c/06ac0776d549
  - [net-next,v2,2/2] net: txgbe: Support the FDIR rules assigned to VFs
    https://git.kernel.org/netdev/net-next/c/7a91722e0dd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



