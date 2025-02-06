Return-Path: <netdev+bounces-163492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4CA2A6B0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5C7A3F3B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5B22DF97;
	Thu,  6 Feb 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkPPS4O8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6B22DF87
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839618; cv=none; b=QzhUAUM4Nd38sLsQgw/U4wVFaAhhMjF2qC1TweIaSpH5vN51+Zdow9+h7oaKMMvh2TjdOjwuAyQErQhVepW4OYyTrbV4Opbdzn5PcKzujgipf7gL0NEJHdGoNOAjKlMTRm0UohyKFffw6WMdIoCgkwe2IDJvhUhwddnUsrg8cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839618; c=relaxed/simple;
	bh=NKXrKDmphRicr3c/u9tnlZfed8DpFAa6Q8D4w1HTJHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9fHtDvbDdYPWTB1bzgb+lF4+Sha/S6JygNGe9GXdPd74ylIvm6YnvxjEaU+xi34MAVS0HgRuNz//dnhNwVDy//hmaH832NizWeosO7jaSlLmLAa49XzTOEoSfgIK4W4iFJ/93DfNgwrABkiXzGdSDWVtcQBbjbs2cdfQh4mzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkPPS4O8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F277C4CEDD;
	Thu,  6 Feb 2025 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738839616;
	bh=NKXrKDmphRicr3c/u9tnlZfed8DpFAa6Q8D4w1HTJHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WkPPS4O8O8XZdwN4LVkqsd+SpvIglMZDBK+vnTgyN3/TN+licRg1EhOFslW8GYpZC
	 CR21p0F2tDLxnwFjvbvEmwOQNBaF3kJVZNvU3LLEhWosj94bI7doANnYj+l27vSYeW
	 5yHiU5ypk2aRBbyoEoOouHw2Ck94KjuH2AyQRIy2wirwK1BnGzoChsSJxTs7sZCWB9
	 Km/hlre/pdMATOffpsjJ3ViaggVqs161Vlxz8Wr/XEb3cGZbZRJ2HOfX1cb0c8JcKu
	 o+M0rQQ5e9h4v022fHY3Ycsr7ATuqNpUFkKI9sdw+hzXPc2wx8VBBGah4kpXyrBbXc
	 9jAOR9dU9HHxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF2380AAD9;
	Thu,  6 Feb 2025 11:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] eth: fbnic: add MAC address TCAM to debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173883964390.1434316.4192183447293145964.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 11:00:43 +0000
References: <20250204010038.1404268-1-kuba@kernel.org>
In-Reply-To: <20250204010038.1404268-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Feb 2025 17:00:37 -0800 you wrote:
> From: Alexander Duyck <alexanderduyck@meta.com>
> 
> Add read only access to the 32-entry MAC address TCAM via debugfs.
> BMC filtering shares the same table so this is quite useful
> to access during debug. See next commit for an example output.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] eth: fbnic: add MAC address TCAM to debugfs
    https://git.kernel.org/netdev/net-next/c/79c0c4689bdf
  - [net-next,2/2] eth: fbnic: set IFF_UNICAST_FLT to avoid enabling promiscuous mode when adding unicast addrs
    https://git.kernel.org/netdev/net-next/c/09717c28b76c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



