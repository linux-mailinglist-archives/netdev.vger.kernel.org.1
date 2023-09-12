Return-Path: <netdev+bounces-33296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D279D57A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54752819AA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E418C2B;
	Tue, 12 Sep 2023 16:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7718C16
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29794C433C7;
	Tue, 12 Sep 2023 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694534430;
	bh=7NT2w3TW9la1c0C719JHjAuvB4LTaYPe94tsaPiMO80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3ZEtYn73+/1uj+yjsxvypWCip0BUsU6Jsz5s8s6NZy/gL0KFY7bbtSxtrfjYNjkW
	 J055SgxMvCGYUCWp5pCi8LxoU0f2yHZHJ4OW1LHC40v6shzwNB1LyDWqwwG/yMgbyb
	 qL+lW4Nx4rOAGGTmvOc4MfFXDKONgCUebB2HqvPp9xkwlmfZjlWQqWJxgTubHsuB9M
	 TO4mDJ0jFrf/G7UfIHF5AC+dbSx44pp6s8XXHxGSyWawoC8lBOeiC8wUMNp6azDNcB
	 NztEwpqzIpd3T+AdRa/oEsbw1CnAemsm+2BsEA54Q+Z2E0geXuiWcrWULdQ97C6v28
	 O5zfmMkbiPnHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 094FAE1C280;
	Tue, 12 Sep 2023 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] vdpa: consume device_features parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169453443003.4554.2781113098793657141.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 16:00:30 +0000
References: <20230911180815.820-1-shannon.nelson@amd.com>
In-Reply-To: <20230911180815.820-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com, si-wei.liu@oracle.com, allen.hubbe@amd.com,
 drivers@pensando.io

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 11 Sep 2023 11:08:15 -0700 you wrote:
> From: Allen Hubbe <allen.hubbe@amd.com>
> 
> Consume the parameter to device_features when parsing command line
> options.  Otherwise the parameter may be used again as an option name.
> 
>  # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
>  Unknown option "0xdeadbeef"
> 
> [...]

Here is the summary with links:
  - [iproute2] vdpa: consume device_features parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=92eac7e4bf14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



