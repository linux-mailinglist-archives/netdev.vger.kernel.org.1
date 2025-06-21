Return-Path: <netdev+bounces-199977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D775AE29AB
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA533AE939
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49E210184;
	Sat, 21 Jun 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx1gDlJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AC20E708;
	Sat, 21 Jun 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517982; cv=none; b=H226sEsvPJRiLr+Zg5ncnB6TNxXiDyKN19drfrYGPI2v0vmN9P1AYcJQvlvIjW2ElmxmCHeayRydrvTu4OqIz1qNxlpCsmHaxQ8iqOO9tvBXSGpIZO+mcAH/AQ7mSNegcXa5b35ZyEbDUSRnguSND558B6nlROgJNBeMwSv3Pvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517982; c=relaxed/simple;
	bh=8gKyuqa8jcgb6fTdTTw9lJjApL1TmBoRgR2CoE04yxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rYwTHnYQRnsqYuKP10I3MjEGIVGleQ8fGJOIKHuHFICAySGhCTJo4wWmzxDdpyFWQvREkqJTGGrQhDXEDvHIOUYKayaACgzZMGDDhrLq0KVazN5NLDCStbnYxgHmASoAGNo4w0wgmVi/sXJxCsEdA1fPP/+SUKAiYeN+MATtO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx1gDlJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09DDC4CEEE;
	Sat, 21 Jun 2025 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517981;
	bh=8gKyuqa8jcgb6fTdTTw9lJjApL1TmBoRgR2CoE04yxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kx1gDlJNIEXq58R8sS5Hs60w/C04XXh2iqmGSbdkcQ0wV6HjjP9IwWHPgzSxYDBLe
	 PjtAExxyrLy8Mw7vqSMEtKZrvL3QGi5Wdo6GGT5C83SHcjWaih/jxeAV6z+MNLzEh3
	 hr5HKJ+OjmTRpPGj4cldSPaWDeprOJEwldeGVY0W3Kt3P38t0ukA+bAvy1unUk/b0S
	 EqmicbTBQ8pRp3zOzDviO/ICmGUwMMGjLLSQNauyMuY1Fk4zn3PLyepauOVRwo7snj
	 Z/cYCnG6R1G2W8FN8l3sque4MuRjQ7QAUs8GlcfIzone2d91fxG/NE85w9iIGX5nHi
	 GAFigbCQbHKgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A1DF438111DD;
	Sat, 21 Jun 2025 15:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] CREDITS: Add entry for Shannon Nelson
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051800949.1877807.82162384886487611.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:00:09 +0000
References: <20250619211607.1244217-1-sln@onemain.com>
In-Reply-To: <20250619211607.1244217-1-sln@onemain.com>
To: Shannon Nelson <sln@onemain.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 14:16:07 -0700 you wrote:
> I'm retiring and have already had my name removed from MAINTAINERS.
> A couple of folks kindly suggested I should have an entry here.
> 
> Signed-off-by: Shannon Nelson <sln@onemain.com>
> ---
>  CREDITS | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [net] CREDITS: Add entry for Shannon Nelson
    https://git.kernel.org/netdev/net/c/714db279942b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



