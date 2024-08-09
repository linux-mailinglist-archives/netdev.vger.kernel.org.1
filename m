Return-Path: <netdev+bounces-117058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14A94C8B6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BECB1F21236
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6011798C;
	Fri,  9 Aug 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2WWV8w6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A51C2E
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172437; cv=none; b=Clxzk+pKRpoWO3pMNsqVTVWidjy39Z3tJ+SRJ4pdQkFZj5+rwLrNTJ8gsieYufdFB+7u47kovgGv7IzWuSTEs5k+JLXWNEY/sKiEQlECONp8/g8Nc77fHKM/eLIPumN87kxfVgg37jyGi1zRqfyN6Ffw2BrqVkOsnYeZ5IfW8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172437; c=relaxed/simple;
	bh=ClD0iS5kjjA+qOeYV6UV9OwDw8aTDG6VaK9a5OUkFC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGiD9nGTA/iq72hkyr8NpBzS6PbzzJ3E9+CkJmHQ+jM5YvbAfJ6/McQ/ntWQ1FIGYIjzEG3gsIraUMhNzQecm16xZrIhzxFsvnMf8PH18zc4nAoEtqazMkF0/EPGm/49SlylMG0xXkJVG4pml5x/CuXxifKbHWDdnXC6lahHosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2WWV8w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57637C32782;
	Fri,  9 Aug 2024 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723172436;
	bh=ClD0iS5kjjA+qOeYV6UV9OwDw8aTDG6VaK9a5OUkFC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2WWV8w6vAt3zW59A5KtNSDguQZASeaVWHyp/RNz/tN0zksZHffD7FgAoa5e1tEAO
	 9MgZHkqpBTzohCZIjcveaUgc0fha1vvXWOFob4rbJ0bVktX0dC89QEN7ovBVwQz870
	 7qdDDo0cToE4ZE7zxBsWmyoHBoPUIYQfg2kWAr+NhdyBYb36EDL7FyllktzWK9+nwU
	 p8GXDSYxWLEUGxFtd3kOmRHkZPis6+O9ze+M5z1K86ODzKAu/wwSiaRXgGXb2mtYdI
	 L1585s8DpORzlCrCv9NG7HG80SXPDhrpY1wo2Yn0EM6md+TVXVA46O8ECRxdVSrz9i
	 gUHd9n/UBtFxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D53810938;
	Fri,  9 Aug 2024 03:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: ethtool: fix rxfh_max_context_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172317243527.3366602.3553373522952407337.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 03:00:35 +0000
References: <cover.1723045898.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1723045898.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Aug 2024 17:06:11 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Changes in v2:
> * Removed unnecessary limit==0 check, since this can never happen
> * Renamed rxfh_max_context_id to rxfh_max_num_contexts
> * Incremented bnxt's max to keep user-facing behaviour the same
> * Added patch #2 to validate the max is sane
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: ethtool: fix off-by-one error in max RSS context IDs
    (no matching commit)
  - [v2,net,2/2] net: ethtool: check rxfh_max_num_contexts != 1 at register time
    https://git.kernel.org/netdev/net-next/c/ceb627435b00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



