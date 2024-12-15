Return-Path: <netdev+bounces-152036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F376F9F268C
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CC11886AF9
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96981C4A2C;
	Sun, 15 Dec 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj8F0gIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6961C4616;
	Sun, 15 Dec 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301212; cv=none; b=Qg44vaoRsY2PhBEucY2I09dcquH72xTLI+9daOgOsLDY7E+biAoTF6O05exoxKH1hGdCoEQBoTSYBFJrvi7MbXhqMnpakoxtJ813AZVgdI4u4vekK+lrrAFmC3kB/fr7CCPEDxMW4bLSMGbmzyBbyRRE5oCgJknLpOiZlyvlXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301212; c=relaxed/simple;
	bh=pgFcx4vATfkUzjcy2OHq1Ngq4be/TjLTKjUapAC3DXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aN2//qoPyqFFe9AjKN3xpYCgKNkCu/p0Q4Uw6UBsyUd0T81HkUkYmp0NqNHL0X4hb6/17ECTck/dB63uoUzk1XNFURIgJ/XD5Qh7E+yAJ+ofCdlLLLKgM4qulFhDcwhH1a3aTjsRx95j1Vlcu05i1jkgL/7OCsiECCpjZvSdpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj8F0gIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E887C4CECE;
	Sun, 15 Dec 2024 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734301212;
	bh=pgFcx4vATfkUzjcy2OHq1Ngq4be/TjLTKjUapAC3DXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sj8F0gIFyvoW8EIMZnAn5koZKvIEUjwbTTm+KfcG5s9aFJ5lj8+fhnyZ6FM/JDP1g
	 W3NLJR2y3X2PGDppNjBQNe7Kyd+qt3AWrc8dIDC0apJ1jlmW3ucHD2XyPFuK56fnLt
	 O+jbYyoB7sDZlVDbAcQLp9yDMtN6TiyeVXvzMykG7d8Ny6DbSE9uZin3VI80LMVqi+
	 kC8G/8n/MDSUTdophfLnGFPS1bZ3682T1QMTOYFGGceXC0jDjVFUyd8R/dILI7rkgR
	 O6sRJTGQIHyQa1jWM+BmHe9c+JGCxke8a1Zq5R8EgSX+zrOX+xIM3B0RXkuBsq2hnp
	 7Z14rZsRZ94SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 449203806656;
	Sun, 15 Dec 2024 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430122900.3593151.18358965146513672110.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:20:29 +0000
References: <20241213-net_fix-v2-1-6d06130d630f@quicinc.com>
In-Reply-To: <20241213-net_fix-v2-1-6d06130d630f@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_zijuhu@quicinc.com,
 gregkh@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 20:09:11 +0800 you wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify framer_provider_simple_of_xlate() implementation by API
> class_find_device_by_of_node().
> 
> Also correct comments to mark its parameter @dev as unused instead of
> @args in passing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: wan: framer: Simplify API framer_provider_simple_of_xlate() implementation
    https://git.kernel.org/netdev/net-next/c/dcacb364772e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



