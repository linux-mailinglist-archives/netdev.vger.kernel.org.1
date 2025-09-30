Return-Path: <netdev+bounces-227241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47243BAADB8
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4818801D1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E533198E91;
	Tue, 30 Sep 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etp7exoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC11624C5
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195252; cv=none; b=C4mIfb7MSmZ/Dg56h5JKCFjUDi1GWbYu4BVfBhXOdYdL1ZAWsxak7yZSxxtSBAXF+dGukXq1Pfy1ex/3N0Jrc+Mvm3zjxhAK5qhXq6K73F0RyHLInAj++BU+dybG7EJ/6EXVTLVXzkIVea0QMc7hnELMd+OrU0uHPRWps+9slTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195252; c=relaxed/simple;
	bh=GilZ7fQlu48oruzCF5JlNa1Ty+x3xxkWNgOFQ/iBzIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hM2UfEgEauAzqVfsNcJrTQQM9UR1ivbuSC9oA34ds0JYI1kLn8dfJA+lPsOfjz1pXlqrkMGCQ5ATilIJigCLw4kVmz9QN3Y/Rkk1f7upm9gE+OtWjycaU/Cx+76YM5U0+WkwUPpyXrr14gAIwiGm86yTRDOxPqlvrzb7UWzBjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etp7exoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE0C4CEF4;
	Tue, 30 Sep 2025 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195251;
	bh=GilZ7fQlu48oruzCF5JlNa1Ty+x3xxkWNgOFQ/iBzIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=etp7exoE4rBFq/oR7tBLH6+/1zHGkDrTqjpvldLtgicINxwhg2/dg9dy1CgoaLehC
	 C9udGsyjIKGGNhaFniJuUZRAlOfzzzMJF1OdDlr5sWZZftzpdYmBj6KydSjT9mw24J
	 0Kuz4VG4SzRDF98f7bvNhl1XwU3BXYh5T1swTIi/k2YPNNXg+wbHPkJ6e3u38tOfSY
	 mb5+U3gE21V8/7saaAGmQ74xZaBSmKP7xN5vNc0jAVgEA6KEVe0f4qKtNhZrRiizWi
	 KEMtXYg7FPankf4nNyswaJtNZ1Qz1Gdiyod9JUwZ0bypU3IAFV+rHrN/gwLEi/dFzl
	 ehThEx1pkiL0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D5839D0C1A;
	Tue, 30 Sep 2025 01:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove one stac/clac pair from
 move_addr_to_user()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919524499.1775912.10366393472130864906.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:44 +0000
References: <20250925230929.3727873-1-edumazet@google.com>
In-Reply-To: <20250925230929.3727873-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 23:09:29 +0000 you wrote:
> Convert the get_user() and __put_user() code to the
> fast masked_user_access_begin()/unsafe_{get|put}_user()
> variant.
> 
> This patch increases the performance of an UDP recvfrom()
> receiver (netserver) on 120 bytes messages by 7 %
> on an AMD EPYC 7B12 64-Core Processor platform.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove one stac/clac pair from move_addr_to_user()
    https://git.kernel.org/netdev/net-next/c/1fb0e471611d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



