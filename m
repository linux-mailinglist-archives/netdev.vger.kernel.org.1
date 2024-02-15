Return-Path: <netdev+bounces-72109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215A856941
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3CB287340
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AB13A25F;
	Thu, 15 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P245bSeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41751134721
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013431; cv=none; b=Jz1qtX2/O9NZb4MWDCsK59xlIfeonx7F1ODnrjQrT4uLLXWs23j0YaJeOKvVCKYeyNYTnoB4UscH+OxJFv7kSUIcRX/PFIIWSXqkiNXEQlqNEt2JUct4e6vmyCTNAIhONkZRzCNSFyzoG/AmTfZYr3j5NupuOCxzShvIqU/e1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013431; c=relaxed/simple;
	bh=zUj8sEw6WIj9Uu+E3bmygk7fwhSrUmgFzltDYrJ5HBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B6l6hVx9tHXa1HHrutW1hyEjv6V8QscRzby2Uh38Gp1cpXfnNC7XdRBZdmiZgYbKSMf6h54896pr8vg7o62zTqsX7B6M7pKtkfTtwH8G33j/1BC6FCCjwSuBsC7nTVFgo55aAXuar13+4zK35e/5mSSmyQ7Hm5AHFV0og+Tr0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P245bSeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6701C433C7;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013430;
	bh=zUj8sEw6WIj9Uu+E3bmygk7fwhSrUmgFzltDYrJ5HBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P245bSeYEgcpnVDNhY+ClmbZtXGIEpxu6tQ+jM4+M4CRw8/myDxuXqKzvqX9G+1a1
	 1mUf4CO+3BB4hFKsyUc5jiCuAETjmuYqZmU6yyIgqjEAI5m7gdNjzNiAIKkG55aEmO
	 Wvpyfph87qlMYtvwXu/SeCzY6CwEK4kf/zLUKKXAMC1yio1uEdGZT3OBSbGT9zsoDd
	 njw2s1iiWlmy/3K6SkUGdaeFgjPnCqZH4JhztmSKkOjaS500ZFEPGEQ9Eq0Yb5K/Ek
	 tuYwz0V1uA0KwszZZOAG7eqYnnHlMTlDDjf6d4XXePJIMGWjc4M3EMGbSY1cPYnPmU
	 MKa72EpbtPB4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE5AFD8C978;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2][pull request] Intel Wired LAN Driver Updates
 2024-02-06 (igb, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170801343077.17977.10087077974025007783.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 16:10:30 +0000
References: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 14 Feb 2024 10:03:43 -0800 you wrote:
> This series contains updates to igb and igc drivers.
> 
> Kunwu Chan adjusts firmware version string implementation to resolve
> possible NULL pointer issue for igb.
> 
> Sasha removes workaround on igc.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] igb: Fix string truncation warnings in igb_set_fw_version
    https://git.kernel.org/netdev/net/c/c56d055893cb
  - [net,v2,2/2] igc: Remove temporary workaround
    https://git.kernel.org/netdev/net/c/55ea989977f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



