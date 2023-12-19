Return-Path: <netdev+bounces-58881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62A818745
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26951C235D7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5C171DF;
	Tue, 19 Dec 2023 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwIsy9IC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821A171D8
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D340C433C9;
	Tue, 19 Dec 2023 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702988435;
	bh=KOFmBHc3hyh6kpOwUfVLf+1FC/CqAGSA6Lc6lec1PBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MwIsy9IC0qquib6P+5PXns6z9AtN+kleh8Fl1Bc27aRSagKkYzOQuS6/SqmuCvAvz
	 8OiJS9RwMwkzedhKI6Z/n1OgGS5oeghCXBRIWECLJcS9WxUdVxzpmYLOzdTaUjBNqt
	 3IvaINciQsk0it4txzcAcAxfjPb9HYCDfQP1OdBa1ifQyD/HLnRUz8sIoWYiLYby+H
	 0dLbSwp1BXTLwusHd9muatPswMsvg7CvAwQZE8I6EwJSVzi6xu3WSpsfV6DiE5Xn4v
	 mr6TXLJkBMUy3yqBRKkqlzP3kNp6qLPP5SX4qa1+gh5lJ3SS81NzRmwTcAlV2OkcWJ
	 0n+kC999eBXog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 039B0D8C988;
	Tue, 19 Dec 2023 12:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] check vlan filter feature in
 vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170298843501.32516.14068887881705047946.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 12:20:35 +0000
References: <20231216075219.2379123-1-liujian56@huawei.com>
In-Reply-To: <20231216075219.2379123-1-liujian56@huawei.com>
To: Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us, vladimir.oltean@nxp.com, andrew@lunn.ch,
 d-tatianin@yandex-team.ru, justin.chen@broadcom.com, rkannoth@marvell.com,
 idosch@nvidia.com, jdamato@fastly.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 16 Dec 2023 15:52:17 +0800 you wrote:
> v2->v3:
> 	Filter using vlan_hw_filter_capable().
> 	Add one basic test.
> 
> Liu Jian (2):
>   net: check vlan filter feature in vlan_vids_add_by_dev() and
>     vlan_vids_del_by_dev()
>   selftests: add vlan hw filter tests
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
    https://git.kernel.org/netdev/net/c/01a564bab487
  - [net,v3,2/2] selftests: add vlan hw filter tests
    https://git.kernel.org/netdev/net/c/2258b666482d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



