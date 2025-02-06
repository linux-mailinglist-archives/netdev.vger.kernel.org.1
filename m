Return-Path: <netdev+bounces-163332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C5A29EF4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E512E3A6CB9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688121442F3;
	Thu,  6 Feb 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkq3gAFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221928F1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810207; cv=none; b=quCgHx1J7qe1UJtHX0GZhKzSDvi2RPHNONH7BSlhEMpfISyI9Bi2euG/D+IcwWIeFKw0Ze10Xv9AdNiUQ1EOoa6x6UKrkyW9hfYwBo3DZxtRfh8C6XuL6WWtOYwPUyZrMm1kWCvm5EFKexr/Uj6dB//JSw/LOL8X4WuvyGEFVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810207; c=relaxed/simple;
	bh=z45YrxM0rEx5eFGQPAtS2C/UQ3HkBxfuAQPmNVBnU4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzlD/PCTRyQgi/Dzd2eTg0fwDo+wJC66KPv5VUAiMSQ01AQ3i97SgF+en0GGZbInnxqdIwP4tJBi8Bh81HEw2vZf80IYvMGOiOoyTB1vqXfmpt9kWzQ1M7ZaloL+eZsFdI0tZBajXwhLHaRgw5OQq00z0hRJM88kZaUvrbj44CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkq3gAFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E503C4CED1;
	Thu,  6 Feb 2025 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810204;
	bh=z45YrxM0rEx5eFGQPAtS2C/UQ3HkBxfuAQPmNVBnU4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mkq3gAFYFYbZvaaXia5X6ngKZPR5TNfw7k475zS1D88M3DPw3ReOiTGxpVRA8Txza
	 OEGeRxfqPDA4cfIohhtthx4IZCW78LUV4bZ4V0td2FTxCOjAlqBvYLGcmyod21lP2r
	 txqevdWEF6lgh932hAMTAFaGvBKxHO5IbX4GWaN5WUCvD60gDxEk94+rLWE+HbEH7W
	 cXIED8CqpwnjhRnJjVlHJIC7wLGP6RD89XVyl1abV9ujri9TmPTnAsv4ouy4YGTgDb
	 8cR/9oDOp4BexnZHeKrdAseAIXVkT39mCyzXZGeSVM1HyU8iDR+SRg8/YU75NqOjyn
	 v4VTdxdjKuYPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C93380AAD0;
	Thu,  6 Feb 2025 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tun: revert fix group permission check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881023225.981335.17493009005143294790.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:50:32 +0000
References: <20250204161015.739430-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250204161015.739430-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jasowang@redhat.com,
 willemb@google.com, omosnace@redhat.com, stsp2@yandex.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 11:10:06 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.
> 
> The blamed commit caused a regression when neither tun->owner nor
> tun->group is set. This is intended to be allowed, but now requires
> CAP_NET_ADMIN.
> 
> [...]

Here is the summary with links:
  - [net,v2] tun: revert fix group permission check
    https://git.kernel.org/netdev/net/c/a70c7b3cbc06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



