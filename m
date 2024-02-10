Return-Path: <netdev+bounces-70778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86298505CA
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8E41C22DB0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9405D477;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb1fiQsg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85375D46D
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587427; cv=none; b=kx7Dm/0hLVmNF+7E0fR6a2Yfdp8To6whP2ny3BfqpO/OKe9IivWFi5V3PN0bU8iLDPn0H6bHXpTUd/YhL7OgYXG4IePWDi+JNIW+DTnKecH+RWUv7CrXpB3wByFmUxZkAcOjCxJiFcNpsCiKnU42e9uCpSlV/yXnMnfO29QmgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587427; c=relaxed/simple;
	bh=HE464eDCQ891cSRl3u1k5bPy3YpRsGYM8qLbb3pEISA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mRzwDjlqf6Jd5zK4NPJltJhAjeYWxSG6pDlEpZfRsxYdFpYMm1agmp0j48yhY4V/3GiwheVHlrXQsndXKIKXguTOApKkWDnq6CaY2+zHndS5tXAEZxk9MDkyjqPG/M9h8fqjzQ+50lgHJzi7uI2J1WRzKDXCb21xrDniNMWryoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb1fiQsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ADC7C433C7;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707587427;
	bh=HE464eDCQ891cSRl3u1k5bPy3YpRsGYM8qLbb3pEISA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pb1fiQsgZSNPpMUXpVXYvA7WTjErzxwz/aDNpKnupxV4UvBt1tzxNHvoBbyZMjce2
	 19i0k8sZlfoKRDw/0mpqWviAoa3MxJ9CB415DtMxsKmDSMNPqZkFV6fyCHXJehn3XW
	 xogSYivGuLg2BHnQ5ynP19N9se0QQiNFiCkIcqBvj9EvlhbkEGU3MZOPpryw6kb/LE
	 aYflr+u+LTcqpYzW7SILx3Ff5Py1xe98WFU92p+Q+LoB3EbZbZZc2etjQ1puaQKRsP
	 vVWcjpUGD45vzmO9cAczVLghkUFLL4/fFLfQP7LTZNcOOXEbe7gsy/2kZpEFgv8c+x
	 mHGTsR5SwcMCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31E98E2F2FC;
	Sat, 10 Feb 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 1/2] tc: bpf: fix extra newline in JSON output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170758742719.9212.9254624302725179342.git-patchwork-notify@kernel.org>
Date: Sat, 10 Feb 2024 17:50:27 +0000
References: <20240209235612.404888-1-stephen@networkplumber.org>
In-Reply-To: <20240209235612.404888-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri,  9 Feb 2024 15:55:56 -0800 you wrote:
> Don't print newline at end of bpf if in JSON mode.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  tc/m_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2,1/2] tc: bpf: fix extra newline in JSON output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=46031294e3e2
  - [iproute2,2/2] tc: print unknown action on stderr
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b958d3c25dcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



