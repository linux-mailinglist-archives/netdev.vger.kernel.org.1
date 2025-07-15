Return-Path: <netdev+bounces-206932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE3B04CF5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA73A7412
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDF1DFD8B;
	Tue, 15 Jul 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiLw0qbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1835975;
	Tue, 15 Jul 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539404; cv=none; b=q6nbNFCmv7zgfAoCW9g8C9xFKj1v2U90drTKrWmDDU4amlvfL92QiYrQG7dik3tAYBG1G0zEkLdrIQ2zqYo+LCIFyOlL4XCHNENeY3qQH5vEBe/36n+Tu3COEClxXXg+0zVrS+KDAYqCD3y65iJP5IV33ZdbrTzMFcSeInITd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539404; c=relaxed/simple;
	bh=lcF2G8iCOcu9fTmUjDPhHnqA3nglgQrLc/WE8LvvmjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3bTR+o6pX9Btq98PPAsrVKEsOJg93ni+Ad4paFmKrZkgbJ8QpMPmVvAww3XL/5T5aqli7FfsERz+yi9Oiwzus2qhhedFdhWX6CYT+86o3Ry4Cs3VdaxjcLUKM+Q4JKG1K9kxw/hcr8Q+x2BFIuoLfj0BqQglnqtpTiFX+gpm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiLw0qbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB64C4CEED;
	Tue, 15 Jul 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539404;
	bh=lcF2G8iCOcu9fTmUjDPhHnqA3nglgQrLc/WE8LvvmjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CiLw0qbd6s6aDGlnKRbCYPwh5yaczjnYdHFnfnUO5SKBcVBYWjZPBIVWd1xvCNLTc
	 oWfWYogGovVMA2OK2eGE8s+PR/xBPDGyDgqaQy7rL9sQ+v2Fkk4D7JO/w3C1Mr/rx6
	 TTm9+Z6BVhkGoVxpFc4xWt4OALr9k2qHYct7ycal/1D7ktKD3A2Bp9VvFslXRnHu0w
	 k14jG9JSGDrZfh8fmwEu4v0MzttJGmj7tnilKsoQx0VTPvqNn9W5K1SfTZIfveZHWC
	 +bGxpdMMf8hHizSW1j/RB1VK1lFPnIpIrOu3WmBkRJwnFz0SCdOCoG64EpG9db7f/B
	 kPWhYp6c5y00w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD4383B276;
	Tue, 15 Jul 2025 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/x25: Remove unused x25_terminate_link()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253942475.4037397.690068649003103114.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:24 +0000
References: <20250712205759.278777-1-linux@treblig.org>
In-Reply-To: <20250712205759.278777-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-x25@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Jul 2025 21:57:59 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> x25_terminate_link() has been unused since the last use was removed
> in 2020 by:
> commit 7eed751b3b2a ("net/x25: handle additional netdev events")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] net/x25: Remove unused x25_terminate_link()
    https://git.kernel.org/netdev/net-next/c/08a305b2a5b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



