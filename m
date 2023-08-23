Return-Path: <netdev+bounces-29833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E718E784DE4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ECA1C20BF3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B710E3;
	Wed, 23 Aug 2023 00:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94637E2
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7348BC433C9;
	Wed, 23 Aug 2023 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692751222;
	bh=1sOOdjjngRkITTIUqCqd39yusOlu33Yrw1uMkmDBX/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2MaMkwQ6PqhMe/QdrxOUuy8FTjA2ZwjuVlIdCaAauW6ZM+MJQv3BbFovFbfAt0a4
	 cGXM3xXCCDzSPZctAbUSj4IwWBHziSsn1BvfIGmG8OLd+WOeNAGDYdeygM8d78c4c7
	 YhGnxdqhX3HJ8bc+ec9Ln0RYSxvKo9Gxkr36gtvUsswXQexW12kueEL5ESWc1KWL0E
	 ovu7WwfBvzX2N/pEez+OyVV//ayIHlArQnRZ4DqxWew0ZJTqqt7SjMfLIPd2r1ZFIJ
	 PncorGOIcZGJqrpWqB6x2QwSW0ra1HMeMQObxQp3mEv8+aAKT5g8GvLfTLRmkCVqld
	 j90PkdWvf8hwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 582CEC3274B;
	Wed, 23 Aug 2023 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix the typo in the PTM Control macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275122235.28287.4932300542254196898.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:40:22 +0000
References: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sasha.neftin@intel.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 10:17:21 -0700 you wrote:
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM
> requests. The bit resolution of this field is six bits. That bit five was
> missing in the mask. This patch comes to correct the typo in the
> IGC_PTM_CTRL_SHRT_CYC macro.
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix the typo in the PTM Control macro
    https://git.kernel.org/netdev/net/c/de43975721b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



