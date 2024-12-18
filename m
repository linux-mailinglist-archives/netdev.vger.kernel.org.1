Return-Path: <netdev+bounces-152824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D69F5D9B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CA5169798
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364B14B95A;
	Wed, 18 Dec 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tubNOJBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8814B077
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493817; cv=none; b=IOopTgQuss0N13PXwLSpF9av2S5pwCFLtjF9veiMbGkHBEFXGd7SEPLmABOiSk6q1gWz8em/8bF0rKt3/BSZyghwBHGCehZascZ6/9r/QVascbbeeHCybHNwOrk1Po1gQRcG7Ivc7O1Ejs05z3ifjnbRw2zx/Cy0PHfUnMIEs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493817; c=relaxed/simple;
	bh=VI0fnFYYeOl9N8KZS6jJUE3fj8NPPUvJf+dGf6dCKsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fwikz+SeWrwZ2HK3Nkb60/99JNKm3qvple5qwlBn121qN01SRSjQdMa2kyCkGdcIi5cNJeFbxOYoczuHQuTdmOcmq3HjNqYjW7kDJvM/+GQWk54MbuOAy9A0O9VoxXWaCC2iV3hZcvCFy+8DXBwfCiV3cnXhAT8p9qDDz6YOmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tubNOJBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE735C4CEDD;
	Wed, 18 Dec 2024 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734493816;
	bh=VI0fnFYYeOl9N8KZS6jJUE3fj8NPPUvJf+dGf6dCKsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tubNOJBEeomJJ1Ks/s/3umO7wO7oooDPG4VIlfaptrdBSlQWVOfC1BcbTXTOShK0D
	 ddcCMQuB/nvhwSihKN+C5TTizPA5YdAuwhYrUu/BJZZHCykvVgWDdmorIoMYKKgGWN
	 wUPNtR+n4bFMmou3EoCfYeTwwkvQrxXM00hpeMOMY827d82EPDX0GlVREXpNB17Kr/
	 KxmFESU5iIv1LGBjeO9VG8crNJ8khd0s3hrtReXmvEoIjiaFZc3vZqf4ZPnYk4RQC3
	 ioIGPDNT5fzUzTiuh+zkJ6AAsfIejrjYjWwOWE0TtrPa2HQpJOppG7xvn3HXxmDGSh
	 5AVSo4mTOg6FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFF3806657;
	Wed, 18 Dec 2024 03:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: Switch to napi_gro_receive()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449383399.1170405.14735454267346088004.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 03:50:33 +0000
References: <21258fe55f608ccf1ee2783a5a4534220af28903.1734354812.git.petrm@nvidia.com>
In-Reply-To: <21258fe55f608ccf1ee2783a5a4534220af28903.1734354812.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com, amcohen@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 14:18:44 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Benefit from the recent conversion of the driver to NAPI and enable GRO
> support through the use of napi_gro_receive(). Pass the NAPI pointer
> from the bus driver (mlxsw_pci) to the switch driver (mlxsw_spectrum)
> through the skb control block where various packet metadata is already
> encoded.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: Switch to napi_gro_receive()
    https://git.kernel.org/netdev/net-next/c/1ba06ca96ca2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



