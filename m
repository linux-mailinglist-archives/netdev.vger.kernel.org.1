Return-Path: <netdev+bounces-77353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BA8715B0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D261C211FA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48C7BAE1;
	Tue,  5 Mar 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqKDxrKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998E6167A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619028; cv=none; b=shY81IqSCyRy+EMhZuQlIUtm/ZMvlDPV3WNasCgcRpBgzuwICveoAvfqPUslCNhMVwpdccebctlpPyV8Wh0sVlUdtOjoLje6G/JeLMLisWgUmc5NlOw+yGOZcQJEr8ysBpXzqgE0Kx1GEVH5G97oMu/dzoGvxXqo6DJRaXifcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619028; c=relaxed/simple;
	bh=vHjrL35/6w2BWBa9Fldwm2OnqQcutBGceO+MEgBQbZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhEhCFUokxCNDPAZp+qp/IEHPk0VSwcAARiISDtGZVAvQmyEzhWN9Al0TOdpcPHcZXe+Sl073PwYehGoeRm0BsQYWAAukGV6Y+QkJjsO2F87MbgUFJpDYhGQMasECMK93Jt9Dj5q99himBm9MxxeW5y9buXGjmgszQ3K1SBOW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqKDxrKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68104C433F1;
	Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709619028;
	bh=vHjrL35/6w2BWBa9Fldwm2OnqQcutBGceO+MEgBQbZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fqKDxrKCM1QQKJSi4jwtJncPrFue3pDvDxdrWBPiWQt9SfvGIL6lIvk9mcmmtwaZk
	 pPfexbwNXIOU3YByjjQzih2TwC8cyNiaVcmgQNT+FV680tk8XdGNai6yK6M7jaXyZv
	 DT0WMcSxInSXv9270Q7k8NRziPgCSnlesRavPK0hMRZjNumzXXY0BLjM6IK1HdQP7e
	 bZZ/jWlubOfvUMFtWz3yh7VaZZLU8nRxStUj5y5Acys6QS0B95Dz5um9EDrfhe4JBm
	 tBNdTz58i29rM1c5gH6P4lP2zW8aYeMrzbf6r9bAI48UqXvPkMeyYwvnBlsImDdIdu
	 vPKvAdmcgNAig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F8A6D88F81;
	Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-03-01 (ixgbe, i40e, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961902832.11695.6879433397979391086.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 06:10:28 +0000
References: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240301192549.2993798-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri,  1 Mar 2024 11:25:45 -0800 you wrote:
> This series contains updates to ixgbe, i40e, and ice drivers.
> 
> Maciej corrects disable flow for ixgbe, i40e, and ice drivers which could
> cause non-functional interface with AF_XDP.
> 
> Michal restores host configuration when changing MSI-X count for VFs on
> ice driver.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
    https://git.kernel.org/netdev/net/c/cbf996f52c4e
  - [net,2/4] i40e: disable NAPI right after disabling irqs when handling xsk_pool
    https://git.kernel.org/netdev/net/c/d562b11c1eac
  - [net,3/4] ice: reorder disabling IRQ and NAPI in ice_qp_dis
    https://git.kernel.org/netdev/net/c/99099c6bc75a
  - [net,4/4] ice: reconfig host after changing MSI-X on VF
    https://git.kernel.org/netdev/net/c/4035c72dc1ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



