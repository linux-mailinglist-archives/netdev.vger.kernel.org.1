Return-Path: <netdev+bounces-154986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB44A008FE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CEC3A3CF0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B281F9F76;
	Fri,  3 Jan 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB4ZCTUr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C21F9EC0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905617; cv=none; b=kJNEtNN4uxTR9AUFj6YUUr42VorpTCju5tkNTW0yufg7HvDoSEI5Zk4JpVsl4VKyBWnaJUk67Ei6NCTY0tY/K492ZDJ9QtsNEUbJ0cVPg7ctrrKZbqhPOS9kqjLEayuqNHySKbZJqrOw9w1JTZjSRSJOCOSTfiB6CPuVvRY9BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905617; c=relaxed/simple;
	bh=Vpt31kjaJYjHijd6N4CuXbBVwgAn1P3ZIQ33Z7m+mU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XJETgwIuB2d0UC0N8UDlf/qrGJzWVVQG3iH6Vlbrhz0FgK92GKCD2IoJo0LnsTB3eiqA+1/gFckYngxryU8SxE8Dg4phGwx1jnP6+y/Ts4kP43/Qj1f6hZH0S0rAuNAsdo4yNguKxKdo0VYPu3MSiZaWqQDuHe20FyOIqErIbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB4ZCTUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B7FC4CECE;
	Fri,  3 Jan 2025 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735905616;
	bh=Vpt31kjaJYjHijd6N4CuXbBVwgAn1P3ZIQ33Z7m+mU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZB4ZCTUr/fhDF4seLfSResBk1XGcsLniNJlKPt9T7mbwYMHgZKlP6kQuobV9ZhKdY
	 KMFVGrM4+8BzvALtVMnZsleQmZoIGjxs3lE6HlXCAJgAYEH+kdH0YrZ47mm1yXRcHd
	 nLkxo9qEOk8+4aKr26ZnPWevb7c/nTFQmnAXPo9eQ8kJygAdBAEozGEcv61F2THdB3
	 TTQaqZUy+tZ0U5Hphx74hZJcwpkFjoFhRMylvT9VpTNEgEgHNzlblnGZKyd5yPzDCw
	 rcPC8uRE0sQw1+IZ2H52v7VwUW+fbWEyplwT1/gXVdFpCOrfmsy1D5BWCzbF672pim
	 ycl9/+rKTPU1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F86380A964;
	Fri,  3 Jan 2025 12:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] team: prevent adding a device which is already a
 team device lower
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173590563675.2193961.1651665112855074849.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 12:00:36 +0000
References: <20241230205647.1338900-1-tavip@google.com>
In-Reply-To: <20241230205647.1338900-1-tavip@google.com>
To: Octavian Purdila <tavip@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 30 Dec 2024 12:56:47 -0800 you wrote:
> Prevent adding a device which is already a team device lower,
> e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
> vlan1.
> 
> This is not useful in practice and can lead to recursive locking:
> 
> $ ip link add veth0 type veth peer name veth1
> $ ip link set veth0 up
> $ ip link set veth1 up
> $ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
> $ ip link add team0 type team
> $ ip link set veth0.1 down
> $ ip link set veth0.1 master team0
> team0: Port device veth0.1 added
> $ ip link set veth0 down
> $ ip link set veth0 master team0
> 
> [...]

Here is the summary with links:
  - [net-next] team: prevent adding a device which is already a team device lower
    https://git.kernel.org/netdev/net-next/c/3fff5da4ca21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



