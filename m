Return-Path: <netdev+bounces-30610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1F788316
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AFF28139F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4AC8C4;
	Fri, 25 Aug 2023 09:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848522595
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08EEEC433CA;
	Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692954622;
	bh=AhBgYmVf2KRo4P3RovGn2rkqSh4TjTwT9MBgTetHoxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dm5F59h+pKrxZes0MawERc7ahOdcRg8NAgJYqOw8y9Dj6riLuqwQ1ljj9WfNu/jf8
	 X7wmGvLirxEi0OmM9XP77vd7eHE/KLB/KAnh9IDtJhWD5n6X2AgE5PrjgJ9XrrDC6y
	 l58k7tYylxfw0dkWwdEgxkqMRLX9JxP7/kdmy6j9Wu7km1TQ/ZIXdfZsXIPrVsJYrP
	 VHPGY8NyvYkvz0hycv+kJfpAg19EpPTLOJwaGogjvV6el/FcLGbBlSlH9hFb5CpN0v
	 HV1sal3x3CMzUvTudgqIo8xiDNonYJK3vlJx7moh0MDui0POj71ozDGij0nXiOT41e
	 QlWb3Rfjkp0GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2125E33084;
	Fri, 25 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: avoid executing commands on other ports when driving
 sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169295462192.4538.14708258610976137494.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 09:10:21 +0000
References: <20230823151814.3492480-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230823151814.3492480-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 richardcochran@gmail.com, siddaraju.dh@intel.com, sunithax.d.mekala@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 08:18:14 -0700 you wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice hardware has a synchronization mechanism used to drive the
> simultaneous application of commands on both PHY ports and the source timer
> in the MAC.
> 
> When issuing a sync via ice_ptp_exec_tmr_cmd(), the hardware will
> simultaneously apply the commands programmed for the main timer and each
> PHY port. Neither the main timer command register, nor the PHY port command
> registers auto clear on command execution.
> 
> [...]

Here is the summary with links:
  - [net] ice: avoid executing commands on other ports when driving sync
    https://git.kernel.org/netdev/net/c/0aacec49c29e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



