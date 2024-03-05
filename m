Return-Path: <netdev+bounces-77340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68301871509
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEDC1C22E67
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535643ACF;
	Tue,  5 Mar 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5u6hB4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36E40BE7
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614831; cv=none; b=pr9fRknMez9Mn7sMOoryEcNqRGGpGuTGi7ywF/MSsDFtNaTtIQbYAKeQGjrQW9AanfBRdTISXOC88GkVzmCR7kCkS2fz9zhTHOHLDanrqiIGz6yUT+q/3SebEGetzcX19DUVAD3LHbNc/sXZ/efpM0rYG4hoLZtkJ3Iq/1rZOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614831; c=relaxed/simple;
	bh=LwwdSeWHnVp0SndGvKGhDi7oXXZGoAOOKnSlE8tcMYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uufAczucFEjpHjd2M9t9TvCaFVRRdEHya0iHHzphJeCyqRiYagCu3o5v8gntHqblFRdVdJrsBWEIc4D4VjhOH3Vkm3/+E0chw28zT4YLkzSo/TqKwwFYttWZmV3B5Lxi3xfFj49g+rJFGUaz9CMiKrvY2QhUu8FBUSOI+5LzJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5u6hB4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD2ACC433F1;
	Tue,  5 Mar 2024 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709614830;
	bh=LwwdSeWHnVp0SndGvKGhDi7oXXZGoAOOKnSlE8tcMYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C5u6hB4jJABNk9bcSlH4vpevxCycMgv9osC63k2LeIBRBoYk3XJ26/zpUQyMEkHp3
	 Q3uPTZGi7nbji1WkwQb/OVu6vmHIpGEHcz9a0R2vaii6xsi4rqJu4uaUamC2NoALz9
	 4cND+tqRecG2SqHRM5UOqLC2DnA0dvvB5OLZYStnkTa/LbQlBQD73k0rQrLh8AcMis
	 7E4m655bINRiD/G/HD3oTMZQiS2QT0ixXD14HGdm/W3baGCPiK86MAJoTKBVAQReuS
	 7rFmnWIYgj0J/x7DsWV8JL5ySYGzwUltW4EqR1ARxBqMI/ZM1NYwE92uBG3Ahf2V8K
	 eYRb6faS+ElfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC5EFD88F87;
	Tue,  5 Mar 2024 05:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: align tcp_sock_write_rx group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961483070.15495.11283200986725328482.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 05:00:30 +0000
References: <20240301171945.2958176-1-edumazet@google.com>
In-Reply-To: <20240301171945.2958176-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, sfr@canb.auug.org.au,
 lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Mar 2024 17:19:45 +0000 you wrote:
> Stephen Rothwell and kernel test robot reported that some arches
> (parisc, hexagon) and/or compilers would not like blamed commit.
> 
> Lets make sure tcp_sock_write_rx group does not start with a hole.
> 
> While we are at it, correct tcp_sock_write_tx CACHELINE_ASSERT_GROUP_SIZE()
> since after the blamed commit, we went to 105 bytes.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: align tcp_sock_write_rx group
    https://git.kernel.org/netdev/net-next/c/345a6e2631c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



