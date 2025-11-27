Return-Path: <netdev+bounces-242140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5AC8CBB5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CA0A348745
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8B1F12F8;
	Thu, 27 Nov 2025 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdMaSYkn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80074BE1
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213428; cv=none; b=F06ENWH9X3Qgl+mGeIqWEZrY3qwfCK89kY/d5MltxPEqp7JLIEoCcpNr5+azQl+////F+O6bCA9CDAH24tqRP3nsdlxYkMjR9UdZUB/TvfqBfA73v7exjr2qN8/MZP0pCFKPVrH9LyECNYYbWFbFxZMybvDI2pqLRPTsy6UZReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213428; c=relaxed/simple;
	bh=ZCTum5jF7OHundrd2aOD/7qbzjoNuKSGvPhtd50U7ts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgONY1n+bJVeIhurAJw9LGC6YCubHTKA8DLKu1uFTUKP5r0SqpWONE6OpMgzrraMBsxImy1eZvfV21zu6ky/EoErbPiJUztbTQXzaGbcB0Cr78Bae61kjFvElSPiLtS6R5el2pieqJTQWz3h2nDb66wpAwNXXoweMS2Cw3x0dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdMaSYkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F6C4CEF7;
	Thu, 27 Nov 2025 03:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213426;
	bh=ZCTum5jF7OHundrd2aOD/7qbzjoNuKSGvPhtd50U7ts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AdMaSYknA4pre+2FNYArZc/Ex9twYWwWEvDfSiK6OK4a96MFa9CvtnMrT/qR01xwF
	 FfKLiFY2T32vmFcte8eN+9i3jbUkcGxqAlSZ/maQpp98y9ghmi5hQ5n0wP/1gFuL3c
	 hnzzSqlm78V9BP0zZ7YN/YLM7bqwf2HZLYSJiilMiIMkdd0KYo/q778q5LzBCg23tO
	 N+myTu4hlRR7LI7eyDtYD7vE6npV14ojHvXKKCq+BzB0Yn5uP4MreqFdkZCejHaOUC
	 hu255i1l+ltt/VdT6lxp1VD0J5pI2mzOVB5MZbC7UiG5ntj/QU/+rwXkeVBXui0RRo
	 eXLdso0W9fscA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE9F380CEF8;
	Thu, 27 Nov 2025 03:16:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Fix counter roll-over issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421338749.1916399.7175645336781698371.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:27 +0000
References: <20251125211704.3222413-1-mohsin.bashr@gmail.com>
In-Reply-To: <20251125211704.3222413-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jacob.e.keller@intel.com, kernel-team@meta.com, kuba@kernel.org,
 lee@trager.us, pabeni@redhat.com, sanman.p211993@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 13:17:04 -0800 you wrote:
> Fix a potential counter roll-over issue in fbnic_mbx_alloc_rx_msgs()
> when calculating descriptor slots. The issue occurs when head - tail
> results in a large positive value (unsigned) and the compiler interprets
> head - tail - 1 as a signed value.
> 
> Since FBNIC_IPC_MBX_DESC_LEN is a power of two, use a masking operation,
> which is a common way of avoiding this problem when dealing with these
> sort of ring space calculations.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Fix counter roll-over issue
    https://git.kernel.org/netdev/net/c/6d66e093e074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



