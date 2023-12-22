Return-Path: <netdev+bounces-59904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DE81C9C5
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8961F25FF8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5317993;
	Fri, 22 Dec 2023 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcOQscON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E818C34
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D070BC433C9;
	Fri, 22 Dec 2023 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703247626;
	bh=dPPuCkOiZDPqth/dkNqxCzcTEt/rvx5sLFCvDL7ZzzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UcOQscONbEtWKd2O6oWpPeejsdQLRCs3kpo/Zi6Fswkf2ja2ntePX3RhyFAougSLh
	 tAIZPdRbdJ6GSdnHM2fw+ZJh+cPNWKg5CJJbAASOVV5GYupuAs0U07UgPkSwwn0Tvx
	 mVzhQLQyKxcHegB45+uxvxBUwQZz12oXIxaBSkHEl79NV5eneyeq0uvHKPnzJ4JZva
	 Xc5+XGVe/Q9Sn1uiS+EWXclt9Jz/EuOInQj11A4VBjaXo4BKGWeg458qMge7H3C4Aw
	 0mocywrYflE6SO5BvlYE95s0oUzlJdF6kBUZdNsLxHf2yfNbBbg5vt0ZtswD1G10Bq
	 2NmersTe7n94w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B72D9DD4EE5;
	Fri, 22 Dec 2023 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] intel: use bitfield operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170324762674.22950.17567228741152319878.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 12:20:26 +0000
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jesse.brandeburg@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 18 Dec 2023 11:48:15 -0800 you wrote:
> Jesse Brandeburg says:
> 
> After repeatedly getting review comments on new patches, and sporadic
> patches to fix parts of our drivers, we should just convert the Intel code
> to use FIELD_PREP() and FIELD_GET().  It's then "common" in the code and
> hopefully future change-sets will see the context and do-the-right-thing.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] e1000e: make lost bits explicit
    https://git.kernel.org/netdev/net-next/c/236f31bb21c0
  - [net-next,02/15] intel: add bit macro includes where needed
    https://git.kernel.org/netdev/net-next/c/3314f2097dee
  - [net-next,03/15] intel: legacy: field prep conversion
    https://git.kernel.org/netdev/net-next/c/4d893c104cda
  - [net-next,04/15] i40e: field prep conversion
    https://git.kernel.org/netdev/net-next/c/9e3ab72c0499
  - [net-next,05/15] iavf: field prep conversion
    https://git.kernel.org/netdev/net-next/c/9b7f18042d4c
  - [net-next,06/15] ice: field prep conversion
    https://git.kernel.org/netdev/net-next/c/23eca34e5558
  - [net-next,07/15] ice: fix pre-shifted bit usage
    https://git.kernel.org/netdev/net-next/c/7173be21ae29
  - [net-next,08/15] igc: field prep conversion
    https://git.kernel.org/netdev/net-next/c/c82e64868afd
  - [net-next,09/15] intel: legacy: field get conversion
    https://git.kernel.org/netdev/net-next/c/b9a452545075
  - [net-next,10/15] igc: field get conversion
    https://git.kernel.org/netdev/net-next/c/a8e0c7a6800d
  - [net-next,11/15] i40e: field get conversion
    https://git.kernel.org/netdev/net-next/c/62589808d73b
  - [net-next,12/15] iavf: field get conversion
    https://git.kernel.org/netdev/net-next/c/65db56d5fa8f
  - [net-next,13/15] ice: field get conversion
    https://git.kernel.org/netdev/net-next/c/5a259f8e0baf
  - [net-next,14/15] ice: cleanup inconsistent code
    https://git.kernel.org/netdev/net-next/c/316a28daa805
  - [net-next,15/15] idpf: refactor some missing field get/prep conversions
    https://git.kernel.org/netdev/net-next/c/6aa7ca3c7dcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



