Return-Path: <netdev+bounces-233473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69048C13FB3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606CB19C0295
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142429BDA5;
	Tue, 28 Oct 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlWAq57Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B8202963
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645633; cv=none; b=gfjzUBf7SiK7SRtL9WLtN4bl2Ow2yGNeHqOlfhdzmv42+5zrtVMDgquzZQa+MgtstXnPJT1jwAlRw+O3kzS42Wl9EDKVJRNyB/XiH1uBwwFsZa0CSrmQH9XILT9bIpAKFV47+62x66jzFrMbqdZrK3k4dMEYy+0UnYtbqjbnE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645633; c=relaxed/simple;
	bh=9E57EW/WyUyrQUeVjmLJzS500ZXAGkrBuMjrZ8Wgwmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tl2Hb55A3ySJSvY5+GCtPEK9VV3yJyjWJ/wh+LTMHwediiHE7rMzDmXpicKBxuJZkuli7/6vGLil4lQ+XlG4JU8pFuqHcyvKOlVQnM1MBHA03KoxTveQso+OygVbI6Mm11/VBSwDNJqklmPbstoTmhX5dBhoy3iOfjnfWhXEcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlWAq57Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FCBC4CEE7;
	Tue, 28 Oct 2025 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761645632;
	bh=9E57EW/WyUyrQUeVjmLJzS500ZXAGkrBuMjrZ8Wgwmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RlWAq57ZEFnO2m9wfapN6CKsYVAJW6B+Dz8KaohInuBOokiv/udanMNxSBMkL6tTE
	 4jUQ3G/pfjWajxXdS6o/0j291Rtdp13HFl5MaFw4t9JZUq0gvBjhGoBMV+upYrJVi0
	 cD7v6hOzkoF3Y8XZEHdG46C5qT907IbXA/bLD/gPk3mybf9ueNLLiR4o7ldkiAfqmB
	 2X5LPQ6bwtoq0UIrTgCUrks39BpWH1G+beJjAXQpeFFjhiBFieIv0PLL/lWCPbcv6n
	 sMzH4AFdW6kF5FCN9q7zmtYZDFURbVnJ/ms6ejPw9y3WUfTH4Qalb1hJbHoaWo5y4Q
	 9j/WECddrnCvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E639EF975;
	Tue, 28 Oct 2025 10:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Implement more features for txgbe devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176164561051.2164840.1317624309819530827.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 10:00:10 +0000
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
In-Reply-To: <20251023014538.12644-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Oct 2025 09:45:35 +0800 you wrote:
> Based on the features of hardware support, implement RX desc merge and
> TX head write-back for AML devices, support RSC offload for AML and SP
> devices.
> 
> ---
> v2:
> - remove memset 0 for 'tx_ring->headwb_mem'
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: txgbe: support RX desc merge mode
    https://git.kernel.org/netdev/net-next/c/a71e36777348
  - [net-next,v2,2/3] net: txgbe: support TX head write-back mode
    https://git.kernel.org/netdev/net-next/c/eb57b16d90d3
  - [net-next,v2,3/3] net: txgbe: support RSC offload
    https://git.kernel.org/netdev/net-next/c/eaed17770637

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



