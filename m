Return-Path: <netdev+bounces-170336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD1A4832D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240DC16717D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA726BD9C;
	Thu, 27 Feb 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY0DEnhu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870E26BD91
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670800; cv=none; b=rXYNpUoVDEll+e4ZB4HQ514bKmg9vhOZQbacZy9kgXtB1FE9PhBiEDwVMhQhnQagC0cTUHPwkF/gTRpJwBGp+4Rr21CSu+qZsK9t/c3qAxAsrelvnXijQORfB/iHJdvSLJXEpvsjOrpw+MomTbK3Oc6nDWTgaDUolMS1LVW7M58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670800; c=relaxed/simple;
	bh=gWujZzySkY9I7gn5qQLFyeQNxEep8Rh1cSIabCjFoC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B26WP6YDoOQfhjKJw/ImCEF1knw8tv8waQfl5voB0pwnfxMs/82juPsAEt4HyLtVmg1Ownzd3sgmjOWcsEyq13X1Gje8yqljF7cYb7ZHj0R8Xr43X3ZlbApNjtX9INebwmR5fqy5c7Ct/92Ro0LAvWbm9GScR4YlWhZ5gG6oLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY0DEnhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34716C4CEDD;
	Thu, 27 Feb 2025 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740670800;
	bh=gWujZzySkY9I7gn5qQLFyeQNxEep8Rh1cSIabCjFoC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VY0DEnhus+sIR3KMAzsCOlRL9pFFHwiAhyiUBaGfglNcsehKb+RZrORkGflDHpQl/
	 nZP4OdLkTkOX/rfTcWQPl5MKTIiKCdkR8l05tFIHA48vraWv8FNssLlu7X/Tc/2/Za
	 k1E77SSn7bnm+NxmI0Z7QVEkytZaPTB9HBPxVE5Mz70fAaDrAYbUIIVpDiIZblaY7C
	 1TeS8tX4td0UMzb2OKnmp9H6az7z1TwGll1WJoZgvJlrfT/Fq7iVfUGI7r3ovnbr4Q
	 YtuPQNE7qWHApyCnrK/CO4m3qPqOq2VkrrzvmvKVh/A1zsYTRYbUqDMELZHMhmFrEu
	 SMA9dyu44MoVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFB380AACB;
	Thu, 27 Feb 2025 15:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: fix checksums set in idpf_rx_rsc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067083199.1471828.13935939120708178215.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 15:40:31 +0000
References: <20250226221253.1927782-1-edumazet@google.com>
In-Reply-To: <20250226221253.1927782-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, alan.brady@intel.com, joshua.a.hay@intel.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 22:12:52 +0000 you wrote:
> idpf_rx_rsc() uses skb_transport_offset(skb) while the transport header
> is not set yet.
> 
> This triggers the following warning for CONFIG_DEBUG_NET=y builds.
> 
> DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb))
> 
> [...]

Here is the summary with links:
  - [net] idpf: fix checksums set in idpf_rx_rsc()
    https://git.kernel.org/netdev/net/c/674fcb4f4a7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



