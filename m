Return-Path: <netdev+bounces-79296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B2878A64
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64861F22187
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D557301;
	Mon, 11 Mar 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIkkjAvw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF756B98
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194435; cv=none; b=F5J5dwk+6R7S0I6ceThGe4nZ5xyuuW/hu78xpeGFBCmfq13JekBmNGmkLpk26FOB1nFOXtLX33WR3BprricwCFoNl4S/iUzUNcZQTb/0yqpd6tyO3hFkdqNfrum/AjhVhypCsN8vuKB01+J37jxgaGEXq3q/4bWklh8kq+NDYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194435; c=relaxed/simple;
	bh=6kJv6Ytp+FjSNs903Y6/+++l3SQV5j0+YvRBkfxwC9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IsyILQj2i8xzCDU0B5t3Iq7uya9Ue21QqQ0G3lAazNYkOzBrcB2yXvshnwoz7Ds2T2+u8pEpo4sul+ZbVtY3ZFvNmlQVBzSF6e5F7PptbV3421Tw0+nztN8pk41mgKGd8NrKFLM2J9I72d43pZLK1gqXyhihpepbGcswV5C99JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIkkjAvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84B31C433F1;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194434;
	bh=6kJv6Ytp+FjSNs903Y6/+++l3SQV5j0+YvRBkfxwC9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIkkjAvwMTUUQODD2KD9fah+zQumxiouaRqwWs7nxg7ZieiVjXZtiVlBCQdD6D+ku
	 6CQtq+Mx+74Hl4qUBfDqMa06Jk9pamBcTQi22nLdsxxtabLcdnaFmgX6E1RqrBTAbm
	 vGkU7litvHXwQJsf/+U0GBE2FU5e61UIKQlbdDs1vIqk2wkSqGjg24TQD2zl29ZOjZ
	 1rwTAQ5XoT04d8ORLWNx+6Fg6KmOW90wxzsWo53cVBcKoDUILM0PPCp9tIWYoZ3Vvf
	 z/ZtS7RwRFkR/Qs6YRtwiB/dSw0NaElC6aJnOGxb5vBhaqBnkHTgUoPl2Ak5Hdi+JL
	 rZDyV3bLtVjGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66B20D95055;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mlxsw: Support for nexthop group statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019443441.9697.6658731872868510841.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:00:34 +0000
References: <cover.1709901020.git.petrm@nvidia.com>
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 dsahern@kernel.org, shuah@kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Mar 2024 13:59:44 +0100 you wrote:
> ECMP is a fundamental component in L3 designs. However, it's fragile. Many
> factors influence whether an ECMP group will operate as intended: hash
> policy (i.e. the set of fields that contribute to ECMP hash calculation),
> neighbor validity, hash seed (which might lead to polarization) or the type
> of ECMP group used (hash-threshold or resilient).
> 
> At the same time, collection of statistics that would help an operator
> determine that the group performs as desired, is difficult.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: nexthop: Initialize NH group ID in resilient NH group notifiers
    https://git.kernel.org/netdev/net-next/c/2d32c49386cb
  - [net-next,02/11] net: nexthop: Have all NH notifiers carry NH ID
    https://git.kernel.org/netdev/net-next/c/e99eb57e9b14
  - [net-next,03/11] mlxsw: spectrum_router: Rename two functions
    https://git.kernel.org/netdev/net-next/c/64f962c65fe3
  - [net-next,04/11] mlxsw: spectrum_router: Have mlxsw_sp_nexthop_counter_enable() return int
    https://git.kernel.org/netdev/net-next/c/8acb480e43c8
  - [net-next,05/11] mlxsw: spectrum: Allow fetch-and-clear of flow counters
    https://git.kernel.org/netdev/net-next/c/6fb88aaf272a
  - [net-next,06/11] mlxsw: spectrum_router: Avoid allocating NH counters twice
    https://git.kernel.org/netdev/net-next/c/79fa52145e19
  - [net-next,07/11] mlxsw: spectrum_router: Add helpers for nexthop counters
    https://git.kernel.org/netdev/net-next/c/10bf92fd775e
  - [net-next,08/11] mlxsw: spectrum_router: Track NH ID's of group members
    https://git.kernel.org/netdev/net-next/c/41acb5549e60
  - [net-next,09/11] mlxsw: spectrum_router: Support nexthop group hardware statistics
    https://git.kernel.org/netdev/net-next/c/5a5a98e5176e
  - [net-next,10/11] mlxsw: spectrum_router: Share nexthop counters in resilient groups
    https://git.kernel.org/netdev/net-next/c/44c2fbebe18a
  - [net-next,11/11] selftests: forwarding: Add a test for NH group stats
    https://git.kernel.org/netdev/net-next/c/a22b042660ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



