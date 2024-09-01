Return-Path: <netdev+bounces-124051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A0967B6E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B29B20FC4
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559717DFFC;
	Sun,  1 Sep 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJoGnfNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC626AE8
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211230; cv=none; b=Vxqo4GbuGBBjx83s6kIT7fc1iULudcbZy0aWTC4DUG0wvbOMljCIpAh0R6r0LKQ7196KbCq8CXEPTjQQBABuvbJiMQD4QqEwO/EBV926z78Qa+BELf4fQjG3q3h+gYH9sgibdCaA9McW4uo5Wk5q6pLEQY39iiWV4aFU3LeH8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211230; c=relaxed/simple;
	bh=fwtKcgIh89658jkP17HrD+zKN88Ig1PwYVlN5hbkrQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oTdHfW6RkVl7YgtTWDRcTYYWXNHF3gKo8119W5yyZdN+AIDNgK7dRbDkVWCdHVe8CcEX5OsLP7n7SYg2ImE43T5Glc8mTnqdbfGa2RZti5M9b2Ia9OkyaKHrT6mKC1q9/Lc+C9Tq9kYp3m/z8k+v828MiC9we0AIrjm1+0OEr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJoGnfNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFADC4CEC3;
	Sun,  1 Sep 2024 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725211229;
	bh=fwtKcgIh89658jkP17HrD+zKN88Ig1PwYVlN5hbkrQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJoGnfNb2kxLWHv3r3zV4PaJyn9ctmvxiZZE61YeC8hO3q7deNuEqoSZbb4+HBeO0
	 Z106LDMkbHcMUzmQtOvvucppWq13eodmL9nC4RCrgf7S0TxK2kpwpTjPUNaO+ERSYr
	 apBDz0Y4EFxf1G63zoZyJ+IvIRZstOYrvJm6qHrhkkNXSoOLHqcSKXjYiqaCUS5Hce
	 aKVZSnZpapcCYcW5IZCbPrEEX2PM81Etze8mcgWXVYo8LnIjIFGenuTY++koPhQJF6
	 ck47MB/WJqMLWV5C55zNK2QHQo8+z86C7F4JvauIWUD66pOwSNAl8V1ADSty9JOIqN
	 0/r/liAuXWp6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A13822C86;
	Sun,  1 Sep 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: mctp-serial: Fix for missing tx escapes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172521123053.3369914.3873085993439343698.git-patchwork-notify@kernel.org>
Date: Sun, 01 Sep 2024 17:20:30 +0000
References: <20240829074355.1327255-1-matt@codeconstruct.com.au>
In-Reply-To: <20240829074355.1327255-1-matt@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 15:43:44 +0800 you wrote:
> The mctp-serial code to add escape characters was incorrect due to an
> off-by-one error. This series adds a test for the chunking which splits
> by escape characters, and fixes the bug.
> 
> v2: Fix kunit param const pointer
> 
> Matt Johnston (2):
>   net: mctp-serial: Add kunit test for next_chunk_len()
>   net: mctp-serial: Fix missing escapes on transmit
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: mctp-serial: Add kunit test for next_chunk_len()
    https://git.kernel.org/netdev/net/c/4fa9c5181cfe
  - [net,v2,2/2] net: mctp-serial: Fix missing escapes on transmit
    https://git.kernel.org/netdev/net/c/f962e8361adf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



