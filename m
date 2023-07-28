Return-Path: <netdev+bounces-22093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE97660B2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1681C2170A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867C80C;
	Fri, 28 Jul 2023 00:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E318E
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83997C433C8;
	Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690503620;
	bh=Bhb6/QjHl3pEpohK1LtERgTU5IfD+lbygJdn6oIMc+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tOtpyQU288Xh5mpfKrnOyaUEIM0SCbOcQgW4qpHyNFyidsaeItk6OE29vI9yGbWmX
	 96QRld2stXddj3L5G7yiAxilsfinDEBGKhMTJBzY89o90ohl/BL4zqaNzrupch5eaO
	 4ROsvtuN4msPPRL4GPbH6h+zuvFq5zD70ORmWfAb3mAWDddy4E7hT+R/3SMg7AQlFk
	 runwkL8o5YZjOBkyk0viLbs4sL48x4ampgqcFcIn84dzomXCA67pK3L0pBWVMSRk9Y
	 CDzEHZN+4yYIZyc27GFvmh79k7N8nskDAuyh1IhpFgKYWjddxaGLU/Vfk2pOYQK0ZU
	 4KsLmtEhSlJ/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BF70C41672;
	Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050362043.24970.11385005356994975493.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726075314.1059224-1-linma@zju.edu.cn>
In-Reply-To: <20230726075314.1059224-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
 lucien.xin@gmail.com, liuhangbin@gmail.com, edwin.peer@broadcom.com,
 jiri@resnulli.us, md.fahad.iqbal.polash@intel.com,
 anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com,
 neerav.parikh@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 15:53:14 +0800 you wrote:
> There are totally 9 ndo_bridge_setlink handlers in the current kernel,
> which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
> i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
> ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
> nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.
> 
> By investigating the code, we find that 1-7 parse and use nlattr
> IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
> lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
> length 0) to be viewed as a 2 byte integer.
> 
> [...]

Here is the summary with links:
  - [net,v3] rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
    https://git.kernel.org/netdev/net/c/d73ef2d69c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



