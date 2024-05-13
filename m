Return-Path: <netdev+bounces-96183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58B8C49BD
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309A01F22643
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B784E16;
	Mon, 13 May 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxCcBXVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9F84E02
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640629; cv=none; b=YzWHg82bfPEcICnZZNGKVxW5oa2F8jo9AcJ/LEMoREeBeXTyBSxg3uWjFlijaCiMMXiaH3WQEOKmMozvxJQCJNceDCnWdtL+1l8KkNwMhCL5J7VjCTP15Yq5nMyfxQ1KZBIPjRKzF5Ebos5Pu//cQldfIo0X8+kKkWUL5z/LjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640629; c=relaxed/simple;
	bh=GJkybS81Yl9yigzQMleE14WEduSfp5RS11JY1dTRoeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NLHkMGLrWHHUFbVU8R2HHEi1WmS37c8sEDeHbmzSbKqvteaDL4yoAAxnzo4/X1FK/zYMTmK1lzHoveTFZdsQ6g9PZr0eDsRmNiO8fQMbLwx2LKTa80ObvPm1k3QPF6IB+QnLeGveo9LcNbN3/2fcSH2hdRjOxfcVdnLtkbtPxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxCcBXVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF8AC32786;
	Mon, 13 May 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640629;
	bh=GJkybS81Yl9yigzQMleE14WEduSfp5RS11JY1dTRoeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CxCcBXVlXpT9t88h67E7BSlKqoWlnAp4jqJpq4x/uzZQ0KWQFly9tF0onb8qsRN4B
	 2fNQ8lsm2XrgnQnzWZtWY0n25lqLaG2a1/dXLBsaoYL02pT3MTnV+OP/4tzdLGZqqw
	 TixWT6/UlLrhCOUcwenzRf9i7a10DoomCE/apMRFbfuljxcsWE1uz1hTVXKYehFjQW
	 fpzNmKSEMPcY1GJfXW9MfEwGywlZKPhRMw7AIQ0ArGR+ou4TLk7TyiNKaRN7VGjf6f
	 BLUMOpkCWucGgstkAZqjwh/u6uKd9YJfOyBrNuHCJ9KRmEReLztFrlAzSYO0G8LXTK
	 /3XU/sq8BAxDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E510DC43443;
	Mon, 13 May 2024 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ynl: ensure exact-len value is resolved
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564062893.28873.1783841297383261530.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:50:28 +0000
References: <20240510232202.24051-1-a@unstable.cc>
In-Reply-To: <20240510232202.24051-1-a@unstable.cc>
To: Antonio Quartulli <a@unstable.cc>
Cc: donald.hunter@gmail.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 May 2024 01:22:02 +0200 you wrote:
> For type String and Binary we are currently usinig the exact-len
> limit value as is without attempting any name resolution.
> However, the spec may specify the name of a constant rather than an
> actual value, which would result in using the constant name as is
> and thus break the policy.
> 
> Ensure the limit value is passed to get_limit(), which will always
> attempt resolving the name before printing the policy rule.
> 
> [...]

Here is the summary with links:
  - ynl: ensure exact-len value is resolved
    https://git.kernel.org/netdev/net-next/c/ec8c25746e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



