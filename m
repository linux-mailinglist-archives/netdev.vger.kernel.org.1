Return-Path: <netdev+bounces-213135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE25B23D66
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB8417C23D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55C166F1A;
	Wed, 13 Aug 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmtwHUx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F92AD0C;
	Wed, 13 Aug 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046799; cv=none; b=idsTA2WmHlK+y973Zz3G6trYFcV4ukFtglKfKLCE+GtUifE4+0OkbDr6YY0OnT8JfolzteNlX4We9vAIDu7RBUod6xBqY3bLHC45+FM+SE/ud8sjKRUL5EfioosLVLxLK5JryybNsLvA5FaLKiyAEmn1Fsmg1DAKeiBVd4SZfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046799; c=relaxed/simple;
	bh=fSetQkEYt/FHJZ9y5Bd1h7hrstkaVMuQlUr6iAEhyP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ry3ic174M1kBiGr8UXHyz1zXMBLDqvfq17CBdjerTepQd24hsOdoSjOsWZKQdmtHMO3GBr0swtUf9ihYv+L5s3OfuKKS0LdpLMCNvGC5+rSxmfdgT1GH5puW8aDKi0DxbTA3lmc9lV1a072G18LwtvYrrn9EY0hDIQVzELyJKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmtwHUx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10082C4CEF0;
	Wed, 13 Aug 2025 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755046799;
	bh=fSetQkEYt/FHJZ9y5Bd1h7hrstkaVMuQlUr6iAEhyP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YmtwHUx10X9ehOsipUQtw1WgoMtHuvcVUjp/36nB4OgnvKD/c8gxLO8brcCUT+BHy
	 sCwgSP33dxRuZb8NmcWkawY+L7t0pL9b6iBAWXEXFfwkfTZVZmdEdUNKFLCRd5wl2q
	 1lMMKoDWXdpWI8dGkbuNfYqYQgoEJR1xat68y4QKaCG2Xlsxg+gVQUrO+uSjPtf6ax
	 iG5tdCk61EKiYXkVU4yIs5tHSE+zYzM7QktDkI9TiJOYswJpuHCRKlrF8mSEF/FzZY
	 bkFsL/sp/kSPDmGk+6dYHURWmkqXlloBwBIKUj7VXog+pgzjeIgvE96b2GX+0PmFDy
	 H23nXMhX/Qt7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8039D0C2E;
	Wed, 13 Aug 2025 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] netconsole: reuse netpoll_parse_ip_addr
 in
 configfs helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504681100.2908717.15523966877694857156.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 01:00:11 +0000
References: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
In-Reply-To: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 11:13:24 -0700 you wrote:
> This patchset refactors the IP address parsing logic in the netconsole
> driver to eliminate code duplication and improve maintainability. The
> changes centralize IPv4 and IPv6 address parsing into a single function
> (netpoll_parse_ip_addr). For that, it needs to teach
> netpoll_parse_ip_addr() to handle strings with newlines, which is the
> type of string coming from configfs.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] netconsole: move netpoll_parse_ip_addr() earlier for reuse
    https://git.kernel.org/netdev/net-next/c/fa38524ca5a7
  - [net-next,v4,2/4] netconsole: add support for strings with new line in netpoll_parse_ip_addr
    https://git.kernel.org/netdev/net-next/c/364213b736e3
  - [net-next,v4,3/4] netconsole: use netpoll_parse_ip_addr in local_ip_store
    https://git.kernel.org/netdev/net-next/c/60cb69214148
  - [net-next,v4,4/4] netconsole: use netpoll_parse_ip_addr in local_ip_store
    https://git.kernel.org/netdev/net-next/c/4aeb452c237a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



