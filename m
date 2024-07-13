Return-Path: <netdev+bounces-111285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BD9307AF
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D0B2126E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E31142659;
	Sat, 13 Jul 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roQJQaL3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AF1B28D
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720909228; cv=none; b=sGwR9kd/0l2sUDV4mZBQYGcI6fjxGTvy1zMXjT/0lB2yCw7eD816Sh19uc633Tel/MxYtagimcqTmJqa/kxCqVbOqdqSKsamoOVHoASmRMkdlH8YIJJ/1gUFJaEu0Nrb6n1ntKinWIlJzdCfN5yl9qZOFqfTuiYGrA1IB5rX1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720909228; c=relaxed/simple;
	bh=ZnY+tTGzZl6qxEiO463sIJDaU+Wikn7XNOUSW0LcwMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RRYqYwG8Mm35w/Thvwu86ptc2SvQP8SL4npvXEsmFSYe6psN/+cMwtr+8ywrY0jwDaiUdHKtvUEJDSoJ6bFvAiOyQ6xn4mIoUq84vssXITsYEFP2j0R/SCl8m3S9A7gTnN2f/0cDRZU/RyRhwxx1rXQZONBbvrbVlVJuH74+no0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roQJQaL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0FF2C4AF09;
	Sat, 13 Jul 2024 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720909227;
	bh=ZnY+tTGzZl6qxEiO463sIJDaU+Wikn7XNOUSW0LcwMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=roQJQaL38kM+jv4Zrl1yBeiklA4f5+L6NfO0HEa+Qc9zAtIbKIvuDPBQPH2xp+EuK
	 fNkM90RyXieI1OnglLpDLW2pQ0v70QmYYRKLX41kNwZdCl1ttY9X/YtIkRtvMfQ9xU
	 050IqrgVPL+YdC1DZ3I0N5n7zLJi+L7Zlb6yTJEXXA3RBNWzyLcMz0bTODEqnRIHEf
	 xCu8qiht4tgwU6vg5Zbfxv6oVK2Y0vtbnbaxH2/ab/urKTkHHBkBKhBhAam2eLYbxT
	 wfHirotkBch8f/khr9RT8/hOjget1wBKJznKIyaZVLqVdZLx6STnTcri+eaa4V0Bn5
	 RHpM2Ui2N96Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F305C43168;
	Sat, 13 Jul 2024 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: add 5 missing tcp-related files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172090922764.17528.8467577684982483496.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:20:27 +0000
References: <20240712234213.3178593-1-edumazet@google.com>
In-Reply-To: <20240712234213.3178593-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 23:42:13 +0000 you wrote:
> Following files are part of TCP stack:
> 
> - net/ipv4/inet_connection_sock.c
> - net/ipv4/inet_hashtables.c
> - net/ipv4/inet_timewait_sock.c
> - net/ipv6/inet6_connection_sock.c
> - net/ipv6/inet6_hashtables.c
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: add 5 missing tcp-related files
    https://git.kernel.org/netdev/net-next/c/8e5f53a68433

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



