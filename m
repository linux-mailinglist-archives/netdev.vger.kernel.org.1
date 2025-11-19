Return-Path: <netdev+bounces-239769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D342C6C471
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20BCF35DAE0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5CB2512FF;
	Wed, 19 Nov 2025 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrBovOt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF823C4F3
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516450; cv=none; b=t8QPz8azX7kcsxXxBpf2PNoh2JUWolOmIpbYow40WtimI2sUi1MNbiLn4o6q2L5fzVsZRQEH3SFb7CUnMw6GL9kTCmI9fR7jX+r0eYoRkODPVcCr7pkuuyc4PzMlvs2JAePColQMxqfc1RM6421O7xe2ID4boGdYMuPE7kMLThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516450; c=relaxed/simple;
	bh=xehyABVYmjE5ulmBH2+gyyeTOHSTMjuiNSeBRkjWrLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GjKrf/gq8GS4bn5oPdIFic6QeSWqPBY4reNT0ppR2U9w/3tBX1XbeRCAsd4pIf8O8UihJ0KOgF/1LL77dSMJcQ0c7AT+PJa8bfjEOA/5vuf1j2VreJl06oKnIDcPXSO+VIBNKU29IBIrl0Oq5aU39enNdrXdHGczi+ZP2hfodVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrBovOt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F494C4AF0E;
	Wed, 19 Nov 2025 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763516449;
	bh=xehyABVYmjE5ulmBH2+gyyeTOHSTMjuiNSeBRkjWrLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RrBovOt9jSte3a6EtUWCCQFeyiDf6x6H4nQSvzgVRa12//u2ODnbYTLqgikrT5ezp
	 XnoaoLoGHfG8Ek3kVIpS9mkx84HJH8kZu+8v3hm8ad7It1MXhGIWBI8fT/IZwz3Yns
	 jSbEJbyaJoXJuCZm5kmVx8seW5C0gumSNiav4jSwx9xaQGIg/6MBdT5fBq+acgDPAM
	 mpZw3yvhV8Q0vG5x+88oV1jAjv87WC4TUStDJHbz3rrEPddOd8MM/I74x0hn12CWdZ
	 UhLtEFbuU09z2lclUytbvq2HZyDfGWPCj1qlyZ6OvYsbvJygmCq7CeX8rFB0D/8gpP
	 gIQ0wR3MBQm+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAA380A94B;
	Wed, 19 Nov 2025 01:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynltool: ignore *.d deps files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351641475.175561.981672614189422837.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 01:40:14 +0000
References: <20251117143155.44806-1-donald.hunter@gmail.com>
In-Reply-To: <20251117143155.44806-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 14:31:54 +0000 you wrote:
> Add *.d to gitignore for ynltool
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/net/ynl/ynltool/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next,v1] tools: ynltool: ignore *.d deps files
    https://git.kernel.org/netdev/net-next/c/6770eaad75ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



