Return-Path: <netdev+bounces-40305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890917C69AB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CFC282C21
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528E21346;
	Thu, 12 Oct 2023 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htmJ/Bs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8320B2A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81128C433C9;
	Thu, 12 Oct 2023 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697103026;
	bh=cLhAWw79kwNYxKES6zDveSTsFkXxKGLY9f4mOyYx3CI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=htmJ/Bs6c0bAAYLQjEQTwrEC1d6bXxtAVJcVsz1pdL5UoSp6VTBEo1HECHKKXhhlS
	 Qhy/lmhDpiagK7I637O/s0OTNffikwWgcDuB9huZs3fQ4vsB5598DH5P94FTN3Ufza
	 Arn/1wAfS/fPSrrXmEEpMzwatCPJBRNlog8GE5g4uQNWtKWdaqP/mJh4sLvJUd3nC2
	 bUmjo5W8JnPXjhwWh5EjFLM2Q1hbiznOJo5I621zGTNZWCNjECQ6fZJAQ9KERoXarc
	 swT47dJ+qn/OWKhjaNTBXQ7OPxQm99NM8h0i0g0RMjPZSReoL1Edi+0KUSkK2qX/0Y
	 v8VLOWDTAymjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 673E7C595C3;
	Thu, 12 Oct 2023 09:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rswitch: Fix issues on specific conditions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169710302641.22077.15617536299898879874.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 09:30:26 +0000
References: <20231010124858.183891-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231010124858.183891-1-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Oct 2023 21:48:56 +0900 you wrote:
> This patch series fix some issues of rswitch driver on specific
> condtions.
> 
> Yoshihiro Shimoda (2):
>   rswitch: Fix renesas_eth_sw_remove() implementation
>   rswitch: Fix imbalance phy_power_off() calling
> 
> [...]

Here is the summary with links:
  - [net,1/2] rswitch: Fix renesas_eth_sw_remove() implementation
    https://git.kernel.org/netdev/net/c/510b18cf23b9
  - [net,2/2] rswitch: Fix imbalance phy_power_off() calling
    https://git.kernel.org/netdev/net/c/053f13f67be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



