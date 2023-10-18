Return-Path: <netdev+bounces-42182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A17CD7B9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC90C281C54
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B901775B;
	Wed, 18 Oct 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g24BS5KA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E315AFE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDA89C433C9;
	Wed, 18 Oct 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697620824;
	bh=5dhYRc+zirG3v+xL8lCr9litt6Xv19Db8q0bpo0dXb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g24BS5KAk3/YL1O4j/vK+DqmVW/CodwOUGAuppMJNNg+dbjgGQTZnQiECvGScTyH7
	 GkurggucP532q9lynpjcrl3/YsBr8+t7GayCgLftRHzWWlHOr2ZK094qE3F0S8xmnD
	 lYjHtyfPff0+0n7d6mGtaFB5LfhGIucIhMqZekIkIPiCBjH2TJC/nOnHnsyblhugFV
	 Z4/SaWyw8N48ddnu/seBBFE9sc94op0oqxHFAkA98sOMBKop4ljE3h0g3Dx+yXmVYD
	 5M0AQidGeGI4ajmYfOtsKtxmgFo7HRGHujMm9/WMcWOS9qAQW8zYOZSWFRna5aovjj
	 g+ar6eoj2wGfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE1B0C04DD9;
	Wed, 18 Oct 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pktgen: Fix interface flags printing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169762082384.4908.15716073327666227322.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 09:20:23 +0000
References: <20231016140631.1245318-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231016140631.1245318-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jgg@ziepe.ca, gregkh@linuxfoundation.org, Jason@zx2c4.com,
 keescook@chromium.org, linyunsheng@huawei.com, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Oct 2023 14:08:59 +0000 you wrote:
> Device flags are displayed incorrectly:
> 1) The comparison (i == F_FLOW_SEQ) is always false, because F_FLOW_SEQ
> is equal to (1 << FLOW_SEQ_SHIFT) == 2048, and the maximum value
> of the 'i' variable is (NR_PKT_FLAG - 1) == 17. It should be compared
> with FLOW_SEQ_SHIFT.
> 
> 2) Similarly to the F_IPSEC flag.
> 
> [...]

Here is the summary with links:
  - [net] net: pktgen: Fix interface flags printing
    https://git.kernel.org/netdev/net/c/1d30162f35c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



