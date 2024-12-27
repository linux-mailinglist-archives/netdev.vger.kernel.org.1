Return-Path: <netdev+bounces-154389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69E19FD789
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852FA1636E3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A71F940F;
	Fri, 27 Dec 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpwYnCF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114A1F9407;
	Fri, 27 Dec 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327816; cv=none; b=Y0ov+mSQJjEjv7lSk4fksgU/n/i4SS6js5X+PJ0vZMVgiCO/7Q89C77NnnYVS78t753fkNBCgMskM9Um9lmTNSTh4aH6URliSqICTEJ0OSvTbAowqcbXOhGu4D899BicgrHrg2h/dthvAa8KCp+ElGRv7L9gsaQ8I7Dj5HvY8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327816; c=relaxed/simple;
	bh=ADmb5v6v2z0O2UzBiuSteqUMBcgUWGrQLlM6NhhZ1c0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZ9kM0cKSf4Tg+mQ/XmQNdtGUcQPPET0/04cH3YfkHtGwZMFpVvbMtq0tgsPWAr10H+5x6mO7PwmtpNmF94Gft0kt+DTW9hPu+kQV1LlduOrPrD7VN6T/hAcc2jU6X8X60TLqttnBDcGAdhXXHJQH3dVl6BRKT/cTgUFE2TUtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpwYnCF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE44C4CED6;
	Fri, 27 Dec 2024 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735327815;
	bh=ADmb5v6v2z0O2UzBiuSteqUMBcgUWGrQLlM6NhhZ1c0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KpwYnCF3qwZFpo55Scq7uaJNRiMfIErwhZuz2L5h5MiBsbIIg5cCk9ELrx9+0p95d
	 MNoh41EihXvr+50YcLaSuB4sVWAkVpVYbaqYiiciR2U5G9hoBtUIX7x0AtpEO8e1aR
	 i8Ohh5guWyIsBW6i7dxCNv+f9LKA2rgjw6NaV3Ge68cUTaXgXpnTjM+wr+n8LJ4tVD
	 Ni/GBjf5SFu1b+EY7q/i61BIVGDbFEnBmwL1Jh2K+Lv8OCqR4i3gxWsZln3kqtiHF0
	 TdswKBLjIWEc/AOl4cwi7KTjvQx/g+BHgsyLvVCWfgeIJfXTfEKrmrMD62QaXdE/6k
	 CVVkYzDo9wrUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB0380A955;
	Fri, 27 Dec 2024 19:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: llc: reset skb->transport_header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173532783475.575952.12564839557235746896.git-patchwork-notify@kernel.org>
Date: Fri, 27 Dec 2024 19:30:34 +0000
References: <20241225010723.2830290-1-antonio.pastor@gmail.com>
In-Reply-To: <20241225010723.2830290-1-antonio.pastor@gmail.com>
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Dec 2024 20:07:20 -0500 you wrote:
> 802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. As snap_rcv expects transport_header
> to point to SNAP header (OID:PID) after LLC processing advances offset
> over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
> and packet is dropped.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: llc: reset skb->transport_header
    https://git.kernel.org/netdev/net/c/a024e377efed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



