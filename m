Return-Path: <netdev+bounces-87249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D58A2431
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05E9B2358D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3586134CE;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHx/j8Hn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56E14006
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891429; cv=none; b=NCRxZf3KEznjYcQ3G7btXMrMqcVSflBfju7EuYFdRCNvOjQ7WFK7a+oYPhSD42oFn66chR43YmxC9vgPRONH24txaUK6G0wjMg9CDOQsu5kNplTNNVGq5mV0g5fM+FQAc0a6gzb/pmM+MEmEIVw/AOY8sBcmGWOS7KA+wJnylno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891429; c=relaxed/simple;
	bh=JHHlEzf6ObIDpWNo2+n9xVQmwyim4N0flXlqMe7Tlgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uN8XlmQwk9vuXVhl7m7tIYggMG5dzW5lZpIrUjeqI/hJwJA1reCQ5DJSuF/iG4TDInObJ+1BHxxOHyofBN3K+CajgmTq8ZOGrFDBR9HghykNxtqboDIK4Dd/RqWJPqmtg8L9nLpgm3p7CiyGjS4wJHykAxlbC/yRldZE27FWb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHx/j8Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5918EC2BD10;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712891429;
	bh=JHHlEzf6ObIDpWNo2+n9xVQmwyim4N0flXlqMe7Tlgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VHx/j8HnMLG51nanOqKMgvU0N4vm/jpf5mAiaIWqvB7Kv1zA5XK4hutdq8C+wzy8U
	 KtB02of4UEpwFTxy9JlejotQhneN7Wp6uCeB0J+9t2a8zDdRmQYD5vG1XsMI8ezgMm
	 WMKl0dxFwdAP6sV/4jguR2pu1NmSfupXbyKtMJxSObbpBJA0DZdexKbykgNb6W/1mV
	 LjuYpXYBQ4RGw6E82N8h8dI3Y5wws1r6kyaw9097k5dhTiictDKees+KpWq2XwltYa
	 OxrW7tWslXiX3felhU9FNu8y3SNE4iF79+5QCI+VK3OVMapygzniIY4sl1efc0DI97
	 eSUNoURdDa1nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A7F1C433A2;
	Fri, 12 Apr 2024 03:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Remove RTO_ONLINK.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289142923.25647.4844205193108735376.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 03:10:29 +0000
References: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
In-Reply-To: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 15:14:29 +0200 you wrote:
> RTO_ONLINK was a flag used in ->flowi4_tos that allowed to alter the
> scope of an IPv4 route lookup. Setting this flag was equivalent to
> specifying RT_SCOPE_LINK in ->flowi4_scope.
> 
> With commit ec20b2830093 ("ipv4: Set scope explicitly in
> ip_route_output()."), the last users of RTO_ONLINK have been removed.
> Therefore, we can now drop the code that checked this bit and stop
> modifying ->flowi4_scope in ip_route_output_key_hash().
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Remove RTO_ONLINK.
    https://git.kernel.org/netdev/net-next/c/5618603f5d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



