Return-Path: <netdev+bounces-229441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64622BDC342
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19F03A22E5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E5A21D3D9;
	Wed, 15 Oct 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZelpvA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBED4A08
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496627; cv=none; b=q9NLvld/0sCO6Ay8svOTIDGAwpkNAHmEunM/kFoSJjKBQVX0ztPlpjhfMdKuWNEDwLoYVY6aG+fMe/Xy7GOnAmPPMsSSoXMsPYvVrTqST61ueeMRPlLAcwJ/1cdZyDUop08QdXRgsSFq6fPN61Bv8u3Vx8d+0ThGk0V5363ott4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496627; c=relaxed/simple;
	bh=1q0iAqm9oGtdCGI/z0cRfOHf5UFan2MXjLyPKCbObnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lvy8ythpBjNwhVPn+5zoQRYf09iTlnsK6lVWA97hil0UA2tzcv/zfhVt3OqarFxigRU0/BSbH6SL0dRC5taYHuVZzOk4Lw3UXbd9jT7DKiNR8sh0ujymUtBOi1V14/vd8msoAGs9YASalD1WOK7LE6NQvrpAuLQIRoZkUfquBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZelpvA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA646C4CEE7;
	Wed, 15 Oct 2025 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760496624;
	bh=1q0iAqm9oGtdCGI/z0cRfOHf5UFan2MXjLyPKCbObnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZelpvA/c239nHrPz2U5s0GWgcVmhHivsuLdhUdtvk2YKlFr23YPfIv8SLv6ov2Dt
	 1nxOUrStjPMIkTOGnq1lrYqo1TQJNS/TOGAYB1SBI4qrXqyFfa8K02rlZRkgbtpguC
	 9+Qscs3AODCCKO9sUbfDuMqcZVmKQ35iNeWqhEDwLQn4lGUhyeLlasUcfvaoVCswp/
	 bN9Cg2AithAcDcCAfOykNxdZBnoqoK7SGyhzqNobb6Q1t/yJEsLcE+DOzfqt/j5AgQ
	 5CnzbLmeNGLR8RZpIb/kMa5F+mBqpoS1Ja/gHPK7ZlDt7baMzQG4g95TxzrvDKuciQ
	 EhiN+PRFE/U/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB4380CEDD;
	Wed, 15 Oct 2025 02:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: airoha: Add some new ethtool bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176049660901.197015.7658108803610807679.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 02:50:09 +0000
References: 
 <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
In-Reply-To: 
 <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 16:29:40 +0200 you wrote:
> - add missing stats to ethtool ethtool_eth_mac_stats struct
> - set get_link ethtool callback to ethtool_op_get_link routine
> 
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Add missing stats to ethtool_eth_mac_stats
>       net: airoha: Add get_link ethtool callback
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: airoha: Add missing stats to ethtool_eth_mac_stats
    https://git.kernel.org/netdev/net-next/c/331f8a8bea22
  - [net-next,2/2] net: airoha: Add get_link ethtool callback
    https://git.kernel.org/netdev/net-next/c/fc4fed9054ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



