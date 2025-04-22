Return-Path: <netdev+bounces-184612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A8A96621
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E67D3A8C67
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9A1F12E0;
	Tue, 22 Apr 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBDEcvgd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30C1EEA27;
	Tue, 22 Apr 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318401; cv=none; b=UueEy4tHiU3nYbd3fK4OP4cbsGgJ79hUR1wAqEpTkSszSR7dJ6lt5uZWQqCUAFdNaUUYWXvw+bSOjKb0VndZv9x2F3uNt3oMQN3ocb7CWWW254EwrWZoOlkI3BWc2YKbU0JrIbWd7Enp2ufwNiQOJjRzN7Z7EknBmie5z/tkNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318401; c=relaxed/simple;
	bh=4LnIRp9D/8OmSuE1d+taUXVsOhdHN5TkiGn8ODV+s9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DSC8yiawuf2eF5n+bz6VTX/kbZpSeugLgaPmIkuqFZOt4QWXaYa4wLokvpyZwL4jXdNgjqqzda/j4MLZDRZniQhq80FZ1ZX0xI8ks3oMKhIagbBxlIABMzZVFlX+X/upHyY/fJQgWxzHqmtUsIHknCQVcDki08o81kgsEBJYkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBDEcvgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608A1C4CEE9;
	Tue, 22 Apr 2025 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745318400;
	bh=4LnIRp9D/8OmSuE1d+taUXVsOhdHN5TkiGn8ODV+s9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBDEcvgd5VXKShzvaTtYa/7AzFo40E5wesQ2yKRP5YItM+Z+vtHMqBBbQ3qUb3TJ1
	 J+gNKOEGl6PQ5LUtpZj9tkBvePxeFySw/gPJhVGoe3EGOGC+g6YATA2BjNU9yXm4tn
	 VxMto+PeB4e777G35kCjb8aKh5jEJazLbMKKCdpS+Tzz95UvLHZAN6jYrO7vhcJRc/
	 n7ezwrBPzourSzPJbJIf/84pAWc/19MKzkzPBiMyOuEbsBi3o1dmY0XCjxn7Sh7AcI
	 /YQ43YUm6JcKO5l2dehp6sOW48e39zxffFB7JID1YbJyHQvMV3UpkgzSqp9cOiFEtH
	 KYRuteD2FNW0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC66B380CEF4;
	Tue, 22 Apr 2025 10:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] ionic: support QSFP CMIS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531843876.1515168.2615748033975707416.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 10:40:38 +0000
References: <20250415231317.40616-1-shannon.nelson@amd.com>
In-Reply-To: <20250415231317.40616-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 16:13:13 -0700 you wrote:
> This patchset sets up support for additional pages and better
> handling of the QSFP CMIS data.
> 
> v2:
>  - removed unnecessary index range checks
>  - return EOPNOTSUPP for unavailable page
>  - removed obsolete ionic_get_module_info and ionic_get_module_eeprom
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] ionic: extend the QSFP module sprom for more pages
    https://git.kernel.org/netdev/net-next/c/c51ab838f532
  - [v2,net-next,2/3] ionic: support ethtool get_module_eeprom_by_page
    https://git.kernel.org/netdev/net-next/c/9c2e17d30b65
  - [v2,net-next,3/3] ionic: add module eeprom channel data to ionic_if and ethtool
    https://git.kernel.org/netdev/net-next/c/0651c83ea96c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



