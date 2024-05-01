Return-Path: <netdev+bounces-92748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B637C8B88C8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBD2868DC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E055E5C;
	Wed,  1 May 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naYtIrMB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648554FB8
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560631; cv=none; b=hH1DHjqGtd0vb0tq+wZ4hfHOIqmKGiQOvijBmZUbHIsycZDvpEBqIY4jQZ/ZtwxfwR2dlDQl1nNT9dCQuQYK/E8kfxPLneQcUhlCQjmdS933SPI9eDe/c8wi3O8FUhPmeN5xqeCMRnqMS225PZhrkY+QgiRDRw37uHnLsOvwleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560631; c=relaxed/simple;
	bh=M5ClWJXxv3ZHwS6vznIA28QB7G0kkVO2SCmlVIb6HLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MHqsZc8p/sMjNF/DvJ1JexgNlDIy7oNcWF9yIQnY7l4SSTU/rqE12+by5u5k8e+BJCE8WOssXSgCK+Zko8P7I0iCbhdBdSSFmQ7fRcFtKe39mK1ZjGnxFE5iUB99eaFWZ0ImCf1LhKh2SZEq8+/i8IU/fXY7NN4nP4R7Dqe/zWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naYtIrMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6441C4AF48;
	Wed,  1 May 2024 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714560630;
	bh=M5ClWJXxv3ZHwS6vznIA28QB7G0kkVO2SCmlVIb6HLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=naYtIrMBYGFphnRq4sogTRoy3+ptR7ULN8Ck7wek1xUMM36Z/dtl7yiI1vYnvwKgu
	 3LXF/VE2kNw04rQSIoAhXbb5/ILJIwzEc37LoXlmy3bhV/r50SyUtvkh/vYXnKsvy+
	 Z7LooGmrK0s6O5dVcq+PshaJ3RbFJRYJn8efxrwkEZTCmMArRuUjOywR/d6j7Uce2E
	 BNoK2gEwsXLx0oRRdj8dceN73+XtKddBlK6JMZcRgTZf7NBQrf+3QABJCs+n5Wt8sp
	 8+R2eNGs+ZMTICVYhlA6ZsHzLuUAgIp90R7ov8F6S6VCKgSdJZHANMTQjQ/XMKmTra
	 ulb8B2QDaYrLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC9A9C43616;
	Wed,  1 May 2024 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: anycast: use call_rcu_hurry() in aca_put()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171456063076.15428.16544432079445394876.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 10:50:30 +0000
References: <20240429183643.2029108-1-edumazet@google.com>
In-Reply-To: <20240429183643.2029108-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 29 Apr 2024 18:36:43 +0000 you wrote:
> This is a followup of commit b5327b9a300e ("ipv6: use
> call_rcu_hurry() in fib6_info_release()").
> 
> I had another pmtu.sh failure, and found another lazy
> call_rcu() causing this failure.
> 
> aca_free_rcu() calls fib6_info_release() which releases
> devices references.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: anycast: use call_rcu_hurry() in aca_put()
    https://git.kernel.org/netdev/net-next/c/fff6e6accdb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



