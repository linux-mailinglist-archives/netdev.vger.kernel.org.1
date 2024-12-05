Return-Path: <netdev+bounces-149221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A329E4CA9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BE4283DC0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78026AFF;
	Thu,  5 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2xQo2r0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C423919E
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369419; cv=none; b=Go+DXpipH3PgR4C6+sX/XW2ofPUGfCcDEt+ENpzOo5zGrngU78G5hbVc16uV7lH80hRiorYAB8p7vrGoJSuWzWxP92Pw+G1dhhyvzqE00Kbq+foFXf/McMYZKcy5zqru/Ah2oorfVRIkNA7klo8s6JpmiqwYAyrPbDttfrHUy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369419; c=relaxed/simple;
	bh=s6OxZ8TFjxqSJBe3M1LGJyjWpKCQDvg3pebkwzBXCK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i5ljlgw9yfSPD+lUBO1AOhwIWlFlxGpdpLWXyDC0KfX7Z2sWgkAp+6JF1TFjMsWbSy0VgqtOF3K1MNUaeXTXRCx4wMypPefxt9etdsxUExL3mLz1K6hLFHqZdyyogyRE+DAu6rXO/DstKqd/Nac/aiYJr97veFjs/GCNLyeRdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2xQo2r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE56C4CED6;
	Thu,  5 Dec 2024 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369417;
	bh=s6OxZ8TFjxqSJBe3M1LGJyjWpKCQDvg3pebkwzBXCK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2xQo2r0LKUPWhi9VqhpijRzjCwjH5us1pnAdLDWpysaCO2T7Zd+gbtdYQjJp0nNa
	 iPwAZzJNyIFWprVTrnVRyMdwNITi5/U4b5IQMHsUDU2EKU5ObsPx9AbwygbImUyjaz
	 FNEbAN8wNHipY8GhUlvDe9uIe8XI3rgVv8REejN4MbELwzdXbEoCzlL+cLfRffKB+q
	 56ZXhZUTb6UIbbK63zXnYucaIIqA3zB+CMfN4ZeqNO+gMzQ9qHCOkhfXhzpZZIMM+O
	 fBL+6VyXIg06EclG7f7BQq+U+DNwgCC5ytIv5LhRe4knH/WEeZeqolJCkVIyUqaiY0
	 1rQcyUQCXTYPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71310380A94C;
	Thu,  5 Dec 2024 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] bnxt_en: support header page pool in queue API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336943226.1431012.12687765519874509231.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:32 +0000
References: <20241204041022.56512-1-dw@davidwei.uk>
In-Reply-To: <20241204041022.56512-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 20:10:19 -0800 you wrote:
> Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
> separate page pool for header frags. Now, frags are allocated from this
> header page pool e.g. rxr->tpa_info.data.
> 
> The queue API did not properly handle rxr->tpa_info and so using the
> queue API to i.e. reset any queues will result in pages being returned
> to the incorrect page pool, causing inflight != 0 warnings.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] bnxt_en: refactor tpa_info alloc/free into helpers
    https://git.kernel.org/netdev/net/c/5883a3e0babf
  - [net,v3,2/3] bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap()
    https://git.kernel.org/netdev/net/c/bf1782d70ddd
  - [net,v3,3/3] bnxt_en: handle tpa_info in queue API implementation
    https://git.kernel.org/netdev/net/c/bd649c5cc958

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



