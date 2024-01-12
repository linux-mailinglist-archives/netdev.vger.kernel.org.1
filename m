Return-Path: <netdev+bounces-63181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7F82B8D2
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E905B23489
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F3EBD;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7tLai1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32CA4C
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 391A2C43399;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=xJEYALgvFLaja+F15P9Mr7uRLwKTkINqosDARH7+ZJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o7tLai1Vv5m6bV3bxvBfqC1Ei9FXzuCWuqdQYv+pXXTQrc7GyBUf+W6w6xZMJM6Fi
	 O5IyFyJrhtv370Diw42zTcO18yzAhhkJylsbT0/ZFUOdrdsfsoffDTu3MsduLDsffw
	 Hx4YX+5+QXC2BXfoYDtgVYIaO4oMuI1RvWa6U6kH7FLreBidOqaEwOSpr0dfkWjakh
	 0q6qievFj+14pS22S/hm/3OBwrH+CIBb9Cpm1syB1ycYWEjpC3CJ7dZyNyGZYw3+bp
	 v46R6Hr2hQsGjqCpavRZEQmwUMBMfGiv+Gg+mF+3ZA9mOEvpWbzLpxjeDn7vCGmMAB
	 DzggxtoaoC4QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22DF2D8C97A;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] rtnetlink: allow to enslave with one msg an up
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502122813.27071.17070520881467487807.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:28 +0000
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, phil@nwl.cc, dsahern@kernel.org, jiri@resnulli.us,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jan 2024 10:41:01 +0100 you wrote:
> The first patch fixes a regression, introduced in linux v6.1, by reverting
> a patch. The second patch adds a test to verify this API.
> 
> v3 -> v4:
>  - replace patch #1 by a revert of the original patch
>  - patch #2: keep only one test
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] Revert "net: rtnetlink: Enslave device before bringing it up"
    https://git.kernel.org/netdev/net/c/ec4ffd100ffb
  - [net,v4,2/2] selftests: rtnetlink: check enslaving iface in a bond
    https://git.kernel.org/netdev/net/c/a159cbe81d3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



