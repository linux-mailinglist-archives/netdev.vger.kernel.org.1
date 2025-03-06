Return-Path: <netdev+bounces-172683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE388A55AFE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877EF3B1835
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763BF27F4F1;
	Thu,  6 Mar 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of2Hqrjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38B27F4ED;
	Thu,  6 Mar 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304407; cv=none; b=Zh+x9k28FCoFWtSyVrB4AfOi7JPUvwGCeU41LVCqdRXxy9NkIQ/vaAbdXCJ4cWDZgR/GB/vA+dHyL2j+NhU3eVDcpODkmbXTskyseWkajer0SqVM12UJQjEXXWb2AZhGrWSfMhT+a9ounqk4qbEUmW88SCxiHkhcdBbBvj2l06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304407; c=relaxed/simple;
	bh=m8UmF50TIxaBKmRn74j4qmA5RNKASxFdXxdWr+dW01Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sD8KPmrutSXfLrSx+r8LUD1jj2b4jIe8IiyDgA2vi176eRazirlywK/Pd2OJge1NoyJ72DggjMja9E+vVrIlDeS0sQWHbzzzijx8z7WFt1TL6B0/IDNje3JeCwKeB3Xg2EBxHAKC2yafXt+ljRT1q3xhGztDLyVG3rLQ7Bnbsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of2Hqrjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B35C4CEE0;
	Thu,  6 Mar 2025 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304407;
	bh=m8UmF50TIxaBKmRn74j4qmA5RNKASxFdXxdWr+dW01Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=of2HqrjoWSdPMpaXU/FQ5sCfAHWUou27Ym81zezOADsPP+KXo5sPLQo3B6j1nVyIp
	 HFBPZo6N/iKzRlJpiRj6ny7jy5X1R/gATK9bQKICChMmREuNGXO4cqn+4AvD1Oh2WK
	 Gq+TaDDHfJdB24xzjpOoU619QdNipSmyDvbEKedK103/RFZgG7ioUueByePOnXpmZ6
	 PCHBe1gyTxl+X8sr4FWkYjUuQU2RSzaCXl/Nue4tOQ/DhRwtbJ1KGrMQbYwQV1ASml
	 7DsR4RV3dyEmtkjZF4j7Y/owP2E4xDT6GgIwblO9tWbeW/i1sGQ2Kpij+0EKO5tSBQ
	 zuPq8/irhyt8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE8380CFF6;
	Thu,  6 Mar 2025 23:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Remove redundant check in _signal_summary_show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130444049.1819102.9589894161599106166.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:40 +0000
References: <20250305092520.25817-1-i.abramov@mt-integration.ru>
In-Reply-To: <20250305092520.25817-1-i.abramov@mt-integration.ru>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Mar 2025 12:25:20 +0300 you wrote:
> In the function _signal_summary_show(), there is a NULL-check for
> &bp->signal[nr], which cannot actually be NULL.
> 
> Therefore, this redundant check can be removed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Remove redundant check in _signal_summary_show
    https://git.kernel.org/netdev/net-next/c/cd02ab73664d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



