Return-Path: <netdev+bounces-133980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C29979B6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240B4283DA6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F2EADB;
	Thu, 10 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1QktV5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9A168C4
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520825; cv=none; b=FYQM1OmhHMHLY5Ji/jNq5tuVUZkobmUjrQ5gzMNdOTobP1BxUaM0Ud6Oh6fIVuD8m8diH8+YmSiYyr+hYatczdSE3IhzRPsYbjhZnVQ2sFZKelfgF7qBcbqIuY+19UaCFQcut6C1uNv/czcpOioLjj0xZdpFBVfWKAYjh+Ke4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520825; c=relaxed/simple;
	bh=ghxJJOr8E8oZuAcKdatNinOj8dxnTu1pqo+ZvyTCtXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zv5XbBpKMt0a8z7T3TUUQOtRMBRsA4gtFZGIncULAP3QClnD5JbR/On+ksTDHocOZk1pYj16aqpdOHxYssvjUQRaJI1W/V4byv6Ga9HZQdZIJx6QSKsiNVwTLBnjhlYLdQ4PubldgQxd0nB8ngtUgrO2eHgLT5ENoMJKyxrgCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1QktV5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61D6C4CEC3;
	Thu, 10 Oct 2024 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520825;
	bh=ghxJJOr8E8oZuAcKdatNinOj8dxnTu1pqo+ZvyTCtXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1QktV5RbDIWvSQxXDlm9ljCn9wr3IfxEObcAWD4laCRyfrAZWEiUwDrW2RzYndfw
	 vRdtd8E/uFmW7WzCG/QcgcxuTplYWGTEJhuv9TrJQ/ZoCZHIopJgHBNsoAgc5N0rts
	 b9szKG04pZJ/0OTNyLjEVv4VcYcUUS/2SDip5SUMo1EpC/ZNXlK9aSVSTRrKasvFN1
	 LZlxyyDisr9wwJvbiorbd0iQA1eEZQuZalVM7/fKRbuJH4GrqdjvfxUGfvpS0/0qoC
	 F/b6KqHio/drkwiRFRDTOdQm9SdR8oaHDyy56W8vWyqS437FYMb2ku9MOvsasiNK1v
	 vzq1BOKlQmz8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD03806644;
	Thu, 10 Oct 2024 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] ipv4: Convert __fib_validate_source() and its
 callers to dscp_t.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852082926.1520677.13956528377198515356.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 00:40:29 +0000
References: <cover.1728302212.git.gnault@redhat.com>
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Oct 2024 20:24:23 +0200 you wrote:
> This patch series continues to prepare users of ->flowi4_tos to a
> future conversion of this field (__u8 to dscp_t). This time, we convert
> __fib_validate_source() and its call chain.
> 
> The objective is to eventually make all users of ->flowi4_tos use a
> dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
> regressions where ECN bits are erroneously interpreted as DSCP bits.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ipv4: Convert ip_route_use_hint() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/2b78d30620d7
  - [net-next,2/7] ipv4: Convert ip_mkroute_input() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/34f28ffd62c1
  - [net-next,3/7] ipv4: Convert __mkroute_input() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/0936c671911f
  - [net-next,4/7] ipv4: Convert ip_route_input_mc() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/1a7c292617e4
  - [net-next,5/7] ipv4: Convert ip_mc_validate_source() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/d32976408744
  - [net-next,6/7] ipv4: Convert fib_validate_source() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/d36236ab5275
  - [net-next,7/7] ipv4: Convert __fib_validate_source() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/3768b402735e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



