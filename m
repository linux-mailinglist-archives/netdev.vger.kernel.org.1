Return-Path: <netdev+bounces-151285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924E59EDE5B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD47A16805B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51282166F1A;
	Thu, 12 Dec 2024 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCmmmChd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C0165F1E;
	Thu, 12 Dec 2024 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977216; cv=none; b=i56aP2Cvci2QH7SYh6wAMNVAk8PhWq5ETkdCT+9Qf2NxSu1QdW/vy7c0nh6cbeFFnE4+i+rBMYmtSmsB4CQe+/xtoV1k8sNF2gzSe2U3eHgSV5IpD7PEwgQf4vHo5mXI40+rXMO2Mk0cmbbgSQ6+WIyy4f5AJZ86uPoCvgcVMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977216; c=relaxed/simple;
	bh=CnOw6bIP2Y4H6+0IOnxONqWj19O+f9B9g0oSTmEZXVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jpyR0k+OqILkVa/lBE8IVWnpq4cVX4GPWfcrV1U8PQnlCGzzxiu3gwrQGYi4Xwjinx3UP4noHQZU01VADYtpeIqqQ/c4Nvs/rUtklHCA6MGjOsB7YRjwvi587B0ieDUtv+J+lD/L7hsLK5U1xfhuwGMpDr9v5f+kvxA4WjxnzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCmmmChd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F33C4CED0;
	Thu, 12 Dec 2024 04:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977215;
	bh=CnOw6bIP2Y4H6+0IOnxONqWj19O+f9B9g0oSTmEZXVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCmmmChdBcsfVrdnObn4NExFNai9EgDF7NhbytoAATCaRixK/RyKcDjE6kXZnoCr6
	 p7OdTrq7qrrzHmxtiSCIkgx+t6UoQCgEaY3Bvv7uOPtx8jN7njAbc/WRFzEe+V2vW9
	 hggQlIDGnKywqGP0xKadRimdF5rYNjjMcarkX0yQc7ZNTtpP/A7LS8SuY6xJw3SKj1
	 6PUIT9IFrxnmvdfwTOPNG0rR4o4DpWkhztYRuEUW8X20FubMaby9VR6Co1GNW7WUwj
	 A+ZUV0fP0j2fYkH7s3XMln+Ko87oo91saq19yG5k5MQ5haYZ5h4X9B4LwkKy6hd4AU
	 CKFhEAjaCM7kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD69380A959;
	Thu, 12 Dec 2024 04:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Remove unused gve_adminq_set_mtu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397723152.1845437.8329650886147614818.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:20:31 +0000
References: <20241211001927.253161-1-linux@treblig.org>
In-Reply-To: <20241211001927.253161-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 00:19:27 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of gve_adminq_set_mtu() was removed by
> commit 37149e9374bf ("gve: Implement packet continuation for RX.")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Remove unused gve_adminq_set_mtu
    https://git.kernel.org/netdev/net-next/c/67571036635b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



