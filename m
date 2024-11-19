Return-Path: <netdev+bounces-146101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01309D1F09
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD81F223CE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561314F9ED;
	Tue, 19 Nov 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+dvi4Ed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A914D2AC
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988829; cv=none; b=CFo2PztKtoHIe9vcBdX3/VGA2N/KiTnNS6cbkdYs8gOKANWWm/J+EOusNYOl2cx74XDoG6k3nFMLQW6mKxThvfJtXpUIcKgmUpvTTcYxEzRg/C23d3umUTk8/SqupcyNi9biQk7Kmygho02xIGRfqMrohFJ91SSL/mW6UimCB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988829; c=relaxed/simple;
	bh=Mbr2tetwam6qNPiGNHAPMAyA2vI+KtbA768mBZcynEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KGrlxjCBbFqv7AG8va1H8ppRTDHYsYXGX4/se0SvEVVpABzm9LIq21H22lGlb23T75cz2gZQ1nkXcWUjY2o0Dw71qO08TyHOy5H3NIDcxzzx2JPb4pBMn629AIMZOwNyCi8QUkUQFoQxUn7ukU8jTBh4/TWD6J9ErSK+hyEeo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+dvi4Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E754C4CEFE;
	Tue, 19 Nov 2024 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988829;
	bh=Mbr2tetwam6qNPiGNHAPMAyA2vI+KtbA768mBZcynEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+dvi4Edd2wxNF5whnKJJGJ+QavSoeDtlPDewGQ+oahretR63XQOfltfxVeJpWzwh
	 qDM7OjGPvMdiYdj/IK+Z1x9ko0uayDkCrstVhEabUC405HcTm0FJkDI7Y2tw0V4BUX
	 kCR+UGzYzPFeJaBuR49pif6mE8Ys4OKgiP4hF46cymkToKbv6BQEV1hz45z6+7FRpi
	 gI7jyH/NgOxEDOXrb7kmSi9CGd2ib2hENwgGLXrFApRDuu7CxidErdmbdtlJbgJb2J
	 jzRCU8sM6hlos8mHCu5T68U+EnSlGQ7bmByeIU5AraqIIi6tIR2fR8oQOskBvlq0S7
	 4+Vk8Co3tJ60w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC8C33809A80;
	Tue, 19 Nov 2024 04:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] wireguard updates and fixes for 6.13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884048.97799.2141245625002993657.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:40 +0000
References: <20241117212030.629159-1-Jason@zx2c4.com>
In-Reply-To: <20241117212030.629159-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 Nov 2024 22:20:26 +0100 you wrote:
> Hi Jakub/Paolo,
> 
> This tiny series (+3/-2) fixes one bug and has three small improvements.
> 
> 1) Fix running the netns.sh test suite on systems that haven't yet
> inserted the nf_conntrack module.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] wireguard: device: omit unnecessary memset of netdev private data
    https://git.kernel.org/netdev/net-next/c/2c862914fbcf
  - [net-next,2/4] wireguard: allowedips: remove redundant selftest call
    https://git.kernel.org/netdev/net-next/c/c1822fb64f67
  - [net-next,3/4] wireguard: selftests: load nf_conntrack if not present
    https://git.kernel.org/netdev/net-next/c/0290abc98609
  - [net-next,4/4] wireguard: device: support big tcp GSO
    https://git.kernel.org/netdev/net-next/c/06a34f7db773

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



