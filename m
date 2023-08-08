Return-Path: <netdev+bounces-25619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF51774ED7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175422819D7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261121BB43;
	Tue,  8 Aug 2023 23:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D50171DF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D8BC433CA;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535622;
	bh=cBl/PnPeu7XWK4iCQzRnWGSrHeyrXSg06VIGzy0mnwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dL5HTlODfnmSvu8Hc3f2PIdjqwM57R9qBZvp6GtRFJqtSlqk73gcoLJt3FBF8Ei56
	 ZY2G/plS5RGBZGm7lRsANnfcVwdQB72OUzJ4GJ0z7HWcolBqf2dFI8F1mawjNChPaE
	 fN/Hc7ZWfaw/fRJFaORtqOVKGvt4neujQzwtseOvb8eBNZjUxhofHZU5JSd7NB132X
	 7xUkKPPwsQcw+JQPvHD1rvZnKAgUE/lDm63WpDxjjhaQA0Pjq2w+drCZ5amr4L+pi0
	 iimJz8RcEMtdKrZX+HbHu70Z16zSXtB3yfK7fjhm2Nhf9DNt/GejuaCud8IndD5tW2
	 k0Z2CPn2X8QYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00C29E270C1;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH linux-next v2] net/ipv4: return the real errno instead of
 -EINVAL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153562200.6878.1758021707222375930.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:00:22 +0000
References: <20230807015408.248237-1-xu.xin16@zte.com.cn>
In-Reply-To: <20230807015408.248237-1-xu.xin16@zte.com.cn>
To: xu <xu.xin.sc@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, si.hao@zte.com.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 01:54:08 +0000 you wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, No matter what error pointer ip_neigh_for_gw() returns,
> ip_finish_output2() always return -EINVAL, which may mislead the upper
> users.
> 
> For exemple, an application uses sendto to send an UDP packet, but when the
> neighbor table overflows, sendto() will get a value of -EINVAL, and it will
> cause users to waste a lot of time checking parameters for errors.
> 
> [...]

Here is the summary with links:
  - [linux-next,v2] net/ipv4: return the real errno instead of -EINVAL
    https://git.kernel.org/netdev/net-next/c/c67180efc507

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



