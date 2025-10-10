Return-Path: <netdev+bounces-228480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30672BCC007
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7571A63914
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9227586C;
	Fri, 10 Oct 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uicikl9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641F263C8C;
	Fri, 10 Oct 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083160; cv=none; b=svzHur7xLi0wlzXLeU1zn03of1GCFAmqKIxzvzyyKswSsqaLBwGymz9saRbWZDNC83ROul4aiV8ZYLL3ABTGxh0QT5bhtVgDcWwKyitkyW71J+etqQp/RtWjIIcBTyUBg2NEdkcXy6EspWcl7LIOaCHC3/IGbEGXEaITysjPgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083160; c=relaxed/simple;
	bh=DwaEsgX63e1zNTYN11CHaSaT/RTdFghy1I1YvqLXGLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ghxkf0ymckPnwWrEPJLSO9ETMGzhMxko0t2KLvQMLpi3LnV3wt6qtMZpIoxRPOaan74DUigNZYq2DtRaMUxvLCGqOwgIlv/nrBIegUZVGXVL2GW930iBZCHK9vr1RX2yFN5H42Lw4stcNSTl1nTNPOpVXCgK7U3wDSC9c9z8Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uicikl9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5119AC4CEF1;
	Fri, 10 Oct 2025 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760083160;
	bh=DwaEsgX63e1zNTYN11CHaSaT/RTdFghy1I1YvqLXGLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uicikl9l2HQIHUmixGVo5LFo8UJl6pdwLANfexzacaAs8LEQyOuRJV7+8XKtgmQW/
	 adXhsCTVASWnma0X9aHNd/Rdj/1a9baYjzXe/QyTC7QvtRZpM++9lNI5FurDgr1XFh
	 1p8Nx+aTwItpbeh6Q91uK+0F1V2jYZE71he9or3ZODqD7/8FcTRlPCp7AQR1GPbywA
	 MaxSaP647/Bi9NpAOv9t1kJQoqMacMSdG6OkL5xFg72OhPo4ob4FUbtV6OG3FcOIsO
	 OLJUhD2RqLH32YHGgoIPgC0PCtIddxlMSxJprhA2powgkfR1F2iJ7hN8W/BTWOPj7O
	 7Ex0gp+jt2H3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D943A72A5E;
	Fri, 10 Oct 2025 07:59:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.18-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176008314800.469542.13448866333667154583.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 07:59:08 +0000
References: <20251009132309.35872-1-pabeni@redhat.com>
In-Reply-To: <20251009132309.35872-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu,  9 Oct 2025 15:23:09 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit 07fdad3a93756b872da7b53647715c48d0f4a2d0:
> 
>   Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-10-02 15:17:01 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.18-rc1
    https://git.kernel.org/netdev/net/c/18a7e218cfcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



