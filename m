Return-Path: <netdev+bounces-154095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044559FB40F
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585FF188248B
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52B1BBBE3;
	Mon, 23 Dec 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peD01YaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8C1B415B
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979227; cv=none; b=Sm0txLd3/hz0Zb8EoBd1itgTl99hBXCUrLhkyRBp8A4TPK2yEe2bR4fwPTSrM0AjaodU876T3AiznYX4b79B1FnIUMaYBjlACM5l/wuS3qP5TjoqqI+MuTREaX8jvZYWfbOULabx5i4lQOE8ANKUcHTDKBxBl9mw7C6KXl+VPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979227; c=relaxed/simple;
	bh=o1Ba39dDUhzu+rf8UeXopx9HelJKET82J9K9ZqiKvWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NVj2hgNsm2UcYXAfrb7pFv+nSAJJ3+W4ykPnen7ThUlUF/tCUoQvUM13jVM7hHcBAi5bmsabLYw8pvjob4j4NKLHmP7sJAxNezgB0e1pv4BatilGWxRAX/uPE0knzoFLfuyoV1GfHSHu9PHonaFb/2biN+jLgoRIdVqcqp1CUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peD01YaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E056C4CED3;
	Mon, 23 Dec 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979226;
	bh=o1Ba39dDUhzu+rf8UeXopx9HelJKET82J9K9ZqiKvWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=peD01YaP7iR4v3Z54vwt2aL5obSu13WX1v2Yt0+cFgI27ax2mKVIAsRDjIYTRvA5A
	 NDzDKT7wl0iJAi6Qbs0EUigadmtjpG+8UCJNYmMr/Pse3GwkjKaLCvx4j5FY+KqDmb
	 V/HEjh28RQaNnK0rxbgISiwjlMaAN4k+7AzGtnFof5N+PC7w0yweE/6uwMa2uj71Uo
	 w6/G3XHCl3+DBEKIHANEe8suuWwnLzxaY0HYXx/nQ+tZUSqtDM6UylEt5fEOHQZFCw
	 vET8oMG7KYOCpsCmxX+uEtcBqHDn2h58OzDj3jIIqZTq36b+wnwuWA7vS68qBR5rCU
	 7jc31LBNX61XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F6A3805DB2;
	Mon, 23 Dec 2024 18:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V4 00/11] mlx5 misc changes 2024-12-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497924501.3927205.16993887490244751404.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:45 +0000
References: <20241219175841.1094544-1-tariqt@nvidia.com>
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 19:58:30 +0200 you wrote:
> Hi,
> 
> The first two patches by Rongwei add support for multi-host LAG. The new
> multi-host NICs provide each host with partial ports, allowing each host
> to maintain its unique LAG configuration.
> 
> Patches 3-7 by Moshe, Mark and Yevgeny are enhancements and preparations
> in fs_core and HW steering, in preparation for future patchsets.
> 
> [...]

Here is the summary with links:
  - [net-next,V4,01/11] net/mlx5: LAG, Refactor lag logic
    https://git.kernel.org/netdev/net-next/c/ddbb5ddc43ad
  - [net-next,V4,02/11] net/mlx5: LAG, Support LAG over Multi-Host NICs
    https://git.kernel.org/netdev/net-next/c/60d01cc468fd
  - [net-next,V4,03/11] net/mlx5: fs, add counter object to flow destination
    https://git.kernel.org/netdev/net-next/c/95f68e06b41b
  - [net-next,V4,04/11] net/mlx5: fs, add mlx5_fs_pool API
    https://git.kernel.org/netdev/net-next/c/31d1356b8fdc
  - [net-next,V4,05/11] net/mlx5: fs, retry insertion to hash table on EBUSY
    https://git.kernel.org/netdev/net-next/c/586face88106
  - [net-next,V4,06/11] net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
    https://git.kernel.org/netdev/net-next/c/9a0155a709fa
  - [net-next,V4,07/11] net/mlx5: HWS, do not initialize native API queues
    https://git.kernel.org/netdev/net-next/c/429776b6019b
  - [net-next,V4,08/11] net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
    https://git.kernel.org/netdev/net-next/c/aa90a30804a5
  - [net-next,V4,09/11] net/mlx5: DR, add support for ConnectX-8 steering
    https://git.kernel.org/netdev/net-next/c/4d617b57574f
  - [net-next,V4,10/11] net/mlx5: Remove PTM support log message
    https://git.kernel.org/netdev/net-next/c/f440d69a21f7
  - [net-next,V4,11/11] net/mlx5: fs, Add support for RDMA RX steering over IB link layer
    https://git.kernel.org/netdev/net-next/c/ef1749d50669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



