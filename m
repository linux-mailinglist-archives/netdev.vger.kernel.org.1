Return-Path: <netdev+bounces-120353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6895907E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963E1B23240
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887C1C825A;
	Tue, 20 Aug 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuILLgcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789A3A8D2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193033; cv=none; b=TC8nrfWXQc5HB2IuCWVodEP0WMGtdrd00OEOccONpe1Kn8isXdY5sTtzdRxjCHfYVg+4zQ45RSndaC1CX7XkbcglaR34zlBsCX10QonZNbV9v92KDeOipGqjRfzTHaO2mn0QIS91CYtayJl/e4iTgxRFCIsA8v7tzykCp37vJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193033; c=relaxed/simple;
	bh=ziCIRLS/G7nC6jmjgM5hTrWAxElMFcfD6YEIHm4kdZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M5zVUpBBgdFKFeO4Zjh+i4WRMBfl4H1CtzQ2us/+fYu5H3j7bOSi5VtJbMPhAl5UOWtDGtB0zlRVEFSh5XOitanEYbdiWoamjdPPGGNHN1qnUtEi5qHRBWbmtiTt4A/QLcZYAStW/cqPVDocUlGZT+SQ7AJLz5100SZMP2C/zGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuILLgcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E055C4AF0B;
	Tue, 20 Aug 2024 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193033;
	bh=ziCIRLS/G7nC6jmjgM5hTrWAxElMFcfD6YEIHm4kdZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DuILLgcKODLB4Fr0KdsOqRnsxxqzZzjTD5U4N20kFXPm5LNy4uHs7MM4d0L803hQf
	 29OvD/WDifQ6DXmZlCKeYRJqB1jaXpgZ+3800KqwVFuSvYJy0cCHTVMM8h6X5cKOA9
	 7RX6ZhVEhFzZx05lhzj/KUe4UaxfVqWyDjIzKp+DzcDwczOu1OqB7XmTCeXxwhVNsf
	 y92tDpZxTHxNvmdKMq3r0ZPz2jZMgrOYXDzItfV34RAAJucbH64IHOeS6RPphpYbvI
	 qTfdZLCioGko5tbYpF9rUS/P8SXvZzwctkWvukmEod7YcE2oKE61yFSmVhx/yUR1Tg
	 OpMq7G2Q3SiVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD093804CAF;
	Tue, 20 Aug 2024 22:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning in
 metadata_dst memcpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419303249.1256151.9987771078379121139.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:30:32 +0000
References: <20240818114351.3612692-1-gal@nvidia.com>
In-Reply-To: <20240818114351.3612692-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, cratiu@nvidia.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Aug 2024 14:43:51 +0300 you wrote:
> When metadata_dst struct is allocated (using metadata_dst_alloc()), it
> reserves room for options at the end of the struct.
> 
> Change the memcpy() to unsafe_memcpy() as it is guaranteed that enough
> room (md_size bytes) was allocated and the field-spanning write is
> intentional.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Silence false field-spanning write warning in metadata_dst memcpy
    https://git.kernel.org/netdev/net-next/c/13cfd6a6d7ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



