Return-Path: <netdev+bounces-21813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8056764E1D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E547D1C21181
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D607D51C;
	Thu, 27 Jul 2023 08:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A4C2C2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9456FC433C9;
	Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690447821;
	bh=GlH5mbp9j0RGJ071GfQGT/J6uBVSMxt/8MVV9sBYAnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s9BaKUC8EICrfKaElJOyIyZsP9PYqR/aZ+JpHahxy/JHrzznz8NDbLLMmhynBC/kz
	 JXLUZelVG3w/F+ocXGXIShkL6pzapwkY64m261kPuhIQziZFxgl+CJ9PE3cXozRI9f
	 lo/GwGuNJOxjJaU9ZSGwjF+vbgYRpSswF1slQEFGAvUS2utOh/qLqt6j20xN3qSFPJ
	 6lImbGQw38+YE3RYzCF5ZGR8rmMwOCuu8Wfc6Vu+S2y1RbFJKxoufdTLj4vTjfkmWV
	 sC9Wxk4PzpGUDoYaZlrmwKasQM9OghZTkmxpc5nYNweeRKqd4XSpvcQrgwa8K0ATlU
	 rr/RQaRD5tAqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78686C691EE;
	Thu, 27 Jul 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] benet: fix return value check in
 be_lancer_xmit_workarounds()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169044782148.5847.13565294652021594404.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 08:50:21 +0000
References: <20230725032726.15002-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230725032726.15002-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: kuniyu@amazon.com, ajit.khaparde@broadcom.com, netdev@vger.kernel.org,
 somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Jul 2023 11:27:26 +0800 you wrote:
> in be_lancer_xmit_workarounds(), it should go to label 'tx_drop'
> if an unexpected value is returned by pskb_trim().
> 
> Fixes: 93040ae5cc8d ("be2net: Fix to trim skb for padded vlan packets to workaround an ASIC Bug")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net,v2,1/1] benet: fix return value check in be_lancer_xmit_workarounds()
    https://git.kernel.org/netdev/net/c/5c85f7065718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



