Return-Path: <netdev+bounces-114362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BE94245F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9B1F24C35
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA7125BA;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOpeks5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B7101E6;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391235; cv=none; b=WhDZMDeOwfLdNrkN2x0cSnRfT9fxmZroBTHyUyxHjBdESMTW/x5M6VEdPFocfq6Vjoi6OTati6LYOZj0StE06ACn9P81nFuGcqXmnr99i5JS9apuT7bOSoIundy+6mPw3PaIH9XQ2FrxvLgTBfWAbU2ZeroWdRKAkwMvPbgGykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391235; c=relaxed/simple;
	bh=9c1O6kJ3l2ngUxzsvXcSm4ejRyhdwEaYIy/u+OSCwWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohGRdXX3EAw1WU/o2EHUBEfY+xTUvQbaDQUWyqatUlG81/lfgFO6OLso/Q2HenwF2XM0/c2FVhQKqepGiSYDl+pJCpB2x+ElBitNnZbkspx6iH68nJTl1n9TKg6OIeif3n2zMlqvzVMXdOj/BlCTt936wpl/6SN6vVVALmg1Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOpeks5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F251C4AF11;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722391235;
	bh=9c1O6kJ3l2ngUxzsvXcSm4ejRyhdwEaYIy/u+OSCwWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eOpeks5pU3TIfiRxcilfI5TeLFboZH8M53NeP6zAM1gSRD6REEZApFNqKMn0jJJvg
	 LnGu4RMHVVh6LKi8CfYJYV9jX3Z6G4Jh4q7UZtoFpRi+PMEmpMleojmm0L1zarwqLK
	 /qgQ5g97AAsxUmksSlUTaZ9t3HRcuCvcdO3TXk9F+DE+3u6LfR4tN9xknDi5p5I1mK
	 9aIUCSgRINVqZVgswJlrct05rZnxHn9NHkcg6i9S2T7u6v65sniBheCZSmoWyRSN0V
	 Lu1C4gMV87Oke+upZ7L34u1g1QdldgUlTQLWsY5wojhGfpBM1H9hhFgeb/VpAnGQGL
	 GhMiB5b1ByPMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0546FC6E398;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/tcp: Expand goo.gl link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172239123501.15322.10476097202735934842.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 02:00:35 +0000
References: <20240729205337.48058-1-linux@treblig.org>
In-Reply-To: <20240729205337.48058-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kennetkl@ifi.uio.no

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jul 2024 21:53:37 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The goo.gl URL shortener is deprecated and is due to stop
> expanding existing links in 2025.
> 
> Expand the link in Kconfig.
> 
> [...]

Here is the summary with links:
  - [net-next] net/tcp: Expand goo.gl link
    https://git.kernel.org/netdev/net-next/c/0a658d088cc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



