Return-Path: <netdev+bounces-116948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587194C28B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF371F20EC9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7B1917C1;
	Thu,  8 Aug 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYDxAN1e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5619149A
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134043; cv=none; b=AdKAibLC7l7vWeyq/DhB6zh/Zj2mPfsu31ECp/dFzQHJ1jhNqopKmkZvkH94GgZnhMHDh8Ursntq4CAg55xMUKkmMe8EC2pbsQKN//ATp9L0ZEdnlSuwdBBhMhf2ZZ4rvNo+NLtb9IOqemekdi6KNHX6Lt/OsnJAiPRa6xitp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134043; c=relaxed/simple;
	bh=4xwC7DItV/brBZNAaaTSCMoso1hzKkTka+72xrqMToE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMUCmJUAkXYksxQlFIO0EB+xTFlrLVW38JOxFHu5H+8+e1qYjkCLkQFmehpAr1uCt3p05fONQTRzPdc4pfbrSqIQrY8ZC0KOy4t/O9u0jzm5Te383HbqGXMQ+J6f+hkQ8cBb4NV80aDiXa1z3OjFfPu/nEsyFBrIJksjVAzN2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYDxAN1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1623FC4AF0D;
	Thu,  8 Aug 2024 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134043;
	bh=4xwC7DItV/brBZNAaaTSCMoso1hzKkTka+72xrqMToE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZYDxAN1e1UHHe7vpB1CQbO42B0nOnKvX7JYsRUHT+ANPXyOCHa4KzQtO0TImRqN0G
	 EmllCLhHeH1kuD0MvobPPn9KCEd+eea6w5UuEljk9AG8KegBqDNEnFlKpFChkrb1cG
	 EErdACMjRnCGl6owRJWlKyyZZmJ8oOB9sbuxWtzCWZoPWYfK9KFFEvj42/HV2sexTy
	 TZshtYbPrST8VNUheVaWzU0TmwkNiwEJGIyUZ/QcFAoha9DON68vhmOJe3hguWJtGg
	 5h1odeR0lP1jRDTTRXGYEAimKg2KgweVX1dG93s6cHxJ3cKZUQOPLgByzGzSWm84kp
	 9jXikGP8a2nZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34060382336A;
	Thu,  8 Aug 2024 16:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: ethtool: fix rxfh_max_context_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313404174.3227143.11979844672648872761.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:41 +0000
References: <cover.1723045898.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1723045898.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Aug 2024 17:06:11 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Changes in v2:
> * Removed unnecessary limit==0 check, since this can never happen
> * Renamed rxfh_max_context_id to rxfh_max_num_contexts
> * Incremented bnxt's max to keep user-facing behaviour the same
> * Added patch #2 to validate the max is sane
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: ethtool: fix off-by-one error in max RSS context IDs
    https://git.kernel.org/netdev/net/c/b54de55990b0
  - [v2,net,2/2] net: ethtool: check rxfh_max_num_contexts != 1 at register time
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



