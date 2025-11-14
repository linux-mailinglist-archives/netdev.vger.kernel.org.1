Return-Path: <netdev+bounces-238560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A7C5AF7B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7714E4E6C07
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C6A263C8F;
	Fri, 14 Nov 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEUdLhZt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D825D546;
	Fri, 14 Nov 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085645; cv=none; b=d+X3smzXqBxCV8EHZ8i4X7XTwuXMtMfGd3sJTQFsPdEbKw9T9l7sDsxxErJZ2e3MExQgEgLJlBemXurfG1i1GVoS41Jx8RIC5vNadLgtd2sUkZesqITcfBt8AkTKgjbRxrqa77zuKFS8FYk8E/OLB3tWKP3Z9kuG5q9No7EMxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085645; c=relaxed/simple;
	bh=tc44Q84nwM31UzYk9NTTob1nNXu1W5I3T15GmcbBzPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MClwyOvJku+JJeHUpNwmDD7Iw8uk3ZV0hFumwDd8IEdIYLRDP22toUO1AkvKo5WN4kH/aFFp/+ozEUFCcs2Xfr4aeZXGgoi4DQ7I/aXfQ5DpnOESlE/5XnLdEw96lQoUJyHktx78hrF1Uh8EFBz8ddP0R5T1ToUtgSrm/0pkzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEUdLhZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFA6C19422;
	Fri, 14 Nov 2025 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763085644;
	bh=tc44Q84nwM31UzYk9NTTob1nNXu1W5I3T15GmcbBzPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pEUdLhZt+S6AtvKiSAUgjQzgLaDgU4RdpnZSRB1Vyk0lMve6CRAvyp6CwDXtw0/nv
	 HUnOPO1WcPqnCgeM68xMzQpJue/Z4q4EeHGKFQPExeGiE/ccd/7Vm57lFMDINpHu7L
	 TZGXfWU8OaCIjMpZ/BBDzFElhXSW3ydlE451IPBAxo/Sti1K5Ui4Djihc21IgDoii1
	 cmnzD+ZUEToUTAA99bewbGDSqjtL1HjX95KKhxAkTnOulV9RCbj460x4GkTnmyaCjR
	 BLIRFLuaLpMRhOHEoiDOjATHwvP/fH149hczv7vDuIMz4rhbID/hBRh3MWkVkUpB6i
	 TzXO00Wpf9zVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAF3A55F84;
	Fri, 14 Nov 2025 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: usb: usbnet: adhere to style
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308561350.1083043.5727485598090319213.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 02:00:13 +0000
References: <20251112102610.281565-1-oneukum@suse.com>
In-Reply-To: <20251112102610.281565-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 11:25:00 +0100 you wrote:
> This satisfies the coding style.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c | 233 ++++++++++++++++++++-------------------
>  1 file changed, 120 insertions(+), 113 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: usb: usbnet: adhere to style
    https://git.kernel.org/netdev/net-next/c/de9c41624c9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



