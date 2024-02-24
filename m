Return-Path: <netdev+bounces-74663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22476862271
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6302842FB
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAB12B66;
	Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw+WMFqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FB6FA9
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744233; cv=none; b=II7DVsrUE8VxOSIam9uJFlsU5jm0EutuJh2YUtNLtkaoxU3A4Dkc44uoauAu338Rqc4IVt6ze8GCxU8iSg+SkmeoBhRPgefa+IsVad7c1/WivldZyAlPCKzSR/yP8IFUaNIGXbyenJTRlpiR4APxZN9DtV4wzAYCpqSfNRvsB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744233; c=relaxed/simple;
	bh=56BbwAi1o33ZaLk88xEYTZVev6/M6U1Y02nM92hummI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p31zz2vFAU+qKD3N4eUTyF6EBwz/DEbP5hdtbNvmVN3i3sXdJ6WpTnSB7+QWrij+vwkEhyxifo0m2llMHQ5mQRTDlHIV8OXsoeWqDBET8ictML+m+hCkiNHUpEMZd5Rky+wnGLHGHmwCccvN6ny3VR/PnaAzLSClbYzvW+oW2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw+WMFqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC6F3C43394;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708744232;
	bh=56BbwAi1o33ZaLk88xEYTZVev6/M6U1Y02nM92hummI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aw+WMFqLtvDCqvV92ZougZKvKs385wrClvp9ddwUZsS+Hu/xu0f2Zel1XFcKqSSiJ
	 Avi2JKbOLzBXNbt6DJHw/6iIerU7GidXY/G6VAIJkbvc58UNPy+IqVtMbGqYlkHcy8
	 XoUBWg0Ts+9wFNKfjuZd9dns8EcsfmvR1uCkOypjh6jO+dfwMNkgXNSA5W3e9jN9L0
	 N4Zk1xskm1fuOXMvbNgJk+AquqZjhWUwNRm1YxIUmzAn8YVsLJDRfwgVGIbS2fqfnr
	 XLMadyj9CL0uC96XKFPzneeAn7DQ4cnq2ze6tKLEpXxq7gVJzYZ/UkZ0YM/M4OksPd
	 p8HV8nNuyaqdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C127FD84BBB;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3 0/3] tools: ynl: couple of cmdline enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874423278.898.5856223605403948581.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 03:10:32 +0000
References: <20240222134351.224704-1-jiri@resnulli.us>
In-Reply-To: <20240222134351.224704-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 14:43:48 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This is part of the original "netlink: specs: devlink: add the rest of
> missing attribute definitions" set which was rejected [1]. These three
> patches enhances the cmdline user comfort, allowing to pass flag
> attribute with bool values and enum names instead of scalars.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] tools: ynl: allow user to specify flag attr with bool values
    https://git.kernel.org/netdev/net-next/c/ac95b1fca034
  - [net-next,v3,2/3] tools: ynl: process all scalar types encoding in single elif statement
    https://git.kernel.org/netdev/net-next/c/ffe10a4546fe
  - [net-next,v3,3/3] tools: ynl: allow user to pass enum string instead of scalar value
    https://git.kernel.org/netdev/net-next/c/e8a6c515ff5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



