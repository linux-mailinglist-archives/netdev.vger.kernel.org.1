Return-Path: <netdev+bounces-109086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7122926D72
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD591F2352E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31628134B2;
	Thu,  4 Jul 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxkyIU9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B878FC0B
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060229; cv=none; b=qDt+tWOD5Jo9mE5LnesBf5zBXUPd7pcB16QaJFZHDqOCdEqu4dsFiYu3rQm0jm6TQX3hbW5Y9/t6E2Dt3kX4TSnBQW1gsgm5GtMGsTuPJ+yYc96BzPAqdML3CSiLI35kRdINhAhcyZGJJawwjXwU0d2caQuDa8l+GCdo1GE9slE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060229; c=relaxed/simple;
	bh=9Pz2WAEMTIV2qvUfthx5idHgUxFw9yAT9FFDb/2c1gU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/q9s5ghEaK2EBZ95mUCzUeSTNKtoaW7QAaoiHbFPJpWfRLRKpxWGoYrUhX7VZJd48hD/ALJM+h2x/wgXZLyR7h4gMoir3jNSHQMn+BBagpCHSdRDghBMX2z+5RsEYP1AVkTE9jzK/iLDcFrmXhdtbYzgviffhVUt16mvG3tFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxkyIU9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1793C4AF0C;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060228;
	bh=9Pz2WAEMTIV2qvUfthx5idHgUxFw9yAT9FFDb/2c1gU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxkyIU9stk78eKYJAR/4gI37W1PXKzrTao0drGLFYowpH1C+6++Bzw7iado72Rhlm
	 b/IyQ4eSBPQPufgY7OL8BdgIlUSMlN9lGunwT6flNj6AZRKCJ+W7PdCbDumFgUKzZ1
	 1uswKupK9CVva+anuhUX/m3g6Yh3jL+vPbiSZoOqc7idPoSTHf0VC0iSwnnsHx42Kv
	 v88EmhBa4c2olCsJH8OzSS75XIB8xgZz9fvVyFTuSiBCa85kvckKFzu9X5eHr8h77X
	 4sHkX4rMXNZczMV6g4Q9xxPFHp/XzBWbfM7hLvUL3MbYt/W6bK67uH9cfGn929vmto
	 cjKveJ3qqmASQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95A90C43614;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: use ident name for Family, too.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006022861.6400.11958785301867846568.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:30:28 +0000
References: <9bbcab3094970b371bd47aa18481ae6ca5a93687.1719930479.git.pabeni@redhat.com>
In-Reply-To: <9bbcab3094970b371bd47aa18481ae6ca5a93687.1719930479.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 16:29:31 +0200 you wrote:
> This allow consistent naming convention between Family and others
> element's name.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/net/ynl/ynl-gen-c.py | 52 +++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Here is the summary with links:
  - [net-next] tools: ynl: use ident name for Family, too.
    https://git.kernel.org/netdev/net-next/c/8c5a9f290e37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



