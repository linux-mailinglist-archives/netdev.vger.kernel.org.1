Return-Path: <netdev+bounces-97948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5918CE3A3
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C21C21055
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129085277;
	Fri, 24 May 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1l+Naew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7E7E59A;
	Fri, 24 May 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543631; cv=none; b=AicfR3oTQEReolJIJiRGCqO/ICbbKR9W7QBWAmK+owsD4ez6Tmvo403uWkohcy6JdQ4N/0lSaNVMay0VIaE6F8L744XxJEsZf2lGqzEoa3icET4hK2yDiczQOTzqoVOzvugeUWLlfEME7n4xBjd79CN1G49EXU6IjbI/YR7PKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543631; c=relaxed/simple;
	bh=V/rsDYTkJG8VOL9PNBVVH+iVu1471LNUCOUuL7FB6EU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aDEGsW2NTr2p3CIoem/n0VPpeW50CktLVRW/phW7m1et+6D6eK6neq5AFFNDtkwPRqRcXVskzw1qqhIhxKhFiX6nyxXMmpPUhvvKYjQc5A8ZTTdnUFLNbgQvWMecvGdKMxUbNL3s1Oj2H9BGy43yu2CHDQvX1gBaIu1zWDpG7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1l+Naew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56AFCC32782;
	Fri, 24 May 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716543631;
	bh=V/rsDYTkJG8VOL9PNBVVH+iVu1471LNUCOUuL7FB6EU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o1l+Naewg7k7t3tx9UBPvcCHRQPxev9GgtCeJfOdWDA6oiOi4S/YkwDY35fOhs6Xz
	 +vYSyudpfCNmFUx9gqUr+NpudZB6e0AsVjKH4+EPpLIk1UggxgZ4Dys+Mp4F269qXt
	 oxZi1kcvilkMwCz2JP0uXNmsnUgGn/p6PtdQ0R7XlXCJUR/DSA07/cg3c9RRtjwrpg
	 boCyHt/mkiKD9T1bDfWJivS7B+l3inKfwYm1V9t6FO+aXauWgnBmydI6TIx9HlRZ6L
	 CnGtXqjZQqgjDbI/Q3jIEmXMGIyvFy9TJ99BVx1g9Y5QoD8CyEK6PSzxwN+BnJRgcd
	 qzqYQCptNBkWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B4D7CF21F1;
	Fri, 24 May 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] connector: Fix invalid conversion in cn_proc.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171654363130.13276.9385730381130942587.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 09:40:31 +0000
References: <20240514041046.98784-1-zoo868e@gmail.com>
In-Reply-To: <20240514041046.98784-1-zoo868e@gmail.com>
To: Matt Jan <zoo868e@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, matt_jan@trendmicro.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 May 2024 12:10:46 +0800 you wrote:
> The implicit conversion from unsigned int to enum
> proc_cn_event is invalid, so explicitly cast it
> for compilation in a C++ compiler.
> /usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
> /usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
>    72 |         ev_type &= PROC_EVENT_ALL;
>       |                 ^
>       |                 |
>       |                 unsigned int
> 
> [...]

Here is the summary with links:
  - [v2] connector: Fix invalid conversion in cn_proc.h
    https://git.kernel.org/netdev/net/c/06e785aeb9ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



