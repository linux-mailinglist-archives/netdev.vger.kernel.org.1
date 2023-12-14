Return-Path: <netdev+bounces-57233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E88127BF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CAB1F21A78
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD87C8CC;
	Thu, 14 Dec 2023 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNc575it"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC982610B
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB77C433CC;
	Thu, 14 Dec 2023 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702534231;
	bh=Gyd7l2N4fILLMF930hx7t53+oRJEEp1n6+Zr9HVu2IQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YNc575itS/LUeZWHEkn6HLrA0l/nVuY4uuosALiwCwG1yvwbTFXgAtrDI4SdGtHQ9
	 bUsI4Cj9XGBRABiJsFkKii+7uLNyMTBqiwWnDG9e4i9svghrAFvq91ybunQB5XFVwq
	 1Tz45SSpD9OGDaoUpU6DT4ygADLPv2wa/eUe9DNakrX54gZPLjxcHFzVz40piCL81q
	 CUih2Bv5Ln1ljtco4BRdqQy+niFflRx9jmwhi3YLGuxb/hHdwUC1acFv/MF3xmyATh
	 qV9zUmfOYl/pOPIbPN46PffwKMPKqfdbzIU4sPAfHQW3H9EmOmwK4Jvfy/vKfP7Zvw
	 4Xmsy6IZF95MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56182DD4EF9;
	Thu, 14 Dec 2023 06:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-12-12 (iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170253423134.14576.84211628284681145.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 06:10:31 +0000
References: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 12 Dec 2023 12:36:06 -0800 you wrote:
> This series contains updates to iavf driver only.
> 
> Piotr reworks Flow Director states to deal with issues in restoring
> filters.
> 
> Slawomir fixes shutdown processing as it was missing needed calls.
> 
> [...]

Here is the summary with links:
  - [net,1/3] iavf: Introduce new state machines for flow director
    https://git.kernel.org/netdev/net/c/3a0b5a2929fd
  - [net,2/3] iavf: Handle ntuple on/off based on new state machines for flow director
    https://git.kernel.org/netdev/net/c/09d23b8918f9
  - [net,3/3] iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close
    https://git.kernel.org/netdev/net/c/7ae42ef308ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



