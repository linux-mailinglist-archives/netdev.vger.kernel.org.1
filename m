Return-Path: <netdev+bounces-105651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12991226E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0BF1C23C8E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB43171675;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfcm2llt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76109171662;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965828; cv=none; b=N4xCgAFIcy1u2XDEIjls260fXOnxHGp2GYlFvDm5/VjiUnnv9hWfCeGgSBwHGcrBuJbat1Q03Ub0kEGySNqJh3muA0Hp0rhi0q7kjZGdyvEDyXa+ZJd0ebtlbrHXyB377xjf024YE7zFHa+ViWuW+q+fa3rUG1v+m5RhQOOJeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965828; c=relaxed/simple;
	bh=ilLsJgqvd/4EUF4UNwCkjfwmpf5eLoUqxw8U7NjMprM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L6jNCWp0A33zuMUjYv10VaqsdybPUYXymnh6LNa5dwBz9mfsdrBlYoYvSASpjcT0O0wW86CudRLt3hyP1UFewwQrFUtOXq57TjpJXSy6t44BVv5muh+TQuURlFbh/LCGlXSuYmeVq44gK3NOdGxarAL+nGaC30ihyQ/w+4lBpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfcm2llt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21B19C4AF0F;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718965828;
	bh=ilLsJgqvd/4EUF4UNwCkjfwmpf5eLoUqxw8U7NjMprM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kfcm2lltr0Wgx6KuPSyF9ZT+kUXf7Bjtmv0C9jMhSlh5RCDpi+UELwKfwEtJqQ2kH
	 cX7NkL5dhRidbQX0DqwZ/GH/a/fT9fMwk/wZoqWG11TX7FPFbbaLTfyqOfMJQ04eV6
	 t6AZawREOMO9broocb6exy66g5GJLKTSiHFzaKkRbxKsNwEmCjz9cF/43x00t7JF0r
	 I1eQphqtBfcFjz83nsnjq236cfCFqAJGhfH6DYQUlIDsxKx5HwTh9fawQaey40HAXC
	 XPx8rRYJSbbP0ItZ11nZlhH9/eY1udyj9tYgaHDuI2CRIE6E0Ndc3jCcH3US5132fN
	 at+JwmeYbcR0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15F2FCF3B97;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4] octeontx2-pf: Add ucast filter count
 configurability via devlink.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896582808.421.9486570187185667040.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:30:28 +0000
References: <20240620085949.1328937-1-saikrishnag@marvell.com>
In-Reply-To: <20240620085949.1328937-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: jacob.e.keller@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 14:29:49 +0530 you wrote:
> The existing method of reserving unicast filter count leads to wasted
> MCAM entries if the functionality is not used or fewer entries are used.
> Furthermore, the amount of MCAM entries differs amongst Octeon SoCs.
> We implemented a means to adjust the UC filter count via devlink,
> allowing for better use of MCAM entries across Netdev apps.
> 
> commands:
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeontx2-pf: Add ucast filter count configurability via devlink.
    https://git.kernel.org/netdev/net-next/c/39c469188b6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



