Return-Path: <netdev+bounces-104844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3D90EA81
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50CDB2422F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5F13E883;
	Wed, 19 Jun 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5vJzm1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454213E3F2;
	Wed, 19 Jun 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799030; cv=none; b=L469nqc3VyK/J4U62pHl57qihe4uyO7uAzR4Z8h7RV6LGBJS59+VjhQSl5hUJOQ/aiLIrHgWYG1ssMoxH6b6JSIwiXvLJac0gKMOIWAcEMPmGkJte2Xtc16anDbpYiqsOnmK6MVrHe088pMOf4jKjlus1eL5f10MB1qiuewt2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799030; c=relaxed/simple;
	bh=eZ8XllB65QXIXnBJuHxfuvQ4B/S7xZ1UwZ7cVt0yxJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QrQNK37KbkJdTGYBpjIr00Zy2Hc6Lk8If32RJvWXJEm3GINDJl/We0NCT64S/IdKTnBVm17FqbodNjaxJLEy+DQWM3DE7eFn1qEyi9tkuLl+jkAet2AV8YtkYXV4X1KZHdsRWE9cP+m2OEBY9nFFdDtVQ9wpk28wa22BpN4Xo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5vJzm1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1184C2BBFC;
	Wed, 19 Jun 2024 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718799029;
	bh=eZ8XllB65QXIXnBJuHxfuvQ4B/S7xZ1UwZ7cVt0yxJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S5vJzm1pU8d5CW2yRcActecru3v/w1OUMt0wnzTFls0Z6zQ8ZidgA+h8+5EWa/lJd
	 voIDwWufLb4do86sCxn1qXnultez7qf5zyavycqV5Tm+q6RuK2C9sJedxkXZwPQIhN
	 ik+NFmIWf+D+OusMEUyfCs7vJ32md4voomTke8wO1gsjnEc5EzpPcmmyIPkD7mnzwy
	 cGQzVpcVTGAf7fcNhJ3qyeyr9EJyfmQ+HyodqaX5RL0RRxb6JJaiEEN4L7AKFaP8dY
	 M/udFLTTUFS580QLpQnxxJsPKBjEZ6BGutN3leHmLm5Yq3w9oTNP2nkY++GnsgA3+L
	 nB7+lT0p8gNPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B80B6C4361B;
	Wed, 19 Jun 2024 12:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Fix linking objects into multiple modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879902974.13459.193085214581535588.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 12:10:29 +0000
References: <20240618061122.6628-1-gakula@marvell.com>
In-Reply-To: <20240618061122.6628-1-gakula@marvell.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jun 2024 11:41:22 +0530 you wrote:
> This patch fixes the below build warning messages that are
> caused due to linking same files to multiple modules by
> exporting the required symbols.
> 
> "scripts/Makefile.build:244: drivers/net/ethernet/marvell/octeontx2/nic/Makefile:
> otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix linking objects into multiple modules
    https://git.kernel.org/netdev/net/c/1062d03827b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



