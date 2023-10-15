Return-Path: <netdev+bounces-41101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41307C9AEF
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD5A1C208C7
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4367F9D3;
	Sun, 15 Oct 2023 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV0FMx51"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83246259B
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0DDCC433C9;
	Sun, 15 Oct 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697397023;
	bh=J0G7xRI+dz2lTSms94crS+csF2xB8Yy166ftDr4IzeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XV0FMx51MAmZZfEBnjzqC1LDBIYC4D4Pd4tjm/N31D575+enfcobi4zEFwa7FS6sJ
	 Gm7F/kqTFNAzuUJf4d2lVbNUVH8DIBJAYmWZL7jbdxzuQ0HyIq97fFNrIxxduWwo2s
	 YIJB183jxCePradMObglbjCmPxBqciqgcyEODSN4sHfMT5gRgD0eq/zoAK12DWIBNL
	 SKdUGkmWIaihA63qpbTkMyn4evBOWKGbyZHBMyNpIAkLxQkASf5j1/7tgm76eROcux
	 igu8pHzzr1KOzDBX8ckggJRfx57qycd7ushTCKkYB3byZ/UjEXjexZw2+ZKGBIzERS
	 83mqjl0lYjUxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2125C691EF;
	Sun, 15 Oct 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] selftests: openvswitch: Minor fixes for some
 systems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169739702379.16848.2168367864052155252.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 19:10:23 +0000
References: <20231011194939.704565-1-aconole@redhat.com>
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, amorenoz@redhat.com, echaudro@redhat.com, shuah@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Oct 2023 15:49:35 -0400 you wrote:
> A number of corner cases were caught when trying to run the selftests on
> older systems.  Missed skip conditions, some error cases, and outdated
> python setups would all report failures but the issue would actually be
> related to some other condition rather than the selftest suite.
> 
> Address these individual cases.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] selftests: openvswitch: Add version check for pyroute2
    https://git.kernel.org/netdev/net/c/92e37f20f20a
  - [net,v2,2/4] selftests: openvswitch: Catch cases where the tests are killed
    https://git.kernel.org/netdev/net/c/af846afad5ca
  - [net,v2,3/4] selftests: openvswitch: Skip drop testing on older kernels
    https://git.kernel.org/netdev/net/c/76035fd12cb9
  - [net,v2,4/4] selftests: openvswitch: Fix the ct_tuple for v4
    https://git.kernel.org/netdev/net/c/8eff0e062201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



