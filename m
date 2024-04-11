Return-Path: <netdev+bounces-86843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E768A068B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F628AAAF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B113BAD0;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isaruOwM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFA13BACB
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805030; cv=none; b=m6DfP2A3mL2MUEI2t8Fj2BT1nWmLrLLaknrED+0bsgeF8f+LqpjfhPBjLcJpp4EIt+aCsf+ozS2TGLj+Of4QUh54pmSEs0r276WgwDJ3KxvpGk6aOKuGPgC4bK1HjdUpJxIZ/WbglZy6rFO9rY0peObHw2oLwWBAwV2D3bp/I9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805030; c=relaxed/simple;
	bh=oilUbW+s111NWfm0xVjT6sMiyPEomly+mHk0yhaP/uY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t5zqwC+craPKI377+CqV/3lGay8JUe5vNVQOjSnK6SqiBNmy/KyS1dfTL5N2aJvWUduRqTjIQeLZ7rPgLzCHGSPE4O+kN8TSYnLBJPvHcZ6ztaRgVKANVU9kl97ktK0JOgHtmFV8zR96/4vzVAqC2n9VrhctUe5evxKzP+EdgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isaruOwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE7AC433A6;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712805030;
	bh=oilUbW+s111NWfm0xVjT6sMiyPEomly+mHk0yhaP/uY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=isaruOwMo4nHgoO00FUa5uBCmGoMch6BcJrw7hpAfSjpiefvdHAZJWteUNIZWmClt
	 fBi7nEhcmn2RQOlAFROt7SCPD8KHv881cbA0G/bzshoXXXefNcFpyn32tNI+cgO8qA
	 bQmDBaMDgH2Rk7BuRbxlF0rVBSGQ/MGe11m3ZROfMZfBxR6sG3u4gZqyzy4mxkWai8
	 y3CX9tKgy4w8agelcI9y2R38SeNHjEfNO5dLu2D5tEks9zsEEtuQfzI9kuY2Ha2gKU
	 wIilJjpQgVXf0Lz9vY+XPlUU8kId3OI61NxMcRtGXRNiZLB2+Igpt4durG5RoIuxRg
	 oXUUCcZwvHLkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ACC4CF21C5;
	Thu, 11 Apr 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_ethtool: Add support for 100Gb/s per
 lane link modes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280503010.8263.5083912301420690819.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:10:30 +0000
References: <1d77830f6abcc4f0d57a7f845e5a6d97a75a434b.1712667750.git.petrm@nvidia.com>
In-Reply-To: <1d77830f6abcc4f0d57a7f845e5a6d97a75a434b.1712667750.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Apr 2024 15:22:14 +0200 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The Spectrum-4 ASIC supports 100Gb/s per lane link modes, but the only
> one currently supported by the driver is 800Gb/s over eight lanes.
> 
> Add support for 100Gb/s over one lane, 200Gb/s over two lanes and
> 400Gb/s over four lanes.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_ethtool: Add support for 100Gb/s per lane link modes
    https://git.kernel.org/netdev/net-next/c/930fd7fe10d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



