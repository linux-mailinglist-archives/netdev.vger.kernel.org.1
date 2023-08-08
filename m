Return-Path: <netdev+bounces-25628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84346774F3A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957902819CB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CAA1BB4B;
	Tue,  8 Aug 2023 23:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877C171C4
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28371C433C9;
	Tue,  8 Aug 2023 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536820;
	bh=hDJyGT1EW9AJZNFTtNI/f9U9RD19MdRHN85tVl7Qga0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yh9XcnFJc2VHeOiXwXsZHkqD7YduBU2WuRKmQBloybekOmWTJzcpT/WkK5sYDygd6
	 g9JNpefjB4uMZWJyrR5GB3HrDfK8G4FJezNr0nn4Zz+GnaLq7IpfQKnQ7tVDlxdSvQ
	 WAZjmVaxTFSwjHDC/DskWUAJyd45fv9tOTGezBFZPsfOkkjm9PuMf4msNaqQYpLULF
	 q9hg4bbfFNKIS4MXMqpUCz+ZdBNzq1QJ56dioXwny7iWrSzPZgIjhJePI4O+sh4sbK
	 3bSr8JvOhLnsx6PWyhrZ+XUFbvGy2Mxv21LiI1lDjkLZ166pyXCAqkpPPzjt5+dBzQ
	 0LjOx7RzTNb4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09E3AC395C5;
	Tue,  8 Aug 2023 23:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: net: page_pool: de-duplicate the intro comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153682003.18545.14656413462759347609.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:20:20 +0000
References: <20230807210051.1014580-1-kuba@kernel.org>
In-Reply-To: <20230807210051.1014580-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 corbet@lwn.net, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 14:00:51 -0700 you wrote:
> In commit 82e896d992fa ("docs: net: page_pool: use kdoc to avoid
> duplicating the information") I shied away from using the DOC:
> comments when moving to kdoc for documenting page_pool API,
> because I wasn't sure how familiar people are with it.
> 
> Turns out there is already a DOC: comment for the intro, which
> is the same in both places, modulo what looks like minor rewording.
> Use the version from Documentation/ but keep the contents with
> the code.
> 
> [...]

Here is the summary with links:
  - [net-next] docs: net: page_pool: de-duplicate the intro comment
    https://git.kernel.org/netdev/net-next/c/2c2b88748fd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



