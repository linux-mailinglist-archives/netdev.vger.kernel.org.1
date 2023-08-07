Return-Path: <netdev+bounces-25084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1820772EA7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C3928149A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A601640F;
	Mon,  7 Aug 2023 19:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5B107B6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDAD6C433CB;
	Mon,  7 Aug 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691436624;
	bh=Z/OMo1UUjPfjEoPKUzLHbyn9EJmcX0slC88j3wxs/BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ARARg7OfIUNkZ+JN0AcGjaqsBJXMtGiThQ7368mbWCI5zP92aA4aa0HagXKaqaqjT
	 hWgdKkwVvHOQTR4Ss39UemxsbtOSaN8syCXU6gKYip11q66S+bRY+tVI2su129Hk3K
	 7uMou7Es2ltWrt78sSzn1OzqFEgc1hZ1mMQaYvJArbMvGfxyXYoJ3zKTxopVZaL3B2
	 83pspnZZGhX6chLR/EQmIFKkvOUa3Q0dzzEx1/pATiUPHzbVaRIJL34KBO+MlkdMJq
	 hVhgcEHqiRI4ZdHW2SkdXWyJmFBMEJ9Alu9trJPBuDxicekjBCQtLvTo0/SxW4ki+e
	 sEWWo3jkjBxsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B4BE270C3;
	Mon,  7 Aug 2023 19:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: Fix incorrect deletion of ETH_P_8021AD
 protocol vid from slaves
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169143662379.21933.12591460777341079885.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 19:30:23 +0000
References: <20230802114320.4156068-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230802114320.4156068-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 tglx@linutronix.de, vadim.fedorenko@linux.dev, idosch@idosch.org,
 kaber@trash.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Aug 2023 19:43:20 +0800 you wrote:
> BUG_ON(!vlan_info) is triggered in unregister_vlan_dev() with
> following testcase:
> 
>   # ip netns add ns1
>   # ip netns exec ns1 ip link add bond0 type bond mode 0
>   # ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
>   # ip netns exec ns1 ip link set bond_slave_1 master bond0
>   # ip netns exec ns1 ip link add link bond_slave_1 name vlan10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link add link bond0 name bond0_vlan10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link set bond_slave_1 nomaster
>   # ip netns del ns1
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
    https://git.kernel.org/netdev/net/c/01f4fd270870

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



