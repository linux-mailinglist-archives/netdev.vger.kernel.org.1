Return-Path: <netdev+bounces-121356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F185195CDE3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB501F24DE7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F718661A;
	Fri, 23 Aug 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfV6Jbzj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF88185B5A
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419834; cv=none; b=psATefvYyjJscaNtBmDFpAI84JjDyFoZ81xsvp0/z/EnE4o8vb0kGAUDrEIU4fXO+XQHnBk2/wGk5ETsscn/F5bjNM3PdgaCC/26ZUWMnwM33avRa4U10U5lJEbMTQIcLElurn/weU7mJN4YCbMio3PCZVcp7LKlWxwR+UCoWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419834; c=relaxed/simple;
	bh=Sr8MyyTDsGDIH6NYWyqO1foVDoL8x8fgbhYwTGZiCe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P14ZLqYYeM4AOWeg/sijmztFkUT9LXMdEszyD7Q+9qEQVUYUUnobc9iklnnIFZxgjIIm15MGUoY7Ce9Kf14bKS82LBJidxTS+pNl4ag+mZDnW1YXSY2VPNtWmmZ0T5tuGVnppfCOW68BwRUCBfRhzHE4oEfpblVnD3TIK+e5Tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfV6Jbzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F5DC32786;
	Fri, 23 Aug 2024 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724419834;
	bh=Sr8MyyTDsGDIH6NYWyqO1foVDoL8x8fgbhYwTGZiCe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JfV6JbzjKJ0ukOiyJg+lf78JN1lI+s2CGvMzCxKPDo0P5r7t8qXVtN9tblSfXWqK1
	 1tgAMGkMaIR9qi2Ej6oRaXmWtuYnsjFDhLbW5/ErXy5g8JiD5/GsZbb4HT5N9PqtWd
	 0CdNPNCBiH/XOBhDCdWHU5+vp8w4K7lcGWJA4osMvj50x4iP2UAuazKCzwGjvoPHyn
	 dhIx072Im11WiJsWnuZs9qZd3OY/r4u0eigGGWSVm8/JxJ6ldPyEYQmIkyRC7CM7zl
	 W1MK+bqx1aQyDWs3WwGTv9eL3RpQXs/QPe9Y4gcseZRIdW1qpHPkyGFVEwravPnKuw
	 JfE+i7dlTYSww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC7BD3804CB0;
	Fri, 23 Aug 2024 13:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] net: Delete some redundant judgments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172441983349.2965533.17962795969149712149.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 13:30:33 +0000
References: <20240822043252.3488749-1-lizetao1@huawei.com>
In-Reply-To: <20240822043252.3488749-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, amcohen@nvidia.com,
 petrm@nvidia.com, gnault@redhat.com, b.galvani@gmail.com, alce@lafranque.net,
 shaozhengchao@huawei.com, horms@kernel.org, j.granados@samsung.com,
 linux@weissschuh.net, judyhsiao@chromium.org, jiri@resnulli.us,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Aug 2024 12:32:42 +0800 you wrote:
> This patchset aims to remove some unnecessary judgments and make the
> code more concise. In some network modules, rtnl_set_sk_err is used to
> record error information, but the err is repeatedly judged to be less
> than 0 on the error path. Deleted these redundant judgments.
> 
> No functional change intended.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: vxlan: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/6ef1ca2d14f2
  - [net-next,02/10] fib: rules: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/41aa426392be
  - [net-next,03/10] neighbour: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/c25bdd2ac8cf
  - [net-next,04/10] rtnetlink: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/2d522384fb5b
  - [net-next,05/10] ipv4: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/4c180887775f
  - [net-next,06/10] ipmr: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/ebe39f95bc81
  - [net-next,07/10] net: nexthop: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/649c3c9b8e44
  - [net-next,08/10] ip6mr: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/aa32799c017b
  - [net-next,09/10] net/ipv6: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/cd9ebde125bf
  - [net-next,10/10] net: mpls: delete redundant judgment statements
    https://git.kernel.org/netdev/net-next/c/fb8e83cf443a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



