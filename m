Return-Path: <netdev+bounces-139769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6719B4086
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5671F22DEB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D81E1325;
	Tue, 29 Oct 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDVOuN6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6C1E0DA7;
	Tue, 29 Oct 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169627; cv=none; b=sxajCGKqFQyYCiLK8i9D8rSwc8/pBy4Ma459SyasezmQzZ00tV8wBjWaIp4desdHkzSc8HBuKo4ssgf+IUKws6VcFbfrBMBVppX6Hsc5QA7EaU+HE7nury/dtWQy22fpPGUCvcFE8L95eRkJ1oSIzCFpBPyEUFBhh5BF6MP3M3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169627; c=relaxed/simple;
	bh=APQuSZSyZY8lsOIbRAOJwqTJ3REHGadcaaLp4lQuAYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJDff8BdIbaOwbknWHJ5e73Or2NBFJ0CqypMHtwd2hHyKe2xjRWUYYX/ENObTSQnzbcJNRI85jxCqVDTYXejkILSUtOgp+9nlVrHLIWIAhSBVlKCYAK2yk9K3F6Xz/X0Ui6ISRmyvFegDmhVAb9U/mTH1gGXNNwSi2wOi+lJuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDVOuN6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5221BC4CEC3;
	Tue, 29 Oct 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730169627;
	bh=APQuSZSyZY8lsOIbRAOJwqTJ3REHGadcaaLp4lQuAYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDVOuN6PgKf6jvbCTAOV1P/hkpH83Cst/sls4tLc3nQWNm8R0LjIak08N386D2C57
	 HreBRQwFaq7+DLe8i0hTnYEEO6pdzewhzGh4mc0wbdBJrdmA+2KqjphgojhnsnYfBi
	 UTbMe3wvPEcSiHmcJv2QiXxkHsBRusDLNvXhF2Jv4+LUKUqoZiv7Brb+MlPyJRGyFC
	 pEbe+pq15ZG0xxXM/15C1bpDXfLe0gEWvcn/kqMgHterTFmMoX9PvUvb7N2X9Zy3bD
	 LhkhfJKpnSYzX6aCic/5QQB74sbLxf+UNrPBLQz7meQFnWBkGf1kbshBJGPRMdJ4/0
	 4OKtG+UctCdsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE34380AC1C;
	Tue, 29 Oct 2024 02:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: Add missing phy-ntf command to
 ethtool spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016963449.250007.4006668390954946687.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 02:40:34 +0000
References: <20241022151418.875424-1-kory.maincent@bootlin.com>
In-Reply-To: <20241022151418.875424-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, thomas.petazzoni@bootlin.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 17:14:18 +0200 you wrote:
> ETHTOOL_MSG_PHY_NTF description is missing in the ethtool netlink spec.
> Add it to the spec.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [net-next] netlink: specs: Add missing phy-ntf command to ethtool spec
    https://git.kernel.org/netdev/net-next/c/63afe0c217dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



