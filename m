Return-Path: <netdev+bounces-178475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38679A771BC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B66188DBDD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751941714B7;
	Tue,  1 Apr 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPyp+/aH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511561684B4
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466220; cv=none; b=SkgUV2wrJzHRb9p8mFttnRtDnbQFxYuhSSsjFIo77ZsNm4J2DyExX+xmT4FNTpDj+OajYwiydFe7IKA0dtzTAvQ5TJ9B1KqLZNV8711HzjijTM+meOZEzvr3FN8Unj4VA0sMVzcVZy6mpbjDx0ODiLq8wWSOCuSWxYHLZkTh888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466220; c=relaxed/simple;
	bh=wBb/huNQorYOwrkR/InTr/dW/O721p1IiLxRB2g3+nY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lV34n9gy9X9D2Yvfl94SAiTPW6vttb20oPH6DZiCnRb3JxMKyg1hsvc4KeHhfA0X1F5rEL4FEEpZJ0Ub2/oRlThhNleA4P0QCdQj7rMg2mYCvd4iv8PRMQx1Fy0TrX4JWxnf7E96yPCti+/wEUP4byMFMVfJIM8PNMiYjw0SZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPyp+/aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8597C4CEE5;
	Tue,  1 Apr 2025 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466219;
	bh=wBb/huNQorYOwrkR/InTr/dW/O721p1IiLxRB2g3+nY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPyp+/aHbgDAlsUGQjBGIxzhsXVZbBPFy6G4NJQKr7nXbDb7te7FqXWga5wqvHHE7
	 b8BGUZbEZx6c0JRxOD5kKY+sQ6Fe0ZVB1A3z7Tuq7I5icyBuzuuMJVg+GDbdwNZJL1
	 vrPeMkVD2SO00aCgVQZNjR4dCMXEeeklk09qy6lqoMkvcCN1NUhWhB0+eaUBHFspmK
	 N6jWWGOvn69I0OOJVl9rHMoVAtarFyzwFRlrGb2clceJqQBDKH40jwpyembmOqGQYk
	 h8WS3m9SVY51txVb0SUGPisBNklmXHB+iXaSHLb+wy44BU6kmZBt8JgGCUSKG26fug
	 GrXJtExX+UelA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0B380AA7A;
	Tue,  1 Apr 2025 00:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] selftests: drv-net: replace the rpath helper with
 Path objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625624.178192.4849291086810969698.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:56 +0000
References: <20250327222315.1098596-1-kuba@kernel.org>
In-Reply-To: <20250327222315.1098596-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Mar 2025 15:23:12 -0700 you wrote:
> Trying to change the env.rpath() helper during the development
> cycle was causing a lot of conflicts between net and net-next.
> Let's get it converted now that the trees are converged.
> 
> v2: https://lore.kernel.org/20250306171158.1836674-1-kuba@kernel.org
> 
> Jakub Kicinski (3):
>   selftests: drv-net: replace the rpath helper with Path objects
>   selftests: net: use the dummy bpf from net/lib
>   selftests: net: use Path helpers in ping
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] selftests: drv-net: replace the rpath helper with Path objects
    https://git.kernel.org/netdev/net/c/e514d77334a6
  - [net,v3,2/3] selftests: net: use the dummy bpf from net/lib
    (no matching commit)
  - [net,v3,3/3] selftests: net: use Path helpers in ping
    https://git.kernel.org/netdev/net/c/88dec030dfcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



