Return-Path: <netdev+bounces-159533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62DA15B46
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DCB167DA1
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE386334;
	Sat, 18 Jan 2025 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXsYhaEY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33D282FA
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172213; cv=none; b=Vtu/iZPqPQc6EewzI3ytBmh14F0mNx3mMDCfUJOLLYM8lj2OSFeHA/ZmYLK9ZFMAEjoAqpiMEykI+WZcTInC6aAvWv5i3JkdhQODRA6B1cx+2w5pHnWXHs1trxzV5nKlSe66og5LahrU5AVEqFiz9c+yXmacgvBmuxeHyHjkAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172213; c=relaxed/simple;
	bh=lV8B4tJV5mnDVX2lGKwdXmO+GSwUEn0VX7t1cY+oW0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmwPxzzJyYOcKG5Vn/5Z46QZVmaUpU9428zQXVuNbY5+cjCUdRXvRTszHyfDPAS6bOlH4rlQf8HprPp5M7uFczvX/NritQjbyguifl3nR1g8H4fUSX+0WVMe+jXntIXrnHh3c0BujvajR1IkZhqfC27XuiCIkT2ISlV86PBn6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXsYhaEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573F8C4CED1;
	Sat, 18 Jan 2025 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172213;
	bh=lV8B4tJV5mnDVX2lGKwdXmO+GSwUEn0VX7t1cY+oW0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXsYhaEYWI0ElItHLZSGVNGdiehGupIwd58m8zfLoBFKUFgOBF/QmEjg+DnhX8DPB
	 mpEm+0B2Y4akGityO2RW0cK9rjYGYhNtSZMZU1Du/M97Chq9o6kcyEpxWiVQhmgJYv
	 v1YYnmh7ms3BhEPktWiJy8a9ItvmT+v+pJawxHKHcE581pdwYNJSQDqPglQozHD8qa
	 WagHmyEhOe29aq7l9cntlwp156tWVu4om9GQyZQ/XhaIqLYGXG7QEq/J6dGlPqWjpu
	 gmnc88fGw5pSL0w4flWJOz0Col4tVHU9KNV7uPRyLJyNlgmSEpEL8kJCVJakeTc47H
	 miqarXktSM8OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE69380AA62;
	Sat, 18 Jan 2025 03:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlxfw: Drop hard coded max FW flash image size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717223667.2330660.17430231890843429811.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 03:50:36 +0000
References: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
In-Reply-To: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 idosch@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 msanalla@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 14:33:16 +0200 you wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, mlxfw kernel module limits FW flash image size to be
> 10MB at most, preventing the ability to burn recent BlueField-3
> FW that exceeds the said size limit.
> 
> Thus, drop the hard coded limit. Instead, rely on FW's
> max_component_size threshold that is reported in MCQI register
> as the size limit for FW image.
> 
> [...]

Here is the summary with links:
  - [net] net/mlxfw: Drop hard coded max FW flash image size
    https://git.kernel.org/netdev/net/c/70d81f25cc92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



