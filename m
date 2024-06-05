Return-Path: <netdev+bounces-100887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436148FC789
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BA81F23EDE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64B18F2E6;
	Wed,  5 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGdHwZZJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C81946A9;
	Wed,  5 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579231; cv=none; b=IhuG8iVCP+mRbVjS9vDjB9mmr/BcJBlD11ycGvyX1HihfJhJcpkI3xseSY1p620R6poimwcQfPh6WHKuDFgmayUSNfc9aeT4ni9KVhQ9iLNnI4CSZ+1z3GNBRvmGtTFOAOMuqIVbOkCdyekLzaWc2euOzT7KXL+MzbNtfDmtdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579231; c=relaxed/simple;
	bh=EH/xQNVgLBvKT7KpxHLDDEO03pyCldPwRj55PsMI9zk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+RlPCw+kheDZvDNmaGSDvhohlelIdwwWQgEVgeMX6rSVdhzrWQ952szfb4h61Fg6hzeAFdDIZxc1jmDROKN3sce/9v2CwlvEUhab/FO/5EuY2MuqZ7K6VFxoGHzcxPM21R6h+BHW/kwh6D4Gr3kkuk7f/phef9NiO1DLcQUw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGdHwZZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E66D9C32781;
	Wed,  5 Jun 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579231;
	bh=EH/xQNVgLBvKT7KpxHLDDEO03pyCldPwRj55PsMI9zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cGdHwZZJOVHU2lREiPkQ039t3hurlkiGdLdTYtN0CZURsk1xVjWIpNGwu7pKmXJNx
	 eBgTbGSS1ya0cf2H8Q/0wm+7bvKOT0n7ijPEHV7N5nv198N2WXlCRWUcfV1WOZytDQ
	 eR5uktdToNxeJVBeNG3NgnZcasaJkjUM+1YB1mIGTI6u+CoOAcFGP9W3A1j+98UxYQ
	 gxtnFwL+UWvC0YaHmq6KV+HjL40dydrhTi56G3zp904uKMbTIxjamAX/hCTsaGeymu
	 qgIb8mcM9pYI/on8i5S+U/07mdIukA/L7R1S1/3wdiMOPnR14qIHXsBWyZS5YWQ4cA
	 w+US8MIrlnZMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D58BCD3E997;
	Wed,  5 Jun 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethtool: remove unused struct 'cable_test_tdr_req_info'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757923087.31707.4583982812675009172.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:20:30 +0000
References: <20240531233006.302446-1-linux@treblig.org>
In-Reply-To: <20240531233006.302446-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  1 Jun 2024 00:30:06 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cable_test_tdr_req_info' is unused since the original
> commit f2bc8ad31a7f ("net: ethtool: Allow PHY cable test TDR data to
> configured").
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - net: ethtool: remove unused struct 'cable_test_tdr_req_info'
    https://git.kernel.org/netdev/net-next/c/a23b0034e934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



