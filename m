Return-Path: <netdev+bounces-167983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10175A3CFEF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E51218942D8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC51E503D;
	Thu, 20 Feb 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqRWR8Jn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533B1E3793;
	Thu, 20 Feb 2025 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021019; cv=none; b=bbq1RgaijEM3kL1kwmRG/vs/xiMIrkOW81RsCfhWACPIiF0cQ/ak4b1I0CRVZx4F5qmj5nxnf7fuoS86M0fvBvpACiYOfMVhjUYpOm7aQTEA2rJj+LimBqQ5ABjgkJz8ryqrY+B2M1pD85eWPGECHrMRHQQ7ITyOMuBRLaf9fg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021019; c=relaxed/simple;
	bh=6c1X4TEPxSY/fEZfB4I5XbwylzMAZ7aJTvTLzG/oHhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bFxXxk1vF2GtK4IU5CxCgSSHYtV8qEEtLsHBgCBFmDG4JCjhq1Do5fO/l8oAg8SZF7C+6nMU/RnpjYMukC+m/5XOc93kcFSuocZBDiB7apqv04DifEs7zlxSFRrA6hFCe4DNAuTwffwP3LfBgNjeQ86hdrmZQ8IhCYOo+vk/A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqRWR8Jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F54C4CEE4;
	Thu, 20 Feb 2025 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021018;
	bh=6c1X4TEPxSY/fEZfB4I5XbwylzMAZ7aJTvTLzG/oHhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iqRWR8Jn+EKBmffZEwZIEb8TeUNhHNlasJe44WdC/sXMmB00AStzge5fGuzMcbFi6
	 DgAupt6JKaXioW/Rm9SDYI0bNEr/J1QDnPmZwEb0T7nfJLcY98gaIti5qRS6jv8KWe
	 VebV+4NDQHgY1nrgct9BiMApjO4bXbw8HmVV53Qvb8pZgA7iYsXwf32eIY1UB9E9KB
	 Yi+SWyz+QWCHxcmtmU9b6mdYMNUbsj3UvNmjNyu3lRm2m1b7ExnsHTb3cS7c79t4ii
	 1ZucupZD3zMV4D6Zlxczz/3stQa6XiQ6iwzhiQ+oUmPqLA/wLU9gti/I4A6cgGpGXV
	 fYeqULiJb+5pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F27380AAEC;
	Thu, 20 Feb 2025 03:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: hci: Remove unused nfc_llc_unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002104899.825980.12756293699855359450.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:48 +0000
References: <20250219020258.297995-1-linux@treblig.org>
In-Reply-To: <20250219020258.297995-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 02:02:58 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> nfc_llc_unregister() has been unused since it was added in 2012's
> commit 67cccfe17d1b ("NFC: Add an LLC Core layer to HCI")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: hci: Remove unused nfc_llc_unregister
    https://git.kernel.org/netdev/net-next/c/9a6c2b2bdd5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



