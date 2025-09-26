Return-Path: <netdev+bounces-226810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5941BA5509
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922B5325838
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4B30EF91;
	Fri, 26 Sep 2025 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/wQiZBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEA30E840;
	Fri, 26 Sep 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925231; cv=none; b=hI5ISJ06kukvxSYPPYZ92TU/+GjxT9gAO6Ul+u6y2CY5xTF8lINpzpDpl+SY6fUPyRq1A6GlRIG/vfad+7VFn+Pfd/FCUPm3P3Zx/eegfXhWMa3XYNOoLNplrF3R3DNwzMo8mb/ONrEOVyNAiZQvcAPrgVcBkLhm/2iI/mlOoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925231; c=relaxed/simple;
	bh=20rCXv7m4emWNkH1SYVJfAGPOG70bNRH2RAGvXRzBsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5J/OKxa8r7MZ0RcYyBILcu20MLm9+KNimdah0lIAf4wWVbB9ss4dg/2c1JKVzuj1VaJHnAMXUpkH+AaqNT7+YZCRtqon4b8fiB8/w40QYixDx/V29wZwFpypUf9RI1XsbASf6DvE6U/lGFl9yi2lCTfOtvITd3cjMh9Czq01g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/wQiZBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86E1C4CEF8;
	Fri, 26 Sep 2025 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925230;
	bh=20rCXv7m4emWNkH1SYVJfAGPOG70bNRH2RAGvXRzBsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/wQiZBJRfIg68VDAJ7oLg8TSHnxMuXo3LJfI3Eg0kf/Swjx508qz8+a76FL6Eeld
	 tW4zOsmPv4lFhWivYQ3CICPNBNqd47bhYQ2EEotIue96IWFI08ByIE5kGle6FC3IDP
	 RCwqz2VsC8izT1/Er+KYTipp/SZpf+DMQ3MHEfpprcRp8gQJF6wqI1J6zBqtyZj9JT
	 el6AQ7j7ee8DAAv0lsPEg3saa0ixuAfyi8C0dkVOv3X6B24VsQDGa7z+mDa5TsglC4
	 /cHqFfg7lycS9jHpjBjm6cL7qMscCDQEG4I1pnx9uB5+TMp3ra6j/jW8B1tP7sGSqU
	 fWyXDCPB4WRbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9B39D0C3F;
	Fri, 26 Sep 2025 22:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: wan: framer: Add version sysfs attribute for the
 Lantiq PEF2256 framer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892522575.77570.6076596261138078373.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:25 +0000
References: 
 <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
In-Reply-To: 
 <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: herve.codina@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 17:06:47 +0200 you wrote:
> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> [...]

Here is the summary with links:
  - [v3] net: wan: framer: Add version sysfs attribute for the Lantiq PEF2256 framer
    https://git.kernel.org/netdev/net-next/c/0e41b0af4743

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



