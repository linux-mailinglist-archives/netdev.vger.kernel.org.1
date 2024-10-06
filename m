Return-Path: <netdev+bounces-132502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2D991F3E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9091F21973
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B356446;
	Sun,  6 Oct 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUalILu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE321273DC
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728227428; cv=none; b=uoaGQzf8iUCV55zgkUbsTdVRavnC25H/k3WCkrDNJUfA9cTrwndJ+Gnhrzvf2+Ift1uYcjaJbASr0X/pOm3I93vrM4rHte9YUHLuY1l+zQhGqriO5ltd5Ge76pccW1g0G56MfmAIfz8lMdB8QWe9pmGUj/a1i8gzBG8pyjz3JU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728227428; c=relaxed/simple;
	bh=2FtcjDNT1mLZTmbPHzSfzMJPZC/fmgyfRBlM87s7rao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+KrTryPfLLESAwjoNpp9RFtobj6NWkgPb00MN4Uj3C12p1ovB8N4la+XVaLXnfMeKUWoP7f9NYJTmudK3HK2JnQDaHdc9YWOXgCPyJ1Go5xwMxKL/ljFyXRuthoC2cBYZNuUjbA4IWG92D2kGDzoy8CjQekkhrLEQI1h4vVzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUalILu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F258C4CEC5;
	Sun,  6 Oct 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728227428;
	bh=2FtcjDNT1mLZTmbPHzSfzMJPZC/fmgyfRBlM87s7rao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUalILu+IbiZDSnQC+NtM2B/PzDQgDe2UrPRtMoMSPJm9D6Jr5uXkoSzAAbCr7mGM
	 SXig86S+R+hQ3PlkMSy27WBuCRG/svieMU27SwxFpzvBuB+nZAnGMQoYxyC41FzXqB
	 98WZCYmWQwK7q7Kaaaz65yVel/pdKcXONLf4is/oLHDCdpO2WXjQKNtbKtokR/pNqi
	 UlPbnAU/JOBUAXm7JsdNcZ5HI4mkGzMq5OYw/ER21Nh90PLIAlF3O72xGmtp02Pu75
	 42ncgaAA2wRsLs5z15J5xhAp01tfmxPsaZFWE5gkmqP/PYa1+BHSoj/0PmiKAuafas
	 IYRnOor+41g4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CED3806656;
	Sun,  6 Oct 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/7] sfc: per-queue stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172822743227.3442353.5221498759841516913.git-patchwork-notify@kernel.org>
Date: Sun, 06 Oct 2024 15:10:32 +0000
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1727703521.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 30 Sep 2024 14:52:38 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> This series implements the netdev_stat_ops interface for per-queue
>  statistics in the sfc driver, partly using existing counters that
>  were originally added for ethtool -S output.
> 
> Changed in v4:
> * remove RFC tags
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/7] sfc: remove obsolete counters from struct efx_channel
    https://git.kernel.org/netdev/net-next/c/65131ea8d3f9
  - [v4,net-next,2/7] sfc: implement basic per-queue stats
    https://git.kernel.org/netdev/net-next/c/873e85795026
  - [v4,net-next,3/7] sfc: add n_rx_overlength to ethtool stats
    https://git.kernel.org/netdev/net-next/c/5c24de42f1c1
  - [v4,net-next,4/7] sfc: account XDP TXes in netdev base stats
    https://git.kernel.org/netdev/net-next/c/cfa63b9080bc
  - [v4,net-next,5/7] sfc: implement per-queue rx drop and overrun stats
    https://git.kernel.org/netdev/net-next/c/07e5fa5b7f43
  - [v4,net-next,6/7] sfc: implement per-queue TSO (hw_gso) stats
    https://git.kernel.org/netdev/net-next/c/db3067c8aab6
  - [v4,net-next,7/7] sfc: add per-queue RX bytes stats
    https://git.kernel.org/netdev/net-next/c/b3411dbdaa55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



