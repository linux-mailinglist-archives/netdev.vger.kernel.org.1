Return-Path: <netdev+bounces-190898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB77AB9351
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4E5A00241
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C1BE49;
	Fri, 16 May 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK9D2T8c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9308836;
	Fri, 16 May 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356594; cv=none; b=HFty2BX2EdgzSEd0IoGOKAR35ZHXejm6GAQggn1McrJXvrMHVUK+zarU9rliOI1a5DZ1Kih3+FCATZAQ/kUe+oazS9ExK32Lyjws1ISCro45eqAik9dqNCnw2yDmT/9sB7GUqyqu8TRK/zhKeQXtvzVdrMUlHKI6ydDLWGW8aqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356594; c=relaxed/simple;
	bh=XSV15eqGpPAYWfgNKtmP75oLVwnaM6M6k5cIFqoe43k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CM+leA+D115AItZnVrdEnGHaN3re++x09B39EfFUGOzJl9mmtYv1hNfi4eRzwgyEJeP6zEkzUcHOSg3qdg84iNabCgAUKHDX9kZJ8nJZXC5wqjWdj9WRedWB9lPe4S1iCXtfj3cJ+lOXhTyMa4pcjSdzV+QoyhBwnzk91gA+uQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK9D2T8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02726C4CEE7;
	Fri, 16 May 2025 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747356594;
	bh=XSV15eqGpPAYWfgNKtmP75oLVwnaM6M6k5cIFqoe43k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LK9D2T8cR+Lxgdd47IN8F06Hl62DI4kZ4dN4x+1zT2hscFdAsa8oAAbHehS1reFxg
	 mx/0XnhEmkaOsedQP7qWOaRilu7VviAwUFHo87PbRInblFQ/CW/cKapiN3+Iw/LviA
	 YvYvCpK7BdoXQZULVd/htQPNiQqRtJnVkyzaU+K2hJCrxRd8XDCeI/MC5JHCrQlY/4
	 NCj1Iiy1PyDPBqPFPc4de4Xcely1mtESOO/ruyH+7eXtEoDiEdGtPhqlLtHrn0qpCe
	 u3N2NFQLtnwEg/S80HjlCNiaXU8LhDlCoP6jB7TpVgmsnVORhhsWMMmF+DSungbzZF
	 eFprDEol82zCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F103806659;
	Fri, 16 May 2025 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-05-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174735663101.3293660.11774924610003254258.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 00:50:31 +0000
References: <20250515171909.1606243-1-luiz.dentz@gmail.com>
In-Reply-To: <20250515171909.1606243-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 13:19:09 -0400 you wrote:
> The following changes since commit 0afc44d8cdf6029cce0a92873f0de5ac9416cec8:
> 
>   net: devmem: fix kernel panic when netlink socket close after module unload (2025-05-15 08:05:32 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-15
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-05-15
    https://git.kernel.org/netdev/net/c/c39b1bb5bc6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



