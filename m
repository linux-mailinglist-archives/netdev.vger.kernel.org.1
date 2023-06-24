Return-Path: <netdev+bounces-13752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33A73CD3E
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA4D28110C
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167EEAF2;
	Sat, 24 Jun 2023 22:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB51F50D
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6658C433CA;
	Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645219;
	bh=K57FsvDdDsQvc6eBxw1iMwtDiWoqnphia826r61uT3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LWwO3NiN57OSRe0PXPNoDLEGDLODcTDgVclO3tqyFra50+dzMYefFaWh3Rbud03c/
	 gOpfDQeJP12RdvWeDdirshZPJsjdytVxvYExw5459Y3P1WQYru2QYjt/ujKxzWrOIM
	 o+lA6MlPNO9qdb7wvNkfqNc4isEoWCP4XkN99bzO7kBqkAEIkYE4JjPHOBJJyDOJGG
	 yjG7igaqr/UXYWmtLlPDED+F+GxffcI/ox4Rpj3MLmR1EbNbadqg5tEDhCgnHreSnB
	 2R8BPvr0kR6ysI+B8eOE0HVdZftW6wHRO6UMSw5KYH7UbkxSPLnjFDOVBlu9bxc5+k
	 Ujs5R4IygvAXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88599C43157;
	Sat, 24 Jun 2023 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rtnetlink: remove netdevsim device after ipsec
 offload test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764521955.22804.7450435784531069720.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:20:19 +0000
References: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
In-Reply-To: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 23:03:34 +0200 you wrote:
> On systems where netdevsim is built-in or loaded before the test
> starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
> created during the test.
> 
> Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net] selftests: rtnetlink: remove netdevsim device after ipsec offload test
    https://git.kernel.org/netdev/net/c/5f789f103671

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



