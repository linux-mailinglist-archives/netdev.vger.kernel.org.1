Return-Path: <netdev+bounces-229949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5ABBE27FB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DE01A61976
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6127B32B;
	Thu, 16 Oct 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp9ZIp0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602023A564
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608226; cv=none; b=CJp8zXVRa+NpXXA1/7nOWin9IZe2IN7cfuBX5gNg7/mrNxtlOQjWwgimPyNKWEADtfnn7YCrpAQyZpVnfqjINv6PMdr/bnfaW1b1UI2LOGEClNjHSTQcKE6PHa+yC9a/8u89cfckzw09BK6kPB7HifphrGUr9eDHzIubuMi+ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608226; c=relaxed/simple;
	bh=4kG3LTA6EA87pZDawYP5wmUopPnUKTi93v6IVLUl2tM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pSqDBlyqeXqFO6LjFRN8Sr2jQe47jyYj5YqAgiJ1m6AyaKzNAPKoW73M40QkeJ1js2+EDbqXTDN0FYZPuxo7KAp6rLNLJryhNIlFaW+czhZbtt+dy6CbQJTPZrTwh0NaPEahp77hDBemvqIKE/eLdsblN02qOonKu60qIflZzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp9ZIp0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E63C4CEF1;
	Thu, 16 Oct 2025 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608224;
	bh=4kG3LTA6EA87pZDawYP5wmUopPnUKTi93v6IVLUl2tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cp9ZIp0LBSG832Iy/mL8N/gmEFedpf9yvjsYlbvK16LYTNytZINLHSsfTA2egLWX6
	 brbe5JMYBDfVyWx/bHTogPiu687lDl57zLZ0WrSrQLy6GySs48UF1U7yG5ODzb03KQ
	 cK9go7f1Xf9Ih2rKRJpi7hFFVmM5xxJ9I6sbXiv1gj+gcF9WVxLukEfJQSunbLv3OX
	 tbRV5ylaaSunsrQMwXc/drUn0M0Mk1lU3YxjUL6wdgKpJXOhzDEXxFJggfitq5vN1G
	 zx9rYih4h4NAqqOwvsCeGuaj0vTXyXXq5/6S+Fl8dQTV6BqElTiDNx6uQHLWgJxlNm
	 7R4e4IZI/tvKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBD3822D55;
	Thu, 16 Oct 2025 09:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Add aarch64 support for FBNIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176060820901.1267151.17057285154261217313.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 09:50:09 +0000
References: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, alexanderduyck@fb.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Oct 2025 14:14:47 -0700 you wrote:
> We need to support aarch64 with 64K PAGE_SIZE, and I uncovered an issue
> during testing.
> 
> Dimitri Daskalakis (2):
>   net: fbnic: Fix page chunking logic when PAGE_SIZE > 4K
>   net: fbnic: Allow builds for all 64 bit architectures
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: fbnic: Fix page chunking logic when PAGE_SIZE > 4K
    https://git.kernel.org/netdev/net-next/c/4bd451f4c285
  - [net-next,2/2] net: fbnic: Allow builds for all 64 bit architectures
    https://git.kernel.org/netdev/net-next/c/75b350839b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



