Return-Path: <netdev+bounces-167574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C41A3AF55
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6B5175B6E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75914B08C;
	Wed, 19 Feb 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxkmnY31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A4208CA;
	Wed, 19 Feb 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931010; cv=none; b=llpIWgZo3Yzv4lTS7yzlwg8aReArQUDfyh+W5uEPYf6nHLVYAN6BxKurur7J2LRY2kGVZ/K/AMzsGu6i1J3mTlhCwqT8dSJPD5gGK3yAjWWUZKmLgL92VwGjz3W2OBmzAWCI1hxXWoJ9xrMBkVjQJS0pPSS2vKW/otK/RRr27C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931010; c=relaxed/simple;
	bh=Z0WAYTP5t5HoX8DqmVERIVdaskAAhcdNe0AiiDINO6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCm0lKihJVV1bTApl0jf0xTp20ROkrucvn19ZmXvU7pQ6aQlT4esa7RgMC/JOP5tOZFMV63PnyD/js29OcXJxxAd8abIl3jPsPpjnZk0vZZNDkVcwRuw8shE4lbd/XIPPIP83swjLth6t33C2F4LEIP5Ni2DJgASOMKFbmelwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxkmnY31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159EAC4CEE2;
	Wed, 19 Feb 2025 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931010;
	bh=Z0WAYTP5t5HoX8DqmVERIVdaskAAhcdNe0AiiDINO6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TxkmnY31IkOQmOZM+aH+OldrAC6mQieZ1fHxgLvACg3liDAAQDdZQNPWRcGxpwD5m
	 d5V3OeZ3G9Nn6u7vaObZ9PcQ7V5weX3eJqC3lVI62/vbkF7wYgSUi9X+x1KlphjnkO
	 Awm/XydliMGpWvyKM5C1tR7eN77ImL4Pkd/rS9UV87uarIvI2S1uXHyMIF+8BjiSCX
	 InHLKSkHHI10vrrWdP3YYoVdTqzn9WXfl9aj/NTTA0yz4uCOPw5Ielg1yH5BlI7UXp
	 FaRHmsgy2OEUIa+pkFl1xVedG0DwTym2QR3p52kdB5CA+aqlCS8dabtqcFQR2FSFVO
	 fp+813Xsmx0lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE420380AAE9;
	Wed, 19 Feb 2025 02:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993104029.103969.8111544121026009764.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:40 +0000
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
In-Reply-To: <20250214211252.2615573-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 edumazet@google.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 16:12:52 -0500 you wrote:
> Implement byte queue limits to allow queueing disciplines to account for
> packets enqueued in the ring buffers but not yet transmitted.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [net-next] net: xilinx: axienet: Implement BQL
    https://git.kernel.org/netdev/net-next/c/c900e49d58eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



