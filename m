Return-Path: <netdev+bounces-171464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79699A4D071
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776FF188EDCB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7A28399;
	Tue,  4 Mar 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNS7LaSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E21C6BE
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049999; cv=none; b=noZXF3mWX1YYOt/5oxFtps6ht9GwPfCz5l+PfIrKse8CLjFOXp00jHOKamTzUxe/11nq1JstPupUJsWZpsWtYb8MS79sxBMZDJHZvawafII9JobTuiqLhI60+FkL0pMCQhdcbOmKPPvO+D8PXl9zOPjpfno+ZwJSoCjJn1KA7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049999; c=relaxed/simple;
	bh=MYcNHMJ7XEkCfTZwTNueUGF7Rvt8haxIwZfCUvuiSto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBPwJDbYakW43rBWAjWsuXjp10JC7Nbel+SBtI8j6QI17VGCZR9eNd1kVWAA25MO3PTTuKtXwSUm0Bu5TNnZDJR7xxebyKqwCvJAsbruuKPLUkpOJ0a3q8xbKhJJexXK7xdQG6EAOhEcOV7n/FSrgLeEFhtramPB0iByC6lonAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNS7LaSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BD8C4CEE4;
	Tue,  4 Mar 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741049999;
	bh=MYcNHMJ7XEkCfTZwTNueUGF7Rvt8haxIwZfCUvuiSto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cNS7LaSXj/FBFLkdqoLONTFOALQkcxM9Ofqb6x0eo2rRDOm+9qywUvHrIstYcO19y
	 sFJqUO+lCEWZSCBCeDjbwyOPWT/aK3YsWYMK1Wj+HhJ+MI9AXOnZu3TyTvdtIvPh9e
	 ut87axqhOhgexQddyCuy+NaF/gV5IGudtOAoxQI0QwSmrrT6Nm1hr7up7653+zq0XX
	 d8uo1LvDFt5pQnUL+AHbaUKmKc1GgAvb+eU6Bqhy7w5QvxVkfsBsW8NO8m8LHopU9D
	 f4iUacQ2ZERAki7kV0WkCRWEZkcyQ5P+zlTuTRXDqAZVzGBjalixxdgkOcVnZ9eE5B
	 7lLf5QqNuWRzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF203809A8F;
	Tue,  4 Mar 2025 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/6] tcp: misc changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174105003175.3816720.5506834539444353974.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 01:00:31 +0000
References: <20250301201424.2046477-1-edumazet@google.com>
In-Reply-To: <20250301201424.2046477-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Mar 2025 20:14:18 +0000 you wrote:
> Minor changes, following recent changes in TCP stack.
> 
> v2: typo for SKB_DROP_REASON_TCP_LISTEN_OVERFLOW kdoc (Jakub)
> 
> Eric Dumazet (6):
>   tcp: add a drop_reason pointer to tcp_check_req()
>   tcp: add four drop reasons to tcp_check_req()
>   tcp: convert to dev_net_rcu()
>   net: gro: convert four dev_net() calls
>   tcp: remove READ_ONCE(req->ts_recent)
>   tcp: tcp_set_window_clamp() cleanup
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/6] tcp: add a drop_reason pointer to tcp_check_req()
    https://git.kernel.org/netdev/net-next/c/e34100c2ecbb
  - [v2,net-next,2/6] tcp: add four drop reasons to tcp_check_req()
    https://git.kernel.org/netdev/net-next/c/a11a791ca81e
  - [v2,net-next,3/6] tcp: convert to dev_net_rcu()
    https://git.kernel.org/netdev/net-next/c/e7b9ecce562c
  - [v2,net-next,4/6] net: gro: convert four dev_net() calls
    https://git.kernel.org/netdev/net-next/c/9b49f57ccd3a
  - [v2,net-next,5/6] tcp: remove READ_ONCE(req->ts_recent)
    https://git.kernel.org/netdev/net-next/c/5282de17621f
  - [v2,net-next,6/6] tcp: tcp_set_window_clamp() cleanup
    https://git.kernel.org/netdev/net-next/c/863a952eb79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



