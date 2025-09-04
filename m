Return-Path: <netdev+bounces-219755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC5B42DE8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B0D189F922
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC5AD24;
	Thu,  4 Sep 2025 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jspM+jEG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD48749C;
	Thu,  4 Sep 2025 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944602; cv=none; b=moV/ds7ZCpodiup36q8t1SxobHVD2wsgFd6jfGYlDcO+HuHGQt+fbS+n2N9c0GTQ2xHI0oCA4Ru9RWI3dXg8jJajCOq1ZvixB+8bbEKGxsedpGGEJusQzFCnt38zlM2nvgA/RFMYkKf+z6giSKJ/yS1q2aT1fwUZF0MgYdEnV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944602; c=relaxed/simple;
	bh=wJsKBk2q0S3pJweL1mcBE0GK5BV/WgcNJWJHIErzeXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WXhliG170jhMI3msDsMQeNIWbSH/t+UfmE+boG1bThj7PG9L3Rn5VEGBlBRwrGuSVLSLIzfzlnODCBN9h7AVJ09Hop41nVhUXrgo73l5SRciifciBFkHnTFtPAUOLefMXJmPlhnogV0QMfn2fBhwnwmSn9ZQZLisjyomP2bxpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jspM+jEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F56DC4CEE7;
	Thu,  4 Sep 2025 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756944601;
	bh=wJsKBk2q0S3pJweL1mcBE0GK5BV/WgcNJWJHIErzeXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jspM+jEGFLLAESYaOpnP+INKRfFj5q4+2bNS0ZM0yh2dtdXb6DW2XM7QYrDzlmwvT
	 FiIKaTKXtXPvo/Em1at+VFrB0AWXOArurlTDX8fpHIpLYyG5VXGO236hGXccIoutZ4
	 dtbtg1Dphp+FoAnTJ+CheY6K6PupZ2AQNi/UcwEm0++3SWQfAQQxsqZrtoLHprSHIh
	 +3ARVH/haJWdu3/asOQcFUz7wtEHIZ7QAyNTWC7WzwolHRRk3DtD62q0gUClDJlbRy
	 57nIkPiIMnM7krPsCzgDlG5MzV0r8pnQsYSg08oP+A7s6hgH53DEZjJYUvarfSzSCE
	 9cxnMvtyB71YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE06D383C259;
	Thu,  4 Sep 2025 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: Fix NULL vs error pointer check in
 inet_blackhole_dev_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694460652.1244446.15804955986657235785.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:10:06 +0000
References: <aLaQWL9NguWmeM1i@stanley.mountain>
In-Reply-To: <aLaQWL9NguWmeM1i@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lucien.xin@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Sep 2025 09:36:08 +0300 you wrote:
> The inetdev_init() function never returns NULL.  Check for error
> pointers instead.
> 
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/ipv4/devinet.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net] ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()
    https://git.kernel.org/netdev/net/c/a51160f8da85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



