Return-Path: <netdev+bounces-38538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA87BB5A6
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE49E1C209C3
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10218627;
	Fri,  6 Oct 2023 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALoMSHL/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A0125B7;
	Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF64C43397;
	Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696589428;
	bh=EaLFpGzb50pV6X09gUMdvVo2luHhSkmKNOAfJKlqomw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ALoMSHL/a++y4z8Z5V8r/KcIHKCpDc5kvPUbVLqEB+zonGPgYdMdPp7TK7d+nIMq6
	 jXGTXc+Apg8dqSeDjXi0EWmpF2OV39Jg9WpFPDpAIl2AVqj6o6LQzigVb9eqTeWEW3
	 FLG9PWCB+8YKK/bPiUPziYpiIEatH+J8uM1qIcGhl8cN+OvKtXmvC7QphYopzr5PmX
	 YYe3LpV6d+/Ams5yadZ8rU7yYLjRFUecJWB/5Wo+l/6wc8DbT4HyN7u/RWzklyxdwZ
	 2vQxkB9cytycPz0DQICUTG7glZiJg95Ui5+qdSzjci75G3dsWxBn9gLKgW901ZbIlw
	 OlyIoiASrjuJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C2D3E22AE3;
	Fri,  6 Oct 2023 10:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: sched: cls_u32: Fix allocation size in u32_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658942837.16254.5390070465876130493.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:50:28 +0000
References: <ZR1maZoAh2W/0Vw6@work>
In-Reply-To: <ZR1maZoAh2W/0Vw6@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, keescook@chromium.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 4 Oct 2023 15:19:37 +0200 you wrote:
> commit d61491a51f7e ("net/sched: cls_u32: Replace one-element array
> with flexible-array member") incorrecly replaced an instance of
> `sizeof(*tp_c)` with `struct_size(tp_c, hlist->ht, 1)`. This results
> in a an over-allocation of 8 bytes.
> 
> This change is wrong because `hlist` in `struct tc_u_common` is a
> pointer:
> 
> [...]

Here is the summary with links:
  - [v2] net: sched: cls_u32: Fix allocation size in u32_init()
    https://git.kernel.org/netdev/net/c/c4d49196ceec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



