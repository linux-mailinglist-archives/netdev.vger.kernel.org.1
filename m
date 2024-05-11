Return-Path: <netdev+bounces-95655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7298C2F05
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386D21F22510
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91822626;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXkeIzk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651EE225A2
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394634; cv=none; b=iPM9sFevF+jfkfNCVgx0DTKKx4eFOt+40RgXw3OORuKyPOcgWexUfgQHnww4xhcJ/n+QR6TnaCz/6q5gSi8/WWAJF5KkUPflYxK3le+K74tVY4XslLiOvfam6b3l8hIcBRmqkVPkTfr+VtA/SSB7D6KeNq4ztJTlN2dJUjqY7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394634; c=relaxed/simple;
	bh=V/9WFOp3lepA2OeJTNPa2O03FmEgqnLHNYVoYvPUOyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=feU4zkLl2X9TpgVr+IRHCdB87FsSqIe9oLI83p4J07To2UkqL37mZ3AV4DnNS9KC7GwB0nGo/bAGrw0F6MBt3AWNW5HBwOblVR0hEohwFlTWS3I2FAQAu3nN9NHXa8p+0kR3MmJBmKQ3PHJH9VJFUw/rO5byDCCQAyCHI7p+qKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXkeIzk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F23C32782;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=V/9WFOp3lepA2OeJTNPa2O03FmEgqnLHNYVoYvPUOyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oXkeIzk6gnPjYANOLTOxvyoToWacBq1aBKneO1qt8lOr/s7pNhhZEi01+L0DMrl6B
	 wIptaHaXRt3R0MtZ2XnJv82WkTwleHV9YkHva/AgwVf76orgsczy9ZqPkHTSIR9mmz
	 s2woumeAIkmZx7PDY0OdWCcY5KUt/sdhBi1o1XBHl3AXEaFjeRdfnXZJrP4WH0F3Wl
	 daqe3+xgpvd861PKTfImiZidoOmrWuWq12GI76Jlg9Nvv1NH/BoEfpCzko0+nRwbAR
	 oJjThiMUYgkqfZ15WiXSVuRr4JknaDbe6WyCEpQ+6v2hgphdwe9QzgqPtM6RTsaz6t
	 Nn10WI7G+hRuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7DFCC54BA1;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net 0/3] ipv6: sr: fix errors during unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463388.29955.7988637027890851012.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:33 +0000
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
In-Reply-To: <20240509131812.1662197-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kovalev@altlinux.org, sd@queasysnail.net, gnault@redhat.com,
 horms@kernel.org, david.lebrun@uclouvain.be

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 21:18:09 +0800 you wrote:
> Fix some errors in seg6 unregister path, like missing unregister functions,
> incorrect unregister order, etc.
> 
> v3:
> 1) fix unreachable code when CONFIG_IPV6_SEG6_LWTUNNEL=n and
>    CONFIG_IPV6_SEG6_HMAC=n (Sabrina Dubroca)
> 2) separate the patch into 3 small patches since they fix different
>    commits (Simon Horman)
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net,1/3] ipv6: sr: add missing seg6_local_exit
    https://git.kernel.org/netdev/net/c/3321687e3213
  - [PATCHv3,net,2/3] ipv6: sr: fix incorrect unregister order
    https://git.kernel.org/netdev/net/c/6e370a771d29
  - [PATCHv3,net,3/3] ipv6: sr: fix invalid unregister error path
    https://git.kernel.org/netdev/net/c/160e9d275218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



