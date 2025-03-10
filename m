Return-Path: <netdev+bounces-173587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB128A59AD0
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86899188B118
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDB22F166;
	Mon, 10 Mar 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkHFlL5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC222B8A0;
	Mon, 10 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623600; cv=none; b=hudUElV3Z38B/08NLeGEuj/2eQpPNj7+eMSk/lTWBcmSf37hQlh0ms+y00uIzL+Mc9VLo42dBJum/M5IMdl8kbpwQ3uWi5WY5Eax4eJJ4HyvSj53nUiDJ6Coj0VqICAKwIcSzdpna49PS2QFC9VgDaBaDcnpqnvMAuaW461Gcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623600; c=relaxed/simple;
	bh=x1kHn8ZrJGiUvWKSmdLfFza4/6zzmPHAXVTNHowxKss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pXUDuxVqkAk9CQU2lrLLATPRM52c160oDa4d6gfgP2clKHdxs8ILA/UwjVOQ2toB6/HVZmz6vhBc12aX77x0+l7vuvlK+gUMKIfsNJQO3VsJqkFoCAAv2/LjO8rJCaB6MULG+IriTdai+JQgtRftG5QCx0vNM/3xWGYidBlkE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkHFlL5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76173C4CEE5;
	Mon, 10 Mar 2025 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623599;
	bh=x1kHn8ZrJGiUvWKSmdLfFza4/6zzmPHAXVTNHowxKss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pkHFlL5BIS6+xca0rEKcSchVSUKJTyWQTaaYSvc9P5ASJ39ec6V3ZH+4r4e4omwdK
	 WrZYeoX5McZ3W9zVuCK8x7qTFUTDjlQQsabAI/JMITpDrSuee+83meGvbBPIs7jzbh
	 Eea2c0M+Er83MKHsv8VOc9XKvWZDC2kwhrbM6wF7oCKMOyOQrsFa+5NmP06iaPziOS
	 9diS/IgK90PUW+vZvf4ZRsyBvRNA19gxkvF5zUH7MwYa+lnGgRbwzcF6mAHOUSgo2H
	 MSR4bQl5WBIPJWlpXEeKdWgtMdrjwdMVFrc4vEKCo3nhCZNDELARlbDin+xUclFz3B
	 Fk3NAnAV1Yy6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBC380AC21;
	Mon, 10 Mar 2025 16:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-net] ss: mptcp: subflow: display seq counters as
 decimal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174162363352.3590516.2874190652040692999.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 16:20:33 +0000
References: <20250226-iproute2-net-ss-ulp-mptcp-dec-v1-1-4f4177cff217@kernel.org>
In-Reply-To: <20250226-iproute2-net-ss-ulp-mptcp-dec-v1-1-4f4177cff217@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 dcaratti@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 26 Feb 2025 12:08:44 +0100 you wrote:
> This is similar to commit cfa70237 ("ss: mptcp: display seq related
> counters as decimal") but for the subflow info this time. This is also
> aligned with what is printed for TCP sockets.
> 
> That looks better to do the same with the subflow info (ss -ti), to
> compare with the MPTCP info (ss -Mi), or for those who want to easily
> count how many bytes have been exchanged between two runs without having
> to think in hexa.
> 
> [...]

Here is the summary with links:
  - [iproute2-net] ss: mptcp: subflow: display seq counters as decimal
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e3f9681d4a77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



