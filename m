Return-Path: <netdev+bounces-147934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634789DF365
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F5162D41
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29A1AAE2B;
	Sat, 30 Nov 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVPEPbMW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8E78289;
	Sat, 30 Nov 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003416; cv=none; b=ov+peB6qz5lKGdgwuq95oDrxZhmJAWvuaJqBjC6C7LBISWzNRDUoH6S56BItIRFJ9LsoFYp6P7xA4q7NFMofQtPthlNIVsR87YcciGCfJuUkRehIy8pcb19mjtjTLhKHEn2PItaUmqX90ZbYj525hs4Fq2kyqHPPUerLD7er8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003416; c=relaxed/simple;
	bh=J3c3Hk9Cl/2Lpq+VpH8VoEoqPHas3sugXyD+hSCLt78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3JYoXbqv9SLiNFSAbFJuTuU8XjLNKqoR57JIu5uIuvM1zeFrvK0JeBvxaX+TXn5aUKHwRXQizzTzBvkfXJ+296FnFnX+DmkTDlOOz/RtpsYRnKG20Lz7iFh+5DEIHNCBdlzVtCz+/urtQO0GAThfCKsi7ODbbladGdlNFAzj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVPEPbMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48AC4CECC;
	Sat, 30 Nov 2024 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733003416;
	bh=J3c3Hk9Cl/2Lpq+VpH8VoEoqPHas3sugXyD+hSCLt78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVPEPbMWKdJvg2K2N8lrO1owV3Lmu1Gla4rlopG8QzCY7dwXnZ51FHQfAi7TBbKpb
	 1bZ9ypD9+0e+CSODcmPYH8yyjxVpajBvXbafIzwz/NRMG9c/V2Zg5xX9RtGfjBB7pR
	 lBFRBGux0jd5Cz3yDDjBluzXM3e+LhKgfdr0/9yep5xlQKMDWHOuTxKtE3WiAizk0u
	 L2On0TKyGQhNKT7ZOarAAOd8mGrkdUg0eFJn0BJqgHEUhGb8HXsAgoqpj0FEtdcTkM
	 ttzrPpWEUIVczWYhuVvxRJiU4+FaeJlbMqzaX20uSxWiBpYOp8Z2GI+0g71nrSkSkZ
	 zUtpJvrHBDAKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10F380A944;
	Sat, 30 Nov 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH]  ptp: Add error handling for adjfine callback in
 ptp_clock_adjtime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300342976.2487269.12573512762481068076.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 21:50:29 +0000
References: <20241125105954.1509971-1-ajay.kaher@broadcom.com>
In-Reply-To: <20241125105954.1509971-1-ajay.kaher@broadcom.com>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nick.shi@broadcom.com,
 alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com, florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Nov 2024 10:59:54 +0000 you wrote:
> ptp_clock_adjtime sets ptp->dialed_frequency even when adjfine
> callback returns an error. This causes subsequent reads to return
> an incorrect value.
> 
> Fix this by adding error check before ptp->dialed_frequency is set.
> 
> Fixes: 39a8cbd9ca05 ("ptp: remember the adjusted frequency")
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> 
> [...]

Here is the summary with links:
  - ptp: Add error handling for adjfine callback in ptp_clock_adjtime
    https://git.kernel.org/netdev/net/c/98337d7c8757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



