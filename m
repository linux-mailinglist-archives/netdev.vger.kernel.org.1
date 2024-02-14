Return-Path: <netdev+bounces-71658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C872B854860
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C475B28739
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216E19472;
	Wed, 14 Feb 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2To6Az2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2641A28C
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910231; cv=none; b=jzRTUhonBltNmA5sjdcYC+9p87RoPVcO56KiQK/wlCxbVQn6BXMwTmr9O4+0tJ92h27q9TqpYKt1OYqBRbpkO1HuyUqssejbD+zIisy0Zuyehz5z1ZbhdpFSoNPy0mpEuKtKx4uX6kx9P81u8ExRm6FcXZvhi6reSYxX4TsIyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910231; c=relaxed/simple;
	bh=Y0ghbHuRv8gxzaOV1DLGRaYHv3eqrpaXu1YYOcOBULg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aej3mo4TrliDwCylof8YHCAVrm2JZWSJZXb8UOHNn1/ICbGoPohF4PH8HWwM0xVD1gHfbfZkWPllfotVD2hkUJMMYFBCuMinhaG4Iw/CVUp7W0AFqOHvM40xGb/GmHouKGYrTuQuqp9n3OoUFsMmL9odBk1HHaSaGsmGAOLEie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2To6Az2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7881EC433C7;
	Wed, 14 Feb 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910230;
	bh=Y0ghbHuRv8gxzaOV1DLGRaYHv3eqrpaXu1YYOcOBULg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2To6Az2CiIZO+S4fvuRlRt/br5jzOSuSTjRBUbkPQI955D4Dqx+/odEQQItGCIWm
	 uzR2oe1+AP4lSzVw57ZWy7pmBhXtG7cF9lNyQs16ePENKHXHM0hShyvjkVIOf4McK+
	 DTxanS39wxgcCnwueIhAZsZWGahyrBnYEWqd7ZxgR8uaYkEjIINYxZbWcZLJVnxEl0
	 BiSvHwpBzS7MatA80MaVVBDzN01tOYCAUVZAlQstoyrJb8NGji24SXZ7Eg8pwoNKX0
	 gHj7ZCfx1pW3LYXXy6ros8aO3K5tVdWfYbjgybic5vAwGNVlZtnrtkCpOLJM/IAWOA
	 f8YMGi0oj9Zpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E487D84BCD;
	Wed, 14 Feb 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/13] net: complete dev_base_lock removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170791023038.28104.15842901505906159563.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 11:30:30 +0000
References: <20240213063245.3605305-1-edumazet@google.com>
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Feb 2024 06:32:32 +0000 you wrote:
> Back in 2009 we started an effort to get rid of dev_base_lock
> in favor of RCU.
> 
> It is time to finish this work.
> 
> Say goodbye to dev_base_lock !
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/13] net: annotate data-races around dev->name_assign_type
    https://git.kernel.org/netdev/net-next/c/1c07dbb0cccf
  - [v4,net-next,02/13] ip_tunnel: annotate data-races around t->parms.link
    https://git.kernel.org/netdev/net-next/c/f694eee9e1c0
  - [v4,net-next,03/13] dev: annotate accesses to dev->link
    https://git.kernel.org/netdev/net-next/c/a6473fe9b623
  - [v4,net-next,04/13] net: convert dev->reg_state to u8
    https://git.kernel.org/netdev/net-next/c/4d42b37def70
  - [v4,net-next,05/13] net-sysfs: convert netdev_show() to RCU
    https://git.kernel.org/netdev/net-next/c/12692e3df2da
  - [v4,net-next,06/13] net-sysfs: use dev_addr_sem to remove races in address_show()
    https://git.kernel.org/netdev/net-next/c/c7d52737e7eb
  - [v4,net-next,07/13] net-sysfs: convert dev->operstate reads to lockless ones
    https://git.kernel.org/netdev/net-next/c/004d138364fd
  - [v4,net-next,08/13] net-sysfs: convert netstat_show() to RCU
    https://git.kernel.org/netdev/net-next/c/e154bb7a6ebb
  - [v4,net-next,09/13] net: remove stale mentions of dev_base_lock in comments
    https://git.kernel.org/netdev/net-next/c/328771deab16
  - [v4,net-next,10/13] net: add netdev_set_operstate() helper
    https://git.kernel.org/netdev/net-next/c/6a2968ee1ee2
  - [v4,net-next,11/13] net: remove dev_base_lock from do_setlink()
    https://git.kernel.org/netdev/net-next/c/2dd4d828d648
  - [v4,net-next,12/13] net: remove dev_base_lock from register_netdevice() and friends.
    https://git.kernel.org/netdev/net-next/c/e51b96243874
  - [v4,net-next,13/13] net: remove dev_base_lock
    https://git.kernel.org/netdev/net-next/c/1b3ef46cb7f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



