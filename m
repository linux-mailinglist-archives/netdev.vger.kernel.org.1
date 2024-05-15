Return-Path: <netdev+bounces-96531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB468C6528
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC5B238B1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C885FDA9;
	Wed, 15 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGvK9RTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3F5FB87;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770230; cv=none; b=jelIK8OvphPIn2mXj/EkUpVI9l5kauFLArULYY3Suh6iqpn48AfiqmHRWSSVtxx8mMzyc6QLxp5a9IKcza1613t+bEdynuPksX35S5YmCvsppzcywJh1AeeWefTKDRCFWnpkRAErgCLpimYxzEq3pM8Y9wMH2ivSqdhr1Xs1teQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770230; c=relaxed/simple;
	bh=h8/sKbJq0L9KSMNi6aEnhEU/Z5pFEd/YN2L1lnRYszQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jnVp8EDWKQx26OAJoUnoK3J9NP/Wuewo3GLn8R7Dj69pBYh7pHE6Ahz7c5xn3OTeVEOlv5UW+BbXsGAOPdqDEegyABD73Kv57RhKzF2rSk8Q6Dld7kuuJsiMm+7fmPr03+lases/NDvxvf5i3cYzArG6iQp1TzT7uj45AKKCVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGvK9RTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3D5FC32786;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770229;
	bh=h8/sKbJq0L9KSMNi6aEnhEU/Z5pFEd/YN2L1lnRYszQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGvK9RTybWOLMV9zbYVyVSEbU9xhUijPEsEG8T+jX4cAl3+HVNBMxZujWTcx5oZ4H
	 z17k5MvFlFoVwZ5zVEQ6wtueb6LQbiFyB9rMdyyEJXdkUhdiMHITw9FJKPyUtnGb5H
	 /ZKnAaw3FtzbWO4TG7Jlt7AmqtHCpeIQE67hME2OX4Y4NCJlgRZOijlL6B6V65zm+H
	 NF6LamAH+kGDyxrwF0dq1SGgh87zIxu16IS+pvLpQODr200np9ccAqC4yjJCXLr1Wu
	 SwcYiA8AVmnNHXNbfm2j/XolbputnJBf/NzG57O7JMVcrC9Zi0Zc5mAFldSFnPpGqg
	 aeNh7NSu8eibw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7EFAC41620;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude timeout
 membership interval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171577022968.14646.2766126822531337987.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 10:50:29 +0000
References: <20240513105257.769303-1-razor@blackwall.org>
In-Reply-To: <20240513105257.769303-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 May 2024 13:52:57 +0300 you wrote:
> When running the bridge IGMP/MLD selftests on debug kernels we can get
> spurious errors when setting up the IGMP/MLD exclude timeout tests
> because the membership interval is just 3 seconds and the setup has 2
> seconds of sleep plus various validations, the one second that is left
> is not enough. Increase the membership interval from 3 to 5 seconds to
> make room for the setup validation and 2 seconds of sleep.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval
    https://git.kernel.org/netdev/net/c/06080ea23095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



