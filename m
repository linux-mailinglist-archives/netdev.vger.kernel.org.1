Return-Path: <netdev+bounces-211831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7CB1BD00
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC3618522A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B162BDC20;
	Tue,  5 Aug 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilY1RlqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41625B693
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436001; cv=none; b=sR/iSNHEYfM4DXgAcMb7DjyRuffMqowTfNDuWFaaGXumd+iLT6X6Tx6Ku4TqJKcGhQ1Cj/4Lw4sGM2UtKke+wAq3hXfpYs4rBOR3dPvVdjP8WLUSELG+rX3dS0lnxcbtBmvaPpDzCmmE5OGRoDZyVLjnMRzkVZI7lp+OUQWfxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436001; c=relaxed/simple;
	bh=zB+3FpwOZTwbAJDKoVi7tZ6E2wiRyIQlCODPhjNRwA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PMl+1Bko4f7VuisiQxV28oxFY+auclGLa45dtP2ayFZKe+j7UdryemTt1zy64ojZgnnYPsJw7emk06TMrzMkjYyYYq+y0ejo83dIOqvcIeFp8f2KH/wddV1BuRA7RB7o0CoHljPxZIhW4QaXc0FfBinJFIya+UHYK0wJ4OxXNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilY1RlqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78827C4CEF4;
	Tue,  5 Aug 2025 23:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436000;
	bh=zB+3FpwOZTwbAJDKoVi7tZ6E2wiRyIQlCODPhjNRwA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ilY1RlqQcWrJX0G2qYW1PWPGIBeP0qqH9BOSSaowMPyf3PU8/czc1wnNFbPC4dfN5
	 FINCU3wzRJNGIQtyYYaoQ6sN9EC99fdL0lp9QxeleYwRXu5HhuQ/LetjCpapHad158
	 lhLX+hO1qNjKfqLSrqRErr8K6ZLcRCBLrvyGp3oTFc5G47MfjlKK5EJ5VmSrHfcZAB
	 3I+b6++Cd47gwAZJRVHIBOuhZ2lFSVNupRQg+dab0GqajH1X+EKbXkUS5tj5M6gTw1
	 sSdiuJZOhsgkqa7Cc9eRIokLPgCD7lJkbsnSbYJvPN+pILD2PNrH8IUydL0tbvnrhA
	 HiemuakD6f52A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC3D383BF63;
	Tue,  5 Aug 2025 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: remove the debugging trick of super high
 page
 bias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175443601438.2197607.222527424846735387.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 23:20:14 +0000
References: <20250801170754.2439577-1-kuba@kernel.org>
In-Reply-To: <20250801170754.2439577-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 10:07:54 -0700 you wrote:
> Alex added page bias of LONG_MAX, which is admittedly quite
> a clever way of catching overflows of the pp ref count.
> The page pool code was "optimized" to leave the ref at 1
> for freed pages so it can't catch basic bugs by itself any more.
> (Something we should probably address under DEBUG_NET...)
> 
> Unfortunately for fbnic since commit f7dc3248dcfb ("skbuff: Optimization
> of SKB coalescing for page pool") core _may_ actually take two extra
> pp refcounts, if one of them is returned before driver gives up the bias
> the ret < 0 check in page_pool_unref_netmem() will trigger.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: remove the debugging trick of super high page bias
    https://git.kernel.org/netdev/net/c/e407fceeaf1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



