Return-Path: <netdev+bounces-22094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60F7660B7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6100282331
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136B18E;
	Fri, 28 Jul 2023 00:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5807F2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 100C0C433D9;
	Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690503621;
	bh=r/6uOjuf+8jNeeGqAD02WhCCOf2Al94cddsqK3FFU9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRIawUj0UTrfi29fx4N2OcqGZQqexbjxn1G9b4UPsY9BlMrtEvi/1N9g9In6Qc+lL
	 NN9IB/WF1qzGxyvWhK8cL7WpgGepyjs6nxmkOtmof9EY/25hCvk20/xi5L2iSNrKfX
	 aeUK+0vpOdZQJWXGUDkpk5FlcgotSufXBmGsHu6kXXtJsZFhHs5lH1/WVa//BvQyZ8
	 L6ECsomIHk6c0CsnxGrr9BYFnAySGT7MI0ubQq/qhgOBp8Npn2bzuZc9De/Z4U2m+i
	 rHKuFoLkRQpHkgjiY0+RPhrIT5H+5eNUr4PAopbwKEwPlr+MhrfCaIHcckj/UgjNhf
	 f/JfjUOGI/QMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECCFCC64459;
	Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dccp: Remove unused declaration
 dccp_feat_initialise_sysctls()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050362096.24970.7000722732893710320.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726143239.9904-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143239.9904-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:32:39 +0800 you wrote:
> This is never used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/dccp/feat.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] dccp: Remove unused declaration dccp_feat_initialise_sysctls()
    https://git.kernel.org/netdev/net-next/c/d4a80cc69aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



