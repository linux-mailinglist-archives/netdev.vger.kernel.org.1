Return-Path: <netdev+bounces-29171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70257781F2A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261B81C20844
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279963B7;
	Sun, 20 Aug 2023 18:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF617F8
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F47C433C9;
	Sun, 20 Aug 2023 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692555205;
	bh=/kpJeZbH3cX6qT2GDtIuHy2iJvRa2GYhxoTx6CJOFFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXp8N2pS3j1Rb+VfljKd5QPj9dtcUAVoSDyX8WpiLtnSv1WfKXk/pxlvwrrxPNKE0
	 RdPTNqZfetiHBrctAspxP8A3DeG2hNy24+GhnC9OLmJmtL/CGTTgYgwx0TDNgVYbgu
	 47d8Qv7cuehiveyQEh0KfBf1IYgAcLpDghX+aB1cTQQUiFWIZRcHoAtxiIp5cichLv
	 o9bZQZSRsuOMgMmtYMxrXEbdrbzBAFypjNfn4ujqTpdGP7EhB5yVz7PL7P4whhMS4p
	 GqAvEjlrtFEGBfOP+Tsbq2QkAjewtUVL+BNOkmADfvSfpK6RS3JjXQ6PZt9KXrLTu7
	 OyxF3113TiuYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1084E26D32;
	Sun, 20 Aug 2023 18:13:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] selftests/net: Add log.txt and tools to .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169255520578.4244.2265053947731100162.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 18:13:25 +0000
References: <20230818173702.216265-1-tuananhlfc@gmail.com>
In-Reply-To: <20230818173702.216265-1-tuananhlfc@gmail.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Aug 2023 00:37:02 +0700 you wrote:
> Update .gitignore to untrack tools directory and log.txt. "tools" is
> generated in "selftests/net/Makefile" and log.txt is generated in
> "selftests/net/gro.sh" when executing run_all_tests.
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
>  tools/testing/selftests/net/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v1] selftests/net: Add log.txt and tools to .gitignore
    https://git.kernel.org/netdev/net/c/144e22e7569a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



