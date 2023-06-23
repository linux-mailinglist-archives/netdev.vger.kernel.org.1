Return-Path: <netdev+bounces-13306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA673B346
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069B02819FC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86D184E;
	Fri, 23 Jun 2023 09:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C33D6C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65EADC433C0;
	Fri, 23 Jun 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687511422;
	bh=9qt3NpXo6vZh6lvewEfm58QYAoaKHCqno0C2Cxrw2BI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eB0kCe4EwvLlBVC5068iUtCE3f8T/w93+i7aeo4K6RK8l72jf0xz5hEPwZTVAPoaH
	 lahRqk/UDiHsEhX1NjZNg7nIq0ucZWkorWg/OfMeNMBqyF8G/r1zijGENJn8xsAr5L
	 ORJt4G8VMwQu0+L4J5wILVANY+zU379sScrYhcTFU7Tdy94amZTnJA3bzB4vsf0unh
	 v1+kTRi8iiA8zimSZLo6xLIeI4unDIVMsrVSteyj0oeoHHSMstC8Ubaq563oM11cdH
	 3hO2ZVndr/Q9NEKHX9lzTZnUG1DlcGCv3Mg8KcF9hO+bHnsORnIAEnPE+JMiapurNb
	 nI7lwqp8HG0Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45464C43169;
	Fri, 23 Jun 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: hns3: There are some cleanup for the
 HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168751142227.25488.10355722983066462058.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 09:10:22 +0000
References: <20230621123309.34381-1-lanhao@huawei.com>
In-Reply-To: <20230621123309.34381-1-lanhao@huawei.com>
To: Hao Lan <lanhao@huawei.com>
Cc: netdev@vger.kernel.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, wangpeiyang1@huawei.com, shenjian15@huawei.com,
 chenhao418@huawei.com, simon.horman@corigine.com, wangjie125@huawei.com,
 yuanjilin@cdjrlc.com, cai.huoqing@linux.dev, xiujianfeng@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jun 2023 20:33:06 +0800 you wrote:
> There are some cleanup for the HNS3 ethernet driver.
> 
> Hao Chen (1):
>   net: hns3: fix strncpy() not using dest-buf length as length issue
> 
> Jian Shen (1):
>   net: hns3: refine the tcam key convert handle
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: hns3: refine the tcam key convert handle
    https://git.kernel.org/netdev/net-next/c/9b476494da1a
  - [net-next,v3,2/3] net: hns3: fix strncpy() not using dest-buf length as length issue
    https://git.kernel.org/netdev/net-next/c/1cf3d5567f27
  - [net-next,v3,3/3] net: hns3: clear hns unused parameter alarm
    https://git.kernel.org/netdev/net-next/c/ed1c6f35b73e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



