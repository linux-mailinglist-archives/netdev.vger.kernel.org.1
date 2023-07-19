Return-Path: <netdev+bounces-18784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B3758A72
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333B91C20F04
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA4522F;
	Wed, 19 Jul 2023 00:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A95CB0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC50C4166B;
	Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689727820;
	bh=gomJX7WZdIUn68JJd90qXrXndp2wVZptSNcutFvLGKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uVTdgyI5kMXIHt3XZ5QWbBsfkCUbUvfcohqCsRY6YVU47cLpcONHkbTF/zuXGezNH
	 TGEVSgEefb7zRCbUkhwPiwxajL5rAI+pwRr87n4Q0ZdUd6GDvDJFe/ZHvoRJ0q0sXS
	 kT5xyBe/doy3VevxJOdcXGxWXlT1TymE4a8r0Gp8X9q8LRpa+vMigCHaRpAjy6oS55
	 opHckKe3sa8vI3+OX1OqHXCJZalUYtKZsyzTmOnHtLcfAJJFCdTlINXC18UiegyJZ4
	 Qrz9uwebFi+PBiM/e73C1WZJll34/cG/W0AStfU0mBOoUWRiCpxvwR9qoGV5YHHNCm
	 FRgKJEQto1elw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C364C64458;
	Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] selftests/net: replace manual array size calc with
 ARRAYSIZE macro.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972782004.15840.17484255346823026.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 00:50:20 +0000
References: <20230716184349.2124858-1-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230716184349.2124858-1-mahmoudmatook.mm@gmail.com>
To: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Jul 2023 22:43:49 +0400 you wrote:
> fixes coccinelle WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
> changelog since v3:
>  - move changelog outside commit message.
> 
> [...]

Here is the summary with links:
  - [v4] selftests/net: replace manual array size calc with ARRAYSIZE macro.
    https://git.kernel.org/netdev/net-next/c/3645c71b582b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



