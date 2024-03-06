Return-Path: <netdev+bounces-77792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD1873048
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E4C2859F0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1B5D742;
	Wed,  6 Mar 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaDScke9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7B5D49C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712628; cv=none; b=l0yES2CLrg8efcS30H7uwJPQ9CJ2CdKmi3tMh34E9sCQD7zgJR8KVGSnNM6ZFPQBtjycp57XhhY1YkDPPUgsx7p16uesitBTilLEwHlHlqoT3fsrxzaT5rNis5QlhPuBYYfd+oyRSHpN/XTgMjKNe74dYaSbtwj6REaXFUgTxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712628; c=relaxed/simple;
	bh=aTgQRzJavO6oGB9f3kk/p5lI1n8mmwkZI0+MPEIQY5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XhdIS5MBm/6o6aaO/onB+V/8Bg0ybWdxWcVqSppXn15moz5c1OeuweBoUCL63RpiTfPW4nVXOKat8I4BmbKD9zi++ZNZxdhfqQhSuNtJtZllhsJMLPh5RCN1zApVwFMcjDX2iGb5K+fQnHLt283yUHDuVpOAq8mT3zv1SmtEH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaDScke9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6359AC433F1;
	Wed,  6 Mar 2024 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709712628;
	bh=aTgQRzJavO6oGB9f3kk/p5lI1n8mmwkZI0+MPEIQY5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaDScke9iNDiyNS0zfR2SIkTy4ADFxIcZb97z3CRUvEoFap5DWfaSTK3oYKwRRuLW
	 nUmwf10wrksD9ifqOD1zsgyKyK4GvYmMIBX8R77/AXIpdtHg3gnQ7WEfboohXGENhf
	 gMkEhGM2iNb464rXK9HFwg/9t6igU+ZMjIXYt046c3mjXhg2Hz+CsphLdYEdBkbw3f
	 6DGC4CF0DfUo9pQbjF+QSFz5gCYg5EmHL0FViwb/z63eq6j8yd2gWv0DOYq2SoVduw
	 mf9JfSdoRYQLr3YHZ9zPqB+2NaoKjPhUeuohTLRrRVOeCmPy9VDgMZPvCjW46bb+bb
	 +Xq9ZFfzRhniQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47A8FD9A4B6;
	Wed,  6 Mar 2024 08:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] netlink: handle EMSGSIZE errors in the core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170971262828.14675.12431628238899747792.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 08:10:28 +0000
References: <20240303052408.310064-1-kuba@kernel.org>
In-Reply-To: <20240303052408.310064-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, idosch@idosch.org,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  2 Mar 2024 21:24:05 -0800 you wrote:
> Ido discovered some time back that we usually force NLMSG_DONE
> to be delivered in a separate recv() syscall, even if it would
> fit into the same skb as data messages. He made nexthop try
> to fit DONE with data in commit 8743aeff5bc4 ("nexthop: Fix
> infinite nexthop bucket dump when using maximum nexthop ID"),
> and nobody has complained so far.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netlink: handle EMSGSIZE errors in the core
    https://git.kernel.org/netdev/net-next/c/b5a899154aa9
  - [net-next,v2,2/3] netdev: let netlink core handle -EMSGSIZE errors
    https://git.kernel.org/netdev/net-next/c/0b11b1c5c320
  - [net-next,v2,3/3] genetlink: fit NLMSG_DONE into same read() as families
    https://git.kernel.org/netdev/net-next/c/87d381973e49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



