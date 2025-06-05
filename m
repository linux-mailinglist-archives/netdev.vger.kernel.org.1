Return-Path: <netdev+bounces-195281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C332ACF2AB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F98161480
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164127587F;
	Thu,  5 Jun 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH9Ry18t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BF275878
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136214; cv=none; b=Vzo2PqkZuXLRpOC9XUGRP1Z9d2XyJFTlO2G+jf6EocLKI0BjCcOHhLVLE/NQklt536FzLuKbkIgnu58+/Fpt5LevrECTmuaQ7MwJQBkCiV8xVAyMnpVJOzekd+XHvAMqxGDwAsIJ2FIRbbX3uOuRdkC3AZ1MNPgqlv6xvtBceuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136214; c=relaxed/simple;
	bh=31d7/Rx2GJfGuO8ffCUWWeonmSKDDVKBFcORPxX9KfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=th0rEHBd2ZnuV2pE5wTQ76VcUluEOjhFqWyOWCM69QIm2mXM1V4he4trYQgfhBmR6YHDwh0k9VLphJAqLLmTAfXZnteqDqwWTEg6RuUerQfbVCs/W8wkFozT2YG7w8UCF/4OWXsNeJJok+aMsL4WZ6MMq95r72L/FagIk54WHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH9Ry18t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC52C4CEE7;
	Thu,  5 Jun 2025 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136214;
	bh=31d7/Rx2GJfGuO8ffCUWWeonmSKDDVKBFcORPxX9KfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aH9Ry18tMmovk10rYV4HyzGNa758Fe+HM6nk7/hrD7vl4y7R/GtvMINwVHcliVlmN
	 WO1ML9tMfa9JFCLnoSjT7y5/O0FbQIySxLi611au+gnEBl3aiigtoL31GOsC0MDOXa
	 M7Epuem6+4EPmhks94x9pLYQ5nfi2Y4lf5wbUDv3plorN6iqIoaIsjhQNAnas3k+7P
	 v/ekq59Gsir3j/Wxz+RlR1nl4bIt1CExuVTlnO/yvW9AHx8pdYQtuKI7FhKdGhnamZ
	 Rxyw010YvhXHdDEbeTnDnIcg5dy2fRxcUouTVrgUP6LQj6FOBkoDoGrZDIAyBU3xPB
	 d00LhfGVe79qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1338111D8;
	Thu,  5 Jun 2025 15:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/1] wireguard updates for 6.16, part 2, late
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624573.3108661.2784863774645566882.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:45 +0000
References: <20250530030458.2460439-1-Jason@zx2c4.com>
In-Reply-To: <20250530030458.2460439-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 May 2025 05:04:57 +0200 you wrote:
> Hey Jakub/Paolo,
> 
> This one patch missed the cut off of the series I sent last week for
> net-next. It's a oneliner, almost trivial, and I suppose it could be a
> "net" patch, but we're still in the merge window. I was hoping that if
> you're planning on doing a net-next part 2 pull, you might include this.
> If not, I'll send it later in 6.16 as a "net" patch.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] wireguard: device: enable threaded NAPI
    https://git.kernel.org/netdev/net/c/db9ae3b6b43c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



