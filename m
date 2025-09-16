Return-Path: <netdev+bounces-223311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E22B58B40
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31AE2A0A7B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8E262FE5;
	Tue, 16 Sep 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy9FqnU6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25031EDA2C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986249; cv=none; b=LxXpJlA7lVD68rRoYoajjTA55CnoicJny6a7f1wf3BsTGvjXcKmTLHVy6z5dMzzdACmZ8ZvYYQvf4KDzyc/ZuM/fgTQseITbvbKlbCoLWCB8CtWiTsWNXLA51jMQeqWuQBOcj9es2KqFH2cgDxT2IkeIiA8YwWnI1ks0ZyN70qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986249; c=relaxed/simple;
	bh=OJK9kLaRRG72FUMiApCor494UcaDzzJ199Hm+DLDVDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DzK8qX5NgSVTVXK/7PXtuzvez0mUNR13g4Izs1gO4BKEGoTaT12rzlBMKFio1E774AJZiii8tD3yT8zs7+bMMwDiWZzNyWnVrTkT/O5iqcYgfGLMFlvIsdQhKNIgeKATIJob/a9oZihfcFhRkAU4hKxdhFTM8iutR0bH/04HFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy9FqnU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918F6C4CEFD;
	Tue, 16 Sep 2025 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986249;
	bh=OJK9kLaRRG72FUMiApCor494UcaDzzJ199Hm+DLDVDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wy9FqnU6xGvHeutIWHJwxLuqKnsqW+2VuSe5n0SJ1LvPAuqDPe7scsNEEtV802aqI
	 PoMOgZzYycLNTVcRKfKq4gByjuz61GB7HI8d4VrBUiC45O80jcbYhqJvDcMMgm/kse
	 6w2txCiPRfDEEAHb9X2av4oQM7l87FttGwCgBe2xlomx1tivD7fqOlDY4tLSiVSjkR
	 kcwm8HSroK41lAv4gUTC/GbbGaFQY27UPGJLZ47GRMzeecnHPHXQG4KPoNrtngTy3O
	 OvmwA15pB9f/n1KytUqXtJNAQsyvyBIDbsz1OSHqgESZvfs1gpeyPQuttuLOEmp5OL
	 Sd6jeu922JxZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ACD39D0C17;
	Tue, 16 Sep 2025 01:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] page_pool: always add GFP_NOWARN for ATOMIC
 allocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798625074.559370.8532885689010895341.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:50 +0000
References: <20250912161703.361272-1-kuba@kernel.org>
In-Reply-To: <20250912161703.361272-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 09:17:03 -0700 you wrote:
> Driver authors often forget to add GFP_NOWARN for page allocation
> from the datapath. This is annoying to users as OOMs are a fact
> of life, and we pretty much expect network Rx to hit page allocation
> failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
> by default.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] page_pool: always add GFP_NOWARN for ATOMIC allocations
    https://git.kernel.org/netdev/net-next/c/f3b52167a0cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



