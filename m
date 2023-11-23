Return-Path: <netdev+bounces-50600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C67F6460
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1940B20BF3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC71B3E480;
	Thu, 23 Nov 2023 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiaFQrhP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EB266A7
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C601C433C8;
	Thu, 23 Nov 2023 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758224;
	bh=eJXnZ0gfKXRrimeSAlRK8XM5QZfNlr2df7oZi1kZMQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RiaFQrhPcpmH7s6vBzeDkk8FVMWU/0piHeS5fS9B4Vswhf/dmx7U3WtYki1Q+MnJP
	 PcJYjru+Pf8eT5cRD2hsnQCLOYU+r9M9CGkDczUeSIsTjO3lwcY6aRmTH+aFNrtg50
	 dCUhyMMJ9WoU38+XrIJLdwR8PVpknJ3BMmJBaEO1JOv7Mx8l/3msgfGHXjgN/zixYU
	 npmZ93tSsFk25QJ48VbBDWBWqdclrtLz/OSXJlEjYyV/oW7W+B221tV9OVxul7pX9h
	 Tv8fxqPvEmE7lVp3UJshen57pjoLqtXemLKYq+Gxwiefzz+JzsX1xUKGmaDJwlr8a9
	 KodvJPohKVmqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12DDBEAA95A;
	Thu, 23 Nov 2023 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Fix adding unsupported cloud filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075822406.27893.5223280468557332254.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 16:50:24 +0000
References: <20231121211338.3348677-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231121211338.3348677-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com,
 horms@kernel.org, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 13:13:36 -0800 you wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> If a VF tries to add unsupported cloud filter through virtchnl
> then i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but
> this error code is stored in 'ret' instead of 'aq_ret' that
> is used as error code sent back to VF. In this scenario where
> one of the mentioned functions fails the value of 'aq_ret'
> is zero so the VF will incorrectly receive a 'success'.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Fix adding unsupported cloud filters
    https://git.kernel.org/netdev/net/c/4e20655e503e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



