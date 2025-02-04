Return-Path: <netdev+bounces-162583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C0A2748D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7267A2DD5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743192135D8;
	Tue,  4 Feb 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRxai0j9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B12135D1;
	Tue,  4 Feb 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680005; cv=none; b=H71telvy+imi1qGbAAD6nAZK7xEyK0q8EUAW0MXEQ6+5Auo9TxfRnNxmlIL8ASmCJ4j58+w0qVscAzUqbDefiU2NtY6DZSHwfc/Slr2qdnAfN99DS2eZXO1zh+Q6Yz47e+z1+qECfabm+lqiHqTI6cNmdh40izNRmbUjQYgv42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680005; c=relaxed/simple;
	bh=Q0G+QZjAQCmK/nyuKiESdoITFbg0qLCV4bnWYjs/ZUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X4fd9IGp7cjKy4QnQBCja0/TQa4YFNeVFLxeIrIlcOts2JV8PTKOdYYeHyF2F/hBg9IAbnAqA4n9J/91MddFPO2UwBdGXQPGEjbkLitb9Ts1ujCrZOeGm14EL26cxQjH3FuXq5etggP9cunFerwrXQMUwHJzFpB5yiP5DXyZvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRxai0j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF47DC4CEDF;
	Tue,  4 Feb 2025 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680004;
	bh=Q0G+QZjAQCmK/nyuKiESdoITFbg0qLCV4bnWYjs/ZUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRxai0j9JraCEnKk85O84sJoDnCps0EwkNeBVSiOBY6teginJ02bGyExCB80cx4Qw
	 v/GgysNZpQpgcFnmVplzQXcCtNw3ztoRPSyfNXUqxBo1gJEQ52Np4QM73SQjlL99kL
	 fmXgh1ytxnCOMN0r/uw9Jr83hCKJ+F6Cj8gNl2Sgl+h/59coKZcz0AoBUsfFhs1s1S
	 /2rffHC2kofMTuL/4QebWWqw/NSKxqDzsjGt3RvT2Eh70JUbzJxlK5cE9Cg+UUCvTh
	 CvNchucdzkP7XK3KJiCcigOHAhu9BOZkPtHM1q2ttc2AtC/ob89DgPbpnDyihazz1g
	 7OJqfeKCLsYqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F04380AA67;
	Tue,  4 Feb 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173868003201.17912.9717325856767438818.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 14:40:32 +0000
References: <20250203110307.7265-1-dhowells@redhat.com>
In-Reply-To: <20250203110307.7265-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Feb 2025 11:03:02 +0000 you wrote:
> Here some miscellaneous fixes for AF_RXRPC:
> 
>  (1) Fix the state of a call to not treat the challenge-response cycle as
>      part of an incoming call's state set.  The problem is that it makes
>      handling received of the final packet in the receive phase difficult
>      as that wants to change the call state - but security negotiations may
>      not yet be complete.
> 
> [...]

Here is the summary with links:
  - [net,1/2] rxrpc: Fix call state set to not include the SERVER_SECURING state
    (no matching commit)
  - [net,2/2] rxrpc: Fix the rxrpc_connection attend queue handling
    https://git.kernel.org/netdev/net/c/4241a702e0d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



