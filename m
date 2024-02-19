Return-Path: <netdev+bounces-73039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4085AACD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC38A1C20FC5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9356481DB;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJJKsPFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C21481CB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366826; cv=none; b=NZf8AK61k03amNvoL+kfkbj3O+brLrV+XdQKIuyhAB+zt+YTZnNdLiQHiAtX5Pc+epSk4Anl3i6wxR0URSayHPZS7IjQiV4D5UcEgFGIj9G3A3JdSrLLxKGc8rse94YgbQ0/sc0hboGmMM+bRElf626NVFgfZ0z8eEe/QKvfheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366826; c=relaxed/simple;
	bh=UPyM5pfA0MAfd5BvpfheES2f5cWIrnJv05s43VdWros=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMH423LMv38Vxe2dkG8rHda/53UOHqyLFjGbb0dDyBGRp9NyPbhvzUDzmZPf4cptSkPFQK9n+ODpfS6cxNYWq6zxVI26QZrAj2yv5jxRW399ummqe6VH7Q+FWMPJaM+aQEYgzUc2gmZbiO8ns4pvB+8YApsWEzGeVSbZLWec9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJJKsPFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73954C43394;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366826;
	bh=UPyM5pfA0MAfd5BvpfheES2f5cWIrnJv05s43VdWros=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jJJKsPFU96NBt4ALhSOCSZL14oex6eGTJ7BqwyH02YXp9YKSjbu+EWsjIR+sFvkz0
	 5uPzGGWxSV9WpiMV4BtnNcjnyBfqN6SmGrkT1nnf+YaBX8GSd42ceZZvsbbWW07p2n
	 2fZvc/WmG3zgQo2dHJ+o2oVPQB66BWN58atV98hhDm7swsdGJM2VSNpyR7Uc4+2FMp
	 vFyFAqUdmRluEoZ/vUS7raGm6+1nuv1cfeahaMIT22aDQc7unG0epPrmZqvL6mvHyZ
	 Yzx78NOoL8zasf/IJOLJ/E8ZzMAgTZHbRGwAKqwns9SbSIsxUycYW+EjHSUAgorq3R
	 1KKJ2pCEn+Ibg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB4ED990CA;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tc: Support json option in tc-cgroup, tc-flow and tc-route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170836682637.11627.9046955615011122870.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 18:20:26 +0000
References: <0106018da1e9b5ee-8b2403c9-8e5b-4f22-8b25-18919a57d29d-000000@ap-northeast-1.amazonses.com>
In-Reply-To: <0106018da1e9b5ee-8b2403c9-8e5b-4f22-8b25-18919a57d29d-000000@ap-northeast-1.amazonses.com>
To: Takanori Hirano <me@hrntknr.net>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 13 Feb 2024 10:01:04 +0000 you wrote:
> Fix json corruption when using the "-json" option in some cases
> 
> Signed-off-by: Takanori Hirano <me@hrntknr.net>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> Changes in v2:
>  - Use print_color_string at print iface.
>  - Fix json object structure in f_route (to/from).
>  - Avoid line breaks.
> 
> [...]

Here is the summary with links:
  - [v2] tc: Support json option in tc-cgroup, tc-flow and tc-route
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4b6e97b5f3d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



