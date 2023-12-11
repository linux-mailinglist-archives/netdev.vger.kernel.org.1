Return-Path: <netdev+bounces-55823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D480C611
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905B5281844
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B182577A;
	Mon, 11 Dec 2023 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxhmqA1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5C249F3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07F1FC43395;
	Mon, 11 Dec 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702289424;
	bh=Mfckdoq/uj4UrZUr0n8Hz654qOJ16sFZDtX0WVYkOLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VxhmqA1vjmaec2hor592OuuKLRQrfBs3E/tusOcUv4I5CV4bG5o5xd+FtVQmaw29u
	 W1O4hpI9omMxyxc7QRjm2FdNGN0HJN23PQjM9wOwNrwsdiUZByb/cVhKgzBoEsLuyL
	 vsbs8UFqu702pDmeggKbA6T6qk3PcPyo/33iIlKY3TiUWubDlPSQtsS99QCgm/ZM/M
	 orXvQNUkzlVAxFkR1POOrzNO0fmY9hS+WSXc2cTMjxcq9ZocKDmhcwxN1PZ57yB1Bm
	 gsoSnf6ZRZ3Bo9GhV/QYCM5VuBaIeDAq1Z8A6kakGKMmvBqh1OJyp4v/5dD/lIgsOO
	 ni4l3uwhIDnKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8AE7DFC906;
	Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: support UDP segmentation offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170228942395.26769.11191413773078872145.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 10:10:23 +0000
References: <20231208060301.10699-1-louis.peens@corigine.com>
In-Reply-To: <20231208060301.10699-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 fei.qin@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Dec 2023 08:03:01 +0200 you wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The device supports UDP hardware segmentation offload, which helps
> improving the performance. Thus, this patch adds support for UDP
> segmentation offload from the driver side.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> [...]

Here is the summary with links:
  - [net-next] nfp: support UDP segmentation offload
    https://git.kernel.org/netdev/net-next/c/18c5c0a845b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



