Return-Path: <netdev+bounces-46744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F617E626A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C0B1C2087D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADCC53B8;
	Thu,  9 Nov 2023 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pehz7Znb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A95382
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 786A9C43395;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699498231;
	bh=4pxL3ef9HUeKTrArdp19oe1vo3hE4qsZy2uZoZkNHpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pehz7Znb9ErW+9y/XSjzwtp+fxHBlVn7M6LxwOwdy/+nL8IGugQdqFFfn7BIhQXw8
	 +3Pl9p16PRrnMEPSNmv/dBD7+FSalklMgrTEbR1aySb5YB1IViEstZP+IjA9vy98Te
	 3XgiNHFJlnSfap4dyrkRp+4+tvPOd17YOQ9L9QcPaq/m+nJPUtXNqr2IHQ3VlSg/5T
	 yktlSVTFClaLWLoaq8Om0+ZfH0CCp1lEfmqECjOcUpy658jOBd09leWZaCdD4EEU+Y
	 aj1E8UwSYNSrFptHOGsvIhCNaq7KTxH6t5X2VBethfdlRboChw7VVIgEFNniGNc5rB
	 /rMwqP+QxrGPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 643EBE00084;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: kcm: fill in MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949823140.3016.5232565045176578697.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:50:31 +0000
References: <20231108020305.537293-1-kuba@kernel.org>
In-Reply-To: <20231108020305.537293-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dhowells@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Nov 2023 18:03:05 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dhowells@redhat.com
> 
> I've updated the cc_maintainers test as promised at netconf.
> Let's see if it works...
> 
> [...]

Here is the summary with links:
  - [net] net: kcm: fill in MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net/c/31356547e331

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



