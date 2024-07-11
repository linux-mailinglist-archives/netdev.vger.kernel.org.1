Return-Path: <netdev+bounces-110714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DD92DE4F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5199284028
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A8BE6F;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHfLjY3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D22E560
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664433; cv=none; b=Bcp2VUSVmnrlGCxFljxwRY4i9zbWbZp+iRNvV0ZpY5s0nuNop9Xitc0VZv7Tb+LkvCGxVbqn0H7ToUO/dv07NrE25B5DV7iyoAm7iC11Vu+hvETG56pcyDYENWyj14Q0lrldSvD4vO5ObSZKWQXkpaaYqG/EX9HGe7J82sgpq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664433; c=relaxed/simple;
	bh=Pu+g0WXqRNbuA3nUlh2wjqQS07yaQLRatL8FFgat1Uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pNDvH2Y984WhyeZwxXndUUJ66eESe+T2Zh286Vnu93JjnLh5EhPY3ZYhnXm0CKT2TTmZ+Orx4k6mRKVlpeoIBizol3v5GFqpn2HAM99mAD7OIQXGLu+8XBJr+dP4cKOy7QyyAkqBt21+IAR7qqNi7oPsOrUp/NeFHyoVd0CjC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHfLjY3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B48C4AF07;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720664433;
	bh=Pu+g0WXqRNbuA3nUlh2wjqQS07yaQLRatL8FFgat1Uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHfLjY3d7zsvfAsmylko+yO3TLzkgW8V6Y13bRkSIOhoWCbRr9w6Uh1OX7IapbAds
	 rflIWXrA6WqpmnaTi4lM+zbp0Rxf1CmmOdfc871LxoGcPgvW+nuRNlHyVIYnsYQKSW
	 Mm2xIuZIri6t6fgKLRA/6yodynRm+iRpjbRFIhfV8TzsqQ4C8ps1kpUNXmlo9ta4dl
	 WE+OXqMwNBKScPezgHvVZC4ahKfCQhijOdemE0e3nE8XpEco8I6wWBvEyMzkoIKe93
	 poz2kJws0HhiQyavnbE8ToQItuFCRyGJncx5vOz3enKRHrSMlXqm2M2sU/EJhUB6RN
	 ZM6E4pz6YYANw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3CF0C433E9;
	Thu, 11 Jul 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3][pull request] ice: Support to dump PHY
 config, FEC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172066443299.28307.5949523403493455582.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 02:20:32 +0000
References: <20240709202951.2103115-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240709202951.2103115-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, anil.samal@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 13:29:46 -0700 you wrote:
> Anil Samal says:
> 
> Implementation to dump PHY configuration and FEC statistics to
> facilitate link level debugging of customer issues. Implementation has
> two parts
> 
> a.     Serdes equalization
>         # ethtool  -d eth0
>         Output:
>         Offset          Values
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] ice: Extend Sideband Queue command to support flags
    https://git.kernel.org/netdev/net-next/c/a317f873ea85
  - [net-next,v2,2/3] ice: Implement driver functionality to dump fec statistics
    https://git.kernel.org/netdev/net-next/c/ac21add2540e
  - [net-next,v2,3/3] ice: Implement driver functionality to dump serdes equalizer values
    https://git.kernel.org/netdev/net-next/c/70838938e89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



