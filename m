Return-Path: <netdev+bounces-138123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32A9AC115
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12771F211F9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B63155A34;
	Wed, 23 Oct 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjQfwkvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D214D430;
	Wed, 23 Oct 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671022; cv=none; b=DRS4HhuM0n2x/WuGQIobyd4dSoA+15L68nDhtEyTaambQsVAgnYq2iqV32qXJWuwwNJvONI/RHRZmJIGslwus2V3QqMzwqWB8GdnGVBe64o31vnNtKoKbaq9BxKUSeenLAQxrpbOMi5ezRkv1ebUZf4hGkMU2E0zRS2OsNMLs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671022; c=relaxed/simple;
	bh=KEVapUmSHNAnKHpUbqWWY7HUKA/s/hQPC4oid7+P+4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhWzGd4kj1ZAQMQTTqORxWBNaPniFHxrQJoYXLXzRq0tcHYjPNPNkEhx6rG6iWuPu/CC+jQI+c70vPIBjEX5yWb3R6WyyECvZKrluGxFuOUaNKkuSa/XbcCps8E4IWoSQHjmROTvkkUKsygjfpMGVNYP4q3glM5YPP9Jt06fuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjQfwkvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2467BC4CEC6;
	Wed, 23 Oct 2024 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671022;
	bh=KEVapUmSHNAnKHpUbqWWY7HUKA/s/hQPC4oid7+P+4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MjQfwkvTLzps/JFjJs67ULTPscnSGnQaHYrAx0jJE4b1CAS0Q6esK576yhzQ9Crjs
	 U8aXuDK66V7EOxYo5daH9+0muYtVxEJFqezbJX6x2TXO2qm3HFbzR3uinacSzV+2La
	 cBv61MhLs/UeFpllE7crC+UsYQCNte5TO2abx3sPBS2MoItWhRUiQ6iu/BBWc6vCoH
	 l0RiOIf8NapXhe8u/9EVLRs9TC9qFHN1e4MxmfxGgOniroW65KEECPYFEZE2OTlKj+
	 1YBhiBcAPnb1mskiaUjPJ4MTAQdieCZjna4rPGNhKrd3qIk3JvFP2AaH9elZzi6KfC
	 K2eNGWuWy/ycg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2B3809A8A;
	Wed, 23 Oct 2024 08:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use sock_valbool_flag() only in
 __sock_set_timestamps()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172967102851.1512053.4625084732459579673.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 08:10:28 +0000
References: <20241017133435.2552-1-yajun.deng@linux.dev>
In-Reply-To: <20241017133435.2552-1-yajun.deng@linux.dev>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 21:34:35 +0800 you wrote:
> sock_{,re}set_flag() are contained in sock_valbool_flag(),
> it would be cleaner to just use sock_valbool_flag().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  net/core/sock.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: use sock_valbool_flag() only in __sock_set_timestamps()
    https://git.kernel.org/netdev/net-next/c/6886c14bdc30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



