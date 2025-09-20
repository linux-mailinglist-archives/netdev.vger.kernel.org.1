Return-Path: <netdev+bounces-224943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D035B8BAF8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2EE7C0F0C
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A61DF751;
	Sat, 20 Sep 2025 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8OF9uEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0401DEFF5
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327625; cv=none; b=TuiUYc9gm+0VTF7z7FEQhik5Qn0vBsFCiZC/uw8qxIupFuTkZPNi3ikMdfSBNyWqV3NHWMX+PzuzwnSelyTzp9bJe0WV6OiQ0aGkYv++Ky4GXXB88m1iucAR1kQj+A6cab2s2AuDjGqN65aSPBeVX4RRQ/H/GAM5p74P59ICH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327625; c=relaxed/simple;
	bh=O2Bwabw7f/KJgCFr95NMx/e0rgCRQ8VVma2j94hW9W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B2O8G/TPdzRATP5UH5Po+RD+4p8QtKlHJZswoMRgjvaqJifz5h/lfCG5Vyh4Jo44gfmUYBHYCEk2uiY4TY51RKwPoNKLM8vaty2i1A7OO+sASWKHrn0zcw707llrBicd5OeLknN7z9kjTYBvIvm+4ddOoji2ueojMCv01GCk0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8OF9uEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB098C4CEF0;
	Sat, 20 Sep 2025 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327624;
	bh=O2Bwabw7f/KJgCFr95NMx/e0rgCRQ8VVma2j94hW9W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L8OF9uEIPdtXMPg2sU0x+eOIpFfhj9L5pEWqu/QlI9vo7YPjbNqkJ7/HbuS8EiY7o
	 xBSXcIEwS8D0yHkYzlUQCkuSxFE1LUems7AfxH2ozD489/yLIlkhW9UtU/S9rscK4k
	 ybRf9mn2nPiLV2h5Ti0fxemA0wRhMcDRtu6q1CUAN5Sf0RrDAwB2j6H0sNJrO5qc6F
	 tXpRawhi2pMrBFPrKXm9Oy+HMJVwYh+wzg0B53gYHewtLwKN7m4/llhe+t6PgQO5Wa
	 Y5L2sJLIRByBFzFsTnMscrGGc78OIW5wacx2fdUz8PjiPmHsWVQDb5+WAZ0Vnu0+dY
	 QPObqKngTFEbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEC39D0C20;
	Sat, 20 Sep 2025 00:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] psp: Fix typo in kdoc for struct
 psp_dev_caps.assoc_drv_spc.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832762374.3747217.17684872810590491233.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:23 +0000
References: <20250918192539.1587586-1-kuniyu@google.com>
In-Reply-To: <20250918192539.1587586-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel.zahka@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 19:25:35 +0000 you wrote:
> assoc_drv_spc is the size of psp_assoc.drv_data[].
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/psp/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1,net-next] psp: Fix typo in kdoc for struct psp_dev_caps.assoc_drv_spc.
    https://git.kernel.org/netdev/net-next/c/f1bf77491d5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



