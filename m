Return-Path: <netdev+bounces-42076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B57CD14A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EB31C209A6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E78F59;
	Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR206GgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D048F55
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 373DCC433C7;
	Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697589032;
	bh=soDnUzUKYBogGm2mhVzuR5Tjnbz2TQhgwTDBGtH18WA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lR206GgArxDcl9qRo6OHCY550ounvDFHzexzGKxWM/MoFA0gYsl6rq3sd8JLMi2gx
	 rB+82JguvQA0OJLySRnhTstXw0uy3NXYODp9s0PvXRBhql4yew7W5uETu6xIfx1YM3
	 CvogE6yVuLx4qLU+yyRTy3CP56+G8LxmeK452zA7oOsbRzbsW+olA57+wqrt6AlsWy
	 5OZ9r3B3CCQbtI+cIWHjxjpXISxIVA/dprjath3rYsOIIMglWTugUryLQF8G/w6xN2
	 CTdPs55JMAU722n2tCis4hS3qCs+Mw6P1dhpnGOy/36TGIslwXiRoyE9M9E/I/TOTX
	 PGJqfF71BWVgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A816E4E9BC;
	Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-10-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169758903210.2770.15454538416871688769.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 00:30:32 +0000
References: <20231016143822.880D8C433C8@smtp.kernel.org>
In-Reply-To: <20231016143822.880D8C433C8@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 14:38:22 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-10-16
    https://git.kernel.org/netdev/net-next/c/56a7bb12c78f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



