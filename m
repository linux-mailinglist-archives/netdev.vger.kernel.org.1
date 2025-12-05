Return-Path: <netdev+bounces-243694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456CCA5FF6
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 04:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4291931A859C
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE829C327;
	Fri,  5 Dec 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov5nHg8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C628850B;
	Fri,  5 Dec 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904999; cv=none; b=hI0Z7QO50BshD3eOaKsOfJ74j5S9AZW1ww1geeU77DBraKUUui/RLkg0NEJEA7DkGQut8X/4IiVtNYWLZKLwLdYiYzRjzB+UEts3PH3YyTA04uHT1lmjUQ8Tn90qkOp7ohco+ODKYMGJYvd86tKqOjkmBnbwjm7CsIKWcYrK0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904999; c=relaxed/simple;
	bh=8h/EbhHmq6jEPpO6K8yQVzW4wPeFl29GhnVIZvTkUvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a6Lh9dt7uoaUYvwhjpEQ6ETIjICfeyh62XySUSDdTgut++WCuu5+Me2u5ang1yhcM1VrZ0GdigNJfVcjedfvnX/jvaTjtw+oaHsPls2e1XDi4aVtSHdpMm7T2zxNiHjjQW42XuAt3kWIRGjOVDlzhjO3OzGvUWUoBrFEfVyzmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov5nHg8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F326C4CEFB;
	Fri,  5 Dec 2025 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764904999;
	bh=8h/EbhHmq6jEPpO6K8yQVzW4wPeFl29GhnVIZvTkUvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ov5nHg8+3JNrw3B8mdeu1JmSdBhB7E++eJ4xV2nmfDyWMxI6bIIzbm6mV+DSRZrHQ
	 wWHDehtub2PJDQ50xCVb5vCEvMvD9399oIWFqraxma9ZiwfpOXFKo/7pUXcH0UNOfD
	 mve1j5l4y4VYsFNHIM+AcDkiQqkmT682SvnQMAfyFe85dwlxS9zL5jMzZCPpAJpX2L
	 G9g4lVjJSAvGJ9kufZUSwSSS843tNtgH6Ry6cZFpwo/eDXFH8U2ZzsJ7F3y6Tdu0fK
	 0RaNIG0inmFaEEgF16Rr2+73Mur/YdoXeglUvxXeChK0EODw6bAVkon5MdDJ9Nhd5O
	 pLKZz7YAjYPZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BD493AA9A89;
	Fri,  5 Dec 2025 03:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Move gve_init_clock to after AQ
 CONFIGURE_DEVICE_RESOURCES call
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176490481704.1084773.17016519468675100556.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 03:20:17 +0000
References: <20251202200207.1434749-1-hramamurthy@google.com>
In-Reply-To: <20251202200207.1434749-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, willemb@google.com, pkaligineedi@google.com,
 thostet@google.com, linux-kernel@vger.kernel.org, nktgrg@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Dec 2025 20:02:07 +0000 you wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> commit 46e7860ef941 ("gve: Move ptp_schedule_worker to gve_init_clock")
> moved the first invocation of the AQ command REPORT_NIC_TIMESTAMP to
> gve_probe(). However, gve_init_clock() invoking REPORT_NIC_TIMESTAMP is
> not valid until after gve_probe() invokes the AQ command
> CONFIGURE_DEVICE_RESOURCES.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Move gve_init_clock to after AQ CONFIGURE_DEVICE_RESOURCES call
    https://git.kernel.org/netdev/net/c/a479a27f4da4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



