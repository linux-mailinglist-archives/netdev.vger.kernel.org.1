Return-Path: <netdev+bounces-37732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA87B6D4C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E00D02814D4
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AC36B1B;
	Tue,  3 Oct 2023 15:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7E36B15
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B6DEC433C7;
	Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347626;
	bh=4+yCcSXsHd4MoVdHEC0vZG1u38JdAj+K8E7ian4dU50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNRUf2+O982oI0YZStrKSg7NLTF/nckCdyzp0lC3uT/zepAJ0yubT6igXCerIQuIS
	 uaccbYO08cGhksLHIAWIvLCzafHkMzwgn3YBnPEeD8g5kpIGqOyk9hiMljT01T9+DO
	 pIkUf2FNIcnwUcJ9TPT+YoJ04xhZr7s9NyL1bMeALMLvtHfcro/g/FEUwFFRrjQSRs
	 EzyCaWMSasHLeaMFAtgxqmOwnnvFJFK6sDaaREkK8q7XI7NOMdqkllVzHnFtDDQaOG
	 kn57Hy2ozFuVKzCGZrFAshPk3RqsCFvnOTE2lVXZIA3JEpZvz0f8NBPzyy4JlBtTVt
	 SdLBAC1jVAi6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F89BE270EF;
	Tue,  3 Oct 2023 15:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: nfc: llcp: Add lock when modifying device list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169634762619.3806.17902886441122676535.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 15:40:26 +0000
References: <20230925192351.40744-1-jeremy@jcline.org>
In-Reply-To: <20230925192351.40744-1-jeremy@jcline.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linma@zju.edu.cn, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Sep 2023 15:23:51 -0400 you wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: nfc: llcp: Add lock when modifying device list
    https://git.kernel.org/netdev/net/c/dfc7f7a988da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



