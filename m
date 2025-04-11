Return-Path: <netdev+bounces-181481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89591A851FB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A444C2022
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9FF27BF6A;
	Fri, 11 Apr 2025 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKYBr8ho"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C36FB9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341639; cv=none; b=uCqhNZaSn2vYyRK6mtcHOmLvHsxUdUxybhq3c2cuFOrRJQ9LQGrPuUu7NLnm0p1+AKmx2YdIsN5UQBdtIlCC/BRDQbNXhbFLSIekzbAwLhVtNfwNp0JIuXNkhhbiuil+2lhOe0SLgW9Sk/ODza/q8gvb3JeMQVjIdwBpf7cVImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341639; c=relaxed/simple;
	bh=dCgF0J+zKxj70RKsOPy2HEERilL6LC5V1b19tivIxB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMpjDW4a3ASdewZOKU8l39AFcV0kZyCmkqZyrgPyeX8ZeXw+upWYh/kqpV+P85qJHb19U9552pflG3JVGC+OA0ROQjLn73G+VyLXBMJRmegIiuFh7dJwlmUVvAlugm2YHHGqnWyowSNnHriBC2dZXCsGq4FLdODo0wb9KrtySbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKYBr8ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6648C4CEDD;
	Fri, 11 Apr 2025 03:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744341638;
	bh=dCgF0J+zKxj70RKsOPy2HEERilL6LC5V1b19tivIxB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKYBr8hoXBwWuSVYl7RYiICqlYh+w/VVbPoSNuHZ9oni1dZHoD28f6Gwc7W66vWdX
	 inl+biCbpMr8rRdlpWnwqiejBvtvGtKmG8fFOXtUdeb3WN144ZMJvX3D4AnAcfc2TN
	 U+Pf++dV54s+nYMesstyUtkZhAqb9axIyvcpWpN9AKvJ25kAM+/bnI99HptM4gkmC8
	 ct5Un32s41bxZgWM/JMW6pn4zrV10nhJWoz+QGHnNcWpR1CPQ3rngGI7Vr4dPFE5ri
	 ldxHM/iB2cEA+tCMP5qIw8f+2iS5HDtxHeK8XChAupwPHKkgEwmA/SfcofCBjJBP5T
	 yb9VmnimM7s6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE9380CEF4;
	Fri, 11 Apr 2025 03:21:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: add exception routes to GC list in
 rt6_insert_exception
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174434167629.3942163.3059858018074493474.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 03:21:16 +0000
References: <837e7506ffb63f47faa2b05d9b85481aad28e1a4.1744134377.git.lucien.xin@gmail.com>
In-Reply-To: <837e7506ffb63f47faa2b05d9b85481aad28e1a4.1744134377.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 thinker.li@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 13:46:17 -0400 you wrote:
> Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list
> of routes.") introduced a separated list for managing route expiration via
> the GC timer.
> 
> However, it missed adding exception routes (created by ip6_rt_update_pmtu()
> and rt6_do_redirect()) to this GC list. As a result, these exceptions were
> never considered for expiration and removal, leading to stale entries
> persisting in the routing table.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: add exception routes to GC list in rt6_insert_exception
    https://git.kernel.org/netdev/net/c/cfe82469a00f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



