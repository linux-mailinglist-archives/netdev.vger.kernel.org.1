Return-Path: <netdev+bounces-117363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80A94DADF
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC25D1F227E3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397D13D619;
	Sat, 10 Aug 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+X+z95D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1C45BEC;
	Sat, 10 Aug 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267241; cv=none; b=Y5ibYWDFiWIqLAuxQ7sTUGMXbnJabUmCu2w2TtRGmczo/oFSgap+iKDNtswz/X2GOSQmEpyqI+M8MWPAP1lUGX1D9IgYHFvj976pvodV6WrTON4XMEKkgzf1i1YqIHWqWTcr9LSyAvCCLeF/e98pNXuY3gL9WiKH3WuKQHnAn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267241; c=relaxed/simple;
	bh=UtPLN3pbjiIR/k03wkRjAthzpYgFJO/pwbZEAhWERqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VGMXO0Qy2uZUAPZD1o5f+EGvOhu2zng6GozvWOSZJzZE5RzZbs8ycLnkfNoctOXz8Tij937H3TMBsb/W3HL8EWJZIdaaIrk5ciHELwYRe3kN9klSJKP8oqesZ0S+qDj+tK54EpzHFBU8FyEJyaaHRjODJFC1BDVwaVTO7O2mQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+X+z95D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F21C32781;
	Sat, 10 Aug 2024 05:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267241;
	bh=UtPLN3pbjiIR/k03wkRjAthzpYgFJO/pwbZEAhWERqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L+X+z95DD1tHyor1lQ0vEH1GC7lLhD/X14Zg8329dl+qywXWGoLzOKdOh0Mq0pjPT
	 XkPk1F/wpnJ4HozurMG9Z9C7fYBlP2PjQFPm8uDrI4Glm9SDNfc1W/x9EDttd4TZZP
	 FLu9IHDVOdmNJOZmMb28Z4DPf3/OevAI+RHGQvyhifVdUWV+VmPVJsAk+sPof8LCBg
	 ElzcjP6iVKLG0sNwJwES/1dJkUsLjjbcTRvULql8MWdBPI4dLHhvYvUVs5ViTNtbDC
	 rJAAs+Ic6GzEcgCAx6jvJqGUfnVX3lhrO3bt4T37YwmaQdMsNfGITFwTlIKWpjmpdR
	 aZGnWntBCZBsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D40382333F;
	Sat, 10 Aug 2024 05:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: cdc_ether: don't spew notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326723999.4145426.8495973392597760485.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:20:39 +0000
References: <1723109985-11996-1-git-send-email-zhangxiangqian@kylinos.cn>
In-Reply-To: <1723109985-11996-1-git-send-email-zhangxiangqian@kylinos.cn>
To: zhangxiangqian <zhangxiangqian@kylinos.cn>
Cc: oliver@neukum.org, davem@davemloft.net, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Aug 2024 17:39:45 +0800 you wrote:
> The usbnet_link_change function is not called, if the link has not changed.
> 
> ...
> [16913.807393][ 3] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
> [16913.822266][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
> [16913.826296][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 11 may have been dropped
> ...
> 
> [...]

Here is the summary with links:
  - net: usb: cdc_ether: don't spew notifications
    https://git.kernel.org/netdev/net-next/c/2d5c9dd2cde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



