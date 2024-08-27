Return-Path: <netdev+bounces-122506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B19618A0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1874F1C2301A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF151CEAC9;
	Tue, 27 Aug 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUNjcCkK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCC1C8719
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791233; cv=none; b=eZ4X/UpQgqQ4xDiq3wMcLgommtV5QBIoVVn6JbzMZEppL8cS1M5knpCZ4EP2HmhlLvGjd6l/uDYSP8ZsmBYEaFui8pEQfH3tlwiZ+NkGkQKx+25dVHMUBtyc1zExl0iKufA1azFNJVdccy8Gp1ANGF0/wbICmazhZdKBcdNlDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791233; c=relaxed/simple;
	bh=b9gWkPqRq9MLX0q/MR+SBeOgbYjo/OB3/LvaQ5jex7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVKUumcV2e4s3UAg+5oC1IFYhvOp5diyinNONf/iiECOlPyYKsTJe3O8flFmFFcFzoUmG6Rmcn5gOqYpBIPrYiaOi8DwZrmy77hlaH2Cf4KsjE5EOMD9upraesjOTjYqyJTJM+/fDTxabTegoWLXC8/ZRmCO9jXCVGt6nDntXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUNjcCkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC2BC4DE09;
	Tue, 27 Aug 2024 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724791232;
	bh=b9gWkPqRq9MLX0q/MR+SBeOgbYjo/OB3/LvaQ5jex7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BUNjcCkKIdfYiHY25NO4WKKeSUy9NtK9t+c5p8VHk3yu0V3VFKgg7eLNITH9mJ3QA
	 i/MQ/NDX3uNm1fnD2JXUku+PIPImvi/K6I/NCOgzxLxlaeymE+CwXxZSLBCBGBM92L
	 I38mwxdl5RzP6RlxFpB3tUWU6EJRqNJNvZ0iwFaNsBgdjSM402CK5HnsO2UUSfjYXV
	 iTlgZyPPG9qyO7Lt1P23FMY1Sq4qOeFMHoWkZDjaFco1SL2gGyGps4aFqAAqxSWWG6
	 YOg4o+HU/8AjGFLe9OFA6uKPDMCgJZG4XCQL5z292FikXffJXfCbxJxxfwZsc8uRQT
	 HqTQczgNFkMlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFEF3822D6D;
	Tue, 27 Aug 2024 20:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] l2tp: avoid using drain_workqueue in
 l2tp_pre_exit_net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479123225.757308.14877891205035162893.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:40:32 +0000
References: <20240823142257.692667-1-jchapman@katalix.com>
In-Reply-To: <20240823142257.692667-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 15:22:57 +0100 you wrote:
> Recent commit fc7ec7f554d7 ("l2tp: delete sessions using work queue")
> incorrectly uses drain_workqueue. The use of drain_workqueue in
> l2tp_pre_exit_net is flawed because the workqueue is shared by all
> nets and it is therefore possible for new work items to be queued
> for other nets while drain_workqueue runs.
> 
> Instead of using drain_workqueue, use __flush_workqueue twice. The
> first one will run all tunnel delete work items and any work already
> queued. When tunnel delete work items are run, they may queue
> new session delete work items, which the second __flush_workqueue will
> run.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] l2tp: avoid using drain_workqueue in l2tp_pre_exit_net
    https://git.kernel.org/netdev/net-next/c/73d33bd063c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



