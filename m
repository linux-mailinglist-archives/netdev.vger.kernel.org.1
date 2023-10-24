Return-Path: <netdev+bounces-44003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D787D5CCE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EA7B20FB2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39603CCF9;
	Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQe7s8kc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F12C852
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3334DC433C7;
	Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698181225;
	bh=XbwDDDHUb0TA4KMbid2Sc5GNAmeqnpv06E3h35HAe2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iQe7s8kcbk8ZcKnDqSaIOceVTtM1SeTE6Uaa02iRv2eigyxoTvCbpSD7n6ua42ToO
	 oBwV129sirJDu3F0qx3jEhYJiuzRw8qEkfzEIx2b9w8uNluycdGIW1DQJpID1aQyah
	 u/b1VLGfbY13zgc5ase9/xd5AKdPQsUulDyzLcXbAZcc6MwFILXT+KHo9qa7eFbPk7
	 QqfZKRheWk0KIa+iyXP/S7/Oj8W3lPJHyapuL97z7nsqgkHdKtD3ujbpcwRBngYPfg
	 AjOZ+zzpoVCbyGHvvqXk9TbKjxrslq4AcLrfwv6OQ4jinwGMZPVexB2xGcDnpT2B1R
	 whlmqJsfBeFow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ECADC3959F;
	Tue, 24 Oct 2023 21:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests:net change ifconfig with ip command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169818122505.23262.9878970940813907976.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 21:00:25 +0000
References: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
In-Reply-To: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, jiri@resnulli.us, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 18:04:22 +0530 you wrote:
> Change ifconfig with ip command,
> on a system where ifconfig is
> not used this script will not
> work correcly.
> 
> Test result with this patchset:
> 
> [...]

Here is the summary with links:
  - [v2] selftests:net change ifconfig with ip command
    https://git.kernel.org/netdev/net-next/c/37a38e439d4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



