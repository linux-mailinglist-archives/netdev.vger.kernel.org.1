Return-Path: <netdev+bounces-227338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257ABACB78
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61E354E267E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92F72641C3;
	Tue, 30 Sep 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkpe9kT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C0263F30
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232413; cv=none; b=TwY2/d6o/S5WcZGBG5qa271r52V8opmDNc3MGRND847geNcDtoWlT+GvjgC9elQhztKeY+7m/YH069rXKCH54uTs7nml/FBBigNnzW7hHKupnEMjiwWba/u8GM+TgcWRIbqvMqQ3t6TZ+jkoe6Y5hszNyJ4vJsCLE7tBK8EeGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232413; c=relaxed/simple;
	bh=XMUx57QcHS97KXOcJceusZV4nIHM3webnnZLPaRJQS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7pCOHhOXlvWnDgiXS6cmeukxcgbgnpSO0snKpJ0HMds968fdC4uxg65RfYqjsIdWnNq3TnTe/+wF8CGePeP4o3RSGleeXv16MVLzpF63lW8fNGIFqlGPSxc2ltDWWQ3RDslYS0Cra0cwymTg7VT0m2kkknkqu5HubOOPXtHums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkpe9kT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B70BC4CEF0;
	Tue, 30 Sep 2025 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232413;
	bh=XMUx57QcHS97KXOcJceusZV4nIHM3webnnZLPaRJQS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkpe9kT+Aqs8V6DbzNIJf1+dGIINDsc2Hu6qn9UvadEGpfyz6BrAgDx+djvVSen50
	 mRtfF0cHiHnhJ4TJhsR+n+kK4LmUo+VQScxsZwSCVLj1SZkOV2SEEQSPSpj4t8Xjew
	 Cy3qFaF6ILhFUqOIasTx2z2fcWfRheOAjlGGiy9Mg26XT55hts9sn9aUerCbJvVNwp
	 59fVPxsThvwNQI6xDM0ULrn2NColsBWmru47VVTl/kYQIr/fR08QuxXlJldZVbznAy
	 mhd5eUyH9ClBbihgLBVbSq09daoRni4bitM20GpGIgIFIqH1d88lTfVXb9sWuYW46x
	 1tNdYSdCAPdRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8BC39D0C1A;
	Tue, 30 Sep 2025 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: don't include swphy.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175923240676.1954979.2743038851194854729.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 11:40:06 +0000
References: <19921899-f0a8-4752-a897-1b6d62ade6eb@gmail.com>
In-Reply-To: <19921899-f0a8-4752-a897-1b6d62ade6eb@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Sep 2025 22:03:35 +0200 you wrote:
> Nothing from swphy.h is used here, so don't include it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/sfp.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: sfp: don't include swphy.h
    https://git.kernel.org/netdev/net-next/c/df7dcf5ebf34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



