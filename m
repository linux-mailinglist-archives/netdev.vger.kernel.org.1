Return-Path: <netdev+bounces-152030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD69F265E
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E8F164FB8
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B11C1F02;
	Sun, 15 Dec 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv/Cbohd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB151C07DD
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299413; cv=none; b=AeHTeO+Y0GNnFPNQR4sF5c4Giimxnu6J7z+QB1to4Ubtn6LLGrxeTuULZ+fqYjY9V9BMY+MV5hUo0g0wqgUGjMZk4qbVmkNrlYCpKvrKdEd8AIka3AGvlg/RgFBsyC+X7Ys6mnUmHlLrNBdK3FuDderkYt99aWRtxX3MnVM8A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299413; c=relaxed/simple;
	bh=Sxwagv9DlJVpvS762m5moNIo5FL5mhrOTPvfr/8V+i8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=icsvzC0+XIJ8Tpse7Bx86mk1wAA+rcyM7MnQ/rf1x0gH/WN3p5RcU0HM57DYfs7czYiU41A2/p20yzqId6DkS56GHagBVMTXt+FqzKmQYC72xKtMap0v07FP8iqmKc+JSlxQENJyMdG8DZaviEwzNhgsie3LiomiDB3oCPI1dno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv/Cbohd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC99AC4CECE;
	Sun, 15 Dec 2024 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734299412;
	bh=Sxwagv9DlJVpvS762m5moNIo5FL5mhrOTPvfr/8V+i8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uv/CbohdKdZeINJm0oiM0OgXdcmyODClcuemJJiBAO2NwWMpxpgdEa26I2OIOpz/x
	 6YT3yCrluyWPxYsxWyHTl6O7g/Top++KFmK3G+x0ZOlQqxscl6BQNUboul1YzI6qGu
	 SdOoKYPAE5t1TPbkPLSM+pt4g3j3q/3AbUG6twyMgCoX9p/5KZkz/mS3ix+yR7pQ3K
	 1trRQjl8cC9CcIL9MLLmTsMDiT00tivL8axOcJnOQi+EzLANP4hc8wj3HDne36KeE9
	 P0aREoukh0ClE7EVs5mNHxwnT/iZUzO92GaX4s4ziFsSLXRaXTIPCfKaVJYkJcIZTF
	 SMr8GwpQSkP/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DE0843806656;
	Sun, 15 Dec 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: ena: Fix incorrect indentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429942974.3588300.12203092048877177743.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:50:29 +0000
References: <20241212115910.2485851-1-shayagr@amazon.com>
In-Reply-To: <20241212115910.2485851-1-shayagr@amazon.com>
To: Shay Agroskin <shayagr@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 dwmw@amazon.com, zorik@amazon.com, matua@amazon.com, saeedb@amazon.com,
 msw@amazon.com, aliguori@amazon.com, nafea@amazon.com, evgenys@amazon.com,
 netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com,
 ndagan@amazon.com, darinzon@amazon.com, osamaabb@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 13:59:08 +0200 you wrote:
> The assignment was accidentally aligned to the string one line before.
> This was raised by the kernel bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412101739.umNl7yYu-lkp@intel.com/
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: ena: Fix incorrect indentation
    https://git.kernel.org/netdev/net-next/c/36e32b33d811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



