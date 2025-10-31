Return-Path: <netdev+bounces-234778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13756C272E6
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98D8A3509F5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD92BE636;
	Fri, 31 Oct 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUgTMFaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464218787A
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953433; cv=none; b=HmM0i/UMrX5h1qKQDfZD6XfRm0Z+1AZ5FG3rirQAw33AHv7QaFvxp4lHDdXzHL5h/XwIzQy35MGg00Bw7SLGmRk53/DYfREUem6IekYgwxiNODYAFc1Iz5ZR7H68uee9rh54RtYU51V3Jln5bIOXKG5DK+RNBOZza5C7rthWn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953433; c=relaxed/simple;
	bh=Wd3lwyCWNgLr5SKG/ZyhU44xTPQlON4M3PZn3ywB5HQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n0Ez5vNlaKF6bwHFFXMu8NSZTmPkZ/l+8WJgJSL9WS7o1AR8FDWykH6n0wx6JrY/qB9OkgfZerplMnEX3HyEFMFwmHswfuitTcihPwVdH/QWPF8nXSHXk0DsMH0JvzIz8BW0GAUI0MOf7IPWjtPvTbQztyB3B8AKBwDFZT3VX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUgTMFaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2CDC4CEE7;
	Fri, 31 Oct 2025 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761953433;
	bh=Wd3lwyCWNgLr5SKG/ZyhU44xTPQlON4M3PZn3ywB5HQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUgTMFaUUT2XsJHCMpl7YxUF9dbCs+PA6++Y1yhetbepqlbNdBYBHYqiPfb/OHDZt
	 Qyna5jInJkmr0PXlJsWCQREljDqoq0OLcrRNgdSGSao36aNy1qiCPXDNK8CKdCHYBn
	 pLAGX1TOt+38qgrzevLvntTTGjoLunyP2I5Dn+dy4Ep2oeN4V2qNL1jK4P9tPwatMp
	 TWJUp1pCs/yG6Jd1DqXjhKFftwtwr7q3Z77ygVf4OxE/3K8vMUJRlYWMLi2ekRR81N
	 lO10diNyVPXSrP1phvvKRkyRfRKlYKubOWiWGoZgGtRluIpZOUirUTFkgDfaTSkgVv
	 p4gTFjdUR9PmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4D3809A00;
	Fri, 31 Oct 2025 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gve: Fix NULL dereferencing with PTP clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195340950.666625.9872917114678524497.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 23:30:09 +0000
References: <20251029184555.3852952-1-joshwash@google.com>
In-Reply-To: <20251029184555.3852952-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, thostet@google.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 11:45:38 -0700 you wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> This patch series fixes NULL dereferences that are possible with gve's
> PTP clock due to not stubbing certain ptp_clock_info callbacks.
> 
> Tim Hostetler (2):
>   gve: Implement gettimex64 with -EOPNOTSUPP
>   gve: Implement settime64 with -EOPNOTSUPP
> 
> [...]

Here is the summary with links:
  - [net,1/2] gve: Implement gettimex64 with -EOPNOTSUPP
    https://git.kernel.org/netdev/net/c/6ab753b5d8e5
  - [net,2/2] gve: Implement settime64 with -EOPNOTSUPP
    https://git.kernel.org/netdev/net/c/329d050bbe63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



