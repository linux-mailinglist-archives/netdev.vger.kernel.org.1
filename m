Return-Path: <netdev+bounces-37288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10DD7B489A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AE6591C20400
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBA18B0C;
	Sun,  1 Oct 2023 16:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D01803F
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 917C9C433C9;
	Sun,  1 Oct 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696177225;
	bh=vDWFoMySv5YVwFEjBk2npWg/Qq4+wwOlEN17xSfgzCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V4AfoZV4ZvmDcj1g9Ve5o0dEbCOOMrR3rfyz0DkSk7LVCgW7AmPjvhUyLDI4pvYFm
	 /2M+gSef7D/pa5pTfYugf+W/NVzJ8hkyXs+1MpbKVnZqghqvSu3a3aWbmoydnoFjcx
	 9jJfPXHKkBIATgiXUOJsDthvMw6WDakYWQOMXYXqwnvZOv3genb3PxsAgJ+4QLPn2i
	 /l7WcMaqAzHtN4rJfvw3ctpkW6RUbCuuahlme3EI3cWYr+oKfm4RC+1B3Q7HC4ReVq
	 JoZSTP2TIOhOYlg3yRZuWNDLBsCbpUSQIcySgvSDFfz/5QP9oqhk47mIEut2Qtzchn
	 WMmnwJhLOnkew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7684AC64457;
	Sun,  1 Oct 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] neighbour: fix data-races around n->output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169617722547.23548.690515351827053685.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 16:20:25 +0000
References: <20230921092713.1488792-1-edumazet@google.com>
In-Reply-To: <20230921092713.1488792-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 09:27:13 +0000 you wrote:
> n->output field can be read locklessly, while a writer
> might change the pointer concurrently.
> 
> Add missing annotations to prevent load-store tearing.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] neighbour: fix data-races around n->output
    https://git.kernel.org/netdev/net/c/5baa0433a15e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



