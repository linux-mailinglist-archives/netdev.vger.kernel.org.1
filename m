Return-Path: <netdev+bounces-72729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D154985962F
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 11:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C37C1C218A5
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19C52D052;
	Sun, 18 Feb 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfftHt4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975E2D04F;
	Sun, 18 Feb 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708251624; cv=none; b=Xe0XPyLs9yle7xTR6Iak0oUnLR1W9bycbs3hOfqzLaxZTgCmCNo9kRtRWQDW9fYGSFhZsXySUAV+g9DLHIM9Et4XIeI4d6kGXyNHvKJIYQNOkUHhERDA9UQFqyMmASED8NHiWmrAo5uH9k6XJODCXzqL/hjUGMjy47nWug19tIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708251624; c=relaxed/simple;
	bh=8Se2Hd4Gvt/E/8QXweutrEJnGJKs9TJImInulpwzzN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gwITg8oc+aju3RhUkeDhGbo45YADGj0nBbtHWafWnrmL6a3tIFLLeU0ZgeDWCcsAVkHE6ziR0GeEj5/SGOBjzukS/A0lmDyNUmseWaVoU+faBG0pBwfoFXYdr/KwJev+B5vQLBoG1VLMIOHFH3RxaFOuu5fpOfGaoLYZA2o4NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfftHt4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C45C43390;
	Sun, 18 Feb 2024 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708251624;
	bh=8Se2Hd4Gvt/E/8QXweutrEJnGJKs9TJImInulpwzzN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfftHt4s5smySC244T5S8zYH6DXTp5b76Tz4Ucg4swTuR/enYeX0QxbnRQimj44CJ
	 L+d5W3MZcRfDKgqE3VuYgJR3ExtU0dqAFKuD0gCvc0U/Zu1VrBqYH39LjyuwWlA4i+
	 BoWgM+4R0i5/IouvvOor2Cool11OK20PmBQSdPHXuQTtKc738oUV6gLisyqDxarMC4
	 ekUsl8uOTz0K5TGnbM4ppq2fQAEXQU1+DtRPyjMaIf64o9umdGFgRJ/3yxYYfq4q9L
	 oMhfTWZb85TgCo+16r+50GMbILy+gjDwO0uhcHAcd05IOJl7heJTYPx507oPTt1ASV
	 KZTqU70lWejTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D19CFDC99F1;
	Sun, 18 Feb 2024 10:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bql: allow the config to be disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170825162385.18347.10398309297353590491.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 10:20:23 +0000
References: <20240215170508.3402883-1-leitao@debian.org>
In-Reply-To: <20240215170508.3402883-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, therbert@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 09:05:07 -0800 you wrote:
> It is impossible to disable BQL individually today, since there is no
> prompt for the Kconfig entry, so, the BQL is always enabled if SYSFS is
> enabled.
> 
> Create a prompt entry for BQL, so, it could be enabled or disabled at
> build time independently of SYSFS.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bql: allow the config to be disabled
    https://git.kernel.org/netdev/net-next/c/ea7f3cfaa588

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



