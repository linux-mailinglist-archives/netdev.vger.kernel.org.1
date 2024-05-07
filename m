Return-Path: <netdev+bounces-93916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9E8BD937
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16101F21C0F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E064C63;
	Tue,  7 May 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIUUf1vl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4464A15;
	Tue,  7 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047233; cv=none; b=Suli6mBq5x0C6cZHjzghx3lnpUWMnfUIxzG/4u4t1QjxWwxrImr2KbODF/pYqQuHfb+gMSFBZyh+ZWAHKIENQr46cYkGfnbgGnUwirV2XuqO+18hMvFy9jOt/zrAwMJUv+gS7JCzB2ltH+9Os/X/7qs/ugoA5eXJkXowiN/mkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047233; c=relaxed/simple;
	bh=qoy8thTFvIVPPAoydXePLz4hIIbKSzIzvg40BO3RgQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oAM/CNYUkO842+2/EM4aZcxaJJlu9FXkORgdF3Hlu7HO0qucrXNMG3gMZ/HhnwOYqAKNBcIsJWMsESfhWzt0cggn0ypHFTgyXi0199buZpTCAMxlaVQgyIiKf9JR3294HIMS86rvE+azrCpkJ0d9lDdx6eNu0Vk6PygMLgJKf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIUUf1vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0EE8C4DDE0;
	Tue,  7 May 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047231;
	bh=qoy8thTFvIVPPAoydXePLz4hIIbKSzIzvg40BO3RgQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mIUUf1vlrSG48rpfF4A1C13b2fgnSgGKBSnrelHjobPCU8SqlIBXv/16csX6BDVaU
	 N5eBM/cWbKhAPQQKjIwHHpbG1x8P5YpD8UEPSI2jPK4h/ABVAMkwS/JkxzwJJsp6N1
	 jWDpH/sR0DZ2+aB8F258nJbe6xr+bExqb3EYU1M9skl6q/hv/QmEh2gM3NBe9N1iIF
	 o270MEHi5Zb8/NvF/6kHNL74jRy8FBw7y+J33P3KYjcacJxKmW8iUkxCA0Mc7k0hvF
	 5cV0gH2px+X6ST1oi1H+Z8xc7gKd+u69WTBrh/vlI9FyhrhGU5M+SYkO4aVxORJ4FL
	 /6fVpBRtEQeeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4F3CC43334;
	Tue,  7 May 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atm/fore200e: Delete unused 'fore200e_boards'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171504723180.13822.15041073764970344223.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:00:31 +0000
References: <20240503001822.183061-1-linux@treblig.org>
In-Reply-To: <20240503001822.183061-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 May 2024 01:18:22 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This list looks like it's been unused since the OF conversion in
> 2008 in
> 
> commit 826b6cfcd5d4 ("fore200e: Convert over to pure OF driver.")
> 
> [...]

Here is the summary with links:
  - atm/fore200e: Delete unused 'fore200e_boards'
    https://git.kernel.org/netdev/net-next/c/ad3c9f0e6292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



