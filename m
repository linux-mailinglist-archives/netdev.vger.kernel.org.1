Return-Path: <netdev+bounces-72858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F6859F83
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCA0283807
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249123779;
	Mon, 19 Feb 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVQ7lnoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A424B24
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334425; cv=none; b=e30GhEyaiTdHJ/zrkNV2zWHiFfLyrNKi5A2CJuh2ZJALHM90/KJGDdluWK2AzBy2AIyPjN/Rc1NlJhN1pXf1WA2Q4uk6ZFTTRG3IgBLwr+UweE3qxCG1HjhR6OzkRfbkP+4VlPKhGkScDvS7EA8pnnWVQjAuymLWfn6d9+1HFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334425; c=relaxed/simple;
	bh=y1IttFaIOOz99Mc1ci0EJMtJyi5V4DyFwTFsnnL/+bI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GbRjN+06RDUwGF2qNzHRMjmzj7NC8spj30W6fAA7K7lXRtGz2/5I6EWjDDkw2RyZlUexe8kmOVOda9vI2UywBPd2hvI3fwM0sazyjIzvVSEcUJFu5nYfY7sanAHDGmRxyAxksZMkKr8reAuzQaXUs41y/nxASuQa+h4whcq6nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVQ7lnoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D90FC43399;
	Mon, 19 Feb 2024 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334425;
	bh=y1IttFaIOOz99Mc1ci0EJMtJyi5V4DyFwTFsnnL/+bI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVQ7lnoEkFOjP5AC2rbCaG6DcKwWTdTOM7pOqCnIFkqKvZlUNdF5wUnbzrFcgydQF
	 STNlVstPpF3cSQrp+9jAQI1LuqamTMEN83lePnKDUs18pkNrHnPRbgDoeMg+7GGVXW
	 sSeh+sL7Rpqnc7d9/WXqc+QrRUScmdddVQHTYO9CEPRFigkmhBsdF4PNZ4VQvjbc1f
	 H5f6g1MaISeY2+cBdmD9+W9ANukIsnHg4F906iYOjd1+GvrfjJE7B5JUb+xZhojwic
	 R8YfGChafVpZmX5kzfentN1YP/G3yuV/xamIWg9EJrTOYkMT0N2UKE9zVWgUUMvj4n
	 zFUVjN/6RrBSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14B87D990D8;
	Mon, 19 Feb 2024 09:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] selftests: bonding: set active slave to primary eth1
 specifically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170833442507.21692.17278891729918402269.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 09:20:25 +0000
References: <20240215023325.3309817-1-liuhangbin@gmail.com>
In-Reply-To: <20240215023325.3309817-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 10:33:25 +0800 you wrote:
> In bond priority testing, we set the primary interface to eth1 and add
> eth0,1,2 to bond in serial. This is OK in normal times. But when in
> debug kernel, the bridge port that eth0,1,2 connected would start
> slowly (enter blocking, forwarding state), which caused the primary
> interface down for a while after enslaving and active slave changed.
> Here is a test log from Jakub's debug test[1].
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] selftests: bonding: set active slave to primary eth1 specifically
    https://git.kernel.org/netdev/net/c/cd65c48d6692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



