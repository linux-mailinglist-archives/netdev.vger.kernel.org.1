Return-Path: <netdev+bounces-46172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364D7E1DF5
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6723428113A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DB17743;
	Mon,  6 Nov 2023 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjaM8jKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BC4422
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93043C433C9;
	Mon,  6 Nov 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699265424;
	bh=cH8O/faWsYqOjwz1jzYWNwsmm1sfvjLFRWVbB4lrV9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GjaM8jKfoGPFOvVXmKcccvbul8CZRlPa7rBhIBIKM2sTjbO8GNtCMrTJn8TApooj1
	 qB6w42SQ6HrWSXe8Au6aZnrBkUBmUgdB5gkzkVFqyud+FUrAgVyu4WpuqsLSEQTge9
	 cFfVqlVhFh3uneNaWrJz8aBhcUl7KvVHaubg2wXsMnh7xBtCPf+ekrX+d3lyNDLM9R
	 wz/bRmmFVvcVL2LHsvMz5LmQMorXRmbb80tGQR620esYVmcDVVDal9eLAaAFZiB+Ui
	 NaoWDXPMNkfuY9euamnRUau5nAQNniWNahnBhMYrU3hTWXMqXv36Yy+CTwAlLgO1Iu
	 ziD6qQ4VLyP/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78864C04DD9;
	Mon,  6 Nov 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] bugfixs for smc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169926542449.26451.2583545485943327625.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 10:10:24 +0000
References: <1698991660-82957-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1698991660-82957-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  3 Nov 2023 14:07:37 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patches includes bugfix following:
> 
> 1. hung state
> 2. sock leak
> 3. potential panic
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
    https://git.kernel.org/netdev/net/c/5211c9729484
  - [net,v2,2/3] net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
    https://git.kernel.org/netdev/net/c/c5bf605ba4f9
  - [net,v2,3/3] net/smc: put sk reference if close work was canceled
    https://git.kernel.org/netdev/net/c/aa96fbd6d78d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



