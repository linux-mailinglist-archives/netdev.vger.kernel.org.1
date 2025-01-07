Return-Path: <netdev+bounces-155873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A06A04243
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BFC188A6FE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168A1EB9F9;
	Tue,  7 Jan 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBEjv7xw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFE1F191D;
	Tue,  7 Jan 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259611; cv=none; b=Xj2IL+fcWLt/Jif7zZkdNjo1XiRIFt/SxPXBpCNaDLpfZn+1d/Yv/3BMLjzM17djwjbN3svSF8fWfssegi0DQ2fzF7I2S4HjXInAuT95gaz9fMlUlvIR7bdJHHKGdURs6M6UBV1R/3cXNYuvB5I2w+LPdeC8ahcL8S0+olYFQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259611; c=relaxed/simple;
	bh=tZAnqmiCWOiltU5tuzyMfBofmsQaf6IJVpmbjzzEMCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcVTf0Zv25kJ91l5l/N5nvHb04+KkDi1WcS01FNTwrZufuG/HyrJPlnolI3wBYF3LoGAU72Jf5C+I9ng3syN05yLrq59x8DCJXZwLYOeFvOvb7toreDMXWgDzvKWVF0ex5xKa0+QSuJQrVPOJdgTpS9qKjp9EuqZVbimPxg23Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBEjv7xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F5C4CED6;
	Tue,  7 Jan 2025 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736259610;
	bh=tZAnqmiCWOiltU5tuzyMfBofmsQaf6IJVpmbjzzEMCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBEjv7xwrzZX9yZGWLYhf71reNG+d8NMZJkQTFYnPn5qsxMjNZ3QxlgWc54KZ+Swy
	 2aAoKWs1QcrJTkRp9jphfU19Rd8vC+k7720LA0WnSCf7eAHjqz8zTMHGF5NPkHxvLm
	 jQ4CVaFh61M2/6FbggdhIWNtrYnkRKHF/yftLYiQrDOwatvIzjWHpJnq9QmQnHYsdC
	 0Mv1mIvX25+RmQXlNXzIv/qUKep5KwjplOwxDjXN9w3IFN5cRBc2Cl1tKStGPjSQFy
	 xWGZ5TpM+YZ3xHto/tRc4YagqNi1WyG0PVLrGGEriskYZ27kWAjDM9TnEPucCuJORf
	 OUNSz+JmrISTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2E380A97E;
	Tue,  7 Jan 2025 14:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bridge: Make br_is_nd_neigh_msg() accept pointer
 to "const struct sk_buff"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173625963175.4170472.16906690078040133844.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 14:20:31 +0000
References: <20250104083846.71612-1-znscnchen@gmail.com>
In-Reply-To: <20250104083846.71612-1-znscnchen@gmail.com>
To: Ted Chen <znscnchen@gmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jan 2025 16:38:46 +0800 you wrote:
> The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as
> const.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
> v2:
> - Rebased to net-next (Nicolay)
> - Wrapped commit message lines to be within 75 characters. (Nicolay)
> - Added net-next to patch subject. (Nicolay)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bridge: Make br_is_nd_neigh_msg() accept pointer to "const struct sk_buff"
    https://git.kernel.org/netdev/net-next/c/a1942da8a387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



