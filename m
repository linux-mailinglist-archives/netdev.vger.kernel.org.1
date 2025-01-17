Return-Path: <netdev+bounces-159124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B6A14775
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098C03A9C29
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41217555;
	Fri, 17 Jan 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZGFCBia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B525A62F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076809; cv=none; b=pUyHXe1qSHvdIxdw1zgRqGggXrvfbCVlYSbqf7TbFdrLD3Xyuxt2fo6ITfl9TZsBzKUDmB/eVwixJdoj8HjBXTqze0sI76qSQMOXYG5QYhLLmRqSdeSAk2EPqHk9Ir2FQYgjVlB6X4Ej5lMmaDxMlQQhLHNWDOmDEgPRyatKm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076809; c=relaxed/simple;
	bh=1xcBroJtb8l6BTyvgveUlPNYyiU6sJaLGwJVI3Fefcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hOyd+gHA5fDQOo7Lt0gPeNukUeRi3oSnUYnSPhhkmpPzzAVsx3iwKSrx6/ITxOBhyOIhdervrpbOA+ekBv1CTmaEcUm/2PSb+Pi8oDKNwvlyXSxRR9zkK8kyRb9zgrdzmiTW3Sy8pyMmjD5DRPlnOUuGyt6XmfYiGoSt7zjr+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZGFCBia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89338C4CED6;
	Fri, 17 Jan 2025 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076807;
	bh=1xcBroJtb8l6BTyvgveUlPNYyiU6sJaLGwJVI3Fefcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pZGFCBiaCXLHQA9HyKMvwolA+k+5Fwohf9fCYTw5+sDF7PSXO95JQDQAD9KFisolz
	 /sc6sZgNlDxtDzYllthptlF/GNJRyOtkfiJcui+HB6UPHJyf+GP52GY30Ieu6MfWHU
	 YQWuIHKO+szAkrfSxlk+x/ufWeb7ZAb5IP6emhMYH2fA8IO6PHJu+VSIbjDLXU9rg9
	 N8Rk/XnVIKgOhXlNXWOhvFxaWSfATeqtIuXG8g9WZxrv5UDk6IFY8bYsGlT43q0W7b
	 eQKwX0MlX+rYoeaI9cdR/wL+yJhxFiQI5+xlCVXfG0hvx+IoEF5rMmpXnf3YRVQD+s
	 6CZ+3/unSNysA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD70380AA63;
	Fri, 17 Jan 2025 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gre: Prepare ipgre_open() to .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707683077.1645866.16013950168522357362.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:20:30 +0000
References: <6c05a11afdc61530f1a4505147e0909ad51feb15.1736941806.git.gnault@redhat.com>
In-Reply-To: <6c05a11afdc61530f1a4505147e0909ad51feb15.1736941806.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 12:53:55 +0100 you wrote:
> Use ip4h_dscp() to get the tunnel DSCP option as dscp_t, instead of
> manually masking the raw tos field with INET_DSCP_MASK. This will ease
> the conversion of fl4->flowi4_tos to dscp_t, which just becomes a
> matter of dropping the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] gre: Prepare ipgre_open() to .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/2c77bcb344f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



