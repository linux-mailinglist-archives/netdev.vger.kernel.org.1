Return-Path: <netdev+bounces-133348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18326995B8C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AAC281107
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A7218D7D;
	Tue,  8 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pun3BpjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4401218D71;
	Tue,  8 Oct 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429632; cv=none; b=RG/mwUggF/DfCFOvNPOXbQwlavO0BnRc1QVtNFdFRPcdcBEQ8KFtOlWfLIpJ5vULnAy6nHjK2tw6x0NvPCK14H0kUSBRKsiMMQd+BItnHui0mKxedoxngi/JAP2fve3iEst8ix3rzdqG2ITUJMand009Bcjlxs445pc8BFAY9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429632; c=relaxed/simple;
	bh=3t0vYqaUuvs+E138RMMNvcD37CTwjo7vjK1Pl/GHwVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=islTJxOXntIgmJLqnSP9AGOyY9QptlIhS6h5k3Y0CbhramesWUXrp8PeW9SqUo4uIR56fVM97w+Q0VDc29VvdnBWAXJ41hTuUSxCJ9zhypOTY+3Q/APiA2LLZpVKMlpU1fzNSHZdGHB2C+w96jiDxdNgek8Ma2bMsevqNGs61q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pun3BpjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440A5C4CED0;
	Tue,  8 Oct 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429632;
	bh=3t0vYqaUuvs+E138RMMNvcD37CTwjo7vjK1Pl/GHwVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pun3BpjZD7/oKaOAU1jVf2fsPDg4svEYG7bBJKEEa4LF1pMaUWw9KnerCXvycF+yT
	 XEKF8hn68ep9MrUCNzzyEHbxkD8iRq3q6MUX18ZjS0VfdFu+ac5dTGCzXV+xQ2eH4l
	 6Zi/9tMWDi7s9M3jNtxkcb9EXde60+tvvBVcPmu1RXFzb3/A5ssPyJWDc+LcPhrEnL
	 zbr4fISJ4voTCTVfW/iTEL9V/IrVPwhDjFY/y63DvL0GHGUtWveygHi7BccLNgwWfF
	 PQrvh0QB20vF32HvG5ApYsV+5Sjz5WYEZELHEKEm+wpDLJOru2alXoZ0a4RJV4bEDn
	 bxgZfY7yrM0Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6E3A8D14D;
	Tue,  8 Oct 2024 23:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] caif: Remove unused cfsrvl_getphyid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842963625.718280.1977924503014171367.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 23:20:36 +0000
References: <20241007004456.149899-1-linux@treblig.org>
In-Reply-To: <20241007004456.149899-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 01:44:56 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cfsrvl_getphyid() has been unused since 2011's commit
> f36214408470 ("caif: Use RCU and lists in cfcnfg.c for managing caif link layers")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] caif: Remove unused cfsrvl_getphyid
    https://git.kernel.org/netdev/net-next/c/3fe3dbaf2672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



