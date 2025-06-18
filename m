Return-Path: <netdev+bounces-199243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93ADADF89C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EB8165C0F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB627A131;
	Wed, 18 Jun 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFSa7lIm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B67279DDE
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281591; cv=none; b=pKGqBiPw4HNehl4NjiWWH6kz/qMMjlJAjT1YzIiP/hNlCNaFSuVPMMjI7FdV5RYTSQBPKkskK8JbNcyndc9t2fbKlZlC98DamftgGkPJqlDWIe1r/fRkGBnwycW6RdNzom5jc2HrwCS/TOZs+px7GtGjXqMazvpprqJqA36biUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281591; c=relaxed/simple;
	bh=Kg/yycnopd+i1vqgDuW5Wi7ezJiyyRDh3Lz+AHX4rCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sGvuT2P6w+G2OdNDxqfYZp+Ub6ckscGFBf7L5GXhwYZ5S6w5fNjkKc4X18aK5I1Q+/Y0OZ8pKJuzthmRVzFRVVMxge873NTVxXCsr2LQprYx0mZdnOOdW8pyKC5e2b6ptx+8ZB4L3He3a6GCAVrNbZFPAK7eMvbubWeza4yLhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFSa7lIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292F2C4CEE7;
	Wed, 18 Jun 2025 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281591;
	bh=Kg/yycnopd+i1vqgDuW5Wi7ezJiyyRDh3Lz+AHX4rCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RFSa7lIml6HC4EqWJjE4/lAZDV8sL8nGpCZON6OHKZ2E2YHXJuIgjlrI96ZZ4OQKj
	 dF0hU+5645oDDZG8KeowLDW9bU/7YvTMew6s/ucpxUaO7VLKewRWGoQqq7fwo8iryz
	 uSIF1ccmVlvuWDyuQtgjsbFULD2qXswmN5keQmMVRlGnvyT79ncOURrYgFibpasz8E
	 yMrp4WU5XbaiEbRW1hn97cahhlP7+MpEoxU5qgxOSRRpJoD/ueywJxXtqfYI+IT7hv
	 lvKjUf54bjAuTeSOTns77+LZcxsqzGAMuiv9CWfO+2Dq8VfeL65uNv1j5fwpymXQ+g
	 bQeNwP/a0rZjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAE3806649;
	Wed, 18 Jun 2025 21:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net/mlx4e: Don't redefine IB_MTU_XXX enum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028161948.259999.14361453597066990153.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:20:19 +0000
References: 
 <382c91ee506e7f1f3c1801957df6b28963484b7d.1750147222.git.leon@kernel.org>
In-Reply-To: 
 <382c91ee506e7f1f3c1801957df6b28963484b7d.1750147222.git.leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, markzhang@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, phaddad@nvidia.com,
 tariqt@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 11:06:30 +0300 you wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Rely on existing IB_MTU_XXX definitions which exist in ib_verbs.h.
> 
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net/mlx4e: Don't redefine IB_MTU_XXX enum
    https://git.kernel.org/netdev/net-next/c/e0e3265acf5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



