Return-Path: <netdev+bounces-52504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7D7FEE6D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFD928207B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517A3E494;
	Thu, 30 Nov 2023 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNiTmBZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577323C682
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC217C433B9;
	Thu, 30 Nov 2023 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701345624;
	bh=CUreQza/C7c64MC/0Qvm+BYMYkuQB3B3gg2esZpOBwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fNiTmBZn/NdnM0mMK2odLgyucOhDeIX8d9Gm0kMdK8EVeHDuRzELinO9JxPEYxY/d
	 5P0nNLxGA314A54LgxtDINW8oj55gOogah0Y3slI5+L75jFZnbpXUr6X8PWX2kKz3i
	 HGt1bI82tBCYcBNlktviugZ7BYH5LwGH6Xa/uhtBFqi72pSoR29yfHaxC/JMrx7LAd
	 AjIOqVuX0xaiUfq7XFIK+V/fP0m6kLhhbxIGLmQ07y3WX/YToeSfMRPHr4ctDm69yt
	 d4T/724cZwFonlMljDXhclg2PBWuys9CVN5EbQup9PlEDYdPW6V9sC27AOJBaw4p3M
	 7JC72ioZXONow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A013FDFAA82;
	Thu, 30 Nov 2023 12:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next 0/2] devlink: warn about existing entities during
 reload-reinit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170134562465.19177.6196540342532643128.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 12:00:24 +0000
References: <20231128115255.773377-1-jiri@resnulli.us>
In-Reply-To: <20231128115255.773377-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 corbet@lwn.net, sachin.bahadur@intel.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Nov 2023 12:52:53 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Recently there has been a couple of attempts from drivers to block
> devlink reload in certain situations. Turned out, the drivers do not
> properly tear down ports and related netdevs during reload.
> 
> To address this, add couple of checks to be done during devlink reload
> reinit action. Also, extend documentation to be more explicit.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] Documentation: devlink: extend reload-reinit description
    https://git.kernel.org/netdev/net-next/c/15d74e6588a1
  - [net-next,2/2] devlink: warn about existing entities during reload-reinit
    https://git.kernel.org/netdev/net-next/c/9b2348e2d6c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



