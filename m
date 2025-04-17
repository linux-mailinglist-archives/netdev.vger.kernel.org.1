Return-Path: <netdev+bounces-183716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48555A91A88
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECDE5A7280
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1123A9A6;
	Thu, 17 Apr 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA8x/lHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0323A99F;
	Thu, 17 Apr 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888797; cv=none; b=m0p+hmsTBFSo8pnhIIAH+Xj4Nm95bFXXq+a3zt7mSdWWR1lIvOByJr4kIvGSj6Ti5jQ4yvOk4m4y066Z608qFIJnrxkH97ogX8FmSvvpZH84cKDc7Ykqhc24WSlzDRT10HnoUTqkg3RnV9TFclk7A+DvB+p0koUuA2sOfGRhDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888797; c=relaxed/simple;
	bh=NE5pT/y8MY+0VdoKpg7plUTLCtrjr+cP/H1ACYfg2+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MBUnv+VzkVZ3neMr2M4wkTMMjv13KjUfKUE1Ppnf84htJmkv0a4y+blBJui4RKwE5vNqKRIE+LlYeT9zaUF62glD0+o/oFTOXgNwFpzsABtMx6tKlK0Eh+e0wtxP25ITeW56LdGXF8twlsvLM6I6X2KJex74PcgltPDwrVTYRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA8x/lHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B68FC4CEEA;
	Thu, 17 Apr 2025 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888797;
	bh=NE5pT/y8MY+0VdoKpg7plUTLCtrjr+cP/H1ACYfg2+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JA8x/lHDYRltmdceVJiaysjVGVEOOZbcIx4zoRWk/R1yT0+eKPDORfJ1WZ7oWYzFY
	 rKLXCR4IENkBdFFBERmfI4hwq+DS6Px8VBXz1SUgNRerBU64V9Z1lm6zfFZ/tB4/ES
	 hbGXg92EapzQBL7srrwnoqdO8f1GTyqHlEOXQ+A7FRF5oJ4ihfz750CPx22wwkpL0J
	 ARb+DpKiahBQc/j7HSF9LHzuuZwxTCuxZcyPuCpJI6zOws/Z0tOaa6zDE7h31fDElJ
	 gI5jqHVQ5mI5BnG+7+fHjO36KwMrDSekDLjTMYkwGRy6/aOVLzznDIpaFHSJGJCzEJ
	 x/2mBVO5sNR/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4C7380664C;
	Thu, 17 Apr 2025 11:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-04-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174488883552.4039084.17774428301828701540.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 11:20:35 +0000
References: <20250416210126.2034212-1-luiz.dentz@gmail.com>
In-Reply-To: <20250416210126.2034212-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Apr 2025 17:01:25 -0400 you wrote:
> The following changes since commit adf6b730fc8dc61373a6ebe527494f4f1ad6eec7:
> 
>   Merge tag 'linux-can-fixes-for-6.15-20250415' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-04-15 20:05:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-16
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-04-16
    https://git.kernel.org/netdev/net/c/a43ae7cf5542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



