Return-Path: <netdev+bounces-33746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF079FE24
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FD51C20AF7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE018AE7;
	Thu, 14 Sep 2023 08:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042D28F8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B128BC433C7;
	Thu, 14 Sep 2023 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694679626;
	bh=bgtFB9pPCeAZNnsPGVeYzmmhXx+nDQpLvLJuN4vUJP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=axq6F/2BDquSKKLZsXgQPzru+I13yGcjSFhpO8guOq9sLoiut+B1iYNd4Dvb7tHxS
	 EUU65Fx1G+H1j3ziAIbMQvTwKDLKB8k92qQtc0O4zZxht5pBfLHHatjawMBMZLnNcF
	 nR2lQtJtOCeJ3uXu457Aslnk6Wf3GpJ/A3DagpFHz/kDbFz7s40+OM8HpzoGEmZLDe
	 ulk1WULMdcZKD9W+ehAmYSBzqh/gPaxvRfguzF74KSn/cRXCL3pjEPkUG5ADcgTD8O
	 vVYvMWY3WYyiOnNrpxqF6Hw9q307V+lTX9Ci4nZzL3OblLlWyok2fu3PjTnSBiOUot
	 9Sixwg+IVJscg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98CF5E22AF5;
	Thu, 14 Sep 2023 08:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] atl1c: Work around the DMA RX overflow issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169467962662.28916.1296559484134110409.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 08:20:26 +0000
References: <20230912010711.12036-1-liew.s.piaw@gmail.com>
In-Reply-To: <20230912010711.12036-1-liew.s.piaw@gmail.com>
To: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, feng.tang@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 09:07:11 +0800 you wrote:
> This is based on alx driver commit 881d0327db37 ("net: alx: Work around
> the DMA RX overflow issue").
> 
> The alx and atl1c drivers had RX overflow error which was why a custom
> allocator was created to avoid certain addresses. The simpler workaround
> then created for alx driver, but not for atl1c due to lack of tester.
> 
> [...]

Here is the summary with links:
  - [net-next] atl1c: Work around the DMA RX overflow issue
    https://git.kernel.org/netdev/net-next/c/86565682e905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



