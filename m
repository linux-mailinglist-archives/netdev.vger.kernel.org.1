Return-Path: <netdev+bounces-199548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00864AE0AB8
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DD4A1BE9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB128B509;
	Thu, 19 Jun 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/CK0/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DB242D96
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347592; cv=none; b=Mt8CgesQeTacjIvlrduCvJL3cRt2HocMoe3iHpiQZgjaGZt7Dnmj/QCX3pF2uPz6r5Jh70F+sAZeGNHNJ0R4+x+N/Xlte4Y3A7HcpUWx3zeEhAqozo3jDrnlu8CsUHsilajHIH6XUdnaOLxv39T6YIndOgE1okPQgnwrNqGK+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347592; c=relaxed/simple;
	bh=jV+OZCno1T5pQq8f29xXiDkJq9EOGCSTlU81ln72ilk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUEA37hM8EzrL3+0eDkB0lXgSUEu7PaZFSLnkmTfVhX+nhRAVz2N+3foG4CI6RcKzWt62NPDTDXWF0nbU0gcZpdZv5hYBCmBspXxbGEGdFwnFP6HitM341Y9w1+cfuawTZpFA2GQ7orGFb9MYiqMRPzzXjOPCu0oNkzT+S6WNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI/CK0/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62299C4CEEA;
	Thu, 19 Jun 2025 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347592;
	bh=jV+OZCno1T5pQq8f29xXiDkJq9EOGCSTlU81ln72ilk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MI/CK0/YyCyldQ3UHxDwvcWh+gFyWAXDaWmski7hPotpFAvjr5eu/4gZ0f2rtJ46z
	 US4hxKotdPLGyGK60JVv0WswFpWgHuSexIQqCPDDdlLtkJ+UP8SS4IL8caNprXHFzi
	 pP9CNAS5+eeGfnHT5Xm94lIjWtWculPwTfhPiXimiuGF1mFV0BQzGWHzO0M1caH/Zz
	 W9M3Dv7rdqMDgaqMRad3PmDdJo1Uk+BMjwxxuuRUF5YhRyejh3uMNYYK2D/T2skAQZ
	 LTIBmMXZe/qKU/+86uuW3mZmae6WBesbFL/EcNiImkv9aYc8Ye5eQpdA7ZbEoXvLJq
	 YXfIWnMRBVvzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7A38111DD;
	Thu, 19 Jun 2025 15:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034762024.906129.12155603666888344760.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:20 +0000
References: 
 <20250618-check-ret-from-airoha_ppe_foe_get_entry-v2-1-068dcea3cc66@kernel.org>
In-Reply-To: 
 <20250618-check-ret-from-airoha_ppe_foe_get_entry-v2-1-068dcea3cc66@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 09:37:40 +0200 you wrote:
> airoha_ppe_foe_get_entry routine can return NULL, so check the returned
> pointer is not NULL in airoha_ppe_foe_flow_l2_entry_update()
> 
> Fixes: b81e0f2b58be3 ("net: airoha: Add FLOW_CLS_STATS callback support")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Always check return value from airoha_ppe_foe_get_entry()
    https://git.kernel.org/netdev/net/c/78bd03ee1f20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



