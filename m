Return-Path: <netdev+bounces-239306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68DC66C48
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7A44F29035
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909081C84C6;
	Tue, 18 Nov 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWLXopV/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826281724
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427647; cv=none; b=ilTqNpljqr2ozW43TK8F71m5gWFF/PCtZBa3ciwa1XssyHZmDkOPW4q/I1ghyjaj9gxUg1mLrDwtTY4XGWFWBkdIfQRZiIvJeSFi/vfVUpumqroNy79UfDJe9MD0k+u27CHbpdsrpZ4tZEYnMq0QFfGEQ1tvK5ii8YSyEKbLqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427647; c=relaxed/simple;
	bh=Rseib0rBHmueM9TvLBcBlxlyXvHEAitGPZa/yS8Frq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BSXxawtuGhT7etHZhN5tKdQ7aGq3fTDUn73sX1dpyUVlQ3CvCu9QatbHE73rZtIl/mHVHMEgLiKpci0f7PnJiU/FrZBnA3XwYdeu6hiHsa3L7LtbwTjvFZ6Cn1FvEzb5Hgg1TqHDAyPeTKyBb0dOF8bdoGiNn/uomS42/7gWitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWLXopV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE38DC116B1;
	Tue, 18 Nov 2025 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427647;
	bh=Rseib0rBHmueM9TvLBcBlxlyXvHEAitGPZa/yS8Frq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bWLXopV/ak4/nY2+dslBhkMfFGs+oWHDx0ELxxBte02YE3AodJ6M6Tr05ouoLt6xr
	 mjhLE4JNq0EWElSVwwIb9I36m5mspvOZrQeTpls53ahpDrbB4CGm2PFz/2mDyqW2Gs
	 5Y1dqNXswXJ3pmD/ROiYFe8LIfFd4+LbO6DrJUuZJAWOpIB3gPM+/15l0p0CNOgj25
	 JUmVMIZZ/VupTVYIYxR/bU4+RrC2qyY6ZgxONJZKifTrz6qAt0qETuodiG+g0bM8e+
	 0rWKqhjodej8qLEmdN6pLTLLsA1YWTW18eouOn12ESitdzs9BBIf8NgdhA9V9MdWL6
	 p2JVq4WUWs79Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDA3809A18;
	Tue, 18 Nov 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynltool: remove -lmnl from link flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342761275.3532963.1552896181593873126.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:00:12 +0000
References: <20251115225508.1000072-1-kuba@kernel.org>
In-Reply-To: <20251115225508.1000072-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Nov 2025 14:55:08 -0800 you wrote:
> The libmnl dependency has been removed from libynl back in
> commit 73395b43819b ("tools: ynl: remove the libmnl dependency")
> Remove it from the ynltool Makefile.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: sdf@fomichev.me
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynltool: remove -lmnl from link flags
    https://git.kernel.org/netdev/net-next/c/40ea40853da9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



