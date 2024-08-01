Return-Path: <netdev+bounces-114781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EFA9440F4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4336B32694
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABC1A71F4;
	Thu,  1 Aug 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNg1moYP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9F1A6181
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476434; cv=none; b=HFMSZYLO07biiATZkDekVc7mOSuQSB97WW2Zzx6x0VYH9U59VFcjNvbnbHNVB3IyCEHqr3jgCikuh3XQojR44QMSg2yfxbjwwaufyqAeKZ0/7agtkdnbaJIG2YYlUHeXI5u+4Rbw5p04F83IYf28J382q42+5N+9f1GDnT/4qqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476434; c=relaxed/simple;
	bh=zfO4LKkgYywvwUHXG+Uu7N48jFoUO2pJ61AB5E2nwHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DxK81pufFE4Pwpe1vS5ABn1RGxulDuqq58inMAtorZvsxjeJKhSNiMNNIi7OQWrCPddG6dV90lzBI/FjOwAzPdNMBZGpWsYxP4ckJuVFinWJmTMaoM1GF6fHicQVzybU2xGA4jGzR4x4x9VM/rAvaLaXXeoGsPEw6/zw5vsbnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNg1moYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8845CC32786;
	Thu,  1 Aug 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722476433;
	bh=zfO4LKkgYywvwUHXG+Uu7N48jFoUO2pJ61AB5E2nwHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RNg1moYPm3pET0+OzpPfienfAKzOVaq8GFnAfvY5FgJGPaBqATsiDbKEl8UoENPBK
	 ltKUYySNyTTjAc9Oi5PbhMl7mvOMqRusy57WSmyDrg6Sn2cnKMboQRHPZRI7v9Hlup
	 42+lTeaMFUZ7tNdbFWgX/9XxNkJTwxO31w/A1fKrPQY1pCEC8+SrEdDjfSrrKdDwbU
	 kw1QeEWgKInHZ0xGil+UX7T9bDWOj0Mq7kw+FSQMBN/dwoRgmhx/18u/OPrAEBVBGo
	 e7mD08BjAHVbr/nx7TctlnKhMGnjmNto1S5qbI/x3tz6WPQnyIA/6pDQx6RUKEYZgY
	 mIuL68roJMouQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75BBEC4332F;
	Thu,  1 Aug 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] mlxsw: core_thermal: Small cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247643347.7213.6903623763816168922.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:40:33 +0000
References: <cover.1722345311.git.petrm@nvidia.com>
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vadimp@nvidia.com,
 idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 15:58:11 +0200 you wrote:
> Ido Schimmel says:
> 
> Clean up various issues which I noticed while addressing feedback on a
> different patchset.
> 
> Ido Schimmel (10):
>   mlxsw: core_thermal: Call thermal_zone_device_unregister()
>     unconditionally
>   mlxsw: core_thermal: Remove unnecessary check
>   mlxsw: core_thermal: Remove another unnecessary check
>   mlxsw: core_thermal: Fold two loops into one
>   mlxsw: core_thermal: Remove unused arguments
>   mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
>   mlxsw: core_thermal: Simplify rollback
>   mlxsw: core_thermal: Remove unnecessary checks
>   mlxsw: core_thermal: Remove unnecessary assignments
>   mlxsw: core_thermal: Fix -Wformat-truncation warning
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] mlxsw: core_thermal: Call thermal_zone_device_unregister() unconditionally
    https://git.kernel.org/netdev/net-next/c/a1bb54b1a066
  - [net-next,02/10] mlxsw: core_thermal: Remove unnecessary check
    https://git.kernel.org/netdev/net-next/c/4be011d76408
  - [net-next,03/10] mlxsw: core_thermal: Remove another unnecessary check
    https://git.kernel.org/netdev/net-next/c/2a1c9dcb52dd
  - [net-next,04/10] mlxsw: core_thermal: Fold two loops into one
    https://git.kernel.org/netdev/net-next/c/d81d71434036
  - [net-next,05/10] mlxsw: core_thermal: Remove unused arguments
    https://git.kernel.org/netdev/net-next/c/73c18f9998fd
  - [net-next,06/10] mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
    https://git.kernel.org/netdev/net-next/c/fb76ea1d4b12
  - [net-next,07/10] mlxsw: core_thermal: Simplify rollback
    https://git.kernel.org/netdev/net-next/c/e25f3040a619
  - [net-next,08/10] mlxsw: core_thermal: Remove unnecessary checks
    https://git.kernel.org/netdev/net-next/c/e7e3a450e552
  - [net-next,09/10] mlxsw: core_thermal: Remove unnecessary assignments
    https://git.kernel.org/netdev/net-next/c/ec672931d150
  - [net-next,10/10] mlxsw: core_thermal: Fix -Wformat-truncation warning
    https://git.kernel.org/netdev/net-next/c/b0d21321140c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



