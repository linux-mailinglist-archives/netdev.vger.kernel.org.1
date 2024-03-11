Return-Path: <netdev+bounces-79278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC887897D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF5282273
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC96433CC;
	Mon, 11 Mar 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6rYB0a7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DB40C14
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189031; cv=none; b=ZDtLMnxsTvRUFoZi0rSZuXmVne/T/BGay8qcAfkZiBLlpLpWf1HSEpNeRkrayS17jDEnQZVkxutFIFSjfVA6SAY5S3Ae8e189GtAw2R3B8FSqEVw17FrsEtenOPWyf4uA99n5rfgniNyPklF4by7dZNqszJpsDBAemmtbnz1sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189031; c=relaxed/simple;
	bh=l8uemGVXNgv9DKNFsyTXt66EJ1DbsqY4iOzbwjBXRHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HW4joweyscF32FG9cvP/wAoGfKX4hw4qq5ZkKlYSfPVioQMQH5Rn4FlrRp4oFTdTKKJNDTl43COiSx4ucA9dewBVW8JHKVZW/dPHf8E+82iD51VAkbrSNdkiwfTfrxkLxR+z38aKTeQyDC6Yykb/8U96EUT6x13UORJA8OPLR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6rYB0a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1FEC433C7;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189030;
	bh=l8uemGVXNgv9DKNFsyTXt66EJ1DbsqY4iOzbwjBXRHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6rYB0a7l83+eLGdjQZcJEUaumJepfJqlNK0IKbkpCxb7O4Uw/TPs1RL9uds143ZP
	 rraW739dz9NpYVIwBCpmfcdzGuBKExenLvMspePOu4ET0jtGUY2eO7/ESjVY6qEowc
	 tjJ1+0lj30P095cC/tdMA+WlgEVak9Q95m/S0qLo2V6VJZrx/WEfXrE3DmSQXWZ2m/
	 RAJbTC2QYX63c8qZTddI+/I4jxlzvJffl3Ez4XiMKlbXwT+8NwjfimETF1jKn4XBYk
	 lc3v903MtVnulNsnwvdj+APJwVNBhIutU+QFyO+QiuXG0ftxOGieCOw8TZ8HqGzTC6
	 OOLy26hEJGzpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75952C39563;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next] tools: ynl-gen: support using pre-defined values
 in attr checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018903047.23953.11898489671712287164.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 20:30:30 +0000
References: <20240311140727.109562-1-liuhangbin@gmail.com>
In-Reply-To: <20240311140727.109562-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 jiri@resnulli.us, nicolas.dichtel@6wind.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Mar 2024 22:07:27 +0800 you wrote:
> Support using pre-defined values in checks so we don't need to use hard
> code number for the string, binary length. e.g. we have a definition like
> 
>  #define TEAM_STRING_MAX_LEN 32
> 
> Which defined in yaml like:
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net-next] tools: ynl-gen: support using pre-defined values in attr checks
    https://git.kernel.org/netdev/net-next/c/8d0c314c30c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



