Return-Path: <netdev+bounces-166699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91869A36FC9
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C7B7A30F8
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371A1EA7FA;
	Sat, 15 Feb 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyF/3PmH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFB194C61
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640603; cv=none; b=OnHMkeqMuu/6hT+65N4f5pD0UOeVcQ3fWDmg4q88//WWdaz+5eyz4ikj+dp4I0TqQKa4Gr2xxBslx2l15UMzOhQ83JVybm8ynlWzMN0LLeBB0ASYY+bvHIW5cfn6/U3t68o1CuY9UWHvsfBRkOiOYtej3OT3UJoiujF36ZU1D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640603; c=relaxed/simple;
	bh=2REkKld9n0ggNrMEylXWf43g5lPGYCB/MOY3Qf5vt4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWpOSb4J+vLGokqa93HkQlJlOy0kHlapMwlKgsFJYtKGQ8a0hmodPrcvaLQTU/M4RvLx+M7wGs500wNLNuPD8QyGCJ/pIDJlqNxFwZkSSJDj0x6C7vydxbK6DE7/U1Pui/kP4kHqIKOwBE9T1rByTls84rKDNVlyAJBUavBQ9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyF/3PmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5E0C4CEDF;
	Sat, 15 Feb 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739640602;
	bh=2REkKld9n0ggNrMEylXWf43g5lPGYCB/MOY3Qf5vt4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HyF/3PmHYeoQYBnD4HM4jdhBFHm+adNx70SWVM7vrrnW5sHeMeUSSuZMUloCZqpIG
	 /+vzXlfSVgdL7l0aOhxAClYXOAOkgRktJ7uTrOdFxQd3iiZH7Z0GkTDiQYJ3XT22qk
	 Z41HbJE6oD4qIHy1BYZR4ogAb5bJVE1pgajtSdkysqZOQIF/0MMbIMgv4/c4TvgWwU
	 dsSWwnD2r/UXmCKHcy3ixn4OlYV6G/erumuURrU4gE5CkwRc+jQs1Qzj2sqrza/5Qf
	 uj/t3YTkifrxrIGVe+YpP8KiGoKVvYCGE64Oi8AyFZZgE8yCYzSBMdr0zz0c4scyRo
	 tOsUauKg9WOgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3DF380AA7E;
	Sat, 15 Feb 2025 17:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ndisc: ndisc_send_redirect() cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173964063224.2306719.467147886967865202.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 17:30:32 +0000
References: <20250214140705.2105890-1-edumazet@google.com>
In-Reply-To: <20250214140705.2105890-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, horms@kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 14:07:05 +0000 you wrote:
> ndisc_send_redirect() is always called under rcu_read_lock().
> 
> It can use dev_net_rcu() and avoid one redundant
> rcu_read_lock()/rcu_read_unlock() pair.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ndisc: ndisc_send_redirect() cleanup
    https://git.kernel.org/netdev/net-next/c/0784d83df3bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



