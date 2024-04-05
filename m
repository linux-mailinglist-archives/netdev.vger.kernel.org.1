Return-Path: <netdev+bounces-85368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A175989A77C
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C417287924
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556E2E84E;
	Fri,  5 Apr 2024 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol1B1Lg8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118D25779
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358027; cv=none; b=ZeSXuvG5fRDaEy6jJO1MUMJ3nmlkebcDlQdvgdWLylvpBEDOMyAUaFhkWaiijAmWSLZJDWzAgKH8JSn92jsOvD/mdgXny9kAinZZLC6T4Z5m0BZIVqayTYqz3cmcttgVge7mLuRmXQHFKtD/KFqtob2zFnUVm41zTUs8WbkpbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358027; c=relaxed/simple;
	bh=CHogz2ZLMP8Ov7sSpEX1cq/fAWvb246x3aCOJY08LOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UBGXRwmV5vRJAaxeUuvbmw7mpupqFDHp9oHH6pwJez1csqW79pkxJqu+ig0skJJqxZcPMcKpdeYBTlAgL69Z9s0gafXJHNNpXAWBMH7EB4laKXXA9J9UVkg2Txm7toOhkxjo/3sg3S/aKVnXcm7nAqJ5b2SajqSlhgwhL4N2b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol1B1Lg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72790C43390;
	Fri,  5 Apr 2024 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712358026;
	bh=CHogz2ZLMP8Ov7sSpEX1cq/fAWvb246x3aCOJY08LOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ol1B1Lg8n5BTDgCrVKGtWA0VuJa6H1pWOjJ4XkPdYtg/vP4vIjHhOasSc5sJXxy+r
	 vI+mUJ8dHiwqYYocBj1N10MNU8mSIpUAjwHCiR11KYvvcGJgMeKunKdV/J9EDXa83+
	 I0gRskA+DfMuPvsQIbm/NzC5R6FwKO8fqCA5sqaJRgEPgA77zTL0ZC1iPmpOD7lkV/
	 2RB4a8Iorlwz5in1/e2BBUp91VypDJpDwFsDmZdpIXml1Dzgr337bbzFiE+NPcoexN
	 XFdsfZaNbX5BSjpeVF9502Wr14Qk2tZptcf8Tjl6zioJ6aQ2jyb/GIA2/QPABAfhPx
	 iyC60M/NuNd2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB4FD84BAC;
	Fri,  5 Apr 2024 23:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Fix PTP firmware timeout parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171235802636.32554.10388304731554433350.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 23:00:26 +0000
References: <20240404195500.171071-1-michael.chan@broadcom.com>
In-Reply-To: <20240404195500.171071-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 12:55:00 -0700 you wrote:
> Use the correct tmo_us microsecond parameter for the PTP firmware
> timeout parameter.
> 
> Fixes: 7de3c2218eed ("bnxt_en: Add a timeout parameter to bnxt_hwrm_port_ts_query()")
> Reported-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Fix PTP firmware timeout parameter
    https://git.kernel.org/netdev/net-next/c/da48a65f3ff4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



