Return-Path: <netdev+bounces-149224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD139E4CAD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39661881A4D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C38191F7F;
	Thu,  5 Dec 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeL7jeEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987E17A5BD;
	Thu,  5 Dec 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369427; cv=none; b=ZMbuyS8wq4qGZNLobzpzwFgNatwxY81HC7crovSp6MKsjorZQIdoylA8ljiS2pkpqJZ+XTfY2d/0lPCWERlJ6kTOQrpJTO0bvi23vHBjcDBDdq8ODR1eHp0pLJRPi2PnOV4/Rge3s2ttpKbFAqV+mkpbAbTPqn86KsHz2rmxXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369427; c=relaxed/simple;
	bh=xCGD7IMZkPe/beo63SMas1r363M8QJlM9comt1iPDdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TB5eaowDmct+sE+kKiN76c+2x3uINlahNQg9//EeL50mNptTmaCOCAXc/JKew/wzyFNKm1tsOG5RY72JZDYEoR6Q81k9Mi8x9OQg96W51Hd597V76X5apXPmdGRkoi7r2y+LcXzx1yBOUbu3IE42ypFki7n9qqo2Sk+VgdaLfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeL7jeEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A9AC4CEE0;
	Thu,  5 Dec 2024 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369426;
	bh=xCGD7IMZkPe/beo63SMas1r363M8QJlM9comt1iPDdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JeL7jeEpLD7MzoMmPZrg9lxF3XZYwuXWVZOuQQTkuQdmYjTw2cSG7JYcl0LNzYE00
	 0cHYnjBysCaNexHhQKMtsu0DPhgzk8/ucDE86b3P06kqVj2giRLw6bb4pxBm6oL/42
	 b/jWt9+92O8yfcC9+hBD4oAbV1oa+Z8+X1TrakCTtANPqPnHwONr5LKNnWpigSqD9F
	 mex52vWKG/TKN9DuL4wHcdOk74LP1qAuweac08SJS2DKqg6uqOxohhh85aqEBPm4la
	 G2B/HeyxtpXq0vhHdTQ+01+DPMm1OqBWdo5n9gSLvMZAKvZ8Uc74NCc88xMhYILUgK
	 NplQVONEThBJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71CA9380A94C;
	Thu,  5 Dec 2024 03:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] netcons: Add udp send fail statistics to
 netconsole
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336944099.1431012.14311700404470726284.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:40 +0000
References: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
In-Reply-To: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 leitao@debian.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Dec 2024 11:55:06 -0800 you wrote:
> Enhance observability of netconsole. Packet sends can fail.
> Start tracking at least two failure possibilities: ENOMEM and
> NET_XMIT_DROP for every target. Stats are exposed via an additional
> attribute in CONFIGFS.
> 
> The exposed statistics allows easier debugging of cases when netconsole
> messages were not seen by receivers, eliminating the guesswork if the
> sender thinks that messages in question were sent out.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] netpoll: Make netpoll_send_udp return status instead of void
    https://git.kernel.org/netdev/net-next/c/a61b19f4a658
  - [net-next,v5,2/2] netcons: Add udp send fail statistics to netconsole
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



