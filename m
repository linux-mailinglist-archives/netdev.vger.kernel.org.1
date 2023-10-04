Return-Path: <netdev+bounces-38005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C397B8547
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2B57BB20842
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BB1BDFF;
	Wed,  4 Oct 2023 16:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749C1C28F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 16:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A125C433CA;
	Wed,  4 Oct 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696437026;
	bh=t5lF7zTDmcyrtVRaJtcGGbLVlQjUhEBxDrNH23E4mQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgvzX3KlNOUoTwama6viLyQFlQByhU6EobgiP7xL6A1ZHN3r4b9wQUNF5C3Mv+vBA
	 UwJIpYXlzwAvcXCwD8Awe0Bvy6D/msAbxH2dmlDc7TnpFaK1NTlDQyu7agaGCLCTv0
	 KSr4Nr1H+0Fo9D3YlO64g+Fk2JRbyCwgUFsgP4fiy995AOVRjyKmwSud5Rgz2iWRh9
	 YecGqrpljkhZALqOMis1WC1ihryjBmbUCuEEwn9YIB2dIjdTPij4Pf4gluDkHGk1vr
	 waJN3n3pZycnnrLO9IvIAjtrN5OtJGh8U1AjE4oMopI13yUbq0V8y6IGiy/sUah2g3
	 bhHEXu3vcdfng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FFD3C395EC;
	Wed,  4 Oct 2023 16:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: fix linking when CONFIG_PTP_1588_CLOCK=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169643702619.24477.14593743931976028068.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 16:30:26 +0000
References: <20231002185132.1575271-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231002185132.1575271-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 arkadiusz.kubalewski@intel.com, michal.michalik@intel.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 lkp@intel.com, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Oct 2023 11:51:32 -0700 you wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The recent support for DPLL introduced by commit 8a3a565ff210 ("ice: add
> admin commands to access cgu configuration") and commit d7999f5ea64b ("ice:
> implement dpll interface to control cgu") broke linking the ice driver if
> CONFIG_PTP_1588_CLOCK=n:
> 
> [...]

Here is the summary with links:
  - [net-next] ice: fix linking when CONFIG_PTP_1588_CLOCK=n
    https://git.kernel.org/netdev/net-next/c/91e43ca0090b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



