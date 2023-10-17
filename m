Return-Path: <netdev+bounces-41626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9C7CB7A3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE87281557
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7817CD;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNQbMYag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D215DA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD67C433D9;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697503823;
	bh=DkNe+sb1qUUikjfjSJQCv2um+u5XrcIqH6/wRieL4Ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WNQbMYagesudh6J8PS717CMWggbrz0rO4CqqE2EK5NXJMWYcOG06teQtaiFiSDK8H
	 byG71NeB1Vf4thcnkdo/5i7ggpqNhtJxygIYSCufAybPe89hg7Unli1ES9LNAdwMFF
	 RlOmJb+Nnw1V8C/WG/rYQ0vYZsnMIoycfH+5plC3fRCrt3ww16eAhLZC9aHgp2Lw24
	 zJ/YfKIV/lcXbOSMT1AL8/Tub8QMBtSbag35EjvXY11IqxcDZWXn/ZdEYXmh2Cloob
	 cHleFDbLjy25E37fLXVTXKmj2MZt+bt2dnNOEkZ5T/HN4wTs5FOr5yTp0JVoE+DhAm
	 dfsVI54GrV2ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B76DE4E9B6;
	Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169750382310.30000.96151039538434099.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 00:50:23 +0000
References: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: horms@kernel.org, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 09:23:04 +0500 you wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 
> changes since v1:
> 	- resolved another typing mistake from concurent to
> 	  concurrent
> 
> [...]

Here is the summary with links:
  - [v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
    https://git.kernel.org/netdev/net-next/c/97ddc25a368c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



