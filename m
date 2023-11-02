Return-Path: <netdev+bounces-45703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D657DF1DC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7891C20E3B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9B14F86;
	Thu,  2 Nov 2023 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0XUspGD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD914F6E;
	Thu,  2 Nov 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E988BC433C8;
	Thu,  2 Nov 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698926424;
	bh=Z32Rs3pGCBmghy3mdxI1n1S0eXbTLmN7BHJA9eLZN68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L0XUspGDU/fsERrq9n2OH/zzwAjTetTHMp9Lmfh0e8y9BXx22if6L8P0fkdIedS0w
	 /POEcMBKI87OQA2dHrVgjS5Gm7ZdT8j4yeKp7Na+FWUC3zg84le5rAlRqW4bLS+Enr
	 JUuwim+nzjyiuCVoFR99OKmn+I9ZsJwoGP2B2/RNOHdAImaWbYVX2b6pMTc9m45KM3
	 y7Lc8xyF0PqL7IWkvlKT/mWdmgAR/r2jkMSQVzweTfjAupvJrShX8iuZo0B4N2Ljgu
	 TsM8lPQUhnpPmxrqJiEAd+dkVHkfxlo4a6UmKS8snoFd6QUlFglbRaqrjurnXLudFL
	 RBVJJgYMiR0Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2154C4316B;
	Thu,  2 Nov 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix documentation of buffer sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169892642385.2809.13321976556181124228.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 12:00:23 +0000
References: <20231030170343.748097-1-gbayer@linux.ibm.com>
In-Reply-To: <20231030170343.748097-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, jaka@linux.ibm.com, wenjia@linux.ibm.com,
 tonylu@linux.alibaba.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Oct 2023 18:03:43 +0100 you wrote:
> Since commit 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to
> specify same buffer size again") the SMC protocol uses its own
> default values for the smc.rmem and smc.wmem sysctl variables
> which are no longer derived from the TCP IPv4 buffer sizes.
> 
> Fixup the kernel documentation to reflect this change, too.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix documentation of buffer sizes
    https://git.kernel.org/netdev/net/c/a1602d749097

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



