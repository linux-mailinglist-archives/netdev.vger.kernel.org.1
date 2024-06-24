Return-Path: <netdev+bounces-106062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715999147AA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5651F216AE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E6137750;
	Mon, 24 Jun 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEY0v4Ix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0F136E34;
	Mon, 24 Jun 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225631; cv=none; b=MaoL8mKYiWbZGe+8iveGkh9e4NNZI4LDdLH/CiGJpPJxakwuEx7PGVeY7BCcYSY+l1uts/AgimfgtsUZu+IlIgmwWgyXbu/5oksEFuiTmGc1TIhMlzMNG7JRmQ/bsJptnFV+0uALx2+JXv7a6Sg3yCgJI1ncBp8FcuxusUF2guU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225631; c=relaxed/simple;
	bh=h4lTRBwd21zqKE4SFojwMGyxCnQz2xbhnc1TwmZTVBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/5iIuTHbkDC2xhk2BNx4IwPBOw2KumBUqP+gdgUPeIuHGljyMdKOjkWyRnBbzDj1xEng2QOfYkoUQH9OZxTAbM9hk27A93bZRZwP43vf4UnZ2M7si6stJ+Omfwu2iujrfdBUSALeYo5uVk5s0+QhqL0F00vZwcUvvUQ5/CZFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEY0v4Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D86BBC4AF0A;
	Mon, 24 Jun 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719225630;
	bh=h4lTRBwd21zqKE4SFojwMGyxCnQz2xbhnc1TwmZTVBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OEY0v4IxMi05vpjvq16LHL8uAjU19ukQ4KKE+gSJhPTafLccl91LQEG3hjkwgzLfJ
	 GkegY57ZUiiIYovSuSmbZxtX6L3U0UgRx+n9C6erv6Kc1jzMwf6ztJKBVrk9l+nGw8
	 h2li/jcOdnshKbmAAEr+mCNDvWapb+R/kG4JBd4Cm49Fbuo+4zBPcGaecAelFvjaCd
	 RoYcUpGNAzNkm9TmUaMcRZHJvx3KuQZk1WNpnjdyzUlVrBXsNzarooQ1IcdHz1V+0X
	 4QgVr0NgI/Ylnws1t1YHByiKBBxW8e1zom9uOW67K90LXqF7V3/PfSX1yaq1YVunZz
	 KnKs+bPwVXl2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0119C43612;
	Mon, 24 Jun 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in FREESCALE QORIQ DPAA FMAN
 DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171922563077.15754.10710703804385085336.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 10:40:30 +0000
References: <20240624070326.130270-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20240624070326.130270-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Frank.Li@nxp.com, madalin.bucur@nxp.com, sean.anderson@seco.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 24 Jun 2024 09:03:26 +0200 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 243996d172a6 ("dt-bindings: net: Convert fsl-fman to yaml") splits
> the previous dt text file into four yaml files. It adjusts a corresponding
> file entry in MAINTAINERS from txt to yaml, but this adjustment misses
> that the file was split and renamed.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: adjust file entry in FREESCALE QORIQ DPAA FMAN DRIVER
    https://git.kernel.org/netdev/net-next/c/568ebdaba637

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



