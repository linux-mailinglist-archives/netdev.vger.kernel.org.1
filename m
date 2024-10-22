Return-Path: <netdev+bounces-137843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1DA9AA0E4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA30A1C220C9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FD19AD97;
	Tue, 22 Oct 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB8VgV+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1818BBA9;
	Tue, 22 Oct 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595428; cv=none; b=mTt3Ol567tJ5o0/DgghP6IlhhmZfwvyS7zfDwRhZniP7OJmnX/pkZ5GznviDNwYRl+G9pPObJTvFky0YxYpi7hsCaiHMoOd0k2P20PaIaLF7Bp2o3IrHI6Xj/MwQkCaRTuz2fgbc6Zpzm2lMsnv9v06yfZH9dPWba3Lqtg9FDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595428; c=relaxed/simple;
	bh=e8sSwNSQs3uFcfxLeLdkif6qurnWDGmVDipY8qu0Qs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+pAf6WXFPPWE2xFhc4VAxl1YV4EFn8qA+tFTPrGfNeh0KJymqH5/BpWG0JI3fZal/Usq2KuducgjaAn04FBPm/I7NB79eqSEKglGQnFyhr1Fc0G3+CeAeMSL3Sd/qR5GAP8GJaR7ySQnYYjjzey5c3KsWZhdXXTtXeyHvBVAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB8VgV+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5BAC4CEC3;
	Tue, 22 Oct 2024 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729595425;
	bh=e8sSwNSQs3uFcfxLeLdkif6qurnWDGmVDipY8qu0Qs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lB8VgV+GMAhZh/L5pnwtF5gJdgpd38zs/lwCJsDOD+UOP+1dpEpU8VZCUbRCU6N0H
	 i62J5CB02xoHoP4WSuLT+Khs8+QUYWL9g2cDEPkA3O/HIAAHUbXpdWimuaMRLCgzr7
	 HcJ57IOkospnE0ZoEc58FkELLqVtl00aJgSIWoXJ2jylcg0O+6r+S2glejJNqBok1N
	 pwMUFWSX0l/bco65lSvvVbyTnlSMgFrV4rIo2whWmFwhGc4rteb3vVEgnn04ubnQ64
	 LJaMCh9X8d8UVsfMkiBRWmnm1uBQuNRGBNuqEStP2RyHwem+ooflzdjQ2MGpOaX+5e
	 Sf+NeR0H+0Pow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACED3809A8A;
	Tue, 22 Oct 2024 11:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: marvell: Add mdix status reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172959543149.932857.14183655799935576244.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 11:10:31 +0000
References: <20241017015026.255224-1-paul.davey@alliedtelesis.co.nz>
In-Reply-To: <20241017015026.255224-1-paul.davey@alliedtelesis.co.nz>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 14:50:25 +1300 you wrote:
> Report MDI-X resolved state after link up.
> 
> Tested on Linkstreet 88E6193X internal PHYs.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
> ---
>  drivers/net/phy/marvell.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Here is the summary with links:
  - [net-next] net: phy: marvell: Add mdix status reporting
    https://git.kernel.org/netdev/net-next/c/c797cb9c0988

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



