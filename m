Return-Path: <netdev+bounces-69088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEE8498AC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E451F2352B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711718B04;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJF8DYtz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456718AEE
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132029; cv=none; b=d9oku/+8nQ4vgYU8wUuVUg2zio31BRwwvwQxrMLJ4pfmojd2SblOZWVJey+gUxiNBa6Pbuh4Cbqtj/awOAU5B5Ep/nwmPNeY41w3RSO8Q7RVE8LSeZNhwXIVtekbLNRgP0VPRGwcUNMz+Do6mvju+9uYWG2l8n5Yo75hfS6Mwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132029; c=relaxed/simple;
	bh=vtfnzJB+Gh3y8FK7ixt8Pr3ezUjThN9nLu4sqASAHfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOzGKu2HQ9YXMaoyO3FNFshXFWa4BQmn0D5qcWHS684s5HUcL6YOXIfZCEHyVFytZ45Ir8ZrK8Xshr1mRc8pb6SW47cBLHgOvCpGM2/E5ogKs7mo9bFsuuOtv7jqdouX1ksH43mf0n4lHu1wpvfgTtWSlir3hsivzxNKvV5off4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJF8DYtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C5ACC43601;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132029;
	bh=vtfnzJB+Gh3y8FK7ixt8Pr3ezUjThN9nLu4sqASAHfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJF8DYtzf89iFIeQFsB0UGFHGZh5SQw0mPDhjOgtzyXyFL52n3h9S20WBJqNvnvIn
	 GvR2/BmatHN3DhwIflqvAuq1VIaEi3UzwVo91AsjnvyoSgDfuNSV6wpOT4sfZajJN0
	 kDNwz2CAiOQgSl1M8GqTgSm9uE06ETSG/znTi0BifYXIgYXv1HMnoPW4cVRLH2P26B
	 f4bmXwHuzetTe+a2i0voMZXII2LMCVbLT1d9gUYX+vT9JT6lcIXQgOhYdx9AcKTA56
	 Pmp0Tv4TJ8vRuRabQ/rKYZFiQJ4kzwU+ECnjdrfxKtkOuUmwb1TT8qcTZQK+aRq1e8
	 1aspI9UBfBfBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A745E2F2ED;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tsnep: Add helper for RX XDP_RING_NEED_WAKEUP flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713202923.23951.16374919399685545002.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 11:20:29 +0000
References: <20240131205434.63409-1-gerhard@engleder-embedded.com>
In-Reply-To: <20240131205434.63409-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 21:54:34 +0100 you wrote:
> Similar chunk of code is used in tsnep_rx_poll_zc() and
> tsnep_rx_reopen_xsk() to maintain the RX XDP_RING_NEED_WAKEUP flag.
> Consolidate the code to common helper function.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tsnep: Add helper for RX XDP_RING_NEED_WAKEUP flag
    https://git.kernel.org/netdev/net-next/c/1e08223272c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



