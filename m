Return-Path: <netdev+bounces-193465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEBAC4235
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26957188B40D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E621423F;
	Mon, 26 May 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3xsJ3yk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9F171C9
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272803; cv=none; b=nvpVW4p68FuHFzbfaKXQZ5C4h8czqDLbbpNfjg4XfPwsL5FIIXtHUqmHQziD63zbh54BVT5PectuYWzKZ0DXSsw9hBJsTD00QXHDCMar6+s87LIfRpyTJIsxgosjuXGCjuP1DrEAeBBe6cz+9RNCtSWQrL834AYNp1jO9A4odmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272803; c=relaxed/simple;
	bh=jHBElsd1qOhdF8qHb5YPbYxPeMvc6EuYrxzUld91V30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwLSkSnvDqno0BkCFOBu11PS4n17odbOLy6NWhrhUnLAsI6HSKpIELzAr67DrYC8aEZByOTiZRADXUx9It7Osy6nE1OGu1gxvpyPUAs/SLuLA78ey4I+8Upv49683k38IGCJdfpCsBOTMK7kTW9SRUtPVMTntBfIsavacT0PIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3xsJ3yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43150C4CEE7;
	Mon, 26 May 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748272803;
	bh=jHBElsd1qOhdF8qHb5YPbYxPeMvc6EuYrxzUld91V30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3xsJ3yk/AQMKhq8Z83QHd6pqRJk1HENLux/XqukRUcqWTresN1t9bEQK69IHHFAR
	 lt4cLT9gWUeH2EVS9KnsdqqtE2DSPvRtGZq836+lu8aMeEbVIuIfL+eknjqKU4On87
	 8bYmR0ldDLirNV9L8aSR54EVLEeaV9VBEmiTS8QS6PE17Bw21xhwEK1TMSpztvccnc
	 kRd1ah5HHppiLz6MxPkjLe576Ufh9ttfszQuQn+hWg+5m4RguDFnY9vgKbeA3Veg+P
	 lr+3ok+lB5qYjvlk1imhLclQ4c5mZyDZrXc7+4ZFnyoNX9rhaHCtFYjX5wVXmNx6c0
	 sQgNrpUXbimLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01C39F1DE4;
	Mon, 26 May 2025 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] iproute2: bugfix - restore ip monitor backward
 compatibility.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827283774.956475.16588266056869229481.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 15:20:37 +0000
References: <20250523032518.251497-1-yuyanghuang@google.com>
In-Reply-To: <20250523032518.251497-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, bluca@debian.org, maze@google.com,
 lorenzo@google.com, bugs.a.b@free.fr

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 23 May 2025 12:25:18 +0900 you wrote:
> The current ip monitor implementation fails on older kernels that lack
> newer RTNLGRP_* definitions. As ip monitor is expected to maintain
> backward compatibility, this commit updates the code to check if errno
> is not EINVAL when rtnl_add_nl_group() fails. This change restores ip
> monitor's backward compatibility with older kernel versions.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Reported-by: Adel Belhouane <bugs.a.b@free.fr>
> Closes: https://lore.kernel.org/netdev/CADXeF1GgJ_1tee3hc7gca2Z21Lyi3mzxq52sSfMg3mFQd2rGWQ@mail.gmail.com/T/#t
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] iproute2: bugfix - restore ip monitor backward compatibility.
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=969817ce1ddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



