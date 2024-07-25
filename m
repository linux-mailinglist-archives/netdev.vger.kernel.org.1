Return-Path: <netdev+bounces-112922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C464893BDF6
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB61F2145C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C4147C90;
	Thu, 25 Jul 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLUqFw1+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4DD299
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896231; cv=none; b=ZWMbnjAPoYAP4zNq6WyH3ms6RkEJ0eyvU6G5aX0hs5f4NTAww4xhSN2lXgojDDSbPm836k2te42lUnJgZDVbz+uUFN8N9oXUF3y7UCBu/n3AWjfeGArTShbn+54wO7fFTJ6KibdT4KS4IbFBi7CIj+5rnsUAAid+vzCYX6Ex48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896231; c=relaxed/simple;
	bh=VCQSSAeFRfY5IVbXXQYXdRAkA/gnY7ch3gAPhGMlhws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DZVUIoQrwGduYUZUOjcnuQGqdmvHAu2UF8GK8EVHJKpm5Kjq8qnzIvso196dzSx0KyHIbpYGpOm4pxqUtJtNDIG7HuNLWFHnvKAKQciaFxvZI/Dh5O7R6buu3wTGvZ6w9xHl6pSJwHXhseFQaWIw27wheSDdlEU/SzpqP1sIkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLUqFw1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA8AC4AF0B;
	Thu, 25 Jul 2024 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721896231;
	bh=VCQSSAeFRfY5IVbXXQYXdRAkA/gnY7ch3gAPhGMlhws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CLUqFw1+3cO2bqaUlRi28vbUW0FZbsBq6yBw7aQXz6oWXXaYjBWh4QrDOriKJ8eS5
	 /m17oX3/HVn0Q5K9REGiNMBJ6OcS9BPzV3kHMmQYL3H265eYfVGYpFK2/uNdo4hcR9
	 6PxEACGXuIqEhMSCF6dsk93eWyuyXtlkEru9Cis13zquuCqqVzt1O1+uzAEBdBPcDm
	 ppwZGJEVu2wxwFN4766loOAjOsWhHSyJjER+uVhzV6o69p+TpeDn/kjh7BwJWdvjDi
	 Xlf6Tx5kTwsQt25D+Kx+UJYyyql2vxkFqR5bfC+Ox8Hn7frVtOU6FCUmKVm+lNqUb5
	 qURBcrG0/FOeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90912C43638;
	Thu, 25 Jul 2024 08:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2024-07-23 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172189623158.15338.7546092996127503012.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 08:30:31 +0000
References: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240723233242.3146628-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 23 Jul 2024 16:32:38 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Ahmed enforces the iavf per VF filter limit on ice (PF) driver to prevent
> possible resource exhaustion.
> 
> Wojciech corrects assignment of l2 flags read from firmware.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: Add a per-VF limit on number of FDIR filters
    https://git.kernel.org/netdev/net/c/6ebbe97a4881
  - [net,2/2] ice: Fix recipe read procedure
    https://git.kernel.org/netdev/net/c/19abb9c2b900

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



