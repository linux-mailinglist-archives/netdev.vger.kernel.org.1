Return-Path: <netdev+bounces-125296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8374A96CAE1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6BB2102D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC4187348;
	Wed,  4 Sep 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4JI9oHv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428D186E47;
	Wed,  4 Sep 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493235; cv=none; b=a+x/eFSXZTCPn4B5r2QAJ6Jl5R7vTpOz5L1H7cS4n/+vu8CxBMG4IWzEKwpx6sZhCQldtASL9VMoVh40cRfadg9pbAD5CSDH6hb0dmnpbPqz3mWV8bf2Jqswzr7m81KKjB0G+f5GTW5jpj+Z7c7U7QLXqZY4n9TBcWS3ifoGYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493235; c=relaxed/simple;
	bh=uaCBz6i3GYPZoyY4C17RwCb2cncHSDSWe40lw1vCbPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bEfBSVblwPTwDi+urJ2/M68FngR9w3vPIea/0BayyQwCMaq7SfBr2FI+3VI7OCSZWQCskfkdoctNda5/y8AmY3J7WdA8GTq44YMkeLgJWR8NcaagrMMv35d2mYC8JyliD3O6+3GTENiDF89XZ7BIoJuX4bsnrwNcp+79zt0JuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4JI9oHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F79CC4CEC2;
	Wed,  4 Sep 2024 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493235;
	bh=uaCBz6i3GYPZoyY4C17RwCb2cncHSDSWe40lw1vCbPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K4JI9oHvJ9w/fpKcMkZ244lEDD/JubO28lNNSGSicfU5qd31612HTxwRoNiI8kOv2
	 xs6YZsg8wINKYYpIbW5iwMtFvK4Z7g2VU+WM4U62dmYakPEyko2VN8oPNN6EtAZlgf
	 LF4595W6zbpNS0eJru7T50itzVwvVMDseD9EaAgV4vWfzoyuM9SGhxIuVzUVks57M4
	 ujPzD2FePC2q/sf3b127vXyjPXu7MF7oGfajdy/Ih8khIkiHKY8iMLMd4IOlXELrYG
	 VyK1m8VFqfvU+bhvxqnxomqG1K+aTRkrEmZlko4Zrezc3qSXIgmxw18A2dhpYjj03W
	 HT360nls7H3vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342733822D30;
	Wed,  4 Sep 2024 23:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always set
 EXT_LEARN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549323574.1198891.6356740352236763022.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 23:40:35 +0000
References: <20240903081958.29951-1-jonas.gorski@bisdn.de>
In-Reply-To: <20240903081958.29951-1-jonas.gorski@bisdn.de>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@mellanox.com,
 petrm@mellanox.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Sep 2024 10:19:57 +0200 you wrote:
> When userspace wants to take over a fdb entry by setting it as
> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> 
> If the bridge updates the entry later because its port changed, we clear
> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> flag set.
> 
> [...]

Here is the summary with links:
  - [net,V2] net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN
    https://git.kernel.org/netdev/net/c/bee2ef946d31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



