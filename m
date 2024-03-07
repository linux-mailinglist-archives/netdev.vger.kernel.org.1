Return-Path: <netdev+bounces-78234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27087475C
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E0A286B13
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1714290;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrkQQWOw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBB107A0;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=H83BQyMBd0VTLS6b6qYAnB6CF8YUBffTx/JFAC/12jh4ZyL0iW+1KlJP7NLuF2KRNBIMNNoTdNSiuDN+eHq7Fmy9ljmKUpAuFs3EvQBGPk2zXxXikj3Hn5DrzH6PCHgIQivqAGYw282i9do/Cr3OPf5gQahsEOPw2ugKiCICgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=PkTD6UTmrYxB6PjFYFt2VVIduSGa1BA6cPytMJPSavk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J3xDD5kueQfOZnBMd2sSVhLbwEjT1u+SfD132mbBvx5WgKtdZpRMXFCYuj6hXtX3qk0pAnTCUDlI/TIJgrP4EgVe3LuKyVORxLSCCRGo6RNvz4RMPfidSHc87Cymd4JIn0VtSF0OFLvSHn+XP2MOg7ywQ4d91x+6DVRoZFhV9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrkQQWOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC40BC433B2;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786430;
	bh=PkTD6UTmrYxB6PjFYFt2VVIduSGa1BA6cPytMJPSavk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FrkQQWOwiK9LZ9F3ZRbXb+C349B1OWFsXkEC9dFim8Kz03ALetD0zC3Zuj3lERZq9
	 oKBpExtPCQx1xpOr0Cg2n9vlkLuZSTcqDNZ/fYFThb1rpgf5/qDznT0BJ/vo43MiRO
	 KppmAFGuUh+pHQSNdUjXvAjBoPvAmKAsEHkgnNbFLtOwSSGL1jXiim+J3REFIeqwG1
	 Eeek9yr2QjJaFYJ5QL7iEWs4AkzZqm0AL3Kcoi0v2D+Dsf7nSgfVunWBbcVYUqBJ6W
	 7kqyjsNmHdEQiQ4NHQkufdZipawDJuTAArUd15pSmRFFxbtAWyzp5EUcHVKS/yEXW9
	 0b81YLeOL0Rsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4387C04D3F;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: geneve: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643079.7855.12221876786329256569.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:30 +0000
References: <20240305172911.502058-1-leitao@debian.org>
In-Reply-To: <20240305172911.502058-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 09:29:09 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: geneve: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/f5f07d06007b
  - [net-next,2/2] net: geneve: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/771d791d7ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



