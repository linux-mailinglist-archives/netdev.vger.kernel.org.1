Return-Path: <netdev+bounces-134720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB099AECC
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9F8B22635
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EF1D14E0;
	Fri, 11 Oct 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiNovO40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9D10A1F
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687027; cv=none; b=TGVu6GhpeWdMuF5c/ufnyydiZW+OPiy4CeXej39GHa9/FAAsxxkGtRpmeQ2OqdJm4tVBZst02PA9QFcwn6EXE4CiBBtFLsFLyXP+s0FkrjRBX8MEWxKIS2cpFv/AWTeZ3WLkrqpdFinPcQm9iiLZnxr8BnN0yHIir4wImJvB/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687027; c=relaxed/simple;
	bh=PLjvL5IHaDFoyfSzKprVS38o3Pc2mOeUvjP7YrUWx9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbG5ArVTDYSozZFJ9yrPrOLUrMADueCJmBioXVGbDYdSo5ReDSSD12IQ1+Dzc6JSV1NwGdAjXhC+lBu2ywc4koign9XRpzHADhZDU2mFyGWEzqaoRxc3tUxGt3rK6UG2NjOdNqCZw+MiX3Qe2o5Ep6QV2zItiJLbPLLlnuHUd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiNovO40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF073C4CEC3;
	Fri, 11 Oct 2024 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687026;
	bh=PLjvL5IHaDFoyfSzKprVS38o3Pc2mOeUvjP7YrUWx9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZiNovO40rP5iBX/h78kEqIgimtwv5ubaNNfxB+G1y8sxo6TGGiTxs6zISSGUF4KI5
	 FiGLEw5sZfDhEZ13p/dsXupLnnqfPP+MmyKQgoFkCXrkSSXgQSuXL3AsA1u+au12IH
	 51C1xPgaDIfUGmzymSY8bQGeQgM+oCyKffjtrxqc98y9P8JTFwv2j/RTnBKP7F2K52
	 qJdWApzEPkjFeNmTi8Rd4zdWaq4JbOjmJcAuci3d/btxqHj+DFfZBNfsdUZigY1HfM
	 01rkI8kx2LA4d1o5JpznAuNpjJqvF1srQ58dx0ftImpcfkeThRzbIyGKRzmocyD3as
	 auyPtjJetFR7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE28138363CB;
	Fri, 11 Oct 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: give an IPv4 dev to blackhole_netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868703151.3018281.10440332628872972423.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:31 +0000
References: <3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com>
In-Reply-To: <3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, maheshb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 14:47:13 -0400 you wrote:
> After commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
> invalidate dst entries"), blackhole_netdev was introduced to invalidate
> dst cache entries on the TX path whenever the cache times out or is
> flushed.
> 
> When two UDP sockets (sk1 and sk2) send messages to the same destination
> simultaneously, they are using the same dst cache. If the dst cache is
> invalidated on one path (sk2) while the other (sk1) is still transmitting,
> sk1 may try to use the invalid dst entry.
> 
> [...]

Here is the summary with links:
  - [net] ipv4: give an IPv4 dev to blackhole_netdev
    https://git.kernel.org/netdev/net/c/22600596b675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



