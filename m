Return-Path: <netdev+bounces-136748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29C9A2DAC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6615D1C232A2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C3227BA4;
	Thu, 17 Oct 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED+qBkMb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DD227380
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192824; cv=none; b=AGaMHq5IQs+eCXQ6X707fa1CiNBZUVSyZQ0ijMlBMCEQ27OH917wuKe/KyF8LUub6/n3b+TfaMvr0hr9gXD47t3Kbv4irPKPOFr6B9HAD6p+1MMWsXbYcxVwv782m/FB0kHCqWBVVdjzvVifPKg49vGJDuRudKTHIdqPyK3OCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192824; c=relaxed/simple;
	bh=VIWHG90y7DTq24LFG5OtVVvW8dZFHLYFIcE81nv9Vcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nh4aVN8ZxUjKBqz7AumpSlFTY5HQuaWqqgvhq6kPJw+TcQQ4+4B9sdMTU61yn9EM87TimwfedGY7rveYy/0wGiUBZJ92ohjRdDvDGz+EeJm1ICDJQZYakPeGKWPPXP6Y5OzdtFYDZPREwQIkxmGRFHYJfgdQBfMKC22OWXve9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED+qBkMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A2EC4CEC3;
	Thu, 17 Oct 2024 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729192824;
	bh=VIWHG90y7DTq24LFG5OtVVvW8dZFHLYFIcE81nv9Vcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ED+qBkMbzVjsK+HByZockDFU68/WF2MQxqlxi27Zt1ri1SR/DbjosMmU9Uwf9org+
	 Ek6HEXarS9YP+2ajbJm0u7OUxYcEZe9iXpS3Q54GZnAQgJeN8bxv4lfY09tFs/01Vi
	 4TDWTLoz/Q2x0pQXHU/Am5nEIiUiFy3mjBft+yD1mQwYIk6f6hTD0kkaLNXWJ5I0AQ
	 UNMJxjx3YVAXIx6hHzinEuEKFZdiz2VxNBlCy/o4jvqTEt+LYju4i7h4foVmSLmfL0
	 TtkztcsJJJ8Q6VMzFXtqOeouLEfbjvwSN+D7tu9X2i85mW7CPIB8An044Fei8GH0Z3
	 GyUgaqZv02TjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C253809A8A;
	Thu, 17 Oct 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2 0/2] iplink: Fix link-netns handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172919283024.2582447.18246160222961333649.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 19:20:30 +0000
References: <20241011080111.387028-1-shaw.leon@gmail.com>
In-Reply-To: <20241011080111.387028-1-shaw.leon@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 11 Oct 2024 16:01:07 +0800 you wrote:
> When handling something like:
> 
>     # ip -n ns1 link add netns ns2 link-netns ns3 link eth1 eth1.100 type vlan id 100
> 
> should lookup eth1 in ns3 and set IFLA_LINK_NETNSID to the id of ns3 from ns2.
> But currently ip-link tries to find eth1 in ns1 and failes. This series fixes
> it.
> 
> [...]

Here is the summary with links:
  - [v2,iproute2,1/2] ip: Move of set_netnsid_from_name() to namespace.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=18bbd74b345f
  - [v2,iproute2,2/2] iplink: Fix link-netns id and link ifindex
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



