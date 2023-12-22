Return-Path: <netdev+bounces-59961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C781CE65
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CA82850F9
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BB2C194;
	Fri, 22 Dec 2023 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJhHKMIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B2C18E;
	Fri, 22 Dec 2023 18:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CAC1C433C9;
	Fri, 22 Dec 2023 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703269254;
	bh=+cq7ePS1efJ9IBnDU+1oaepAEh9UUKSeYby4tXcbDU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJhHKMInl3tdmn5tuocoimQ9NLedBHZwvlZxCsJFETXyK9Pjy9moa+OmycZQAmKyV
	 oPWJYctX2+2rVmXda8Jjm0CidxBjwkHbMXzFjDkuBl1myFG2Yi/Ysllc3SFiJWNO0e
	 FNvOT77fARSRqehRSXKyKHkqQ6dhiURDeP8jhSt9lmmnoKc5P7eRh2scROolEVcrlP
	 eeidN+zTGEmGGuGat/5VI3pgRYfpEjhthlbXvDC2xw2uvGmKZxSDDdOKpX2Eeh5L8Q
	 WKpgwD6Y5ydlL8qDO/tpKlv+6YHpB02EQRIGtMawmC1ORhJjVGgA3CrAM8AozNLD9z
	 ronQ1D0z4aCRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF0CBC41620;
	Fri, 22 Dec 2023 18:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-12-15
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170326925397.20975.7742867697124356716.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 18:20:53 +0000
References: <20231215183214.1563754-1-luiz.dentz@gmail.com>
In-Reply-To: <20231215183214.1563754-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 13:32:13 -0500 you wrote:
> The following changes since commit 64b8bc7d5f1434c636a40bdcfcd42b278d1714be:
> 
>   net/rose: fix races in rose_kill_by_device() (2023-12-15 11:59:53 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-12-15
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-12-15
    https://git.kernel.org/bluetooth/bluetooth-next/c/498444e390b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



