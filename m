Return-Path: <netdev+bounces-24700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649977713DF
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D86D2813B6
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE8259A;
	Sun,  6 Aug 2023 07:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711023B7;
	Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57B41C433D9;
	Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691307622;
	bh=Bam6N1dYm20mOTjZTEj2DEAzIMxdEcmcfrPsLZbH6U0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EMF/fh3fkVw3JCZlEJoUyH02FIGagIvDeMSJeXWCYRwbniEbN+eXa4oXkcdtWgK/c
	 80XFJz+SkFLFL9mLeOL6o855y2roYf1mKSLaWyhr088DSaRKiJmkZu6fz+nRy/KDOF
	 F7xVSlXE2YaI9ccJ85LJhyJtdOX52WDKEyevtIP4n5QV7NxFtbzDs54okST56knVNY
	 7mxGePFrNj/HeT7tlLLI37LEufLUOvqQN4zr+CMQfpl0LFOBzo2hZTdPmpA9Nnj/N5
	 2k1PtoWd/SAWTFkjaNWW0JvYfghrhCvYC47Ea1nMO70F3ZBLSYOSitnOm092qmd7Of
	 vxKiGYsRTTygQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 352ACC73FE1;
	Sun,  6 Aug 2023 07:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6,net-next] net: mana: Add page pool for RX buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169130762221.9536.13208185445739206217.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 07:40:22 +0000
References: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 kys@microsoft.com, paulros@microsoft.com, olaf@aepfle.de,
 vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 13:33:53 -0700 you wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> With iperf and 128 threads test, this patch improved the throughput
> by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to
> 10-50%.
> 
> [...]

Here is the summary with links:
  - [V6,net-next] net: mana: Add page pool for RX buffers
    https://git.kernel.org/netdev/net-next/c/b1d13f7a3b53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



