Return-Path: <netdev+bounces-37321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0B7B4C47
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 23A3A2817C1
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FD17C9;
	Mon,  2 Oct 2023 07:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFB17C3;
	Mon,  2 Oct 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 974CCC433C9;
	Mon,  2 Oct 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696230623;
	bh=Qz9f+JOAES8NGqHKt/UEN6UssKaT0glPTgdb17pk8gE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AWMT0ars2iTB1rAPVv8pHFs/T250GSL6vckhVX7jk2NMN2v7D9YCRkElb29UFGGR0
	 UeOBVC5r8neDccR4/+Aa1oej1VUzblgwiqMIqK9Pb84ZO6sqeLgD4lBy7ThOcLuMuY
	 znxVcybXZ4PkgFUMp9zBUifQFx+dDLDnYuKO+TMJ251rUGW45+CYpi/Zjn1gxPRVyG
	 8nlJK6DhQ3EZI+MAdGPiR7uC8dkYWBYSD6SSxiAfHrNHSuBJZlb8Iam9386k2lkfJC
	 6IAQNISEM3s+g7kjJMlnns7ahGEKol3pjkPJFIVuwtPj5fXmz69ZeQE6L6DMiUN0po
	 Oy42eMNRF6+ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77D36C395C5;
	Mon,  2 Oct 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] sky2: Make sure there is at least one frag_addr available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169623062348.24181.10859418276789667320.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 07:10:23 +0000
References: <20230922165036.gonna.464-kees@kernel.org>
In-Reply-To: <20230922165036.gonna.464-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: mlindner@marvell.com, stephen@networkplumber.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, lkp@intel.com, aleksander.lobakin@intel.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 09:50:39 -0700 you wrote:
> In the pathological case of building sky2 with 16k PAGE_SIZE, the
> frag_addr[] array would never be used, so the original code was correct
> that size should be 0. But the compiler now gets upset with 0 size arrays
> in places where it hasn't eliminated the code that might access such an
> array (it can't figure out that in this case an rx skb with fragments
> would never be created). To keep the compiler happy, make sure there is
> at least 1 frag_addr in struct rx_ring_info:
> 
> [...]

Here is the summary with links:
  - [v2] sky2: Make sure there is at least one frag_addr available
    https://git.kernel.org/netdev/net/c/6a70e5cbedaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



