Return-Path: <netdev+bounces-177229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A976AA6E5D0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AFE7A28CC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C21A23B1;
	Mon, 24 Mar 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVrdKFiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98428EC4
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852397; cv=none; b=QeYS+/Amk0SyNuJj8sLjclF5BoET2jix5/HHGzZoQ8vnyFiE22JUXvS8yvMom7M2TCl2R0TJyO/Djnyy1gQU5jX/frqB1Ndz/v5UNTS1BZMHxA3qmGcExYI43GxFmzoFHxy9YK4FNm3NtestRSbUVSysxPRhZDuvKscdDjYVmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852397; c=relaxed/simple;
	bh=OjOqN1ZmcOWYponKMGGehsLgOQz0PkwVsxnbyhAY+GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/SNJdBGL+IUirLTVeEV5881/4VYXuZow9hjqj5Ckx0PBE6hgRwK8GyBf1hxTbQJ1LuJOrc7SOtHilTKkUrwtAbEFnsObsMIU6Uwu1EoMN9MBtfYicZdAUvpE6ib0qTS0WHql8X5xjzmrYlJmpJsjGHeYD2v9YYkc6qoFc1uX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVrdKFiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCBBC4CEDD;
	Mon, 24 Mar 2025 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742852397;
	bh=OjOqN1ZmcOWYponKMGGehsLgOQz0PkwVsxnbyhAY+GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qVrdKFiVaiPqdZdunwLgT/eR9qauFC6iur6JTRa3DYHYblsZA5AkHBWWtii+OggkP
	 YDXlWIY6DEjVTdYC+a3ynyltJeYNmO8tqC1GJmi1c/R8aO4jvgVnZo/bTIAkmlbNSq
	 tIdeDX/pCqRPF/29jl1r3yUAxW7ZlALMJe7ftpskVfybVljEBSrOr81bWxSfGjequK
	 r6nFB+9GOSwfG00TeEaroZkYjXdaflY3blpkMfbqlRJew9vxoFRxi5nvC/LDiz7p9w
	 0J1f9/Yjh16PIzyUTtc1w/zSbJ7wJ6zAtGGMhj1ezFlvVdlg5vBWQIWFAKIfcV63sq
	 MI3mnIL4l4gog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715B2380664D;
	Mon, 24 Mar 2025 21:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: introduce per netns packet chains
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285243328.4187423.3730413599685710211.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 21:40:33 +0000
References: <ae405f98875ee87f8150c460ad162de7e466f8a7.1742494826.git.pabeni@redhat.com>
In-Reply-To: <ae405f98875ee87f8150c460ad162de7e466f8a7.1742494826.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, sd@queasysnail.net,
 dsahern@kernel.org, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 19:22:38 +0100 you wrote:
> Currently network taps unbound to any interface are linked in the
> global ptype_all list, affecting the performance in all the network
> namespaces.
> 
> Add per netns ptypes chains, so that in the mentioned case only
> the netns owning the packet socket(s) is affected.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: introduce per netns packet chains
    https://git.kernel.org/netdev/net-next/c/c353e8983e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



