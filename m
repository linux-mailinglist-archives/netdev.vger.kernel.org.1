Return-Path: <netdev+bounces-34260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD47A2F4F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B881C20963
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B712B8A;
	Sat, 16 Sep 2023 10:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FE1C15
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16ACFC433C9;
	Sat, 16 Sep 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694861423;
	bh=6xWyhPz5p5Las7f3iuSZp4q0CP3LVtCqn0Rx2S984C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EmiwxNS9WAy36RgXyFRpUA32AQdZk08KMIoWgkq326Xvo80CbapIkVZaBh+hNKf1f
	 iG+NjKClVJS+/1rMsqOcPXjGpbyqq7bHqfbJjUruxDIVmaCNb7vMbZJhxVN1ZiAj8A
	 fpMvtbp6jhIk0fSkLEsZ3J5m5GfYDjWVrLLr6etq+c0QPI3DRGJHeP9HVLgJD6cJwF
	 zsMSF1IBCxnAt1c5zSgdp/5/yzZ62oEYUZuBSJdgV2Va7DFrqmSJ19I2k0bRoArqfk
	 mOHscZcA7FbEWOUcW4uIgVs8LV0kkGYuBQzkNLe31YVKQXZUy1YXStlPm9U8TF1Xgk
	 QqHN7PASE80lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEE14E26883;
	Sat, 16 Sep 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486142297.3496.4502904923756282368.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 10:50:22 +0000
References: <20230914220252.286248-1-drc@ibm.com>
In-Reply-To: <20230914220252.286248-1-drc@ibm.com>
To: David Christensen <drc@ibm.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io,
 netdev@vger.kernel.org, drc@linux.vnet.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 18:02:52 -0400 you wrote:
> From: David Christensen <drc@linux.vnet.ibm.com>
> 
> The ionic device supports a maximum buffer length of 16 bits (see
> ionic_rxq_desc or ionic_rxq_sg_elem).  When adding new buffers to
> the receive rings, the function ionic_rx_fill() uses 16bit math when
> calculating the number of pages to allocate for an RX descriptor,
> given the interface's MTU setting. If the system PAGE_SIZE >= 64KB,
> and the buf_info->page_offset is 0, the remain_len value will never
> decrement from the original MTU value and the frag_len value will
> always be 0, causing additional pages to be allocated as scatter-
> gather elements unnecessarily.
> 
> [...]

Here is the summary with links:
  - [net,v2] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
    https://git.kernel.org/netdev/net/c/8f6b846b0a86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



