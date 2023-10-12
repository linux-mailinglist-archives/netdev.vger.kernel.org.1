Return-Path: <netdev+bounces-40373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196B27C6F71
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4454E1C20F63
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F582942B;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhdue6yi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E372941E
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E976C433CA;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697118027;
	bh=2nM5zaOqZbmd4ZhujnMcOSZBIhJQpWG9cLyspQCKOus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nhdue6yib9aCgermGJlXvK17udWbD/GP5Jn1rvCgxzxmGUy/T55e0cvRLpN48kpe7
	 pyWTgomTagUFV0KNPhVq4RVnFjWkQPpUqlJ1+s2xgegTnSFkKptBFj7dNdIBS2ZV3o
	 r4JONQWFl/2U+2BejBO0eNRJ2r1UQYSO9IrQi6eNvdi8hjO0EqFYg2p87blYLAtUOJ
	 M/+s9pAD9jY4Oqz287cmUapncAZZ4Etno6c56sNE7DJSMrDr/UYphA/Q3pIwyt9bQD
	 Ex3R7qMH+aILvDYPIatbULwrbaUbAOG4iHNOEnPMa0GL0g24G7/fcJUNiQ3dLyiv0M
	 ESBi9qwCpsZJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03B80E21EC0;
	Thu, 12 Oct 2023 13:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/1] net: add offload support for
 CHACHA20-POLY1305
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169711802701.13816.13270935364312409222.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 13:40:27 +0000
References: <20231009080946.7655-1-louis.peens@corigine.com>
In-Reply-To: <20231009080946.7655-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, leon@kernel.org,
 horms@kernel.org, shihong.wang@corigine.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Oct 2023 10:09:45 +0200 you wrote:
> This patch adds support for offloading the CHACHA20-POLY1305 ipsec
> algorithm to nfp hardware. When the SADB_EALG_NONE path is hit use the
> algorithm name to identify CHACHA20-POLY1305, and offload to the nfp.
> 
> Changes since v1:
> 
> Remove modification to pfkey
>     The first version of this series modified xfrm itself to add new
>     things in pfkey. We were informed that this was deprecated, so in
>     this version the name is parsed directly as suggesting during
>     review of v1.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] nfp: add support CHACHA20-POLY1305 offload for ipsec
    https://git.kernel.org/netdev/net-next/c/04317b129e4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



