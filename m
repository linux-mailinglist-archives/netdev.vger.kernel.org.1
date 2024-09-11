Return-Path: <netdev+bounces-127598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE2975DA0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB631C21C56
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2341A303D;
	Wed, 11 Sep 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teQmLezU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EA143C6C;
	Wed, 11 Sep 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096829; cv=none; b=HKyzSOvo+jk0Zsve+rkEVD4mJ1Q6MbS63zNE+dTT54/JqoZX4VmOHhTfmZf7yBEkJyf1ADzebb2FfKkUd/F4UFiNx02ssbEkb0CupbDssuFwpCw/A++BX91UQ7iDS6G06aEE1DutSKnTOnJrN96MBTlSO59lDUxOoENjW+xAZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096829; c=relaxed/simple;
	bh=Znyoj7zrNqDONfTgrAvlgyo46Z+vQk6ml+RCaqNj6h4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ePaV9/6kmBA2UA3iePA61vpJ5hwIv9VK+DVLuqKQjMpDPc5RGTWMzQDDagighLV+n6/WVEIAYeXGLvlLcWbf91WmstpafV1UID9AnM9WghW9dueVdZVApIm0kKTZHBNrdyTRo+n/Sq7Pbi8snPuMcIv+KvFUNYY3lltNbiahYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teQmLezU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218CDC4CEC0;
	Wed, 11 Sep 2024 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096829;
	bh=Znyoj7zrNqDONfTgrAvlgyo46Z+vQk6ml+RCaqNj6h4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=teQmLezUb1FOFNsUb3DYet4bbX9Om5Om02PGvbowrrN+9NtGMoE7awsiaVjO7N7C1
	 gjSoy8Ky84+dftD66ATbA61iJMrLKkvXOJTI6v1i5jEkpoL8OszrmK1s020do8vkh8
	 WfV9q2v6QMLsSayDxXs1GokiLsDf6EE40213EeKdySjs8ErEnhLR4Xgim+UipLvbcJ
	 NteNLaczTf/P+ezMHSXkyD0GrZS8MM6IFW/SvjAfbd3zxqjQynuYlr8DqurBg9RSsp
	 VtmA08hzc0F88iOVTfsJdLTcYXcbW95KXwglmbcgt6lSA5HfM1u4R0dJ2Ni4BODGeZ
	 GFec0EDSRUESA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717B53806656;
	Wed, 11 Sep 2024 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dpaa: Pad packets to ETH_ZLEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609683028.1105624.12829363683398700219.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:30 +0000
References: <20240910143144.1439910-1-sean.anderson@linux.dev>
In-Reply-To: <20240910143144.1439910-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: madalin.bucur@nxp.com, edumazet@google.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 10:31:44 -0400 you wrote:
> When sending packets under 60 bytes, up to three bytes of the buffer
> following the data may be leaked. Avoid this by extending all packets to
> ETH_ZLEN, ensuring nothing is leaked in the padding. This bug can be
> reproduced by running
> 
> 	$ ping -s 11 destination
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dpaa: Pad packets to ETH_ZLEN
    https://git.kernel.org/netdev/net/c/cbd7ec083413

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



