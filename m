Return-Path: <netdev+bounces-117353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE7294DAC9
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6541F2230A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162B273DC;
	Sat, 10 Aug 2024 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aug8uLCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991711B5AA;
	Sat, 10 Aug 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266033; cv=none; b=DqdVEFsZ9N5ydy5b0+mHmDwLRnwIksxauIejxPcxYOlJlhTj9cZ4Lxm6wWz33N/teHMxvylW0O8ihqLfyNSoXYV6esmcCnD8K0S+KmL7Ptf4lQK/DDq/1Wqihawh1djxsDWg39VLpxraT+HOqR9LxGHlhTyF8UVN6LwlwjZVFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266033; c=relaxed/simple;
	bh=0NuQqLulfX+HXKQwKooNcDiAAl66rBxTxiIJI2UZxm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XV5KinosIcaowjdgLeO7A/1QdfiF5qYrJXJQddKVoR43taHydCytLK4Ffdw3W4FWUUyvEY08BMD5oK/eJ1TcWJ+WjGC0ORCwkt148PaPJR3y2bBciqI2HLJULlnUVTNBcgDkPEgruMEnitPyzVCKL/2n6QKB1fA4Us2mwRKoX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aug8uLCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA07C32786;
	Sat, 10 Aug 2024 05:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723266032;
	bh=0NuQqLulfX+HXKQwKooNcDiAAl66rBxTxiIJI2UZxm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aug8uLCbBuKetmSnb0vU2MzMb21T1H5NdPfCnm5PPV0RKPh3RPooV+ForPBzzbJ0/
	 6yWyivrq7x2QgPCDyUQxMh7L+PQRaia3b5tK8iEJEeFIcFAbWlKBT5sryiXZRNSIJy
	 wKDXOb0zhcA5AmXxg/vkqOqxxx5Fv2PSJ4Bft9pc1lQ6Ca3ZKVTw86tooN6cU+46XF
	 Nh/49CE7XkZODV6BGgHbScjL2QJP+mDAaL0UM4l89hCqmTsps3ocMleXG0neHuLGO7
	 c1Yn5e/l3N6i+6RJY3gaq+mUyguT28+wvTaZuj1jnMZ08xDCR32Z2jvPnGU7UC9KLZ
	 rbWcDlgjS2TGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340ED382333F;
	Sat, 10 Aug 2024 05:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] ethtool: refactor checking max channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326603108.4142468.12919222166772124286.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:00:31 +0000
References: <20240808205345.2141858-1-almasrymina@google.com>
In-Reply-To: <20240808205345.2141858-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Aug 2024 20:53:45 +0000 you wrote:
> Currently ethtool_set_channel calls separate functions to check whether
> the new channel number violates rss configuration or flow steering
> configuration.
> 
> Very soon we need to check whether the new channel number violates
> memory provider configuration as well.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] ethtool: refactor checking max channels
    https://git.kernel.org/netdev/net-next/c/916b7d31f7ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



