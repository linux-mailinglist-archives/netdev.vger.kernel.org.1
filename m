Return-Path: <netdev+bounces-23454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8586776C031
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A9A2818A3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC7275DD;
	Tue,  1 Aug 2023 22:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59233253CE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB01C433C7;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927824;
	bh=vFfNe2cULCD3iYjT1tv7ykc807rfnxX+TNkhyQJACDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owijtuu2CpHSHvcCx26nG71ISgiaus6jMaejRO6SNAwEdsVjTIPn+4aTQXFbmEnLH
	 qcYellIiMYIJPKqKN+ZcEG/5e3rXnrlcvX1gpIFCVtcOznfpGFWSXtXnYKSVA8gxU7
	 6oZOtXoD3gZErf8v/YR9fc/QOxLH9+9LyQw52v+m31/dN4TUnwEIb4ZCSu1AnZSSFI
	 zObUcf6I0rdWQq39WjPyHTzi2kwn1tTKetBj97HaGaIL2BQfSU3gma+8Sywb6ndE4W
	 KflLAKtcjWxfgREICTLYO2b/w9kX7/9OzrQOjyxCtknEzYuKgUpk9pXFRm/15j6xo8
	 BzO3ZG1HB2/3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9ADBC691EF;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] selftest: net: Assert on a proper value in
 so_incoming_cpu.c.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092782469.18672.9779931482157312871.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:10:24 +0000
References: <20230731181553.5392-1-kuniyu@amazon.com>
In-Reply-To: <20230731181553.5392-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 11:15:53 -0700 you wrote:
> Dan Carpenter reported an error spotted by Smatch.
> 
>   ./tools/testing/selftests/net/so_incoming_cpu.c:163 create_clients()
>   error: uninitialized symbol 'ret'.
> 
> The returned value of sched_setaffinity() should be checked with
> ASSERT_EQ(), but the value was not saved in a proper variable,
> resulting in an error above.
> 
> [...]

Here is the summary with links:
  - [v1,net] selftest: net: Assert on a proper value in so_incoming_cpu.c.
    https://git.kernel.org/netdev/net/c/3ff1617450ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



