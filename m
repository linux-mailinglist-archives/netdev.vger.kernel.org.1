Return-Path: <netdev+bounces-18793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73835758A8D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56371C20F22
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AA17CB;
	Wed, 19 Jul 2023 01:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0015A9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33EE2C433D9;
	Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689728423;
	bh=T//e2pfQDKWOAe1HJ27LKkSwaU+uIiZkMChAZ58CtAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1F7olaR4BCHYFgAN+enpj8qXdDxTtnlNpslqBeJYa1BahCneI2RcHV/J/2FYN1O/
	 NYlTmC0ZHoAfzuD9+3kDVZddTLPQ/iA6jKkkHZEncEY+2gKEuvCJYo52kdWis85abU
	 82yMDgzbHwsUU5PGw3NIIo6mDxGR4WnrSvYt35KAT9NdMzDqa5mv8dEuhrZecXvafz
	 4Qdd3SUlnxf/wdy07eExPypSljj6LbiRpv/FtWe/o2DQ4FumkCybPJChjjD6girwxy
	 DzcBc81e3WM98TueJE9JesVt//SerogbqIJQCSTxznHeZZjRUzi49jGow0NSdFgeTV
	 +voN87V9ZuvPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F65FE22AE5;
	Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mvpp2: debugfs: remove redundant parameter check in
 three functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972842312.21294.6659811622444707479.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:00:23 +0000
References: <20230717025538.2848-1-duminjie@vivo.com>
In-Reply-To: <20230717025538.2848-1-duminjie@vivo.com>
To: Minjie Du <duminjie@vivo.com>
Cc: simon.horman@corigine.com, mw@semihalf.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 10:55:37 +0800 you wrote:
> As per the comment above debugfs_create_dir(), it is not expected to
> return an error, so an extra error check is not needed.
> Drop the return check of debugfs_create_dir() in
> mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
> and mvpp2_dbgfs_cls_init().
> 
> Fixes: b607cc61be41 ("net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs")
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: mvpp2: debugfs: remove redundant parameter check in three functions
    https://git.kernel.org/netdev/net-next/c/f8e343326c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



