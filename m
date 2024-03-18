Return-Path: <netdev+bounces-80339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C868687E615
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D87A1C21713
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B52C68C;
	Mon, 18 Mar 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl8Hf3EV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F62C182
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754826; cv=none; b=bG3/2ZONTdPU06a8rvwtmb/lQjtO6k7BLhpO18XFmMpRueTienzUolEEUpJMINZo5QWFK1OjxcdDU9at8Ojo45o6tjJaSVxNWRZGnGnLMgM7MPK6qs+i4M+jZ3JwZyGmRxdLte7roeFI+p6WdGcVIfgorfdw2gxyIc6yYW1L1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754826; c=relaxed/simple;
	bh=DF91Ls1jumKj3c4cV+gxwl5i8YE4ztVBEpIkplkqG8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7ogqUFBoNpt0Os8H36OFXUrg7HKs/F62MxReRvIrnny5bGRwsGmkhYwMQ/et2ZDKoQfiOK/s3eTVV7EVuqv6JbY3iw54YbVKNay2oU/a/Atf5jEQJZecvhnkUvsEQKdoHwCrTLfe/RzPK0CXmQy1jPXd+tWVwq9KL3PqILxS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl8Hf3EV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 565B8C433C7;
	Mon, 18 Mar 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754826;
	bh=DF91Ls1jumKj3c4cV+gxwl5i8YE4ztVBEpIkplkqG8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sl8Hf3EVlHNDLs+GjhGZ48846Lo2w6HKL/63Gi7NVPsGRH6ZxhGRTCy63sPS/uSFy
	 Idz1qeqdIsYL8tpjzGnKTCTi9OLZdPetbGqzJ0lH9FisqINpyIdXsknjuiTvHGpEHt
	 +Mz4dLcGsZJEYHZ/2twNUm1/YsCKmvorcuKjTAIoGMk2rdvSCuJ0Jfin3+AxVEeX9N
	 BsG0D5Ee/oTQHoJ9osm7mp0fbqopfOpSXtfOAbjfQsGgM9fqF30Mqg+QG+fh+1KdNx
	 zT3MljRn+tnCk8I7MXhjGsW/TkW+SiPAF5mhAlLdZa7R+5DcpCcnU/agWxygPc0WCE
	 gXtB6Vpeh2cmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47407C04E24;
	Mon, 18 Mar 2024 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] packet: annotate data-races around ignore_outgoing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171075482628.24360.16088903223550865449.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 09:40:26 +0000
References: <20240314141816.2640229-1-edumazet@google.com>
In-Reply-To: <20240314141816.2640229-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Mar 2024 14:18:16 +0000 you wrote:
> ignore_outgoing is read locklessly from dev_queue_xmit_nit()
> and packet_getsockopt()
> 
> Add appropriate READ_ONCE()/WRITE_ONCE() annotations.
> 
> syzbot reported:
> 
> [...]

Here is the summary with links:
  - [net] packet: annotate data-races around ignore_outgoing
    https://git.kernel.org/netdev/net/c/6ebfad33161a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



