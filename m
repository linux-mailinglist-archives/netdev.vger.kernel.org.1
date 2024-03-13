Return-Path: <netdev+bounces-79721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5F87AFA6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315081C25C4D
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F57828A;
	Wed, 13 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7jqSP62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1178272
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349829; cv=none; b=PYLY5qZ18oOaZD5qZ+977PlERw0B69vZdllRVfUVWqv0CPYsFML0Z255YSB8MEGsgtQIbwr1ICLOs2w4epqxoKP3Q6/tQtYgtL3CiOh/63B8NnWazVOX+iCSNZL5MkaaC06oq2dgj/cagb4/2mJaUb6BYHg8j+GStwcYfoOCyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349829; c=relaxed/simple;
	bh=tGIt1HHRqlVkCQekn36oUmcViRJRBjVa2265jkthPaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BhhQHZOt2F6wBVU2593ov5luNRi7ffCMfAFWbnlE0ci3sClWWURwMRaZBdFt6wJi7hj51JdC9psau46vrJInPF4cS8u+mxept9Qc+AtIWjKgnELErm8kYy9dKQoYLullzj5b0H03KlgenTRBS5UdZPElHeLkzcBjTYuD/V+3tfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7jqSP62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0AA4C43330;
	Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349828;
	bh=tGIt1HHRqlVkCQekn36oUmcViRJRBjVa2265jkthPaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A7jqSP62x/5D11X2l1kdY+cBZhB3m3qz5bIDAmUxYJ5bkPskNKUEhWkkQpT3Epwoe
	 WgntMdgRr5q39eotnw8tkRirkFpBrRn4zaK6mZrQ2n1T6xFofijHU6qMOiZJNGNEB0
	 PCe6viE7cEM15LIO1K5BW4KaA9Qe27mmxBAbpJ7bGOyUxcVKk3IYlqJzqG5jN46piD
	 Lu5re/kDUvxqBvGlTpft5OGWnYKYjlvLzEf9SmVxLRnH/r+kheztvSDJT3DAsuOuQt
	 /ee40yIgwK5jxjGUl74I50MAWUi3KNnau1lZ6zO+LaBPSyUL6RUvflHbxNuyI+zQsp
	 mCQAm9MQqbW2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82DE6C595C3;
	Wed, 13 Mar 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 1/3] README: add note about kernel version
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171034982853.13122.13414393394060836778.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 17:10:28 +0000
References: <20240308171656.9034-1-stephen@networkplumber.org>
In-Reply-To: <20240308171656.9034-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri,  8 Mar 2024 09:15:59 -0800 you wrote:
> Since next netem changes will break some usages of out of support kernels,
> add an explicit policy about range of kernel versions.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  README | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Here is the summary with links:
  - [iproute2-next,1/3] README: add note about kernel version compatibility
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=56511223ef26
  - [iproute2-next,2/3] netem: use 64 bit value for latency and jitter
    (no matching commit)
  - [iproute2-next,3/3] tc: remove no longer used helpers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=38656eeb35bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



