Return-Path: <netdev+bounces-25618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456C774ED6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D75928183D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0518035;
	Tue,  8 Aug 2023 23:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883DD154B6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E61CC433C9;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535622;
	bh=wnfCaGcdKL2N57wxDamYXODXYLvSrT34tXhZMGxOOKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PVCBvqe7DI4CiKsIy+bSzZbDNtzyvWoW7RwiWoios7pKFZfG3ybZ26E9wta8vMnjj
	 bAlEQaIKIWhHm/sZTkA5gAFSRDTD99NdHastYaGQaJr5bwSx5TbRZ3XvJFaWOsWBl8
	 qwD51ymam3xDM5E7RrmK8inxp3gEii1dLtxLhLcEzTCQU6BvfugsMEXm3rGHBloIrG
	 A1u0sj0pZ1Wp2LiErzm0SKYR/TPxJYG2lmkMBt5JCohFtcwKTL7ob+hONNyf+eMSzP
	 OPptqptADqUoCM0BJOnO5IkqlFCUDYFFKI/3QzRH3/Bh3Nh1UcWKSncTDI8aMdHHaT
	 mHB+STm/XOLNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECC0EC395C5;
	Tue,  8 Aug 2023 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: exthdrs: Replace opencoded swap()
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153562196.6878.13467152721076350090.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:00:21 +0000
References: <20230807020947.1991716-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230807020947.1991716-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 adobriyan@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 10:09:47 +0800 you wrote:
> Get a coccinelle warning as follows:
> net/ipv6/exthdrs.c:800:29-30: WARNING opportunity for swap()
> 
> Use swap() to replace opencoded implementation.
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: exthdrs: Replace opencoded swap() implementation
    https://git.kernel.org/netdev/net-next/c/794529c44800

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



