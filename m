Return-Path: <netdev+bounces-177608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F02A70BD5
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E53B188884B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE1265CD9;
	Tue, 25 Mar 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW0HN3c2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBA25E80A
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936398; cv=none; b=QhpUK/bePWUbR1k25d9qJUQ22G933iWCx2PlW4BqpmDmnHqv8Z11rg+Ucd6OC25Jm/+GM6OcEwOICD0/4JS6BMPObXbPBCq4EXc4twSh0c8ks/L338WNQpzvw0Xw52T2gUNKs3PfznxgRRG0YYx2EtHsMhe0xWOCGl9cmWsNg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936398; c=relaxed/simple;
	bh=nOF+YLwG5C+dVSRP5zT1lg1yviL3bDENNP9UZZELj7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XOTxjCYTDJzQ/bqIeFyU1dkDK6Y+ql5USAAgbW94DOn2TeT8AdxbEWKlyPlZlYWonuY9+ufXWkr0zfpD1cWyUO757EuUn70nvP4ReYFQlTPd1w9s0Obz4g0njpQamID9cUy0MAyNULKyvc9t/00aFaMC3mVGGq7K3hlcCvOu164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW0HN3c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29A2C4CEE4;
	Tue, 25 Mar 2025 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936397;
	bh=nOF+YLwG5C+dVSRP5zT1lg1yviL3bDENNP9UZZELj7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bW0HN3c2sF1igjGAT3BGuL4FVPuD+i6l/4+z3/f8RjOcG/Z+UcVgzzSKArVAixh70
	 IlwegVZe206MvKyWoWgEXZV40OmOOiIDfc72bfgylFf/XmFEZDh/qjc3Dawg05G2a5
	 p5a5iCsr1G68sQkVTKVWLhyEpfanePEpHIUPcMv/nq7NDzy3g4xAUXMUnXfBAxWwGy
	 ePgvvJ7D32Nt/r5oFX5hJ4UmFmqquKVrlOHfinzj5GDIPICWKOBDZcdoKyyMjLxdbV
	 b2FDGd3MCn0h7WPq1AH2yXOYe8fCyRiQYv/dot027/FqxQvOTFDoWKWTvaEQrTQLfg
	 F/aAnishpyY+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FFE380DBFC;
	Tue, 25 Mar 2025 21:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] atm: Fix NULL pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293643407.727243.540381028984589643.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:00:34 +0000
References: <20250322105200.14981-1-pwn9uin@gmail.com>
In-Reply-To: <20250322105200.14981-1-pwn9uin@gmail.com>
To: None <pwn9uin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Mar 2025 10:52:00 +0000 you wrote:
> From: Minjoong Kim <pwn9uin@gmail.com>
> 
> When MPOA_cache_impos_rcvd() receives the msg, it can trigger
> Null Pointer Dereference Vulnerability if both entry and
> holding_time are NULL. Because there is only for the situation
> where entry is NULL and holding_time exists, it can be passed
> when both entry and holding_time are NULL. If these are NULL,
> the entry will be passd to eg_cache_put() as parameter and
> it is referenced by entry->use code in it.
> 
> [...]

Here is the summary with links:
  - [net,v2] atm: Fix NULL pointer dereference
    https://git.kernel.org/netdev/net/c/bf2986fcf82a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



