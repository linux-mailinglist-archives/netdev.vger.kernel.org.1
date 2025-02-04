Return-Path: <netdev+bounces-162786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF9A27E3E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E99B1674BE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A3221DA8;
	Tue,  4 Feb 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0tXU7ME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331F21C177;
	Tue,  4 Feb 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707629; cv=none; b=sEDiqFZuBAEuVH4Yyt3hQ/Tub1ZnJc8yh1878edEpbNO+S80Ks5nCo6EX2KlWEsnl3ul96BlH4q646z0l6IYeNdRW2hG+dbs1/n+vjVXWMhUfjvs/utI+zeKVUC7nUq0dr5Has9l14KhzzrU6O6ts3kz8OF3kfhgxL7zYSY5RYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707629; c=relaxed/simple;
	bh=0CeqCLLGHrdd1M4HmEQCnfV9FYNGcU4yQO0upPukByM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aiwNF9VM3qtPHFPls2SrDGWwY95AUM67XvPignNQ35X8dFk0kY/1sbFY5x2L918OEewJVgZIDEPYlZCSS369YAnDG5UJ0wwt76PYHXWU6PcKhAl16e2O/UBNJvjtO8N6u5LKxEIUHAWlQlw6ZbW2X1I7XbC3TwZmTgM9So8hyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0tXU7ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB39C4CEDF;
	Tue,  4 Feb 2025 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707628;
	bh=0CeqCLLGHrdd1M4HmEQCnfV9FYNGcU4yQO0upPukByM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K0tXU7MEh5aaZsiXpoKcCTWu4we0XfJvJ163Vek4u0t0px5iq8TYjgsi/HwyFk44o
	 5Qtr6ZPKAxGcj4BXvOX5dsYkR0FWBsfnG6qz+PY687Rb5dunvsByHQpMhbIXM8VApg
	 ksrw0ua+jM2QAgE9Cmpi6wNEnp5pGaZt7XEUzspKQiZ79RIR1me9X/yvsBLzn/ldCj
	 6TDQEp1InY7rhk/LmoaPYpV0bIezeErNqzJA++dwR5BksYhHL+MYpgt1DWkSXsyyUb
	 fOik2z5GbTGKgiJHqU6mG9c5+BXn3ZHpVXr0QsBItke9Ul1LzOsIpVTXwSw3L+Ytq7
	 0h/sUjgrmRmWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC64A380AA7E;
	Tue,  4 Feb 2025 22:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: qed: fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870765550.165851.1487563234509959441.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:55 +0000
References: <20250203175419.4146-1-algonell@gmail.com>
In-Reply-To: <20250203175419.4146-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 19:53:24 +0200 you wrote:
> There are some typos in comments/messages:
>  - Valiate -> Validate
>  - acceptible -> acceptable
>  - acces -> access
>  - relased -> released
> 
> Fix them via codespell.
> 
> [...]

Here is the summary with links:
  - [net-next] net: qed: fix typos
    https://git.kernel.org/netdev/net-next/c/185b1d53ea54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



