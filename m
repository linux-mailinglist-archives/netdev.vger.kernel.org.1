Return-Path: <netdev+bounces-115452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DA946660
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C122F1C20D38
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF96AC0;
	Sat,  3 Aug 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D207s1Ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CB2599
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643233; cv=none; b=SJbN0MGpeZhy785c17OMuXTEjlidaShiNCpbuyE8uHcaeYDUz7MCQsnayPs3/NX/jK13B6ZhIUiSS/1cKXjAc3CfX9Uvb7qffNOHQEwW+3uh8wh/XOochOYX6ykAqkDyoBCs4f3tRzpkbzlMDCeYTZ54ERh5WP1tHxQ+b/f1Mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643233; c=relaxed/simple;
	bh=0gAjpiUWGnsgernGPQyx5LHdkapfqbWmUHLloVzfy1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQKESdFSTke1ZW/p1BAIYjHyk58kVfnZeVZhFlkU4SFU/7HEmE0igAucFibScoH+Pg5WySYM+bdVZ8gEsjLia0oilBAbuAiJdX0y/cHnieBuqTvSU6RUrz1P3eSMqzLVHD/2f8P1buwWJcvj1cbN/1ms6IUmKQdiTQpI21CdwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D207s1Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF0BDC4AF0B;
	Sat,  3 Aug 2024 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722643232;
	bh=0gAjpiUWGnsgernGPQyx5LHdkapfqbWmUHLloVzfy1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D207s1IcU+RlzL2YgJlwPhVVeFWbHD1KRvhQ76cg2dRkt4RnvKTBreK0OebEbFVmg
	 u5F8/WTmYDuBTOwZ4eb7VqiuUBpi2xgF5m4uF0vDK7hdsGuCmdUyCpqqPYF7DXDyAn
	 IOkOP66eA09pZ4DISPWo9BaNAfpH6r0tY5is6B9xiG3eYw7cZXn4nQjbhV/GBsWLiL
	 i/4NH1N1Hpd+z2kes4OG2cRrrPYtEP74ph1RKBx7gEvghGu2gwKtlOhll+l/1LjXv+
	 BCIpyaQ7LIwEq0A+4TfrE8aGDY10LGM3tMpcEVTZ87zcY2IDt+EnAEuZVmONoSNdzd
	 NT+hB+9ZtMeTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6D3CC43339;
	Sat,  3 Aug 2024 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Fix use of netif_carrier_ok()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264323280.9161.8677177403425422929.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 00:00:32 +0000
References: <20240801205619.987396-1-pkaligineedi@google.com>
In-Reply-To: <20240801205619.987396-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, jfraker@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 13:56:19 -0700 you wrote:
> GVE driver wrongly relies on netif_carrier_ok() to check the
> interface administrative state when resources are being
> allocated/deallocated for queue(s). netif_carrier_ok() needs
> to be replaced with netif_running() for all such cases.
> 
> Administrative state is the result of "ip link set dev <dev>
> up/down". It reflects whether the administrator wants to use
> the device for traffic and the corresponding resources have
> been allocated.
> 
> [...]

Here is the summary with links:
  - [net] gve: Fix use of netif_carrier_ok()
    https://git.kernel.org/netdev/net/c/fba917b169be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



