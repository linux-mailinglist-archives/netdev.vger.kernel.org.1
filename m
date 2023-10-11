Return-Path: <netdev+bounces-39800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8A7C4828
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E746B282104
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42263B5;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uliMU3Db"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D66111;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D9CC433CA;
	Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993825;
	bh=chhBCKkV6ZerimGonFhRxw877THTC2UOjXgTOzI0cxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uliMU3Dbeg2uHNffO1m5HRHiMQDIb8dS3e0RUtjyg+HY5B2fNk7N11YHjoaVRDqq4
	 bXKTY/R5kLh3EEtAHu+vSsMVKcUnTgP6sWUsNs80b5qwevgGwWV1wUQ0+LTQyldhQA
	 kxFLw1tr8yvSdfeyKHqRjH6p0APsUBtUTYrtRGFOsfv3L9uialQ/zLO7cEQSiC3Eqo
	 Qlj5vE91gMnlMSbt2Rw6LDBFsRyra/9QMMDJdWpSvdFzFbnWLMBQ+2TPIiUW0cfhOO
	 7Z4nfgUr0taYgSK/WA9u675nIyGq5DRczNSOCHh50qiymoe1Ude+FyCNKSLHZZC5VC
	 33DxgP5gqEHtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C24E11F43;
	Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699382568.3301.6960021020124970856.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 03:10:25 +0000
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
In-Reply-To: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: peter@korsgaard.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 00:26:14 +0200 you wrote:
> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
> 
> This error happens because the variable res is not updated if the call
> to dm_read_shared_word returns an error. In this particular case -EPROTO
> was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of dm_read_shared_word
> and propagating the error if the read operation failed.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
    https://git.kernel.org/netdev/net/c/8f8abb863fa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



