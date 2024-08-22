Return-Path: <netdev+bounces-120775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E795A946
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF60C1F23032
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869579FD;
	Thu, 22 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNaFeOxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C61D1316
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288432; cv=none; b=bURTbUDTbkk4wEx+K0NVpQr3fSaj8uhXOHCE7S/uDfzUS7joY7k/0wtqgpmGnJ1ucVRsNYnKnwcuNqFgbv97SQ2FqHHZ4ZQXQL4pVRjzTseUvwAeXNas3fr9VRZutOfvAg86oKGeiFl2jTXXLB6caPrPzpC/5wFrhv+2IbO3SbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288432; c=relaxed/simple;
	bh=9L5VdhLuQUluegGxlBHHNuaQUHh45GBljVHkoUYCPJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YmeA26fCFsa5TDNCF2SjYaCFSOIBLALmXpbIU5AkpPrfd8/uUQanBgahcZIZaWq7mb7vSDmqpFvBoAfrQki7ugp4tMBwewS08bCwFF7rw9Mx3q8Pm4IeCMQR2uDG8Eu3rPUnvWOIJUR7X2eIU7ggY+8uguPphBSWRnWPrTlWyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNaFeOxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD7C32781;
	Thu, 22 Aug 2024 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724288431;
	bh=9L5VdhLuQUluegGxlBHHNuaQUHh45GBljVHkoUYCPJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kNaFeOxvYx2ruemFx3vWT+PkMaZRcptA9Y25NYcJNb49uGWY1+VlIx8wXFazcpxxY
	 jycUxeDILBQ8d/zMLkmM7IQl0mokipGif3lnYRRwqPgZJbDIRv9RjzhpSjIrAhnczD
	 qPx2ZgWxY6F2HusSJsmfTjubkJcHGZjT4uBPar0jj74no2xCi3NHBNIKJmTZkrmLTr
	 H5EtkrQd45uXqb07/7ku5n2n6vZtqweXQhKH1Z4u56M1CWjHj2l+rgN4+qosxY7yYq
	 CB3uR5wbZRneHA/vF9fEUMNxgCjroWNzy4p+YfzOrZv8Bq2UVs8lh+iOUCeIM2ZTtu
	 0u2/bsO47EKjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB03804CAB;
	Thu, 22 Aug 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: repack struct netdev_queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428843149.1875438.12213258887237027252.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 01:00:31 +0000
References: <20240820205119.1321322-1-kuba@kernel.org>
In-Reply-To: <20240820205119.1321322-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 13:51:19 -0700 you wrote:
> Adding the NAPI pointer to struct netdev_queue made it grow into another
> cacheline, even though there was 44 bytes of padding available.
> 
> The struct was historically grouped as follows:
> 
>     /* read-mostly stuff (align) */
>     /* ... random control path fields ... */
>     /* write-mostly stuff (align) */
>     /* ... 40 byte hole ... */
>     /* struct dql (align) */
> 
> [...]

Here is the summary with links:
  - [net-next] net: repack struct netdev_queue
    https://git.kernel.org/netdev/net-next/c/74b1e94e94ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



