Return-Path: <netdev+bounces-73259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A977D85B9F6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492571F23E89
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138B65BDD;
	Tue, 20 Feb 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg6mAPLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30965BD9
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427426; cv=none; b=AG+wMu1PT41wE+6E8EQ9Uq7vAmVJJj+M5UtzvMbZHd2n+tylVrAI34WkQzsvPxx2VrhOyC8qj9O08wcULLUCy6oJwQdM6mrsEe5Jc9W3k/C7KHiDCoEasoIpJLtCStdZElm7F05ChTsuM+ib8z40BOB79CINDwjaS9VhSnOF8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427426; c=relaxed/simple;
	bh=Dl6NA7iRWFU0BDmmXw74DWPHAl/4q/K3emYXG3PHz1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IDifg/y+35tV0xsAq5Lyejmy2vTa8VoMKDHH93Cyj8rVDqqIE0vVBQ55jWP/fmflZqKahXGsvi5yl14NH0tWuRnQU0o2nQrzXfhn+bIln4VXaPKugVjMu4t5ycMAEIchduNPwoCZdopiZ+cik3F7eF3c2xT+n9QAadFRG0OHUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg6mAPLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAD34C43390;
	Tue, 20 Feb 2024 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708427425;
	bh=Dl6NA7iRWFU0BDmmXw74DWPHAl/4q/K3emYXG3PHz1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lg6mAPLeNaKzV3d90JyNyLC+R+AFGh8w3KyJkCaM2zynQIo7AgrQrqMpDH+p+B9m+
	 T+w7Oo/VW33pvobkdSFRoBey0YC3rikdQrI1+e64ecCiBEDoMvsojqOUssj0wVLonq
	 8ZU89jgy0bZLMECK2XVSQ2BpAOdgXPmVkB0dQO29by9p9547QCtkiD7W5xOC/nsHXa
	 X9LmB20wUMahSbYCIQSASwukwTTCPze78BVJ7BIPTuTsolveyf1KMu0noifpbMcMWt
	 DIuB1uc6p4zPmYmfeaVfrtS3BhSPhUcaULxIZ57siG4cK40kOBf54rUR4CuTwm62rL
	 BdKj4AhVtxSEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BC3EC04E32;
	Tue, 20 Feb 2024 11:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: reorganize "struct sock" fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842742563.6347.16360782364826312051.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 11:10:25 +0000
References: <20240216162006.2342759-1-edumazet@google.com>
In-Reply-To: <20240216162006.2342759-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ncardwell@google.com,
 namangulati@google.com, lixiaoyan@google.com, weiwan@google.com,
 jmaloy@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Feb 2024 16:20:06 +0000 you wrote:
> Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
> struct sock for better data locality")
> 
> Since then, many changes have been done.
> 
> Before SO_PEEK_OFF support is added to TCP, we need
> to move sk_peek_off to a better location.
> 
> [...]

Here is the summary with links:
  - [net-next] net: reorganize "struct sock" fields
    https://git.kernel.org/netdev/net-next/c/5d4cc87414c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



