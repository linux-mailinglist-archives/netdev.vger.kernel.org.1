Return-Path: <netdev+bounces-229200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41871BD9171
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D286420CBE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B33101C1;
	Tue, 14 Oct 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBYr2o8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B873101B9;
	Tue, 14 Oct 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442389; cv=none; b=isGJHnHBCISC6XQJdCUuN2ItrJSE8JT3Qiy8/n5thfeZ1hSZTH2L639yvn36a9k9MA3rHAkmrrVlTz8mdYG6+i24BEPno+LqPZiahOIsB/IrPjG/++fooULjqtIBxmGLREoiEyN2l4iOpm3EFS+RwvKVWEZ0G6oVMS+xpk29Gbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442389; c=relaxed/simple;
	bh=WjQN6OgexOgkYV132WA2dstwjo/wqMvxhCI46O1Q5pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Klol/w3HMT+NuNnpXQ5getBFWsYLudWc0sEW0szXvPlTgI9xytI22hCF/84hQIVsY7Atwyf0fM+0EB+VCxvUvw8iZWmFSjLoakIoaTAvY1XrV5kUp7i9gG/Mppt4NgQg05WQmhw0+BpisGg2hjebeluqPLz3Wxw1tRVmfefuG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBYr2o8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E5C113D0;
	Tue, 14 Oct 2025 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442389;
	bh=WjQN6OgexOgkYV132WA2dstwjo/wqMvxhCI46O1Q5pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qBYr2o8Y4k7vrPe9r+6dvpVQR/K5MY5yEdvR+aVl1Yc0aRRjK6L8d1ZWiTE32JUrc
	 l9uPELxx9ec+svIOexPAy4hDEXeL4MtW4rGrgpryGP+xn1p6auNZA2IvtSuPGjBgLO
	 Ou3eDMH9qG0PKthx163yn/rnmDLNOMFIVFr25ogFBnsyPeo3L86xzr3QlJb+9A8tmK
	 awAKJeYVF+5A4mpXqDiFa4dZbgMX4lwVIdjuDYsv9s/9Vs6xRhnTBMV8ifx4IaHTs3
	 koyZd2SNnA9OWyCyA041HhdaWp2nC7o2S8x9b6GDiZM0fbqPDK6VtMsPY40J6Us5wv
	 d4msa6Fjn2+PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB5380AA4F;
	Tue, 14 Oct 2025 11:46:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v3] netmem: replace __netmem_clear_lsb()
 with
 netmem_to_nmdesc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176044237474.3633772.6843370754394921970.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 11:46:14 +0000
References: <20251013044133.69472-1-byungchul@sk.com>
In-Reply-To: <20251013044133.69472-1-byungchul@sk.com>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Oct 2025 13:41:33 +0900 you wrote:
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
> 
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> 
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
    https://git.kernel.org/netdev/net-next/c/53615ad26e97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



