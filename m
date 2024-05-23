Return-Path: <netdev+bounces-97766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E98CD0E2
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7511F21F72
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519F1448D3;
	Thu, 23 May 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqBaU8R4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126613C8F4
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462629; cv=none; b=cY2yHplgmlrDeV0us9Et8LPByeaOKXrTEDkfvHQ/gT3Cjl+WHnGyPndCOxpdHP7QxKmMIOFcc97yLSFBGzRobuJB7e+IAD1C9HZRhkc4RVk1/zYDxRqd5crToHcANVROMSVQ65sdtQRmsM8EAj3jarbxP6Vu7QuR1M/CMYtO6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462629; c=relaxed/simple;
	bh=5AS2s14mlS2q2THpaIG1P6rcpbcrXvSisbCyUrKYYgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naeEf0llpF8PqzZ3V14PLpkf/Jv/n04yxuwR2pCG7ft+RYKV/ahh6D/9fIeOr+WPDzZI+R3vUih2XA2jX5SNWQ6/RIZ8sKQqTbKfFEUAlrniel9hi3pn714Qzyn66TMsmYLdAw5TpJZPVrxNmxOWGjUoFmrlniPLxBruvjEJVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqBaU8R4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37204C3277B;
	Thu, 23 May 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716462629;
	bh=5AS2s14mlS2q2THpaIG1P6rcpbcrXvSisbCyUrKYYgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fqBaU8R4Ch5+bjANrWriDHHtQyGhAoHEUd6eLSI5DohgkMVjP86za4/qILMxQJFFe
	 //yLJEMSscVlZeq2v2n5wyePAIbkgxBkP9mb66lYlXgsRrMEhQ2tcwQm7PxeMBTb//
	 AMXhqtSG4jiwnOj+cm20foYvnBvDYPJG1E3hFYGNYXRS2r4Y4c5GDre0YnWj6pFdeS
	 ULhzyPy9LpxQhWElfkWx0GjftcLBlSt2mnk7cjzSPtvwqdyYx2xWSt94GYudjlpJtP
	 n2RqXbwN/9izjKfE3Hoqmoo//fjsxTeRTAKUUDMDRQfQjHMlS4Kyj6vAW9WWbUV1T7
	 n4QsFmiK5j88Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 224DAC43333;
	Thu, 23 May 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] intel: Interpret .set_channels() input
 differently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171646262913.15895.17957174467563014841.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 11:10:29 +0000
References: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
In-Reply-To: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 larysa.zaremba@intel.com, michal.swiatkowski@linux.intel.com,
 chandanx.rout@intel.com, himasekharx.reddy.pucha@intel.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 igor.bagnucki@intel.com, krishneil.k.singh@intel.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 12:39:52 -0700 you wrote:
> The ice and idpf drivers can trigger a crash with AF_XDP due to incorrect
> interpretation of the asymmetric Tx and Rx parameters in their
> .set_channels() implementations:
> 
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. Attach AF_XDP to queue 30
> 3. ethtool -L <IFNAME> rx 15 tx 15
>    combined number is not specified, so command becomes {rx_count = 15,
>    tx_count = 15, combined_count = 40}.
> 4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>    new (combined_count + rx_count) to the old one, so from 55 to 40, check
>    does not trigger.
> 5. the driver interprets `rx 15 tx 15` as 15 combined channels and deletes
>    the queue that AF_XDP is attached to.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ice: Interpret .set_channels() input differently
    https://git.kernel.org/netdev/net/c/05d6f442f31f
  - [net,v2,2/2] idpf: Interpret .set_channels() input differently
    https://git.kernel.org/netdev/net/c/5e7695e0219b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



