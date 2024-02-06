Return-Path: <netdev+bounces-69455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB184B53F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFCAB28B98
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E1133408;
	Tue,  6 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtDgSyY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5813340D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222026; cv=none; b=qYZo1evu+8HmKK9qH8z7VgMzOawbvgFRvRHoyHq0+2XdU9axxsylyz/Tyy6ln8UollvB7XbzmtS4yVq+B6GcDmkoQDOSZWWahr9uTvRSx+NB5Xa9MeD6ngE93TI2RwENEu3OqJ5yf3eUbIIW+y2pkTZGe/rFQQMfidWO2FoSoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222026; c=relaxed/simple;
	bh=I/BMGU2sq2mpZXKWyws+96g8BVDXh7makeWHcqmb2l4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XIAwkKmBnwOL7r+h6nBhkFe5HdTX6EVcZZA9nE7OUtiCgU4ZLX/rgW1ClPQzikBGeLo+NH1TzHHoo8hCS3apC42B8QtfyejliNa3modrfrg3dc+vA3Tbz8k3YMLTAOf+SuBYDNpk/mMweQvK4BHKB1rCTo62oZ4oTkwZ2HIqSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtDgSyY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76EAEC433F1;
	Tue,  6 Feb 2024 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707222025;
	bh=I/BMGU2sq2mpZXKWyws+96g8BVDXh7makeWHcqmb2l4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KtDgSyY/f5MqvfEfztisKOnUeGLv1EjHFUNCkscRppPyWPqh/cYV2Qfs8/NU4AZkb
	 pypf/SU87oPyzQjIZ5UrEPvlY0n7YR/i+irFA/hJpP8VkmohwLYNAGO1TrTW8YWHe9
	 IUUe/aY0LU8jwm8Sm7vdDwx0luPRth9RumeDzlzZW6XkFKv0P/3KgO3GibFha6sWWK
	 zMxa2fqKxNaRztPbymp1cE3u9BA7GcmjcGuHEb8Ut/i2xidbGbNfD/28xPj2gMNh67
	 ZJsvviDnnpESmlPC/aDn1x57tkOY2xIOAwRrUf96yuJ11jtkbS85XLoZ9cQCe/KXAx
	 dWobl2Ii6PePw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E026E2F2F9;
	Tue,  6 Feb 2024 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates
 2024-02-02 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722202537.10552.174755665758975001.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 12:20:25 +0000
References: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri,  2 Feb 2024 09:56:08 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Maciej changes some queue configuration calls to existing ones which are
> better suited for the purpose.
> 
> Aniruddha adds separate reporting for Rx EIPE errors as hardware may
> incorrectly report errors on certain packets.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ice: make ice_vsi_cfg_rxq() static
    https://git.kernel.org/netdev/net-next/c/3e5fb691faee
  - [net-next,2/4] ice: make ice_vsi_cfg_txq() static
    https://git.kernel.org/netdev/net-next/c/a292ba981324
  - [net-next,3/4] ice: Add a new counter for Rx EIPE errors
    https://git.kernel.org/netdev/net-next/c/0ca6755f3cc2
  - [net-next,4/4] ice: remove incorrect comment
    https://git.kernel.org/netdev/net-next/c/53875f05c997

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



