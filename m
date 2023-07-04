Return-Path: <netdev+bounces-15419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346E747863
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7212280FD4
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFF7475;
	Tue,  4 Jul 2023 18:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472226128
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4B63C433C7;
	Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688496021;
	bh=XAsUzDWBFjyQu6VIHGFGHRzZRGSLGMc5fJfgF4MaxN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fBBtjDFTLsCgtJBJhHINAF4IuQo5EtqzvY9AQNZRsm/KIUVM6lQUsK04E9LWyhw6q
	 lBYPLbslQDg2iEhALpSYDEBR1IyX0atZ25oWga14KChWhY6Dm+NHrN3oU2qDfiHIzV
	 cvzfOf4GHTzSJCQ6y46dVHxnJKCTOA5c5+sp98TV5kx4RHor9o2V7+Ut1m3sJ0pKIE
	 rwyQtuPh4R1ohWIGThBnkXdWxU6QfFYYPE9kNf527qWow0ndo0hOEOiveGf4nx5FBq
	 ize/ewGUK1ZBeVodw9T4BEKDO4WlIpUPb9Wyi/BZ3LaTl0cuV70WSYgjBLDcds5aTp
	 ez8RAI4yljg9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E5F7C395C8;
	Tue,  4 Jul 2023 18:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168849602158.25174.8935313597975371189.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jul 2023 18:40:21 +0000
References: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
In-Reply-To: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: petrm@nvidia.com, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 danieller@nvidia.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 3 Jul 2023 18:24:52 +0300 you wrote:
> The mlxsw_sp_crif_alloc() function returns NULL on error.  It doesn't
> return error pointers.  Fix the check.
> 
> Fixes: 78126cfd5dc9 ("mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Applies to net.
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check
    https://git.kernel.org/netdev/net/c/90a8007bbeb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



