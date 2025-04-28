Return-Path: <netdev+bounces-186562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6A4A9FAA1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11051686A7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DA1E282D;
	Mon, 28 Apr 2025 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmLSXyUh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A21E1A3B;
	Mon, 28 Apr 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872189; cv=none; b=qMiW31G6HY66ouUCdx5rcbG5ektvVI36QcZ1LGum/UrnKSqCDTxRvuwEDg3RrRCpM9wypDhbm51H/YJdgmSlQFOL8w3FOMAwLm0XjPEwJm5xfevz9Oov/a+XkD8b0AcYTFWFO33zJHG0oerejA6X4eJgSqlnOGE74PwwgTP60x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872189; c=relaxed/simple;
	bh=47psVaE5nkmJt7uoBLOWTjqlM9HaiJAlg0BKVekboFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsF3BKaNlStauImi8jEHx1DHu+hc1Ea+dfLGP3nf7YqWy0ZxsuHkAo6d8l8HUECQe8ny26j9IkHAMZlszPDubZd9caOjV25VWfTcy+GbBxD2merQVc7of4aMMJBagaLFHHYvwRgUYp/YfupZThtn7NTfg1vUkdDrhD/DqkG7YIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmLSXyUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9184FC4CEE4;
	Mon, 28 Apr 2025 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745872188;
	bh=47psVaE5nkmJt7uoBLOWTjqlM9HaiJAlg0BKVekboFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TmLSXyUhblduqBc+qveGVQ/hqjWkdC3dTze5ClhVXh0Jtm4oALNqbSH29UDudz0jw
	 LRuM1DEHNgPf6uH915fWgHdoDlCzTcOibWpKc4tOcEp4rNdCbik/vDbLOTY1J0Lc5y
	 +iyeKsWPhI1Gd3Uy+ANS1SsK5iXL+XiM9FsqhTgV6QURjS5g5I9PYcZYyJM1Uhh5KF
	 MS6nzOPCyHEoxgX7LQ4d+HjmmfmN+h106gla5wfMNm6CxN+K1pZJjdEAW57mZYFV4F
	 At7xntfJFylnLm7d/QjwUXjUy4yVjhnSBAkr+9iVcW/U7cA646zglx6yXvtD6UCplK
	 CVPmm3iypgAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE523822D43;
	Mon, 28 Apr 2025 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174587222750.1034980.3975715369800147055.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 20:30:27 +0000
References: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
In-Reply-To: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, kerneljasonxing@gmail.com, andrew@lunn.ch,
 luiz.dentz@gmail.com, kuba@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Apr 2025 14:27:25 +0300 you wrote:
> Bluetooth needs some way for user to get supported so_timestamping flags
> for the different socket types.
> 
> Use SIOCETHTOOL API for this purpose. As hci_dev is not associated with
> struct net_device, the existing implementation can't be reused, so we
> add a small one here.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
    https://git.kernel.org/bluetooth/bluetooth-next/c/7a53e2a5836c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



