Return-Path: <netdev+bounces-27114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6977A63D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325381C208D0
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C91523F;
	Sun, 13 Aug 2023 11:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484901FCC
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8FE5C433C7;
	Sun, 13 Aug 2023 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926821;
	bh=ni2iAAjZqDrAZpq6CKPkTelTuPTnU4okt5Jamj83+XQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e8Vt168ghgJ3H7UF+hFDdVfB1SuVy6uxcqgOxCg8Z6Uhibh9UCdOT3rAldPHO7JTZ
	 KZFy9E4BpmwXtNRQ5KMfnHnlHw42txhrnR2a9VxS4apBHK2RrEpPVsZlHd9/7bDOSq
	 Uq4d5je8BZCQQOXlt/XGRDTsR8q2i5qnQhKtZb3Xb/dHMNrrxeoDebO2akV+52kS8U
	 vihQ4bSEE9h+Rj9GM0I5I2ONeYOnsbxP9RaM0srUiqoIwwT/TuE5+Wdxo/21S3OMrp
	 TWZFeGzQ9bP5Qfh6NSfmbvvRpdoazh/K7PGDyBc27TcsRVCj8OiIa7i3xCz79KI1im
	 dBEMW5DJoCTFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5FF5E1CF31;
	Sun, 13 Aug 2023 11:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: Use pci_dev_id() to simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192682167.1919.12638086769759586741.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:40:21 +0000
References: <20230811110702.31019-1-zhengzengkai@huawei.com>
In-Reply-To: <20230811110702.31019-1-zhengzengkai@huawei.com>
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mark.einon@gmail.com, siva.kallam@broadcom.com,
 prashant@broadcom.com, mchan@broadcom.com, steve.glendinning@shawell.net,
 mw@semihalf.com, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 netdev@vger.kernel.org, wangxiongfeng2@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 19:06:57 +0800 you wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. Use the API to simplify the code.
> 
> Zheng Zengkai (5):
>   et131x: Use pci_dev_id() to simplify the code
>   tg3: Use pci_dev_id() to simplify the code
>   net: smsc: Use pci_dev_id() to simplify the code
>   net: tc35815: Use pci_dev_id() to simplify the code
>   net: ngbe: use pci_dev_id() to simplify the code
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] et131x: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/fcbb797458e1
  - [net-next,2/5] tg3: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/6ecb2ced346f
  - [net-next,3/5] net: smsc: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/adc4d18538ec
  - [net-next,4/5] net: tc35815: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/ca51d1356071
  - [net-next,5/5] net: ngbe: use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/cf9b107f5fdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



