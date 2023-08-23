Return-Path: <netdev+bounces-30051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44C785B90
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AFC1C20B96
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9EC2E1;
	Wed, 23 Aug 2023 15:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0609448
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C614FC433C8;
	Wed, 23 Aug 2023 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692803421;
	bh=I/UiL3YYpCuIqdatC2uvJRAZCIXtBqy0CnYYJRDaLZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RUOBJgVgLFIVX730KEEWe4eKd9RDiEwl7gfDqHphBWcN3EpqER2YJ3UnPImrivKZT
	 LNX7dRkNkNX9aQ4wpVXn0XuYddd24yMSprZvY+RSl65cd/cRpRulTTE1wFltFN4yDg
	 Qna4riwsCTAB6AfdE41y9L9GcUIGMPNDPcp9t9UYuIbJ9Y98FVQUhfeMQXQjTU+eE9
	 7Xi350SzV0+2vmPLJeaO5KViErBCDsYz9Aegr6RV2I5Hf+z5FwgvjqoPQ9Dk2tv+bs
	 HDtIFqitQRCSo+6iQYkzBaRNPwQY3nSSZkTS0MbtIw07fQxPCO8Lu3W8w7cfxJNB42
	 a4IERI3cZofiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAE20C395C5;
	Wed, 23 Aug 2023 15:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] ip-vrf: recommend using CAP_BPF rather than
 CAP_SYS_ADMIN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169280342168.26154.6028605816933015881.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 15:10:21 +0000
References: <43pipyx5qleyhkai5oitdfwqokuwcevak6n5laz6wshm3n4xnj@rarv5zwhdu27>
In-Reply-To: <43pipyx5qleyhkai5oitdfwqokuwcevak6n5laz6wshm3n4xnj@rarv5zwhdu27>
To: Maximilian Bosch <maximilian@mbosch.me>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 22 Aug 2023 14:33:07 +0200 you wrote:
> The CAP_SYS_ADMIN capability allows far too much, to quote
> `capabilities(7)`:
> 
>     Note: this capability is overloaded; see Notes to kernel developers, below.
> 
> In the case of `ip-vrf(8)` this is needed to load a BPF program.
> According to the same section of the same man-page, using `CAP_BPF` is
> preferred if that's the reason for `CAP_SYS_ADMIN`;
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] ip-vrf: recommend using CAP_BPF rather than CAP_SYS_ADMIN
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=df210e83e0fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



