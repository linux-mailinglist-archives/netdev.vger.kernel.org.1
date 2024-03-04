Return-Path: <netdev+bounces-77184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD0870704
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA299281E4E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D111EB34;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5UfHIOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106B1DDCE
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569828; cv=none; b=tlXu+5ZHePZfItmgd/UWKZGpkQDI9Y5kkav1yiGqny4djmcS6G9q59cU4Z1S5j5Qah1zwzV0in80U1/4HIWdGzfQjA2pDDLOkdPHH2uTXlLbIBG2U6alacDHckdrGZyKZBtaqQOUu9pIcgvWepg76ZSjLnGvrhYSAx9MMVLqSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569828; c=relaxed/simple;
	bh=t17KsGSWPyXlHY2c77w5YSCxgUMbiurCCnWzsES9IXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoXvjKGopjV5BCMwabdaT8tdXzsPeZV+vfBYMWiFWjXBYrnMgGIVt+MgBmPBQggZMHkWLw5mTOYasR7FAvIbyH5cPVZ6Xty7N3ScGZy9PtLxa9YiSib8qfh2Q2tr1nGmD0EUoSSrVUyRnhwsKdsoxIza5d1TwpxjXRkNADqcUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5UfHIOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27798C433F1;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569828;
	bh=t17KsGSWPyXlHY2c77w5YSCxgUMbiurCCnWzsES9IXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m5UfHIOjSZhGgT64VRg0a+StyYuxITfZyImdEsVPoviz6mRWAl92wTxuE2uY8v+s7
	 TM858FQhy1gZLLVr0Jz0vVB0sKw5RMCvPVyT3Aehr5du0gM7K/jAkpAbIDqWy4XBCT
	 R0mtGm6JQOUPwIewx5wrbI2gfnV5TOlciVOlF4gIe6llxKsPBssSSxcr3+/18AC0mh
	 dl/CSCREX6RBOpKqGYq9ey2FzzB71iS6iHTtzDj4V8Zvsy29If15xqwmoT78Tgy/NA
	 6u2xEB04ifoBKOGUvSPqsgNbHmoMWlziOzAy3g7Xzsm2a6/j3UcDLOBdYNYR8Jlaj0
	 UsXznlfYJAr0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E6A8D88F89;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ss: fix output of MD5 signature keys configured on TCP
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170956982805.9053.8229958764224181474.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 16:30:28 +0000
References: <ZeHLFNX7f5x1M10/@grappa.linbit>
In-Reply-To: <ZeHLFNX7f5x1M10/@grappa.linbit>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 1 Mar 2024 13:33:24 +0100 you wrote:
> da9cc6ab introduced printing of MD5 signature keys when found.
> But when changing printf() to out() calls with 90351722,
> the implicit printf call in print_escape_buf() was overlooked.
> That results in a funny output in the first line:
> "<all-your-tcp-signature-keys-concatenated>State"
> and ambiguity as to which of those bytes belong to which socket.
> 
> [...]

Here is the summary with links:
  - ss: fix output of MD5 signature keys configured on TCP sockets
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=857a328934a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



