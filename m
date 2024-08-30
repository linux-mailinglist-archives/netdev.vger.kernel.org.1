Return-Path: <netdev+bounces-123798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CE9668D2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F3B1C231A8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB01BC07B;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+8DoYMo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDF14831C;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042028; cv=none; b=ClFK2tLjtlJHZkqMe+q6IU4SWUuPfuIfdphmZiPJwk3dq5cfUeotqlOWwwlIMIcbuJnQLGeUdGfafyviFEUCWGuIMh5a6GmOuoSF2lNVNpjfAnL+9x22MAPq+FkHKPpq0C39vmfnQyWahK0cPmBfV9pqsdUNrb0R032Ajn1YOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042028; c=relaxed/simple;
	bh=xuuzjCXLScCTJubP4AKOc4LhbK2I5kcWNWGx83xTozY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLVHo3hJ8GYfJxZjd/yxfDbvb3B8zFHUAM9EG/SkmGIsmCBNwHFpNP0xj2HOWD8uxuDJb3IwDsvL7fYZ1TshNssMu8SNWoZRR07ZqEeOqMyxPBnNUbCTn7AgtQqZGXnANNxxC43ynzjIHMjPPjnu3rMtAnYzbOxC6wYIuRdq894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+8DoYMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A4CC4CEC8;
	Fri, 30 Aug 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042028;
	bh=xuuzjCXLScCTJubP4AKOc4LhbK2I5kcWNWGx83xTozY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z+8DoYMoB76woB/EXrBG+JPcx7mnQaYIsmoNa84ctam/X5lnpLj4VRaC+ckz0V+j7
	 WKaqQ9O6tOju0M+KL+BlURzBkeBLC+Xl6ztJWUHt1fIM7dEGOT887yIq9cgAKKtMka
	 h0nNhB6XveHAO6BFUMYMKZo+jHg+vu5nB2UxDl0eT4OxorBYRy5SvZQuuHP+9Rjb5u
	 wlE5CnmAoByDq72FB4TKgjBnHTwollOII5C9BhPMApujLYUjNN91nAAX/P+mpf2KA3
	 lP7nQt2y1taUsP4KcS5Od+LQ3755V4zqeq2SEsLFvTIDWJ47/pnG9op0cUlQrXdITd
	 q4cFRGGNDzQgA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C79DD3809A83;
	Fri, 30 Aug 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] sfc: Convert to use ERR_CAST()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504202980.2677701.2667578495289558863.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:20:29 +0000
References: <20240829021253.3066-1-shenlichuan@vivo.com>
In-Reply-To: <20240829021253.3066-1-shenlichuan@vivo.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 10:12:53 +0800 you wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> v1 -> v2: Removed the superfluous comment.
> 
> [...]

Here is the summary with links:
  - [v2] sfc: Convert to use ERR_CAST()
    https://git.kernel.org/netdev/net-next/c/74ce94ac38a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



