Return-Path: <netdev+bounces-127672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905A975FDF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 05:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5273828569C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E661188908;
	Thu, 12 Sep 2024 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBPLRgMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28F187552
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113038; cv=none; b=j5P4C2HQog3feZY28Gtb4181PtJmDbEnX3/CtLyEnvzTwr3ZFGjQCTuB+NhV4eob4gIP0kQmNTijK5zQSbS7bIWuHmfVj4IPDV4XpaJnlT8RgAdan8AM86g/Swuv2o/bt4Xub5AIrCuJPD4NUcHH4NeYXJRvZvElBN6bjVxemDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113038; c=relaxed/simple;
	bh=wc72ZybEGGF+XxP8bwZbGfPleI5HhFr25lXn4uGEJQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z8mzhH4ar37WxPsqlY1bcR3peZNAvreLePbdKNQ5Qo1iRGKo5UMWIyXKdHehWp4r4rDVzsvQg8+u/yt3U8aW6p0NzDuJcMcu7unLwco5OGHFo4FwYdyGwosfU2LElMz5ivoeEyFxwoo8PLmRUcbSY6X5LGTMHxaDOrkP02HsD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBPLRgMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25B1C4CEC3;
	Thu, 12 Sep 2024 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726113037;
	bh=wc72ZybEGGF+XxP8bwZbGfPleI5HhFr25lXn4uGEJQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBPLRgMjiOLh//qV4HqciJvSGhNjjoZ1ePve6v/ao4kJK8ctmvXR4dtXBDivDffXG
	 uxwFBfj9arTL/1yMnZdB+l/5GtU/eQwhCgscP3qUfyQInEHLoqOPfD8z4yeeZalo2S
	 uVrvRwDJh+LDuqeLxq/Hq1yWZg0syq98zXYJbaIMDBPoMlLO7xxHY6u1PSjjo3Fe7M
	 Tq3RRTx1PSN70K/hZc9t3FpWa4FCPYJ9hpRprto1QYDc/v0aSrrUKxZb7usTNAP+3H
	 oiwtlNoldwQ95BemuGxunbFjbRdEmPOC/zFjVwmIFdcFKHYp2auyof48RljpFf19Os
	 cTll0pc34GTwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3477F3806656;
	Thu, 12 Sep 2024 03:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II: convert
 Tx completion to libeth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172611303874.1155279.395544887832441348.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 03:50:38 +0000
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, joshua.a.hay@intel.com,
 michal.kubiak@intel.com, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  9 Sep 2024 13:53:15 -0700 you wrote:
> Alexander Lobakin says:
> 
> XDP for idpf is currently 5 chapters:
> * convert Rx to libeth;
> * convert Tx completion to libeth (this);
> * generic XDP and XSk code changes;
> * actual XDP for idpf via libeth_xdp;
> * XSk for idpf (^).
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] libeth: add Tx buffer completion helpers
    https://git.kernel.org/netdev/net-next/c/080d72f471c8
  - [net-next,v3,2/6] idpf: convert to libeth Tx buffer completion
    https://git.kernel.org/netdev/net-next/c/d9028db618a6
  - [net-next,v3,3/6] netdevice: add netdev_tx_reset_subqueue() shorthand
    https://git.kernel.org/netdev/net-next/c/3dc95a3edd0a
  - [net-next,v3,4/6] idpf: refactor Tx completion routines
    https://git.kernel.org/netdev/net-next/c/24eb35b15152
  - [net-next,v3,5/6] idpf: fix netdev Tx queue stop/wake
    https://git.kernel.org/netdev/net-next/c/e4b398dd82f5
  - [net-next,v3,6/6] idpf: enable WB_ON_ITR
    https://git.kernel.org/netdev/net-next/c/9c4a27da0ecc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



