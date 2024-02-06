Return-Path: <netdev+bounces-69430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0E84B2C1
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422F41C2313F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B21DDFC;
	Tue,  6 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbRuHzUG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7B487A1
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216627; cv=none; b=DGuUqGr20PrVvV2mCdm8mTLqc38rU/+r/Sp57GrRqjG6Y/o358RGYdNP+On9kCO1TY+K7EEQwS0/vsTUxXQ0jKczGTR6O0hkwEVXiofzL2QkDSAn7SnlMFJVA2fNuK/Z7UcGtK0MolNPALAUXvN/fw2SWsG23YlRaavYj1KrSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216627; c=relaxed/simple;
	bh=GgfgAw7k/pdodVCnmAojVLUuGwwiAJL4kooEU6XYp4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QmQSmqJB/J76GStWp9B+W5KdXfUsA+3lX1qwgMQ9WctgGR6jH6+/ywNR1YgM5qgftpJgcqXduq5qCblFgNO2dmd6Hph5B5S5tgoRl7DQIInLonChijVRRW1NdHTzzj8PboCOZXSHEBBIEYN3ysHdWe2FGCNXMqUWMjDtPgCGQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbRuHzUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D5DC43390;
	Tue,  6 Feb 2024 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707216627;
	bh=GgfgAw7k/pdodVCnmAojVLUuGwwiAJL4kooEU6XYp4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbRuHzUGNAOVBYP+3wEgr5mkBMGVDA0IzfJns7KV1d9qwYlvRA8VanqG9oSH3Q2qo
	 tO5ETkr9eMAbD0xMkZBQxMoYEsQ9dnhA72XAyF21NC94dpi6mji7DNm/cnfVxq+spV
	 6P65aw8QmnqmItaBABqnH2h4e+YjfWoXYyl3dBD7O8jAZwKEYZLA8PPjoszWbgyANG
	 UPijF61IcqD0ts9yVzzE2bwgNRl6KEfc/iyc1FkZ7KXoLjdNgZCMjBiu3LdSnKZ2Cm
	 Z0nWgOvoVaS1I71SrfkQWGoW8h+tm6k4f6r8Acj9LvT3trUodCp0UJ/g0WEqo897eI
	 3NufLFc3Zcr7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1217E2F2ED;
	Tue,  6 Feb 2024 10:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dst: Make dst_destroy() static and return void.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170721662685.24362.5208830780972524690.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 10:50:26 +0000
References: <20240202163746.2489150-1-bigeasy@linutronix.de>
In-Reply-To: <20240202163746.2489150-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 Feb 2024 17:37:46 +0100 you wrote:
> Since commit 52df157f17e56 ("xfrm: take refcnt of dst when creating
> struct xfrm_dst bundle") dst_destroy() returns only NULL and no caller
> cares about the return value.
> There are no in in-tree users of dst_destroy() outside of the file.
> 
> Make dst_destroy() static and return void.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dst: Make dst_destroy() static and return void.
    https://git.kernel.org/netdev/net-next/c/03ba6dc035c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



