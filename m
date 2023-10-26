Return-Path: <netdev+bounces-44353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0EB7D7A2E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48081C20DAD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7A4426;
	Thu, 26 Oct 2023 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+AoMZqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1DD17E2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B1CCC433C8;
	Thu, 26 Oct 2023 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698283824;
	bh=NeVDuISCRnY6ht5Wgxvebp/tC/IIZQ1NZekH1rE67V4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B+AoMZqJbKKkleEz1zaY9enDFoMgiIzpaLcTQPFRVjGsbOh92j/Iqg2JEBwCF7/cU
	 81AmgPlGkkkg/soBjN3irgJ0V0wwZmjXxy5p3dlFWB+47n6myjYXw8zNsd9Kj6Ph8D
	 pg8P9YDR4QhAXz32nKGQT579yscxQ9gFjYT87tp0vzoyyiAQYxxT3sD8Vh7x+HZAbi
	 7CnLOLNanWdNoIVLw6gykjYtph7awsT4ROtjqVSBqZdEgvpdDtPsBAl6amgB7Gd3WG
	 zVSkEQOaCoNNrPur0i2hKpQ7GFjkaHfzOjitaw32Npa1yly8vSp4q/fAOVHazjuFg0
	 Cmsh+jch+TIBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65F7FE11F55;
	Thu, 26 Oct 2023 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] iavf: in iavf_down,
 disable queues when removing the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169828382441.14693.17305279040241794804.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 01:30:24 +0000
References: <20231025183213.874283-1-jacob.e.keller@intel.com>
In-Reply-To: <20231025183213.874283-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 mschmidt@redhat.com, wojciech.drewek@intel.com, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 11:32:13 -0700 you wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> In iavf_down, we're skipping the scheduling of certain operations if
> the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
> request must not be skipped in this case, because iavf_close waits
> for the transition to the __IAVF_DOWN state, which happens in
> iavf_virtchnl_completion after the queues are released.
> 
> [...]

Here is the summary with links:
  - [net] iavf: in iavf_down, disable queues when removing the driver
    https://git.kernel.org/netdev/net/c/53798666648a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



