Return-Path: <netdev+bounces-22954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D559476A2C9
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BD01C20D2C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E91E522;
	Mon, 31 Jul 2023 21:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23A1E503
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A9CC4339A;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839022;
	bh=6ln8+1FepUmEq0n1wC3+z9xd4PEXVx5YzvZK+JmHd/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CE8z3JqfEwiFZrU9AhZttfPlEoyX1m+bdAygorM+41Y6doM/yXzXSlauAvzEFVfa2
	 gyWJtC5Pu4tNkCiUyAszW+LWLJEBBVIvF/666RU06YOuD+CCuakHGDxbVCImIfuEJL
	 rpEQy6Dgje5vgyBwK63vZpG01LWs2X4VgIByMeoxkBNQRziGnzr3dXn9NZAQRLGvRo
	 VYyNOAHlp9I/e5Ne7l4Li4EqdooS5WY7zOUtMM5aIau+fowRzMBQiTnE7IVbua0Jm1
	 Um0Yxm+eAczuRBnCTkgHIA8bx1tUFYCM+KM8MKrw1RLktkMV20MIrpPIaCdq2WvQ78
	 +kC+43eb2kSWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D001FC595C0;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] devlink: Remove unused extern declaration
 devlink_port_region_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083902284.31832.11392552376480505400.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728132113.32888-1-yuehaibing@huawei.com>
In-Reply-To: <20230728132113.32888-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 21:21:13 +0800 you wrote:
> devlink_port_region_destroy() is never implemented since
> commit 544e7c33ec2f ("net: devlink: Add support for port regions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/devlink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] devlink: Remove unused extern declaration devlink_port_region_destroy()
    https://git.kernel.org/netdev/net-next/c/2628d40899d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



