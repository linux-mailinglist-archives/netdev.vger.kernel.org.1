Return-Path: <netdev+bounces-60897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA8821D0F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877D3282609
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73876FC02;
	Tue,  2 Jan 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+LnktMn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C5125D5;
	Tue,  2 Jan 2024 13:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB85EC433D9;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704203431;
	bh=6IqGUwbS5Nj/uWqmnYGoibvQ3Ou6BAF8Helju32xKJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+LnktMnTeoTuuIWDLDAHotGPVU3pCZSwVKS0/wR/qgt/dN3Ux6GY59oQ6q+I/C8X
	 aW1jg8kNoJv4ZFAXlwxA8so3uzxpVABmZ6F9Y0nhZtcm05gtmLdxbZgo6N3jiQm6hq
	 qEWkq3p49LhfsrJ8M9p27nTr1gOfa1wHrp6tkp9ZIXEmRDF24FQ0jr+lE96FKX62xH
	 goBR2XsrVZSBdp9hB1N0EXu15H+3+lEYZQcA+8ksdjW13+IszwuvQFCHgfxKvKMmX5
	 xv9Rbfx0eNSftRz10fm51I7s14t8GfP83oarrpB8KdStiz580545cXUw0Yoepdqf3T
	 ZGHq5XFucbWgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD406DCB6D0;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2023-12-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420343083.29739.6967311595901529200.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 13:50:30 +0000
References: <20231222184625.2813676-1-luiz.dentz@gmail.com>
In-Reply-To: <20231222184625.2813676-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 13:46:24 -0500 you wrote:
> The following changes since commit 27c346a22f816b1d02e9303c572b4b8e31b75f98:
> 
>   octeontx2-af: Fix a double free issue (2023-12-22 13:31:54 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-12-22
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2023-12-22
    https://git.kernel.org/netdev/net-next/c/8a48a2dc24f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



