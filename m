Return-Path: <netdev+bounces-246814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CADCF1476
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 21:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A52E30102B0
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3A2EB84E;
	Sun,  4 Jan 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioJBOVnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628001E3DED
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767557833; cv=none; b=ppYqd7t0kU0BW1WXtSySDs9OqvAy54du516ied1AG3lRy+BxFulkABqxh4Yv5whVjYnHpW1XuaM41q1OuG7puL77aUcVsEHPWh2sySxSpoPKsxtjebo0fWGaXRrozomfhhwUWa6J3lM1M6OVRW9J/AC2NA/eDS801cS53nQZBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767557833; c=relaxed/simple;
	bh=cKOSnoVOTi5Exf1RmyrwoAd7fZVqfcmh4VBMd+WH9qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LKvYNtNLxflyPdbJcAG46LC5qhmQZZ/6ZvlkXWRQGYrvqmfjtqkFyEzwKwxBSeWBcFWxeSX2QyozBwI9Em/cbgJtNxvg1L6iv9Xorz0+mZIrXbDYPzTKcoFbcEDIh2M3cVx3so3yToUsop25Szer3/MeCBK+y8U5/411oqBP4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioJBOVnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E105FC4CEF7;
	Sun,  4 Jan 2026 20:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767557831;
	bh=cKOSnoVOTi5Exf1RmyrwoAd7fZVqfcmh4VBMd+WH9qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ioJBOVnNMHmzLf0NQN8CpysyyZPQCP4DOx9ce9ztKd827Z0P67dH63emY52tprKQg
	 UR3jvb5k9tdxKvxdmJ01cqmyuDvz5IRvb6/05IYVVw/xGqV+ety9ej6RSytBNWX1zu
	 iniv7ZK+/rwX0Xoqh9I11/TsicPR+D/7hMn8d4dmIC/9IfCkQvpDdgIV69MSALZkCJ
	 c5dV0eD3rMVdAcLX3sbrA6hqm4yTq6drpGfucmxMd6Zz6WBgqH/xJ1/Hj9p819P080
	 RY/TNtMMdrxxi+Mmcd3aeWMuF/ByZFiLeObYhGItFXEDTnnN4j1MrL8op9Dh/joRCC
	 eaKN0aQ34VKgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F295C380AA58;
	Sun,  4 Jan 2026 20:13:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Update email address for Justin Iurman
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755763052.155813.15487618694758455412.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 20:13:50 +0000
References: <20260103165331.20120-1-justin.iurman@gmail.com>
In-Reply-To: <20260103165331.20120-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, justin.iurman@uliege.be

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Jan 2026 17:53:31 +0100 you wrote:
> Due to a change of employer, I'll be using a permanent and personal
> email address.
> 
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
> ---
> Cc: Justin Iurman <justin.iurman@uliege.be>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Update email address for Justin Iurman
    https://git.kernel.org/netdev/net/c/1806d210e5a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



