Return-Path: <netdev+bounces-143182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A89C159E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321581C227D4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7A1CC152;
	Fri,  8 Nov 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCdrgELx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF231C6F4E;
	Fri,  8 Nov 2024 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041428; cv=none; b=dEyhZCS9C1HThLuY3QGhzGCJPg9VErUzbU1Owhzu368JIzGBtiJsfmV5N4ZITNUfRKg5MYr67fSndhUiExXbn/eJnNA5XxTcRXWA70mrWw4xT/hKwIGFYqtxbycmh2K3IEZg7AirsAaHV/1NS7647TZ7Drpmw34xRx/S37UR/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041428; c=relaxed/simple;
	bh=GVyTqZObE5wST54uI/4DlNaxxzSOO3n/k0M2+eetc7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ku9KB5fTfMJtGQfyOqG59m61gHmCA0CJWfwafuFJUbdXdluaBVD6Tk01PSqp+auhMnQ8QHXjjhHfRnbJldqqEMSjeCTZ6L5sf1GTFGQRs7VNQt5fH2LGTyMzq7BDFZupXEMFhrpR0uQSUV6t7w6GyzFbQ+3hO80j0WtyfAQmGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCdrgELx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62845C4CECF;
	Fri,  8 Nov 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731041427;
	bh=GVyTqZObE5wST54uI/4DlNaxxzSOO3n/k0M2+eetc7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCdrgELxI0C6cSan1ywiGAUJlZEYK5BjoXE1+OCmG5S4CWNHS+8vNut9QsBz0P783
	 T236Ub7cpwCI5/T7pHMKfJ8xWFCh6i0RAW8yxQlMuyms/4abfB4mFM8PRCGdKsC2fy
	 qtyPmhl8WAogWUR3rDmL+eEX2DCGkKXrKJ1THHvchG1UVWS/veHovbPLadd0oY6PAe
	 FuY4LcepSuOTvpnglNuB+s8l7npgC5cpoUXHDPPv2Ww+g2FI8+gWsuIAfnirbhXIEX
	 xBFsg/VycM4f2Yv2aoC0AOJrCgXhqBhXUf7XDxikgewPl0Yz0cuQkc7N8F3EAKzdAK
	 SNuWCly8QKaaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9F23809A80;
	Fri,  8 Nov 2024 04:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Prepare ip_route_output() to future
 .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173104143650.2196790.14566394622027660463.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 04:50:36 +0000
References: <0f10d031dd44c70aae9bc6e19391cb30d5c2fe71.1730928699.git.gnault@redhat.com>
In-Reply-To: <0f10d031dd44c70aae9bc6e19391cb30d5c2fe71.1730928699.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Nov 2024 22:37:32 +0100 you wrote:
> Convert the "tos" parameter of ip_route_output() to dscp_t. This way
> we'll have a dscp_t value directly available when .flowi4_tos will
> eventually be converted to dscp_t.
> 
> All ip_route_output() callers but one set this "tos" parameter to 0 and
> therefore don't need to be adapted to the new prototype.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Prepare ip_route_output() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/48171c65f611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



