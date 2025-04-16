Return-Path: <netdev+bounces-183056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9484A8AC97
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837EC3BE829
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDA1922DD;
	Wed, 16 Apr 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwSQy9bO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63221917FB;
	Wed, 16 Apr 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762801; cv=none; b=QWtiDFj/XGUjZcHPzEANCIlzXP2FOMfoyt3AXK98MYPVrLh21H6OEliI79EWNc8CY2/mh5ykOdY3/GicKMPKDzhf/6ZAzXDSuCZx9+1XE4OW0Y46c73aNC0pUXVQSCGHFHLTEN4RWhtQxvlzv5+4hWDMv5Y7JxUyjbMo5AG7rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762801; c=relaxed/simple;
	bh=ic8GQvJLhDageRtWQvgdYpJc8sgiqXmhmyNqGUuo838=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MB9SmF7WWSaXZjCOP4noZ6badoRbH38z758xkCd+3gsrh6rZvSvUG6JJeX3BdLKqowVBefL88ZKy/0w18NLAVq13JVnqEsj0ORWpcLNL3PrrTpbmyFD8BMFZTHOEmcrTxnbjDUrOjz1Ds9EZfzDPUhor3izmn8XtA22WMXpqn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwSQy9bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89948C4CEE9;
	Wed, 16 Apr 2025 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762801;
	bh=ic8GQvJLhDageRtWQvgdYpJc8sgiqXmhmyNqGUuo838=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwSQy9bOXcpcvrLHiWAIcN2Y0cR2Z8umo1lZzlBN4oOrmL9f9IOZzjWINAhrP3kKq
	 vG3/zNRMoC72Frw3VluVbjTaAdnmG4iP9sj8bHOZWl3a5ymRqWNIlU2Pw81l0wbXCP
	 QI4967v2GpE0oszz1tWUr256e0+ZrCr8LAbxNyZ4GFNaZRwlSnCe/kHtRbqfQyaWqZ
	 7Gp0sDjV0wDiwRE5VTVwQeF3LNfBqpbxyNk+R8itCLSFrJ7LwdlyVs4Jqis2JQ39VG
	 2ca33LTH+fYQfI0SKVFsXkfE0odcFc7RCEsNuRoU8ujzAf4ZkgsxSV7v9mM7K3Kt7H
	 6P94qp2zzsbCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE863822D55;
	Wed, 16 Apr 2025 00:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-pf: handle otx2_mbox_get_rsp errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174476283936.2824794.16159287732746068279.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 00:20:39 +0000
References: <20250412183327.3550970-1-chenyuan0y@gmail.com>
In-Reply-To: <20250412183327.3550970-1-chenyuan0y@gmail.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Apr 2025 13:33:27 -0500 you wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> This is similar to the commit bd3110bc102a
> ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c").
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
> 
> [...]

Here is the summary with links:
  - octeontx2-pf: handle otx2_mbox_get_rsp errors
    https://git.kernel.org/netdev/net/c/688abe1027d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



