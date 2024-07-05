Return-Path: <netdev+bounces-109406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD6928672
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A48B20CF5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA41442F0;
	Fri,  5 Jul 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/S6gpRg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E413B5BB
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174233; cv=none; b=LAFs0ZfUOjnAPin4KubJm3SXFtXKJgjC8hjiLdOnk76NWdvMvDBRLMZfPZfdmp6ZsTwgkjtFeo4x4Iom7P4dD9wMrbZ1coboQE59lWs38gN1K+vam2OZT8gUgzUX8AkMAzp7btnvND9OLO5vfl7Yt+jGOTxpPH5lg0GcsqiQu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174233; c=relaxed/simple;
	bh=7iFtW32cJDlJxwJrdlMfAWszHQGuz6UDfcj0KlAAfKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UeOKsJWQR9qQQ1/+l7s/GG1kV5ai0oXxpz5eXTiIz5iUDY9wyBrqbXOfZJ4+rjMaUmLHN71sh6M6tfxoR2Zz8S5cqs0a8xRGTGP9KM9V7w99azUTI6Q5vWYPSRPVg2c6oE5UdCfU3ltESugNMncc3wtCO0qUbUxPbFIbeP7hTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/S6gpRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D46ABC32781;
	Fri,  5 Jul 2024 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720174231;
	bh=7iFtW32cJDlJxwJrdlMfAWszHQGuz6UDfcj0KlAAfKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/S6gpRg7lY37uLNLfa3ICo7KRSU46vjMQw6f5x7z0lHME7/RN+DsOSA+Fb+zW3cT
	 eI4bY+/owBpvwxQyGOGdpeWiHqlViB8UjfpP6kVCVroB4gVoiv1nAFk+nkhoW9xbGo
	 NNFFfGUcr7SFW2O7kgSUe97UvN2eW3kiE4WtGroiNFUpcf+tVsLRJnIu2U3MtqTmPo
	 o2PU9vRwuKulmsbfh5kvQlZUGPAncs4YD+Dwa3094PiNF2TKQjwHVrbMpejqMYA8rV
	 On0s/tjDEC//IElH5kte8RgOt9hIiq04L4q1geO29StgB0VcbpGyrFI8/bw9U2pBbl
	 sB0yBLtuCt8eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6FEAC43446;
	Fri,  5 Jul 2024 10:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] openvswitch: prepare for stolen verdict coming from
 conntrack and nat engine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172017423181.23783.14915373439611931609.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 10:10:31 +0000
References: <20240703104640.20878-1-fw@strlen.de>
In-Reply-To: <20240703104640.20878-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: dev@openvswitch.org, pshelar@ovn.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jul 2024 12:46:34 +0200 you wrote:
> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP
> verdict with NF_DROP_REASON() helper,
> 
> This helper releases the skb instantly (so drop_monitor can pinpoint
> precise location) and returns NF_STOLEN.
> 
> [...]

Here is the summary with links:
  - [net-next] openvswitch: prepare for stolen verdict coming from conntrack and nat engine
    https://git.kernel.org/netdev/net-next/c/c7f79f2620b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



