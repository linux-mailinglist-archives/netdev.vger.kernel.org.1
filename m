Return-Path: <netdev+bounces-118262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E017951189
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917381C20888
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5618E3F;
	Wed, 14 Aug 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxFtn/nS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AA1CD26
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598433; cv=none; b=dD2ftU1EKtQKs6AwTCwwGu2Y26yn0DkXGLoMG3r5wA2eWYCrCbJxSc+jpOrdaoK+6Jfgt367J6CpYTqN0WYFUUWrByaIMn3fqwkOamyrHOUcT78Jsowz0Geuk9zOTuqjmVxrEsnCUZHqqthyhQ4BPcjnxojcBE/irDMUmBJRDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598433; c=relaxed/simple;
	bh=N8crpV6vz+rLLFotOSTszZyGxBSYfmmnSSwaWOQ5Q+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ff+XzH5t63+Tc2ID0dutLYKT17q0QUcsFRSJWrOL8wUHBxAG3HfkibElmLEM9tyYz1S6iEBxayRFfwoV+11Bq/aPKfaWHHkdj64pQO6l6fIYxAu08ael7Uz3MfFpPXloCwRepwt1ZNNf3s3x+DA43qe73o2t9nMRm2tFPEkodjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxFtn/nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A9C32782;
	Wed, 14 Aug 2024 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723598433;
	bh=N8crpV6vz+rLLFotOSTszZyGxBSYfmmnSSwaWOQ5Q+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sxFtn/nS5qfH3Tj3wLOsxiEDOMnn84AfLnPgFyAmd+QzLlhanqQKLzGL9RtsNTUg/
	 OLcAg8WW670qlppPI/ZvAmwMrbQVEBQ44ro2+tNqVwDHU1TgD+gBOCC2B7g1Tji/ib
	 9iNgLPwL9nUHR4aoXVtJSI1uOYTTmyT16DMtrNRvj3sOaGvp0zVTt8iM/osT0Wv8Fh
	 SZSv1VibOQd003BkdsG28y+SY5wjxQHLRGOGKBb1C2zrV7FuG1zkzyFKn/+sxOVayj
	 mEuWySaYSrLj721/iFaBysT+0lzQpoWamH3tbIn5Mr8iknXEZUG/Ea86ZwRogSPxS1
	 ztBCBrXIg0/qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C423823327;
	Wed, 14 Aug 2024 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] gve: Add RSS config support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172359843200.1830772.17702098729253183236.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 01:20:32 +0000
References: <20240812222013.1503584-1-pkaligineedi@google.com>
In-Reply-To: <20240812222013.1503584-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, jfraker@google.com,
 ziweixiao@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 15:20:11 -0700 you wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> These two patches are used to add RSS config support in GVE driver
> between the device and ethtool.
> 
> Changelog:
> v3:
>  - no changes, pure repost to get the patches into patchwork
> v2:
>  - https://lore.kernel.org/20240808205530.726871-1-pkaligineedi@google.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] gve: Add RSS device option
    https://git.kernel.org/netdev/net-next/c/58c98d0cd4f8
  - [net-next,v3,2/2] gve: Add RSS adminq commands and ethtool support
    https://git.kernel.org/netdev/net-next/c/fa46c456fa6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



