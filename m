Return-Path: <netdev+bounces-55405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9780ACB2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E62B20E3F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D913481A1;
	Fri,  8 Dec 2023 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZPwbNKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0557318
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A81CCC433C9;
	Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702062623;
	bh=+Ukpm9/eND5vB2UVcE1i0sZYRoJGseaolSuSyPaWf7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pZPwbNKJtYgUYZcBGwE6ZgufmXnzJuqgMGySCI2CoHwh0f9/tX/TZiXyB5/pC9Ete
	 eJJhhnEjnJsCkY1scblBag2qWUg5SF0YIkXmJVG9YopsPyaOcF8SO5P1DjEjTObfEu
	 1nNx/9GYBQdPmHj4I4AC14yaDbCKkcqcB4InCC16/5JBI9LVEOAr+EcPe9oX1NEHza
	 1cw2wQpT2uSZKJTnRb7t2N+NtgiUMfaSF3qxI59VbcxLPuW3CQ1oQte0Sp4sZqRmUg
	 IDDYvcA+zsvub/nDQnztMcp9iAXPrV7LftGGTxTz1pGXbJ5mbs04Hekn9fGE1P9JXd
	 xgstUFKhtwOdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C967DD4F1E;
	Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP local_port_range.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170206262357.18001.13368157648472287946.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 19:10:23 +0000
References: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
In-Reply-To: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, stephen@networkplumber.org, dsahern@kernel.org,
 jakub@cloudflare.com, edumazet@google.com, martineau@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Dec 2023 13:44:20 +0000 you wrote:
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
> 
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Use READ/WRITE_ONCE() for IP local_port_range.
    https://git.kernel.org/netdev/net-next/c/d9f28735af87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



