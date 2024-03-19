Return-Path: <netdev+bounces-80582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B187FDD4
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864A282699
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC97FBCF;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkn8Ybcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8907FBB9
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852629; cv=none; b=rEP6o2jy+KniXYqR5ZtMhb9fVCW7F+4gxCxuYcY6EnWcAPR5ecin/wGARYKNibU7mKxAfI1/VQyKjo/vZ2qPg3K2C996j68sfTWFWafhau6fPD6isvXNfp6ulhZjx2YYhh1slHqwMCBaAaImGEbvFWlUI4JGilCN1cPjf8pae0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852629; c=relaxed/simple;
	bh=W5SOc2P/C0uZpermhfs+gHNpR+HxTClcTSQYz3W21To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sITj9DB0Vz30efaTSii9MC881zi5GethKKbc/AOXZy/Ugsz0/VOt3ccjCCsvpUvlJyh6y1L3F8GEOK5cb+irqfFnY+JYJtNnhcNyyAAZ8jGVmWJKo6rHggiVbqXdaarvIzLNyVVrAnKYXwP/TCPVKxI05CZbFwUi/lvamUo5RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkn8Ybcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37B88C433B1;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710852629;
	bh=W5SOc2P/C0uZpermhfs+gHNpR+HxTClcTSQYz3W21To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rkn8YbcuAgIDIxAz2QObK53q9ZLK+IEHp71nmmyiBLFWR9xyj6n/yAWb8s+waN3Fy
	 KRX1QSqyyoO26mukyt2B12M5EYv4ui9b5aRIsISpNFkEFXwq75LvBFuM3gMlgQIQLR
	 GGCoyI1JmxBzN7L7U5XttCp9X8HJSDPXzfi4p+OkX1rnj6PKxUviCIz5JvKI5iJcIB
	 aNQEtyh+pOfDFpzsz84QK46L8BgEp6FKdgQBsuNbTudQ5jTZVRtrXSdgXGiZZYFnz+
	 tqYFuczfL+ktdnE+tZeURzsAl6sU2M0Q7ZrNSn7lmhuv45wdv1qEUWsnq8TTpVtIeM
	 j22iUh7+0LyJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29965D84BA6;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] hsr: Handle failures in module init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171085262916.28386.6365910600633708829.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 12:50:29 +0000
References: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
In-Reply-To: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, dkirjanov@suse.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Mar 2024 13:04:52 +0100 you wrote:
> A failure during registration of the netdev notifier was not handled at
> all. A failure during netlink initialization did not unregister the netdev
> notifier.
> 
> Handle failures of netdev notifier registration and netlink initialization.
> Both functions should only return negative values on failure and thereby
> lead to the hsr module not being loaded.
> 
> [...]

Here is the summary with links:
  - [net,v2] hsr: Handle failures in module init
    https://git.kernel.org/netdev/net/c/3cf28cd49230

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



