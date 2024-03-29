Return-Path: <netdev+bounces-83369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5D892151
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22664B28654
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98184AEED;
	Fri, 29 Mar 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5gBlwWo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497F3D966
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727433; cv=none; b=lp0gr5rs9asEYWSmDZfiwWX0WDo4UnGkRJpJIsixBn6klwHi0A0Es7YtRVU3MXyw2gsQfz8eqNCLRn5Ilrsc4bXlTj+SuLk5bYyWxIQLRro/OKfpK/ec7bdndtQdfPNOUohdl+yfCYy4wbhC1tmzs7OM8HXgQ0No++LQbfE5dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727433; c=relaxed/simple;
	bh=iXNOxNAkASdORsLJ7puMXP3tc4aCJ3Ub+JKIoW59HBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdxfAFRcHhrj0asl0HdkVfGluo4UWwHsbWHxigMzUWZhcQ7rBf1VBoEOtbcKtkyywj/JEkeuT0NuK7Ms1JXXU1p4OoMSW376yAOU4gj6MweP6aydQAcnDWU8iw2slKCDdZvcAgQX5PMgH7gynfqZEOrk+1jIjVtAU2Lp/SaGyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5gBlwWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ECE0C43399;
	Fri, 29 Mar 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711727433;
	bh=iXNOxNAkASdORsLJ7puMXP3tc4aCJ3Ub+JKIoW59HBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5gBlwWohlXT/QH43dwcEYwdHHwRISaRjAQXUiAxympkNKjaZ+N+EEEpOoDnGylKg
	 AF1zP6ZbauBnuCmtCv0g3ChLjtHyY5zZ7NQB+huk92NZQWPnKvdUgcuZSB2lWyG9be
	 y4Bog/sYJ7q6+APnpXfQT9zhLQU1XwDsxxKCGvMjwTJWvM4auWYKgbpEUC6wCpVNEV
	 FX3+Qddl74vW5ta2t2C+c4Pne9H/p2BKAdoKlfWXUgvuR5lNDH/hNw1+RkiLTzTBN7
	 LvqUNFNPrVFao6+JdphPaodZaD9R9ktgVmb90+PMzgWe6tXC2og/ef3P55qdau/ctx
	 w816w/nlMz8MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B681D84BAF;
	Fri, 29 Mar 2024 15:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 00/15] af_unix: Rework GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171172743317.17508.11772802399675256509.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 15:50:33 +0000
References: <20240325202425.60930-1-kuniyu@amazon.com>
In-Reply-To: <20240325202425.60930-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 13:24:10 -0700 you wrote:
> When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
> the underlying struct file of the inflight fd gets its refcount bumped.
> If the fd is of an AF_UNIX socket, we need to track it in case it forms
> cyclic references.
> 
> Let's say we send a fd of AF_UNIX socket A to B and vice versa and
> close() both sockets.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,01/15] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
    https://git.kernel.org/netdev/net-next/c/1fbfdfaa5902
  - [v5,net-next,02/15] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
    https://git.kernel.org/netdev/net-next/c/29b64e354029
  - [v5,net-next,03/15] af_unix: Link struct unix_edge when queuing skb.
    https://git.kernel.org/netdev/net-next/c/42f298c06b30
  - [v5,net-next,04/15] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
    https://git.kernel.org/netdev/net-next/c/22c3c0c52d32
  - [v5,net-next,05/15] af_unix: Iterate all vertices by DFS.
    https://git.kernel.org/netdev/net-next/c/6ba76fd2848e
  - [v5,net-next,06/15] af_unix: Detect Strongly Connected Components.
    https://git.kernel.org/netdev/net-next/c/3484f063172d
  - [v5,net-next,07/15] af_unix: Save listener for embryo socket.
    https://git.kernel.org/netdev/net-next/c/aed6ecef55d7
  - [v5,net-next,08/15] af_unix: Fix up unix_edge.successor for embryo socket.
    https://git.kernel.org/netdev/net-next/c/dcf70df2048d
  - [v5,net-next,09/15] af_unix: Save O(n) setup of Tarjan's algo.
    https://git.kernel.org/netdev/net-next/c/ba31b4a4e101
  - [v5,net-next,10/15] af_unix: Skip GC if no cycle exists.
    https://git.kernel.org/netdev/net-next/c/77e5593aebba
  - [v5,net-next,11/15] af_unix: Avoid Tarjan's algorithm if unnecessary.
    https://git.kernel.org/netdev/net-next/c/ad081928a8b0
  - [v5,net-next,12/15] af_unix: Assign a unique index to SCC.
    https://git.kernel.org/netdev/net-next/c/bfdb01283ee8
  - [v5,net-next,13/15] af_unix: Detect dead SCC.
    https://git.kernel.org/netdev/net-next/c/a15702d8b3aa
  - [v5,net-next,14/15] af_unix: Replace garbage collection algorithm.
    https://git.kernel.org/netdev/net-next/c/4090fa373f0e
  - [v5,net-next,15/15] selftest: af_unix: Test GC for SCM_RIGHTS.
    https://git.kernel.org/netdev/net-next/c/2aa0cff26ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



