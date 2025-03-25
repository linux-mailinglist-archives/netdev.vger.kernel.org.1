Return-Path: <netdev+bounces-177472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F43A7047A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EADA3AC366
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB925BACE;
	Tue, 25 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC8OrYwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAFA2D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914811; cv=none; b=q9cemIDRaXM5qhpZB5Y3QyUJs3r6Q9+wJVZrL1VJ0cwJS6szmlCkee0OTuXNRyuRInRhjDMhWP47lzXb1r97jCQSEc6cD5BiQZVPXHG1YFf/Pe5RR8xAQM8Th4OVVz/yBCIRnmJe2s5QbhocOo9hH4P11tHKdo5WqzAS3Ty8KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914811; c=relaxed/simple;
	bh=n0V8Toziu6odUAiTj1Wad044nuuIpHGQDrgYjNe5x4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xn9IhY4XIjWOSQvmGKpzsEew5yQIXAv6CFmU0ZYvBBG0qUT3N1uCHi3BKSQcwV9DeYuNUvXqdU/5/V4nYKtkIz8rFFIIDd1TLrMnpF4ViPTFisFT2RxNClM4U0oQU5mfRt3pHKwqyOMUE3U4/2OuqqeCGRvI/z1R9ruZj4ei3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC8OrYwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC82C4CEE4;
	Tue, 25 Mar 2025 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914809;
	bh=n0V8Toziu6odUAiTj1Wad044nuuIpHGQDrgYjNe5x4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nC8OrYwV2zMy9HfGWd/4DbdOUambd/49rClox4O7iYHmaGl69alwMUe/T/wW2xXg2
	 dZ/DYzdHJsbPsjcNqYgY8BM7xK1lR4MYFWwMroWRQfcISMaMBy8mY6/jHQbUMpcGa2
	 g2xIqQ2L6CDQtAhUSVdZwLOwQWeELtCPGIdUHIJvS5g4/RBb4jWoDUtam+dwtu7odt
	 2KVWB72gE+Mg/6s6BdCW+0gWPWOxJPNbxYTxYmRD8oSbfhULBdZemFyLrWappsUczW
	 Q0oX87deI2IUty4bFfYHAR9Y89telpt9kp/tSsqvWRHsbOL0nwB5qH/T4aurSj6g0X
	 VxiCFAtfmwuQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34545380CFE7;
	Tue, 25 Mar 2025 15:00:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: reorganize IP MIB values (II)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291484575.606159.9632429755980578625.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:45 +0000
References: <20250320101434.3174412-1-edumazet@google.com>
In-Reply-To: <20250320101434.3174412-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 10:14:34 +0000 you wrote:
> Commit 14a196807482 ("net: reorganize IP MIB values") changed
> MIB values to group hot fields together.
> 
> Since then 5 new fields have been added without caring about
> data locality.
> 
> This patch moves IPSTATS_MIB_OUTPKTS, IPSTATS_MIB_NOECTPKTS,
> IPSTATS_MIB_ECT1PKTS, IPSTATS_MIB_ECT0PKTS, IPSTATS_MIB_CEPKTS
> to the hot portion of per-cpu data.
> 
> [...]

Here is the summary with links:
  - [net-next] net: reorganize IP MIB values (II)
    https://git.kernel.org/netdev/net-next/c/652e2c777862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



