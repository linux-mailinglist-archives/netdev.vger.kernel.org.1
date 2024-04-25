Return-Path: <netdev+bounces-91158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE578B18FF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C517E1C22E7D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD65134BC;
	Thu, 25 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruAdIV8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E011711
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012829; cv=none; b=gwOYlcyAdRyzGMELKdUME39nrkKjG1Ef6SOVvELRTwmm1mkRZkhIAgcL/DTMg3Xx5xFM3JMACn+yxcdfmDvCrrtPw3c6NvK6WLuiJnfqj3y75Q+l/y86rYnJK8iV1xWU9TmVDIk10w+rgfWAYiCnEZcYtqiwkiUcjhng2OTXR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012829; c=relaxed/simple;
	bh=uHPG9IwV+/VYvSIs0IBoqHhNMeccdRmM8y6X1/llZjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BK9kSQkRO/zaFYuyXSe6q8p5L/U15C5mtBnEzIp7yM1hl8EjHMBtGwWV2QpxZcYXLYs13h/8RyZyCZy82Fs6sqkulUfkDEtdl2zgqCtHbcBQyQLb3cRnz9Gi6j8/XpVjTcHIgpoxQ9JjZnbe9RHN+5rXlvg0PZ+zLnUgf09Nvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruAdIV8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454D8C113CD;
	Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714012829;
	bh=uHPG9IwV+/VYvSIs0IBoqHhNMeccdRmM8y6X1/llZjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ruAdIV8fuIZvFFD19B/bEEQrtuMEpqJCFdeID80JXbyyxIR/iWqdx7os3w1/iICQR
	 RyxbdDXSPG6n/EgbdN21uv80myg+vRaYtYATbS/EkKd4upBKr81gZ7IWEbuWRwurUX
	 t3KMD8uhuPW8ut67AbcS4HijOP8J6Zx/ANObMeSlHd5QfBBHAGqztFy3WnOt9aW4tE
	 /kWvfKfX0nLOV4gqlQ5KZnU0aFbThmbqUkl3Bq3laobmfsbASXn+YvGGVaMIzp/DR2
	 T6wCQesG2WeCkoja21YjVB3TZH/L5aLtUZjv/9+Yq0SS7P3XGQLK6d7OhQxN0HYlnt
	 MTAiuCKkCOnkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36D90C595D2;
	Thu, 25 Apr 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mlxsw: Various ACL fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401282922.22297.4320844200193212206.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 02:40:29 +0000
References: <cover.1713797103.git.petrm@nvidia.com>
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 jiri@resnulli.us, green@qrator.net, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 17:25:53 +0200 you wrote:
> Ido Schimmel writes:
> 
> Fix various problems in the ACL (i.e., flower offload) code. See the
> commit messages for more details.
> 
> Ido Schimmel (9):
>   mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
>   mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
>   mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity
>     update
>   mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
>   mlxsw: spectrum_acl_tcam: Rate limit error message
>   mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
>   mlxsw: spectrum_acl_tcam: Fix warning during rehash
>   mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
>   mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work
> 
> [...]

Here is the summary with links:
  - [net,1/9] mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
    https://git.kernel.org/netdev/net/c/627f9c1bb882
  - [net,2/9] mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
    https://git.kernel.org/netdev/net/c/d90cfe205624
  - [net,3/9] mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update
    https://git.kernel.org/netdev/net/c/79b5b4b18bc8
  - [net,4/9] mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
    https://git.kernel.org/netdev/net/c/542259888899
  - [net,5/9] mlxsw: spectrum_acl_tcam: Rate limit error message
    https://git.kernel.org/netdev/net/c/5bcf925587e9
  - [net,6/9] mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
    https://git.kernel.org/netdev/net/c/8ca3f7a7b613
  - [net,7/9] mlxsw: spectrum_acl_tcam: Fix warning during rehash
    https://git.kernel.org/netdev/net/c/743edc8547a9
  - [net,8/9] mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
    https://git.kernel.org/netdev/net/c/b377add0f011
  - [net,9/9] mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work
    https://git.kernel.org/netdev/net/c/fb4e2b70a719

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



