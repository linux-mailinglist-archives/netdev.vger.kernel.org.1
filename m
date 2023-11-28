Return-Path: <netdev+bounces-51652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E27FB988
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4309A281721
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA74F61A;
	Tue, 28 Nov 2023 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkGdETUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF64F610;
	Tue, 28 Nov 2023 11:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754FCC433C9;
	Tue, 28 Nov 2023 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701171624;
	bh=nsohNNl7TIp2uAVmRL6eRKJE7aS6PSos+wqJjRTGK60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NkGdETUoDk6rVlg1SeFurtTsh0co7X0FzpjpoXin/Utv85pgGaIxdB3fHm+o2k9HB
	 Md8YbApNSO92fuxUKopzFcsNP6LkR8dA8HqZdf3oaX8KC2vubI2KXZhlJNxbfspXIP
	 4HPdVHv1pt26fBE2Z4s3RslYjyA+elIe0ZwLu4YbJevKyDIaIZXIXm/+c5IhP2K4uo
	 25bLNHhlraXdWm2XEcooHla7YKCHazU1HkJm61IQ1XZ9/ZFvhImCfGPUjCCGOPG6rV
	 ZzuCuMs6pImk1dQmfs5GQcxjEjQJHPpOIaksTuWdxcu4I2JHFx3ddzJzRFPgeGqvyW
	 OhySY91Tt1OBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56834C39562;
	Tue, 28 Nov 2023 11:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct neighbour
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170117162434.28731.12930304842635897908.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 11:40:24 +0000
References: <ZWJoRsJGnCPdJ3+2@work>
In-Reply-To: <ZWJoRsJGnCPdJ3+2@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: joey.gouly@arm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, morbo@google.com, keescook@chromium.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 15:33:58 -0600 you wrote:
> Previously, one-element and zero-length arrays were treated as true
> flexible arrays, even though they are actually "fake" flex arrays.
> The __randomize_layout would leave them untouched at the end of the
> struct, similarly to proper C99 flex-array members.
> 
> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
> randstruct: Only warn about true flexible arrays"). Now, only C99
> flexible-array members will remain untouched at the end of the struct,
> while one-element and zero-length arrays will be subject to randomization.
> 
> [...]

Here is the summary with links:
  - neighbour: Fix __randomize_layout crash in struct neighbour
    https://git.kernel.org/netdev/net/c/45b3fae4675d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



