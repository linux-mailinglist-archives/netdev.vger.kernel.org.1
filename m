Return-Path: <netdev+bounces-21619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67537640DB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FC1281E48
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490A1BEF7;
	Wed, 26 Jul 2023 21:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3E1BEE3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E17C433C8;
	Wed, 26 Jul 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690405222;
	bh=17zSTu1+UhHiP5tYR+Q9c8MvR3DNiUchoZ2Ti+q76/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPt1reYonW/3J+2/pBu0Rjs5O/ajJK1f+Dp71oq+wDUIi1/1w7zfYe3RtVrFvPXdt
	 s5XAFJGhxp4DynCz1vlTZyuQXrTkv4wL+iF1wlEb4jM1rQV/xU+jY9HZXPLwLRpcOP
	 glGhmHWWnjPJpJOR0UJFZvHIYCN+l1T+wMI4Btg8coq8uyp0dpBHVSozJPhBlEF4xb
	 /vOkRmM05mNxI4mXRDghxhwsmtSfrYdrTGjSb1Py/iBBaolIFkccADhoLv3eCKveWV
	 dY7eiGScFbnS2EXFDPtQbn0WVxGbBaSsCHQgYeFZWVxF4OA1HsnFYebsuSwTUbWjpD
	 PziLVU5zeYrGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E52DC41672;
	Wed, 26 Jul 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] tools: ynl-gen: fix parse multi-attr enum
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169040522264.7465.1154235051402673715.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 21:00:22 +0000
References: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 simon.horman@corigine.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 12:16:40 +0200 you wrote:
> Fix the issues with parsing enums in ynl.py script.
> 
> v4->v5:
> - fix indent issue in _decode_binary()
> 
> v3->v4:
> - decoding 'enum-as-flag' starts from 0 instead of enum's start-value
> - move back usage of _decode_enum() back to _decode_binary()
> - fix typo in commit message
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] tools: ynl-gen: fix enum index in _decode_enum(..)
    https://git.kernel.org/netdev/net/c/d7ddf5f4269f
  - [net-next,v5,2/2] tools: ynl-gen: fix parse multi-attr enum attribute
    https://git.kernel.org/netdev/net/c/df15c15e6c98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



