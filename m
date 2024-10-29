Return-Path: <netdev+bounces-139768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2649B4085
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344E5282EF2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE91DF73A;
	Tue, 29 Oct 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i04X19ov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16C84A2B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169626; cv=none; b=FYyOmyfXziHnpEvPXtIY5WuhmLzVYWLcTI8WS9V22YkS1iEgTgNkvWqxhKQPqQjhD2ThGuHhHXHyLVwAUoPWug6O34ILWVpuzRrsNHEgPzmXUo4rlMq0FB9Wdui/h8BGh0BxIHgZMK85s2kf35t5VX32/T9SA7stu5XsD4GC2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169626; c=relaxed/simple;
	bh=Udx2XQ+Rn/o3n/rLtWFBguv0Yb8HvNYrBv2QqkHinWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATaOIIrUzCDRizTjQRlsSGSmLSOaz69uKZf2kTPqmvJJezsyeiqBRbgemVFD1ZfT9Ik7TjEaE8aUS7xsk+Z/GlH3janmcIsZfl+anJD9vKzy+dOo91YqveQZHVp2wR4N7FOn1NbWgT1RXy7dshWyrUTL/bJg71ERD+IbB8cvAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i04X19ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF0C4CEC3;
	Tue, 29 Oct 2024 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730169625;
	bh=Udx2XQ+Rn/o3n/rLtWFBguv0Yb8HvNYrBv2QqkHinWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i04X19ovK02Faot4eg5M4yg2najEIwj75RtlPxPH4r73mlI/m1tyLQxPUPfVxd0nx
	 4U2MC7XPWlohhKhgJAdKhTnI5R/YfqcDkwHCJaDOxCRlgr9OblFzKdJb3jBHkzcNwg
	 16pxXw2O4ALfRiHNGir7lEgnV4Ny+P43nhYV8SuvZjrXyG26bRMW40BmjMKcjmkotf
	 mZoPPHUDe1BNWJN1bs3IzgfumEcnp/xUpOQd46KqMCm8c8dSbV0p1k8F16LsvDGCpB
	 7TIrLIl5hhBdOhbeRBUKEmPlrbEAM3lfREsnNQ8uxkBTEcK+SUS2lfCwy+Xczhipc/
	 T84FNtw6dv4Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C89380AC1C;
	Tue, 29 Oct 2024 02:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: use kvzalloc()/kvfree()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016963299.250007.17049712123348396115.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 02:40:32 +0000
References: <20241022150059.1345406-1-edumazet@google.com>
In-Reply-To: <20241022150059.1345406-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, gnaaman@drivenets.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 15:00:59 +0000 you wrote:
> mm layer is providing convenient functions, we do not have
> to work around old limitations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  net/core/neighbour.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] neighbour: use kvzalloc()/kvfree()
    https://git.kernel.org/netdev/net-next/c/ab101c553bc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



