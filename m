Return-Path: <netdev+bounces-60915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA894821D88
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB251F22CCB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9D10A0C;
	Tue,  2 Jan 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP+eE89h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7310958;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 705E7C433C9;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205225;
	bh=5yDWZG+dXrMQ1dEUdADAmEt1nvnUCrMTGAMQtlwoBrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pP+eE89hcw0OOCh+Pb5eQzwjIsfW9xzdhB5kM8OWqVjtBa02IhXen0As2z4v5tlVN
	 67eIm4A0oAngmAB5zxn2akCEtQ6N5aoSMnkt3+caDyLwqsc/SKg/ADRI3qMvVU17fu
	 2dxaNvH6CQxF4R5m9a2D7UBnQAlZgpqmupoKhsmAqERNlSdIdkGl141fa0VKgLCw6p
	 TUrMHw6VWhRjK3outlD6svgbI21294ZiotuT9Lo07XfTUYraF9vaLcVhNyz5yTL+Y8
	 pAFwYoqBRwT41h9ANk8UC+FD/iL3vnaFcF78zpiVQ1FdNcwWO+LzZisFK4DMIEO4a6
	 hgMbSBurEEdRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56CAFDCB6CE;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] connector: Fix proc_event_num_listeners count not cleared
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420522535.14312.6065491886891653908.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:20:25 +0000
References: <20231223065032.20498-1-wangkeqi_chris@163.com>
In-Reply-To: <20231223065032.20498-1-wangkeqi_chris@163.com>
To: wangkeqi <wangkeqi_chris@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangkeqiwang@didiglobal.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 23 Dec 2023 14:50:32 +0800 you wrote:
> From: wangkeqi <wangkeqiwang@didiglobal.com>
> 
> When we register a cn_proc listening event, the proc_event_num_listener
> variable will be incremented by one, but if PROC_CN_MCAST_IGNORE is
> not called, the count will not decrease.
> This will cause the proc_*_connector function to take the wrong path.
> It will reappear when the forkstat tool exits via ctrl + c.
> We solve this problem by determining whether
> there are still listeners to clear proc_event_num_listener.
> 
> [...]

Here is the summary with links:
  - connector: Fix proc_event_num_listeners count not cleared
    https://git.kernel.org/netdev/net/c/c46bfba1337d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



