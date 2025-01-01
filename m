Return-Path: <netdev+bounces-154644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59E9FF2AF
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 02:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E53A2C63
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751D7489;
	Wed,  1 Jan 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+ebdsOk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B065D2FF
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735695014; cv=none; b=p1/0X6OqnXwmfUh77At8stz4q5vijspgKizNqdSeRUUy6VJfsPTOsha0XzbJmjlfQsTNUO7ARjoHh+2nho45OKZWUMBb3QJfhH1q3anqWbmUWRgzDKox0jG7hN8Zxw1Zq41/jmPpF9jtSlg2Uid4lcVhMbJ4YX5Z6f9Jo6n2nRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735695014; c=relaxed/simple;
	bh=Fs3Ee1IkSzubkjcs1sjGgfHBkRLHri0ORoHFjUSPE4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hUc/q8EWd/7u8GZClOxiNwP/5WQCCSBSx8qbLW5ahlPAOnKk40zqFN72XCRdmfOn6W1NBjdr1/+RGx6J0z4owI+D3W2d7ZgSD/RlMG2+Lyb/pLMC4Wgiv2RXfpsv9pmcnw35QLe2LWpSMOQwRG6/QqNHrV7FDRn9fS79MpD10OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+ebdsOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758B4C4CED2;
	Wed,  1 Jan 2025 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735695013;
	bh=Fs3Ee1IkSzubkjcs1sjGgfHBkRLHri0ORoHFjUSPE4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+ebdsOkEN894d4+LodL0LzJ43+ZlMINoVAAJomXYg77B8qrSPGLSGSJlc+sQG496
	 +DeyQ8TkPy8P2GdQT0Vc39saFD7zUK/WWebxfRqbkhLBcoIGg8+CeB6hPQ4vh9Yw7A
	 72uSJHrL9g9b8dRn6+wss9cXP/fgmSTBsq5/cfuwedoiKxg5IqH3gXAsR6MPiqEyXs
	 3KFA8SJ/LLa0vWPMwo/dRFpwobq75WT1WqIRrhDHRWIGo3M+NO+gSlA5bItOmIIab6
	 BltZ1YybNFGxLvJT97ScQSIiL3nAOVhRq7eUytfeXpC3iVnRCXhr8XXpvUQp6u6N7n
	 edRheZzgw2E7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE11B380A964;
	Wed,  1 Jan 2025 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/3] Add flow label support to ip-rule and
 route get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173569503352.1658795.12413555846627392455.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jan 2025 01:30:33 +0000
References: <20241230085810.87766-1-idosch@nvidia.com>
In-Reply-To: <20241230085810.87766-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 petrm@nvidia.com, gnault@redhat.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 30 Dec 2024 10:58:07 +0200 you wrote:
> Add IPv6 flow label support to ip-rule and route get requests following
> kernel support that was added in kernel commit 6b3099ebca13 ("Merge
> branch 'net-fib_rules-add-flow-label-selector-support'").
> 
> v2:
> * Remove new line from invarg() invocations.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/3] Sync uAPI headers
    (no matching commit)
  - [iproute2-next,v2,2/3] ip: route: Add IPv6 flow label support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=35ae138e2c94
  - [iproute2-next,v2,3/3] iprule: Add flow label support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0bd19d4645ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



