Return-Path: <netdev+bounces-59756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88E81C026
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506A51F220D8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08D76DAE;
	Thu, 21 Dec 2023 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGX2137Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D310F5
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A601C433C9;
	Thu, 21 Dec 2023 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703194244;
	bh=NFA4T4yy/3QwKLwPY1JuSP/+hB2tcrULBRpPeomQNBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OGX2137Z16xaYxfIjP1mLaD+8mcdTgNg2V8aNX5Gf/2bdZhVTsGlYay53rGWBxZJT
	 9DhX5CUbATC8BlC8n3qT1MyzEXtnHB3WhUnuE6pJmbGQFrFGUnMBX6R9LQTcI0i4EF
	 SAyXnSMG6iGJ+hUFMYA+/keNsGGMGIXz/80tYrh88665pJowKOVfrBCh/DVK3Ez0Qe
	 gEE4Etbi12BDL6109dDYgtNuF7MwNa5TiMVVGuUF5xEfz7TmPXmVGAKkFzaSBxgJld
	 G1bJiQV79a2wpQCifOrS4Ydaxc22u+hNytt18I1URh2DVPul2bUsIdgBYOMlolpRJe
	 6E7uJA4CSM+NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81129D8C98B;
	Thu, 21 Dec 2023 21:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/ipv6: Remove gc_link warn on in
 fib6_info_release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170319424452.26861.6600400726235079868.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 21:30:44 +0000
References: <20231219030742.25715-1-dsahern@kernel.org>
In-Reply-To: <20231219030742.25715-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Dec 2023 20:07:42 -0700 you wrote:
> A revert of
>    3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes")
> was sent for net-next. Revert the remainder of 5a08d0065a915
> which added a warn on if a fib entry is still on the gc_link list
> to avoid compile failures when net is merged to net-next
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net/ipv6: Remove gc_link warn on in fib6_info_release
    https://git.kernel.org/netdev/net-next/c/5a78a8121c4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



