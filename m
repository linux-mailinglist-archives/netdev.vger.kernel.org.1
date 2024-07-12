Return-Path: <netdev+bounces-111011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEE92F42A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54072813A0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9E8F70;
	Fri, 12 Jul 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNY8V4kz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7779D0;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752632; cv=none; b=rtmUH1ZIk8KlyoPIKsU2QvFpADGWcfeqoBKxvBsC4d5LVizHXY7GQOxKgpL9CKZ59vNb8I/zVYoRx83lTt/K/iyUJXgTJtOcBNYZ5Un/M/nONm36dNJI66TY9oImNracMX/e6a+bYtnOxv5sDTlDqPQSWydrGyI4EzCTD3b1KVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752632; c=relaxed/simple;
	bh=LrAQZAn6+hNHEjH9HQH0wqXQhHVzYUfxamYKVpi333w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WhVVKfbUIrP0vfATFFr8uZC1wR5UvqZhd+JDkETmjpZekCX9X+Q6vye1lvcFneowClGfNO4UzHeVZhoFtJctNm+egTqz3rxgMHg1vnesHsBmEDBA0HBCkJJZP+yQG0h1JcFbZw2K7crFHInkQKhutzVTReZ6HROQvkJy0UYqjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNY8V4kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA014C4AF09;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720752631;
	bh=LrAQZAn6+hNHEjH9HQH0wqXQhHVzYUfxamYKVpi333w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNY8V4kzAPLf5Cb58zrmHvQ2EfjPANuaW9OM+qZ2dbK91kmLCibIZ5ljv5QyD1bvv
	 XgU21959cAjtJV8SrZ5w0+34D8S0iaoay+9uhj0nTPcJtBmCfj1r5CR37v6sNpjTk5
	 RVaUbmnLwGhW/OYsb+7638t8r8DRHVnzK3G9/puw3m3flWT65JBvpZ+FMX4n/4tME3
	 iDg26cM5GmxG24RQTYYGSUbSGdLfERPbVGaB1PxS9XfcJScIp0jiSLNFShisGsvMFe
	 oW5Ha2klXFhxk8Q6Z3bkwPm7lO0zSMOy14DBRhO3JRyjga3t2aE49VMVNQAY1ZfXkV
	 37XyJ8NeBdU/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97EEBC4332C;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Consolidate redundant functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172075263161.5411.10236151578796605450.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 02:50:31 +0000
References: <20240709143632.352656-1-syoshida@redhat.com>
In-Reply-To: <20240709143632.352656-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Jul 2024 23:36:32 +0900 you wrote:
> link_is_up() and tipc_link_is_up() have the same functionality.
> Consolidate these functions.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/link.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] tipc: Consolidate redundant functions
    https://git.kernel.org/netdev/net-next/c/b6c67967897e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



