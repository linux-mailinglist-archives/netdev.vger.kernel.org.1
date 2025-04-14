Return-Path: <netdev+bounces-182519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C52A88FF1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668AF189A015
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6C1F4604;
	Mon, 14 Apr 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhW3+LTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780E1922E7
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672196; cv=none; b=KvTxvrolQvm1Jq0EP8fesEux94iWrFZ6aNEvjtY8TW97sjMo8SCH/dLbj7A6AFsyEvQjkMKmUXUIhHBu07efvQHckskgeYWLjEC+qzu7N9oIHClQ8mfz+sWOynStJDhDjDnMVT+Tgd0iSxfzwMB01IOb8mYqA4I9tDhc3bWPNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672196; c=relaxed/simple;
	bh=cHyLVM3GWf0eEzKVS3C3T8NCX6e8fIJDLfYmHRcCq34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkpBsxJhpqKOcYNozemsJDSot1if4cAGN0Fk1Glq1u9FUGhSnlbH7+FZYs3oKHohMYlQkS5hmB7CmYLwfmbLfCCiPqZa/63lX9BlcT2uiD2rgLOoPMBzUmR/r7Tvf0jV0qacit2oAyktkU3cmb0WH1LXmXzNs++jwCMwfUIacHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhW3+LTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93716C4CEE2;
	Mon, 14 Apr 2025 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744672195;
	bh=cHyLVM3GWf0eEzKVS3C3T8NCX6e8fIJDLfYmHRcCq34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FhW3+LTkPD1JRTFm7QHjvWJdlFQCIazTyB9g+9s5AmUZXBpuHR7hTXsL5O89eTB/z
	 ErV/+gxZE3ZvyxJvEPgq31nHAiWxuUDevgMMzOgMbW6B0ygrw8Y8w73EbEPLjj1kSN
	 Obbs0BwHhjAbiA3oB8txbKoq2h6qwS81Z/XD06RMkA1TDJbe8HvAIW1MrIVIncLbdc
	 bVgdzYQm+PMTf20Wk0wPjt0d05L05hmovmC4Oav445AdR5q2Yqbd0YnozCKUnK/daN
	 LG0qVfWmmBWV2/BeKKTFU+HveW6Kd72wwFIBYDksRjIH68qo6+C5Ru3SvwGztkEi5i
	 n4j/S0q7ez4YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC63822D1A;
	Mon, 14 Apr 2025 23:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] igc: Fix PTM timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467223350.2068134.8272906299542993016.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 23:10:33 +0000
References: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 christopher.s.hall@intel.com, jacob.e.keller@intel.com,
 vinicius.gomes@intel.com, david.zage@intel.com,
 michal.swiatkowski@linux.intel.com, richardcochran@gmail.com,
 vinschen@redhat.com, rodrigo.cadore@l-acoustics.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 11 Apr 2025 09:28:49 -0700 you wrote:
> Christopher S M Hall says:
> 
> There have been sporadic reports of PTM timeouts using i225/i226 devices
> 
> These timeouts have been root caused to:
> 
> 1) Manipulating the PTM status register while PTM is enabled and triggered
> 2) The hardware retrying too quickly when an inappropriate response is
>    received from the upstream device
> 
> [...]

Here is the summary with links:
  - [net,1/6] igc: fix PTM cycle trigger logic
    https://git.kernel.org/netdev/net/c/8e404ad95d2c
  - [net,2/6] igc: increase wait time before retrying PTM
    https://git.kernel.org/netdev/net/c/714cd033da6f
  - [net,3/6] igc: move ktime snapshot into PTM retry loop
    https://git.kernel.org/netdev/net/c/cd7f7328d691
  - [net,4/6] igc: handle the IGC_PTP_ENABLED flag correctly
    https://git.kernel.org/netdev/net/c/26a3910afd11
  - [net,5/6] igc: cleanup PTP module if probe fails
    https://git.kernel.org/netdev/net/c/1f025759ba39
  - [net,6/6] igc: add lock preventing multiple simultaneous PTM transactions
    https://git.kernel.org/netdev/net/c/1a931c4f5e68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



