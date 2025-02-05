Return-Path: <netdev+bounces-162831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D6A281B6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E8918848BE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23921481B;
	Wed,  5 Feb 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9gChCc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9F2144AE
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722015; cv=none; b=kktVFxnb9hU9+uQCKUpV6xOf3e73Dg6qH5o4fQ4fVQzLzvRyxmpUcaEpK4yHc0oekFT8hBCoSOl5oUwRNM6lKaYcDieuvLa3dE8Hs5Ir2eHaB7AaoPUk4t9TSMpKi6tOzC5kLz9aesdYJTE1+Ah3pX3g4mviOgmd18xQO5NQRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722015; c=relaxed/simple;
	bh=TXQ8XhMbT0dXmH36odC5kTH7rWTDJnUG8jPf9zb+OYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBDXYfIAWtue+G80uksE8cclbPRXEiWC+lP9gcvt+o9xxlXKXhAovAMB1qDHhyRMJoN3avO+k4SEwC6grh3tSblzOjnw1M1rRo5LRv+9L2y7oJoxjMEMM/6MlviRjG649a9+gfzhmeXOfppHI8a20ft9TzLWI8X0x+6g6FJCyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9gChCc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DBDC4CEDF;
	Wed,  5 Feb 2025 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722015;
	bh=TXQ8XhMbT0dXmH36odC5kTH7rWTDJnUG8jPf9zb+OYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i9gChCc9A1n0kcej88ZkLaZ9cy+ISxUHEKDMmw7ngPev2KajVQZBaeX2y2+huuOKV
	 Ss9ObPivgrZjCLs7WE9F7kXIHQY6NdppOqtCmVWMSwMnikXTuW/J3yOqRGnGFACYUV
	 YgQp+sqpX10Bi9kgbmhZyMTCYcbxIPxDgoihjHjAcP8ZgqgOdYsd192H8FJu8N9tq4
	 R/bRLzSLeK4nNTLSj5yX7ilu5jbYeYgXjiHfb3nMWLIXrkBK5gss5GtLlK4IwFwlh3
	 Pg1SynwMhDwSOosWjpHlMzKWXcFAJyszZbzIjSXAq+HUa8IzZho/fqVBjYV51/XkQr
	 EvOjO4Ipdwqfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDBE380AA7E;
	Wed,  5 Feb 2025 02:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: make Kconfig option for LED support
 user-visible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173872204229.246239.18244724685041621569.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 02:20:42 +0000
References: <d29f0cdb-32bf-435f-b59d-dc96bca1e3ab@gmail.com>
In-Reply-To: <d29f0cdb-32bf-435f-b59d-dc96bca1e3ab@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Feb 2025 21:35:24 +0100 you wrote:
> Make config option R8169_LEDS user-visible, so that users can remove
> support if not needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] r8169: make Kconfig option for LED support user-visible
    https://git.kernel.org/netdev/net-next/c/135c3c86a7ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



