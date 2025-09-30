Return-Path: <netdev+bounces-227266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F8BAAEBA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE81696B3
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414091F4180;
	Tue, 30 Sep 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXEeHNMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA431F0E39
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197041; cv=none; b=cty1+6QETt/ORtUJLrd3Qypd967x+SSGoy9++trxTi2Vlkd/dF12qThJ0e9r7L6yvFyovJX9KIego45EySSo3aZvJWMRukhKM/aJgs4bAcBbutmH8R2wbbFwPZ3xf8lKbV8S/5eJPfTgR33IoIx50GQBWh6DynLgQi1z6UAfydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197041; c=relaxed/simple;
	bh=hI4t8IroNauoNOlg07IJr3h5+CyQWsmzZRSWoh6p0Ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQzbTFU15qVBu3JxcAiz4AZTGL8i+ACRzEm098csdW8drMfoQLvkZQA7U3NP2D8wHTCFCsRZBdyj3dzj30ulXWRaI1FPrDKh/OyB6bKiXOHWHPRgY4qe/gRrZnRG9mT103NPETSxF/YVoOwnZTfVA6xFS2lBlu7qJpCV5hMYOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXEeHNMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE705C4CEF4;
	Tue, 30 Sep 2025 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197040;
	bh=hI4t8IroNauoNOlg07IJr3h5+CyQWsmzZRSWoh6p0Ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uXEeHNMcas3aUOimXBaWCcWvw+Vcazniyzd8rOQ0fSx8a0Lw8ElYvdmWAVGzN8xaZ
	 hKck5YLQvjHWxn2Xra06GTuC71ywGqZV7JN5J5DrjIRR9WZAbCMJ5hqN+S806SC778
	 TWD1NkXRGpy2AZlRh06PXAW9iT3R87y8kDFZIN8mFwmkwbCI7+0qTGgRrlOm+R9JjL
	 YLHivcESGzuk+/R7INO13fIuLZiCABEQhXomv5twlX0XZu8UXsf41j/WIJ/7yl+luJ
	 tA7MSgIEkB3j6e3napX4bExLCRDeWVkPwPrtUDu4ExOukvkkMUEgt+P0xoNGRVwikm
	 tmYy7JAihvZ+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAC39D0C1A;
	Tue, 30 Sep 2025 01:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] Revert "net: group sk_backlog and
 sk_receive_queue"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919703399.1783832.10640405958880412247.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:33 +0000
References: <20250929182112.824154-1-edumazet@google.com>
In-Reply-To: <20250929182112.824154-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, oliver.sang@intel.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 18:21:12 +0000 you wrote:
> This reverts commit 4effb335b5dab08cb6e2c38d038910f8b527cfc9.
> 
> This was a benefit for UDP flood case, which was later greatly improved
> with commits 6471658dc66c ("udp: use skb_attempt_defer_free()")
> and b650bf0977d3 ("udp: remove busylock and add per NUMA queues").
> 
> Apparently blamed commit added a regression for RAW sockets, possibly
> because they do not use the dual RX queue strategy that UDP has.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] Revert "net: group sk_backlog and sk_receive_queue"
    https://git.kernel.org/netdev/net-next/c/7d452516b67a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



