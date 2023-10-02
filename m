Return-Path: <netdev+bounces-37506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80747B5B67
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1B6AF281D54
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE531F94C;
	Mon,  2 Oct 2023 19:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FE1F93F;
	Mon,  2 Oct 2023 19:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5F2C433C9;
	Mon,  2 Oct 2023 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696275630;
	bh=eAGotdaw6xLPfIfuKglV1SVbetFCWk9ec9VM3frmscA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrNY+sS2WqTT67HztJN7Rz5vnMUEuBpYRztYyDjARcsEvxNypgHMJgtpA/t5AF+St
	 fh033LNt1y6IlKaDefgdbbM0OSdG/kInJREpB2szpeF9UXeN0AImEtLQre3FzXdw4b
	 bM+2N3tpEk5jUBGSyktBsViwH2RO3gSHNkOU4lMmwdOlMNQEbKoT63J9Ae6MBXRWj2
	 bH8hSFqZ+8JnuwSCtMsnnDxjA0HdNza0WTDvUIcxJTrSfP9DP+aWi0TsMMvd6sDC1d
	 sql7yWFb5ZQ9/tQ9xlWDQ0BsWpYihNfax/n5vlYypZeny8xDFj3Cq9CXNVMuDzewbf
	 N/P6qKXO3xgSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2EEDE632D2;
	Mon,  2 Oct 2023 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Fix implicit sign conversions in handshake upcall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169627562979.13580.16928932673781658567.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 19:40:29 +0000
References: <169530154802.8905.2645661840284268222.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169530154802.8905.2645661840284268222.stgit@oracle-102.nfsv4bat.org>
To: Chuck Lever <cel@kernel.org>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Sep 2023 09:07:14 -0400 you wrote:
> An internal static analysis tool noticed some implicit sign
> conversions for some of the arguments in the handshake upcall
> protocol.
> 
> ---
> 
> Chuck Lever (2):
>       handshake: Fix sign of socket file descriptor fields
>       handshake: Fix sign of key_serial_t fields
> 
> [...]

Here is the summary with links:
  - [v2,1/2] handshake: Fix sign of socket file descriptor fields
    https://git.kernel.org/netdev/net-next/c/a6b07a51b161
  - [v2,2/2] handshake: Fix sign of key_serial_t fields
    https://git.kernel.org/netdev/net-next/c/160f404495aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



