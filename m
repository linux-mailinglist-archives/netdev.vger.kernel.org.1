Return-Path: <netdev+bounces-243562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0265CA3B51
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60DF300D420
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52934028D;
	Thu,  4 Dec 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbioo+h9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B662FFFBF;
	Thu,  4 Dec 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853390; cv=none; b=iKO2jlMb5XtYx0PHm/l/bpvGueWmdr/I5e0yjL/SnZ+sj67GMtOHTLfVGo8TBjfj7aG5QPjSm0pnyw118w5Ypj4aiCEL3/QkHBOOvXQYV2Xa1HIcQ1kZ00RSi/4Q2ho7D7FIJu15fjfqCfEpqX9Sad7uJcbYfLcLI9NLWqyvyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853390; c=relaxed/simple;
	bh=ijMPr2yDB8lXFSaxtcmyFemM8puzB5457SGeM5PMwL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f5rjEDZv5+HEGvVPDM1ZQt7H9eFnkrrUbFtxkXijbWQPjhyNHgHCaojuh66UQ6uwUzNClcniJnVFgOmevtrqVYq7ffmKuaBmNZfyEDzJiSV2g+VuIpSB4I+7ySTVjvOiV6whjDQwLtHOKvquP5cYAM/es159kXKxcqrvNLsweI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbioo+h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C64EC4CEFB;
	Thu,  4 Dec 2025 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764853387;
	bh=ijMPr2yDB8lXFSaxtcmyFemM8puzB5457SGeM5PMwL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbioo+h9oQzP8YLgHzFOvRV8vcAyvIW6o04vg8hFV+THnoA/HSmmLDI2lvsxrOyoq
	 Qe/2m0nMqwEkROerA22ynBefecuwd3xr06HfWJE4RumDjMHGLvivOIMA9pmomVMXeO
	 IkpXqhNgdf+t2tFcliCjgQejV+2MZSwVFIHXf5lWyRca2M7n/ogGwU5z1rTFmsAsn7
	 FaOtF1U5xE3NJx3Cn4/Y7UnlM1eoyBm3uwPKTurDnR3M/H3yg7nQ7IopZAqBlW7+Vu
	 wt19ca++1kgA3aCHd+Sw59KXKN5i7of2yxnh5sVAHT1t8EJPaKW3D6M4M7xXjcld/W
	 XbLzgcKfKPhZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A6B3AA9A9D;
	Thu,  4 Dec 2025 13:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176485320579.769721.2503512059305579234.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 13:00:05 +0000
References: <20251202103906.4087675-1-skorodumov.dmitry@huawei.com>
In-Reply-To: <20251202103906.4087675-1-skorodumov.dmitry@huawei.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, julian@outer-limits.org,
 gnault@redhat.com, edumazet@google.com, maheshb@google.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 2 Dec 2025 13:39:03 +0300 you wrote:
> Packets with pkt_type == PACKET_LOOPBACK are captured by
> handle_frame() function, but they don't have L2 header.
> We should not process them in handle_mode_l2().
> 
> This doesn't affect old L2 functionality, since handling
> was anyway incorrect.
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
    https://git.kernel.org/netdev/net/c/0c57ff008a11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



