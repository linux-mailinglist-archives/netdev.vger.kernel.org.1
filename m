Return-Path: <netdev+bounces-24578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B14770A93
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983C32823AF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A91DA50;
	Fri,  4 Aug 2023 21:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04B1DA46
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4647C433C9;
	Fri,  4 Aug 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691183426;
	bh=f1ZI/5GSaHTbKyM+MyTyGpPnedEHT2zVb/owD/GWmww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QwuTpyGVF5i4IdwZ/0gOfGQMDvZU6oVPLu9tuzw4L7fp3pxlJ4gKL8VcF7JrYaYpD
	 H7/2nVoVTDLgwAx6TOussee3AhpK6a8qQVbZ/Ur74OTr/uO3ooN+N9dSGfFcghxNeW
	 7XQaAkyKfjxljZSHe0cS/Nwg/UQvjNfbpY7CNlqDni+V+oVSB1RhJ1LskTh3Oqbeaf
	 aGTSdsemQzytKxbx/Erbp8U5Z8V5RHb0y/IZfjzQV0aCaXw4fhqgNMPpMKDK6LXtvN
	 wF57+NOcOmKZb0DZ6eejb6LdPDSm7u38Rb9zGF/1/lckzu0wmffcg8XpJleQsGNkdr
	 wksXdrDf+nBiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84A39C41620;
	Fri,  4 Aug 2023 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3 00/12] devlink: use spec to generate split ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118342653.21389.4919689125641711755.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 21:10:26 +0000
References: <20230803111340.1074067-1-jiri@resnulli.us>
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, moshe@nvidia.com,
 saeedm@nvidia.com, idosch@nvidia.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 13:13:28 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This is an outcome of the discussion in the following thread:
> https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
> It serves as a dependency on the linked selector patchset.
> 
> There is an existing spec for devlink used for userspace part
> generation. There are two commands supported there.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/12] netlink: specs: add dump-strict flag for dont-validate property
    https://git.kernel.org/netdev/net-next/c/78c96d7b7c9a
  - [net-next,v3,02/12] ynl-gen-c.py: filter rendering of validate field values for split ops
    https://git.kernel.org/netdev/net-next/c/dc7b81a828db
  - [net-next,v3,03/12] ynl-gen-c.py: allow directional model for kernel mode
    https://git.kernel.org/netdev/net-next/c/eab7be688b44
  - [net-next,v3,04/12] ynl-gen-c.py: render netlink policies static for split ops
    https://git.kernel.org/netdev/net-next/c/fa8ba3502ade
  - [net-next,v3,05/12] devlink: rename devlink_nl_ops to devlink_nl_small_ops
    https://git.kernel.org/netdev/net-next/c/ba0f66c95fa6
  - [net-next,v3,06/12] devlink: rename couple of doit netlink callbacks to match generated names
    https://git.kernel.org/netdev/net-next/c/d61aedcf628e
  - [net-next,v3,07/12] devlink: introduce couple of dumpit callbacks for split ops
    https://git.kernel.org/netdev/net-next/c/491a24872a64
  - [net-next,v3,08/12] devlink: un-static devlink_nl_pre/post_doit()
    https://git.kernel.org/netdev/net-next/c/8300dce542e4
  - [net-next,v3,09/12] netlink: specs: devlink: add info-get dump op
    https://git.kernel.org/netdev/net-next/c/759f661012d1
  - [net-next,v3,10/12] devlink: add split ops generated according to spec
    https://git.kernel.org/netdev/net-next/c/6b7c486cae81
  - [net-next,v3,11/12] devlink: include the generated netlink header
    https://git.kernel.org/netdev/net-next/c/b2551b1517d8
  - [net-next,v3,12/12] devlink: use generated split ops and remove duplicated commands from small ops
    https://git.kernel.org/netdev/net-next/c/6e067d0cab68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



