Return-Path: <netdev+bounces-59960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF081CE4A
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C9B1F22D67
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8372C194;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn3vC1SL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DA2C18E
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 437D4C433C8;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703268628;
	bh=qy9AawdOSFU2lVQ4r1EPyOui1XrozFgR9H3dkO9iGCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mn3vC1SL4iZwZUwXQTCW0lQpK3iNUuUZnXYkGPlF0u9PFYlyUyu7mx4Gx+ynvTccu
	 eLgtVzIifWjYCnDc6Qc+piOnCyfGB+ZsnmTzFSSrZA1UK/JmieISsXoiFGxmyhm+lx
	 EOiT3Bt/dreQ3ha2vQ9y5W7SmfSTFTDUljrpmZFHT9vW9TF0uPPQUJA6Q555ICM5Ix
	 rrhq8fhfMnSt/FaiXnXxericCKqOYAgK4Uuy2yCzfSKDBdFqakCwfp/kPP0bW13WsU
	 RtLrihDV6/zOnh5jtkxpAdOaJnZF0wFWJqslxzEDSvXw2g9tsTxvDy35dGW1N4pqnu
	 TsJJe6NjNoKtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32ECFC41620;
	Fri, 22 Dec 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 00/20] bridge: vni: UI fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170326862820.16561.9169830960501841295.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 18:10:28 +0000
References: <20231211140732.11475-1-bpoirier@nvidia.com>
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, roopa@nvidia.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 11 Dec 2023 09:07:12 -0500 you wrote:
> This series mainly contains fixes to `bridge vni` command input and output.
> There are also a few adjacent changes to `bridge vlan` and `bridge vni`.
> 
> Benjamin Poirier (20):
>   bridge: vni: Accept 'del' command
>   bridge: vni: Remove dead code in group argument parsing
>   bridge: vni: Fix duplicate group and remote error messages
>   bridge: vni: Report duplicate vni argument using duparg()
>   bridge: vni: Fix vni filter help strings
>   bridge: vlan: Use printf() to avoid temporary buffer
>   bridge: vlan: Remove paranoid check
>   bridge: vni: Remove print_vnifilter_rtm_filter()
>   bridge: vni: Move open_json_object() within print_vni()
>   bridge: vni: Guard close_vni_port() call
>   bridge: vni: Reverse the logic in print_vnifilter_rtm()
>   bridge: vni: Remove stray newlines after each interface
>   bridge: vni: Replace open-coded instance of print_nl()
>   bridge: vni: Remove unused argument in open_vni_port()
>   bridge: vni: Align output columns
>   bridge: vni: Indent statistics with 2 spaces
>   bridge: Deduplicate print_range()
>   json_print: Output to temporary buffer in print_range() only as needed
>   json_print: Rename print_range() argument
>   bridge: Provide rta_type()
> 
> [...]

Here is the summary with links:
  - [iproute2-next,01/20] bridge: vni: Accept 'del' command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e8177094d515
  - [iproute2-next,02/20] bridge: vni: Remove dead code in group argument parsing
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ba1e68f04be3
  - [iproute2-next,03/20] bridge: vni: Fix duplicate group and remote error messages
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0b8c01b4058e
  - [iproute2-next,04/20] bridge: vni: Report duplicate vni argument using duparg()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=aeb7ee297361
  - [iproute2-next,05/20] bridge: vni: Fix vni filter help strings
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=58c8a0817558
  - [iproute2-next,06/20] bridge: vlan: Use printf() to avoid temporary buffer
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=cf7b528a21f6
  - [iproute2-next,07/20] bridge: vlan: Remove paranoid check
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0b8508f44d85
  - [iproute2-next,08/20] bridge: vni: Remove print_vnifilter_rtm_filter()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=060eac10e764
  - [iproute2-next,09/20] bridge: vni: Move open_json_object() within print_vni()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b627c387eb5c
  - [iproute2-next,10/20] bridge: vni: Guard close_vni_port() call
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=7418335b4b43
  - [iproute2-next,11/20] bridge: vni: Reverse the logic in print_vnifilter_rtm()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=14c9845f05f8
  - [iproute2-next,12/20] bridge: vni: Remove stray newlines after each interface
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4f11b21e0257
  - [iproute2-next,13/20] bridge: vni: Replace open-coded instance of print_nl()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=7d8509d84c12
  - [iproute2-next,14/20] bridge: vni: Remove unused argument in open_vni_port()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=562b208a7b4d
  - [iproute2-next,15/20] bridge: vni: Align output columns
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=717f2f82f1da
  - [iproute2-next,16/20] bridge: vni: Indent statistics with 2 spaces
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=dd4e1749a977
  - [iproute2-next,17/20] bridge: Deduplicate print_range()
    (no matching commit)
  - [iproute2-next,18/20] json_print: Output to temporary buffer in print_range() only as needed
    (no matching commit)
  - [iproute2-next,19/20] json_print: Rename print_range() argument
    (no matching commit)
  - [iproute2-next,20/20] bridge: Provide rta_type()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=d205b5cf3877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



