Return-Path: <netdev+bounces-44875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA177DA304
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2569728261C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA967405CA;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avxQgGkD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303D405C2
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD78C433CB;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698444024;
	bh=0Oda1oaY+aLOBUAlHfHFEqEgk3sQMhsPH7w7xKYIR5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=avxQgGkDzSu5hqaf/+RmJRaoppEK5makX87opbV/ACkmNo3beIUzcjAGO4upfw1ax
	 jsLBB33/tf6peOzRWGsL5WnIp6DJ/eCmufYp9VeUwDatxZvLmHcBtoeixLSgPUvwGn
	 heeOEN4P0oUwxAEhFrJPojp6erPS1cjPUmvWY577/Ecr5OFVRLgQCV2m+YEcom/4eh
	 4m3jmCbK2Z3V7puFihtx4keTnqm4RnQNbWIIOhuMJRhOFefhwYA5jZ0NkNiurxuLBy
	 nXx8c/fn+WnhxA6E8yfglQN0HQPmdVMcskrKaPwP4YHAqmYX88mgP0cxY8EW0wjLuk
	 MWqzEjuFssBzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01B4BC691EF;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipvlan: properly track tx_errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844402400.23229.10778434490564946054.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:00:24 +0000
References: <20231026131446.3933175-1-edumazet@google.com>
In-Reply-To: <20231026131446.3933175-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, maheshb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 13:14:46 +0000 you wrote:
> Both ipvlan_process_v4_outbound() and ipvlan_process_v6_outbound()
> increment dev->stats.tx_errors in case of errors.
> 
> Unfortunately there are two issues :
> 
> 1) ipvlan_get_stats64() does not propagate dev->stats.tx_errors to user.
> 
> [...]

Here is the summary with links:
  - [net-next] ipvlan: properly track tx_errors
    https://git.kernel.org/netdev/net-next/c/ff672b9ffeb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



