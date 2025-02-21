Return-Path: <netdev+bounces-168373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA192A3EACA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE345189EC0A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F23C2F;
	Fri, 21 Feb 2025 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAbwQ8zF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB12F3B
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105154; cv=none; b=RZ9PRnajmwl+dxgkpReSYjEPCltjwxFBwOtHs/LAFrl4mfoucztljELgOhPSgcBoKUMe6xNy9kmudh6R/94k//JpY485BL3bz7wSNnVmX97q+YDIhVZAv+gVez6E+W///lD/joV+7iel0eedvBqjuJQbdWXFymEVXXbl1cVgue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105154; c=relaxed/simple;
	bh=wZX/Myu/vEDQZRic5UzR02+2ljCbALxefvMr/k2kAqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WDWkORt3NQg5jvv4Fg4PDA+WmPTlb0n9Bv28TbVNakd/ljokDlsLF8MMXYHMjvLuk92hy3wSDPgKhTHCUxj+Yd1n0cqNN0wn8Md3jlADYTE3Hs5BQsjLcRmgzgS7qJV/+mx2vCK3tMQWrZQieN1CZHLT4wxTBjzoNrgJ0hYDq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAbwQ8zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EFC4CED1;
	Fri, 21 Feb 2025 02:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740105153;
	bh=wZX/Myu/vEDQZRic5UzR02+2ljCbALxefvMr/k2kAqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JAbwQ8zF1BjNCPmb+OAhiaWkGoy6SD5udvUiFZYKEzwKuEsqA3RZU833nPl9FboxW
	 JUnKEJDyLDr4Tj1CfWPQxCo2U+SWFE12IewXllR3rQD/5+qfNKgxYkvN8NehnDrhSP
	 M2kWFzCo5pnEK6217S7CsAUtDyK7PPMbrLnKXYiIyRjQZAen0NOZ0ClDG5jOKvj0vL
	 Q6xTUsLP98WpqAmOzLVpWoNYZ2lj3HZuI44iEpyedzy2lTqlyxjnrGUQ77e/aCmAuj
	 4mo/BKR2OKEBJF7WuX6ETJVl/q41khB68Qm7txuBn5Y9+M7dLGGGXHxl0wiQnBQ0Xk
	 kV7pzdjDoLeww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0083806641;
	Fri, 21 Feb 2025 02:33:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove unused feature array declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010518452.1556524.11017651878366664504.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:33:04 +0000
References: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
In-Reply-To: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 21:15:05 +0100 you wrote:
> After 12d5151be010 ("net: phy: remove leftovers from switch to linkmode
> bitmaps") the following declarations are unused and can be removed too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/phy.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: remove unused feature array declarations
    https://git.kernel.org/netdev/net-next/c/bb3bb6c92e57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



