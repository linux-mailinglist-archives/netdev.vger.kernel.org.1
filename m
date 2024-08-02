Return-Path: <netdev+bounces-115268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364DF945AFE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2E71C223AB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969D1C3F04;
	Fri,  2 Aug 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCrl3QdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42851BE87A;
	Fri,  2 Aug 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591033; cv=none; b=Lwoj0DEFFdyxerWV8NV72TT9xO6MyZAEf6hPkChxgMkYst8GF5M5cIeEEcJL1ixgBieWddKY1d0WA1fbrqgzN9SHSk5/aARuF+uHFg9Ub04WpdbA6wCwtio23nmxofJhtCkKIhbzcjKpBvGOPFNGb4jhXiQmnd8B1PiCKvpO/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591033; c=relaxed/simple;
	bh=/IXMFh19tjAOCShyyy3TVX6EbebjNsa5r9eZZCPyIOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etsZi9bQdyeglynBa5ptUurKqlUIZO6obwt/zHDitt1idBTYmz83zarWSoQSlV0ke/QsP8/EAnYcpcVTt7HjHNl5BKzRtkuVUG0P6438udAY3QJ/eT+APMAwGGmqDd7rjQuqvnVyeU/aDoHlXwQ2KUMVxPh+X5Gbk7xgCYa4qD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCrl3QdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B31DC4AF0E;
	Fri,  2 Aug 2024 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722591033;
	bh=/IXMFh19tjAOCShyyy3TVX6EbebjNsa5r9eZZCPyIOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cCrl3QdHGVFoUzsngFW0U8ZHRtQx0TvyXcp82I+c02pAcScrYyelWuO4x6iqgSQqC
	 muB/skirlNDzGRLEpBw7eS4/oIUR6uGivEo1OgNTl8oTpkUJjB9AP4MCKg6i71qJNn
	 zgimdePtoq2lrzHkeKCoklP8Mixy7yAQ1MPfCET2T73mVXzyxFARFdNyJn3R9KcEvK
	 8cf2AgPkb6ReMSD8JFM3U6I9zd9PYecg5Lv/p011ES1i4aAJnD0ZqlUUZvcOa7l1np
	 2OdwN87oWEk3HTTgmdUTxW7s0E0D/qDo6yihMkrPWxo3PYovF2o8uCVCKm+w93Mqan
	 koOId4zx9k5gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3842AD0C60C;
	Fri,  2 Aug 2024 09:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: axienet: Fix coding style issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172259103322.22234.2396522509666952822.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 09:30:33 +0000
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Pandey@codeaurora.org, Radhey Shyam <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jul 2024 14:46:03 +0530 you wrote:
> This patchset replace all occurences of (1<<x) by BIT(x) to get rid
> of checkpatch.pl "CHECK" output "Prefer using the BIT macro".
> 
> It also removes unnecessary ftrace-like logging, add missing blank line
> after declaration and remove unnecessary parentheses around 'ndev->mtu
> <= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: axienet: Replace the occurrences of (1<<x) by BIT(x)
    https://git.kernel.org/netdev/net-next/c/3ff578c91cd8
  - [net-next,v2,2/4] net: axienet: add missing blank line after declaration
    https://git.kernel.org/netdev/net-next/c/f7061a3e04cf
  - [net-next,v2,3/4] net: axienet: remove unnecessary ftrace-like logging
    https://git.kernel.org/netdev/net-next/c/f83828a0522f
  - [net-next,v2,4/4] net: axienet: remove unnecessary parentheses
    https://git.kernel.org/netdev/net-next/c/48ba8a1d0424

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



