Return-Path: <netdev+bounces-81885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B788B80C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2450D1C35F9B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB5129A9A;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k517G+II"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F0128392;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422630; cv=none; b=ZGOSL+kfEj4OH+yvgJ2+pzOB6utwLM4MuHOC9hOV/TrG8/S31MuwBNemjPxn6lFGrLkEkCNwPoHNPQaLW6R5D+4lY+KzVLylCj7t7wdCuMkh5qWTi7j3m1xFail9xEEmJA348isY+NUroMBScjSt1DGidRy1H9YARQJP/uYz1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422630; c=relaxed/simple;
	bh=4Qa1LS+Om5rfFpv0tUKGCSvSW8j4VPDsOpM83JfU3Ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tut74UKL7m1ZUM/dwF6Q+KmpxnIsbdJ4aLWz+vfbgssi2a/PojqLpMsaifDt0/O/SQ5p6hgRqBfh+8ZX9c4MkAP2GweFM7lC4Q/hBQ6qxqMPR4+3IsCIxl1v2MEG5J/WDHpm+W3U+Zf6xO2RmI7gSOUzo2FWwvb3aTJO5kHDjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k517G+II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F189C43394;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=4Qa1LS+Om5rfFpv0tUKGCSvSW8j4VPDsOpM83JfU3Ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k517G+IIOgv1P+10eowJoT/ObI62mnID8Z5LB3k8jjOOIdmw53vN7PX5ufwAl0PkP
	 9csmRbooUW2ZQ1wiVmt4iZkZtoiZ/LyFkPmc/USJVBPhVs7X09kXkzSi+pBGu493PV
	 y+MNDPAKusC3h50kdD/6Lj0CY79uK7HTo3RRRnESW27eT9fPzwgxQdC5OwBiglY30S
	 hFfmkHQQuokYjGCaJXEkazbaKH9RtEywXIoTTwEi61V8cayHYJwX7TryF2luLfPNNm
	 hQqj/tyYNB/iu6q7fzQOGmWA7GNIiteYt2EOTpSrg9wE+DTOir+6M43CM7AEpfwhse
	 zDvdGOeKqWzWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C657D95073;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: hsr_slave: Fix the promiscuous mode in offload
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263037.4499.17550384842658258820.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <20240322100447.27615-1-r-gunasekaran@ti.com>
In-Reply-To: <20240322100447.27615-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Mar 2024 15:34:47 +0530 you wrote:
> commit e748d0fd66ab ("net: hsr: Disable promiscuous mode in
> offload mode") disables promiscuous mode of slave devices
> while creating an HSR interface. But while deleting the
> HSR interface, it does not take care of it. It decreases the
> promiscuous mode count, which eventually enables promiscuous
> mode on the slave devices when creating HSR interface again.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: hsr_slave: Fix the promiscuous mode in offload mode
    https://git.kernel.org/netdev/net/c/b11c81731c81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



