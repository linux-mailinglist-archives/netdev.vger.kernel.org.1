Return-Path: <netdev+bounces-96840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F958C8005
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1046D1C2197D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96012E74;
	Fri, 17 May 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csYbmg0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C489B669
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=G4vKmkWsvT8AVYQsaa2CKqt6Nf4dpalJOtXO+Sh5S7KuXh26EgehJfRsAlZ5HTcO+qHnZeQlFcv0nicSej4Vo5V3sAF2a7uhZYIcAFRbbOBWGdXhSA7sgpNv99vi8iQcWjo/ec9Mndkjbl2ARhI+Fwas1UDf7xoaBz8gsztc0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=SHqio4WfxXLqifnLG4eCT+zNvwkEk76/kgMga5BPlaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKRHryFGgKyryxf4Mvs98l4cpjeSJ7ow1EcWXymRKXxSZI8uyINkuW6AultV6qNssO2s00qlD2k4DCzIQvuMKOVYfkM+1oTWyHodkEoNaWd1xZ2VtFV4kRk1dsCqJ6S1omuPVq/sHzKgv1w5C9U3toB61u4Rzxmc+8rfvuTI28M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csYbmg0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9224C4AF18;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=SHqio4WfxXLqifnLG4eCT+zNvwkEk76/kgMga5BPlaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=csYbmg0VVsRMr/2RRr4E4Vcvq0zis9QzYkrLFq3xm1C1L8Zvg/96c9+KfWaZx5BYu
	 FSQlti2wMj9IDekmG96xr41dbDr4DUVuBOAIJ/ZEB5VLptNTO5R+j/sG6suFP2mEBy
	 BEsKGQc6RUp75lMuJA+BZ02szKbBVbLvmwknLx+5RTILD1IFJI9mS96qr3OEmom3XY
	 6w5NEGmJ/MGkv2HIoSQSTvnt+DPRv7k36FNST1QqS8xOoYKVJiZ/4ALBOXXTYo/vgV
	 cND7DBD6IipHd8a94T2dKTpGfwrQ/yLNCiT/SjiRtt203/kjtnTdIwmAYBeK8XEKcF
	 6m6wEWk8JALTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E05EBC43339;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix oops during rmmod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363091.2697.9604987777267153805.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
In-Reply-To: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 shaozhengchao@huawei.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 15:57:29 -0400 you wrote:
> "rmmod bonding" causes an oops ever since commit cc317ea3d927 ("bonding:
> remove redundant NULL check in debugfs function").  Here are the relevant
> functions being called:
> 
> bonding_exit()
>   bond_destroy_debugfs()
>     debugfs_remove_recursive(bonding_debug_root);
>     bonding_debug_root = NULL; <--------- SET TO NULL HERE
>   bond_netlink_fini()
>     rtnl_link_unregister()
>       __rtnl_link_unregister()
>         unregister_netdevice_many_notify()
>           bond_uninit()
>             bond_debug_unregister()
>               (commit removed check for bonding_debug_root == NULL)
>               debugfs_remove()
>               simple_recursive_removal()
>                 down_write() -> OOPS
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix oops during rmmod
    https://git.kernel.org/netdev/net/c/a45835a0bb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



