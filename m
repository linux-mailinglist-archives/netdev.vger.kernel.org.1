Return-Path: <netdev+bounces-33539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACB79E6C3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4BB1C20F20
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C21EA66;
	Wed, 13 Sep 2023 11:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F91E519
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53CFBC433C8;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604626;
	bh=An+L0cElQu7EubbF/OPDuMeyOiCDerhkJPPBKhVq08k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d4nzwNRMgH9FZHZzrcqn9J5QF3W50gcKqRjmIRqYBfEpgjbyXiHynBPd1arxO5kA9
	 lGwSSFnbxmnrPn4peJRr6XtHuRhzupCJD/gN36alZkxlNcGjXxrzt5x5lM7LnHjbyv
	 vC7sNURn6zjCj565IyqCBKTM9ub9BOOKSa0CddoecTPzOKX2v/c4NtP05uTZpu5fXF
	 JyM9M+mvUm71wqHHU9RBhtNUUiSuugPNAHaEtfQn1vS57bET8lic3NUkd2nqfpPmgX
	 1CkLB36YJUee6UcZquTU448RM/E6/9DesA4v3Q2938GkfnDhGlaMTUEHHnlhaq4hYA
	 a6xkh6EJd1Rag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37908E1C28E;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: clean up in all error paths when enabling SR-IOV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169460462622.4298.2810335722106841871.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 11:30:26 +0000
References: <20230911202849.147504-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230911202849.147504-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vinschen@redhat.com,
 akihiko.odaki@daynix.com, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 13:28:49 -0700 you wrote:
> From: Corinna Vinschen <vinschen@redhat.com>
> 
> After commit 50f303496d92 ("igb: Enable SR-IOV after reinit"), removing
> the igb module could hang or crash (depending on the machine) when the
> module has been loaded with the max_vfs parameter set to some value != 0.
> 
> In case of one test machine with a dual port 82580, this hang occurred:
> 
> [...]

Here is the summary with links:
  - [net] igb: clean up in all error paths when enabling SR-IOV
    https://git.kernel.org/netdev/net/c/bc6ed2fa24b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



