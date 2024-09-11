Return-Path: <netdev+bounces-127600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E4975DA4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5B1F23C79
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6621BBBE5;
	Wed, 11 Sep 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoLN4p6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1924143C6C;
	Wed, 11 Sep 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096832; cv=none; b=Fc7OCyU6T7FLgORHMhA5AZHzCn+NEnC8VaFxUia3EnRFq0NBkB6I5UksGuHjH6kBCvxJdeiWzr+IAHzvoKhA6gnoID/fp6GFatvJxIsyajMwQlMlksIfmZiY81zRvsqOK52Nq7zRFzSB7pi8vhwRve/kinQlKPFrOLTnZJxRgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096832; c=relaxed/simple;
	bh=IF+yaw1mbQKmmIcUPfyHLfHXmYiHe4hlVdwsgq3qPgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epWGsBL3PeHs2wF9EkvaVrHTZAXRWezvTAixabFcRMGLxBZ/8vEpRcHyryUK212mIwu2Izoq+tQGQIngIIYntIEZFNhFABd31poZurrbx66bD3qI4LrUA4dIausuUwXCM67pGr8X+etbOEWsRqFR0qGDGteFZFxDDXIdxqmAzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoLN4p6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BABC4CECC;
	Wed, 11 Sep 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096832;
	bh=IF+yaw1mbQKmmIcUPfyHLfHXmYiHe4hlVdwsgq3qPgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IoLN4p6xnjjyqGDXU6WAVg+bK5G8ABR1URtM0KUcntLTi1a5CLnhh/2pO6Gsf35zh
	 0XDIKHeH1MOKITVKVhaEoKWeEorCLNTHFxYNjUm5PlBAyyeUUGBwhhWUKhr0o1ykct
	 UYUoUxLfgsyL82m/m/A30jRiD/iGqS4YqcdA4hCFPPRWc6dPSUxwWlgGyB/DKHw6f1
	 qn5a//x9b35p+VuttXLvbZvi8qG/RE8h9kL0/d1DZRYOfVXRowyTgvUdDnSnkbYc75
	 m8VXnrnNo3tDDGUJMKYCYZ1AiHr1IrDuIpmIcaL4/nCZb7ZaRsSVcg6jehJj4AZoja
	 B21MrxOST1jlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5413806656;
	Wed, 11 Sep 2024 23:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609683325.1105624.272226281168764129.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:33 +0000
References: <20240907190341.162289-1-aha310510@gmail.com>
In-Reply-To: <20240907190341.162289-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, lukma@denx.de, ricardo@marliere.net,
 m-karicheri2@ti.com, n.zhandarovich@fintech.ru, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Sep 2024 04:03:41 +0900 you wrote:
> In the function hsr_proxy_annouance() added in the previous commit
> 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network
> with ProxyNodeTable data"), the return value of the hsr_port_get_hsr()
> function is not checked to be a NULL pointer, which causes a NULL
> pointer dereference.
> 
> To solve this, we need to add code to check whether the return value
> of hsr_port_get_hsr() is NULL.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()
    https://git.kernel.org/netdev/net/c/a7789fd4caaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



