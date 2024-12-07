Return-Path: <netdev+bounces-149867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49B9E7DC6
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A025F1884AC1
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AD1798C;
	Sat,  7 Dec 2024 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzq+flkb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442317597;
	Sat,  7 Dec 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535618; cv=none; b=KKx+BL5HA1APdTeaHMqOpigDmej5rWzTq+ZdCSwNRTo1i2uPtMGGNt3ju7mAQ6VKi+vnLnQLgsLHanL+0mLNruKc19ddCB1zQ72h08h77A3XaIK9AK7bb46fo6PfnGs5J0dxdCrIGf20YVESC3vLUSqMxEW/ioXBLodDszoBbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535618; c=relaxed/simple;
	bh=A/0Yl74m2xBiA/+jaRSTm70HYXXe2llIlRgyWbOAj8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tekm3QVGAa5rNT6cB8LQYuY09Ii+otpi/qKbpVy1bQuJqglDsFHpm2adzgc68d2tTUMRCAMn0xn8vTcXbHB0vimK4sa7THPM5UiABH5YmwZ0bi1nqCwxiJ3jeobnP4lcPFcwMDfcHt9uOu5J72GsM22KPcvsOpQ7piuGpgH9hlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzq+flkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70FAC4CED1;
	Sat,  7 Dec 2024 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733535617;
	bh=A/0Yl74m2xBiA/+jaRSTm70HYXXe2llIlRgyWbOAj8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lzq+flkbUQjfDw0tQy+ft4Xgf/dVBnuydRKwgHt5iOZfcRssjWSxAHDXcE/Wz8Rwx
	 CuiHEgQkiDj8ZDtuej/C4Nmw6jt49+XNkO3gAOp9XtZ4YeMAEf/8rRxzZG3wnipSfw
	 zYQkIRmL4Ta+2YJ4LpHhY/pkOkoKoUGqkQFB+45lE3Gr3YdqY9Q4EaJitnNVpO9bWv
	 ldDNHQb9a3aN0At47vMZkM0wQStCN8rocee57bXL407hpKL9ftPwJLZrR6uk+18rXQ
	 +fEo+ogYErrfkfkfly/5qZuEISp6LLnkNETT/xT/4iUXQTew1W3ZBZv5p2ElzSOoq+
	 L7e66r76KqEjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB387380A95C;
	Sat,  7 Dec 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV
 from kvm_arch_ptp_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353563276.2868165.3680363675119521922.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 01:40:32 +0000
References: <20241203-kvm_ptp-eopnotsuppp-v2-1-d1d060f27aa6@weissschuh.net>
In-Reply-To: <20241203-kvm_ptp-eopnotsuppp-v2-1-d1d060f27aa6@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, jonathanh@nvidia.com, maz@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Dec 2024 18:09:55 +0100 you wrote:
> The caller, ptp_kvm_init(), emits a warning if kvm_arch_ptp_init() exits
> with any error which is not EOPNOTSUPP:
> 
> 	"fail to initialize ptp_kvm"
> 
> Replace ENODEV with EOPNOTSUPP to avoid this spurious warning,
> aligning with the ARM implementation.
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from kvm_arch_ptp_init()
    https://git.kernel.org/netdev/net/c/5e7aa97c7acf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



