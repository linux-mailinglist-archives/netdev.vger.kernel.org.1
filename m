Return-Path: <netdev+bounces-22446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649276788D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AB01C218C2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382121BB57;
	Fri, 28 Jul 2023 22:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEC16407;
	Fri, 28 Jul 2023 22:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F160C433C8;
	Fri, 28 Jul 2023 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690584025;
	bh=AYNBOHvmjslFGrDfEGQP0BghWCzYNAEKyWSWWRys2YU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2LfFuzjBHrg4Ay6r69K2UJ61gBf9S1edsw+mWoLjTOU+Uk6RdelUnF1xpRtEoYa7
	 t5ryHiatCsSu5BGNFciy0SOE5Hlr4pXtI9+q+6xr6Uk1jC+ZSDlTlU6Em3NB1bOKpc
	 q6Sbce/hSrxjQdBO/5/dYn8r3BBQ8l+QtmE6ZOfMvR8ktjLA9ad9qAeYBkWIPSCsHg
	 1achSRaTwrNFMz1O1+0qezQoOTmr7NcrgMwG/6dGXITPWBbNoz4PBPtAaz7eiee1aN
	 CGwXscSX8UvLjofCfb3Zlz+/7nupUMVyMavXPGmpe/mHf2N7eCe6bhRR4OF9jQHEhT
	 LhuiU91G8wiXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1356AC39562;
	Fri, 28 Jul 2023 22:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] In-kernel support for the TLS Alert protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169058402506.15090.8253785395174410667.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 22:40:25 +0000
References: <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 13:34:56 -0400 you wrote:
> IMO the kernel doesn't need user space (ie, tlshd) to handle the TLS
> Alert protocol. Instead, a set of small helper functions can be used
> to handle sending and receiving TLS Alerts for in-kernel TLS
> consumers.
> 
> 
> Changes since v2:
> * Simplify header dependencies
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] net/tls: Move TLS protocol elements to a separate header
    https://git.kernel.org/netdev/net-next/c/6a7eccef47b2
  - [net-next,v3,2/7] net/tls: Add TLS Alert definitions
    https://git.kernel.org/netdev/net-next/c/0257427146e8
  - [net-next,v3,3/7] net/handshake: Add API for sending TLS Closure alerts
    https://git.kernel.org/netdev/net-next/c/35b1b538d422
  - [net-next,v3,4/7] SUNRPC: Send TLS Closure alerts before closing a TCP socket
    https://git.kernel.org/netdev/net-next/c/5dd5ad682cfe
  - [net-next,v3,5/7] net/handshake: Add helpers for parsing incoming TLS Alerts
    https://git.kernel.org/netdev/net-next/c/39d0e38dcced
  - [net-next,v3,6/7] SUNRPC: Use new helpers to handle TLS Alerts
    https://git.kernel.org/netdev/net-next/c/39067dda1d86
  - [net-next,v3,7/7] net/handshake: Trace events for TLS Alert helpers
    https://git.kernel.org/netdev/net-next/c/b470985c76df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



