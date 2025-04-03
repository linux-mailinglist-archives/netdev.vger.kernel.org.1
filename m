Return-Path: <netdev+bounces-179201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC1A7B1F7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6341178A49
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093581C8611;
	Thu,  3 Apr 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6jCBqZQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD11C84DB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718797; cv=none; b=Ag3yR0bGjCaePQHCXJbOuXc7lhHjAb0WR3b5f2+VU1n2UqcdW/95uDvt5h2jBYdkTMOCzqv0xrmSSxAMxTGazq2NTW5iSBNDS8NfcKLF7raAl+QDbiEd9k26YKbUk3nN68WSnOH/IrL+h2fF3TdIEDjflLKxjOWPVJDhaVdAn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718797; c=relaxed/simple;
	bh=eIxe2iGgnn78O/5Ap91j60s0cWQ3Nctxdf5VSsgMt3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBnEoArfhvFtd1N/2l3/u+qg1A2bSwCF9EZE5uP65ZPIm6uAe8jFcSE6f+DMOwDwdVkWZ3fXS9q1xACDwSRuB+gv+0ocxSi2fL0OfcmZLNhyZZ10447y3ZXtHZav/9O8qb8sJPOp15HNG798lN4/qJUwhKUSFHwg11XmEvtvKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6jCBqZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B0C4CEE8;
	Thu,  3 Apr 2025 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718797;
	bh=eIxe2iGgnn78O/5Ap91j60s0cWQ3Nctxdf5VSsgMt3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e6jCBqZQ6c5QxLRfG6gVWWJCoqhiwfYThvIQ5y9RTzSNwsNyBMnGP+r9vOlVbZZQO
	 qsoqJVS3ATFFZnAvoS7QKrBkYdawQKOMEu/I9l6Ez1Q2Ojm359gq5DbgbmzdRh5Dyk
	 kYCBZpfhosPuQlMPs0kMh5nmQpqCATMzBZMD5x3pG8zmky/qfxaaneGCG6lylFUFaN
	 RcXx6Cmg3mP4/Z5JD/vDJDrMgt+SaPutxALQgrv7wLPkKAX9Jn5A42PS6fdqm1yrdP
	 TikD2Ps7EcqG68BNCLhzJhUc7qPn8gTIB9c5D2Q6sksUsj8G/YE0mvwQoMpB1l8rSp
	 TP9wKVyjKRUNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD42380664C;
	Thu,  3 Apr 2025 22:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Update Loic Poulain's email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883474.2702664.14678261814470730798.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:34 +0000
References: <20250401145344.10669-1-loic.poulain@oss.qualcomm.com>
In-Reply-To: <20250401145344.10669-1-loic.poulain@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Apr 2025 16:53:44 +0200 you wrote:
> Update Loic Poulain's email address to @oss.qualcomm.com.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: Update Loic Poulain's email address
    https://git.kernel.org/netdev/net/c/40eb4a0434cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



