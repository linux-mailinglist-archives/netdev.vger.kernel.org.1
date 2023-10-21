Return-Path: <netdev+bounces-43180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B47D1A76
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6757FB21507
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A631802;
	Sat, 21 Oct 2023 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqWlhtlJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12E7F2
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC66C433C9;
	Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697853625;
	bh=W95y2ZrmEW5YWfqPVAzYpDb3xCpVFhKnRA1Mr6a916I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JqWlhtlJYjhyY8Cvi9e31/Uw6o0iLuGxImdSo5YoKpaxt4ZqEd4+rJwxu8w1ZpZT1
	 fiE9mlDnxwvKQAtAgGUe23G0edzD47pl50thStohfRQgHRCXgp3kPMy3w7UOfB/cBI
	 UjwhbRs+kQTq/JrYELqNB2cAVbhBAgObqXbFYcZ7pvx9t1kQEkxdEd1/ify9Fr2Gwg
	 IxcWJjB750y8CDOxoayShAQmO16V9i+cjKxDRsaUXfzBFp/L06hn7Qamz5iQ0aAswE
	 OOdjF8zf2VwWMJhi1BWUyzBVfOtS8iFE65FWbIk9qkCJpYVKAMdyhA53x5C8yL1sIa
	 VIEvL7AeGtdgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05F8FC595D7;
	Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: sync next_to_clean and next_to_process for
 programming status desc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169785362501.14770.1328877063192317503.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 02:00:25 +0000
References: <20231019203852.3663665-1-jacob.e.keller@intel.com>
In-Reply-To: <20231019203852.3663665-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 tirthendu.sarkar@intel.com, maciej.fijalkowski@intel.com,
 hq.dev+kernel@msdfc.xyz, arpanax.arland@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 13:38:52 -0700 you wrote:
> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> When a programming status desc is encountered on the rx_ring,
> next_to_process is bumped along with cleaned_count but next_to_clean is
> not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
> overwriting whole ring with new buffers.
> 
> [...]

Here is the summary with links:
  - [net] i40e: sync next_to_clean and next_to_process for programming status desc
    https://git.kernel.org/netdev/net/c/068d8b75c1ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



