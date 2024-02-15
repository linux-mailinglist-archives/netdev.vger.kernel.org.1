Return-Path: <netdev+bounces-72063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960B856689
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA6B28CEFB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29D132470;
	Thu, 15 Feb 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ows7gMnZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C5132461
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008634; cv=none; b=Siee8fxb1r2GKfhxB0H4y3w6O3wVEdg3NxU/r02aNbOWJCMSwfrSQLX0NmdMb8quNqC35LOGidcV+OXU4RGd5npukpZbdf920838fm13wTO8mm/bdQ9zktSjzcBmUTNDs+Ovtwn+LtiJgpNpOPVof3KvEq72UDoWsI5DNZfXM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008634; c=relaxed/simple;
	bh=tDtVaGbMZsbqE7hB/GV615Cxxw0rvKvYpsW3wAUS+/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gheDNNHf1ZhrAbm1PzMKRO42UXzDH6IR0vHGDENe6lrVfO3JE0sC/+W1I7nlfoJaGmF7grwNICPhxwUVK55QxyqvY1STrIqE7rK8ez+mE2m5uAEA5EVyUzfcdsq1NaK1ededqRKFO1OPD7zWjP3UkWciIIBHVBYpaJl8IwWgGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ows7gMnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF7AC43394;
	Thu, 15 Feb 2024 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708008633;
	bh=tDtVaGbMZsbqE7hB/GV615Cxxw0rvKvYpsW3wAUS+/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ows7gMnZXr0gIxVvOll1kd9vozUX+4M4+ey2rw/gg1+qCCxxT/G2G91tJYQ3iT7WV
	 H/2oiei2dwfgtoeBJGFc+AKq0d+WNRzb4/EPTDiXBJanJJBecJHJFBignQO78ROOPF
	 Z9aIz1gw/z+fKt9b8qXwfXdrfcjrCdEkF1MmaFuVNBrD2DSB+duQ5vYyfV0y1uVXNG
	 YtQR92wpd2ikyX8ZrQOlDmIn/e2DqsC/UlmA0bPbbCI5KvjY9c3V8R/JQ+I06OFnW7
	 MxyvZ3HCynxZ/fr1M8odW2O5Szubi/Fvm/PtgQnfz4u4f+B+NxF2UNBNnj+PZ7L743
	 UFtPrOokSG3kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE77EDC99F3;
	Thu, 15 Feb 2024 14:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: ipv6/addrconf: ensure that temporary
 addresses' preferred lifetimes are long enough
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800863377.28024.11410184388510630455.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 14:50:33 +0000
References: <20240214062711.608363-1-alexhenrie24@gmail.com>
In-Reply-To: <20240214062711.608363-1-alexhenrie24@gmail.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, dan@danm.net, bagasdotme@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 23:26:29 -0700 you wrote:
> v2 corrects and updates the documentation for these features.
> 
> Changes from v1:
> - Update the typical minimum lifetime stated in the documentation, and
>   make it a range to emphasize the variability
> - Fix spelling of "determine" in the documentation
> - Mention RFC 8981's requirements in the documentation
> - Arrange variables in "reverse Christmas tree"
> - Update documentation of what happens if temp_prefered_lft is less
>   than the minimum required lifetime
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
    https://git.kernel.org/netdev/net-next/c/2aa8f155b095
  - [net-next,v2,2/3] net: ipv6/addrconf: introduce a regen_min_advance sysctl
    https://git.kernel.org/netdev/net-next/c/a5fcea2d2f79
  - [net-next,v2,3/3] net: ipv6/addrconf: clamp preferred_lft to the minimum required
    https://git.kernel.org/netdev/net-next/c/f4bcbf360ac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



