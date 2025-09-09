Return-Path: <netdev+bounces-221021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8851B49E69
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C47B7AA35D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FC2236E9;
	Tue,  9 Sep 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5cLXug7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5322259F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379610; cv=none; b=jRQjR7ZvYlpR8pbbTrqSQ9xLq21DA90aqGtV29OyYWX8y0bJvujK3Xg9RZR2k1np/oNvNGppKmGHftQ3x5kFO+XzDfnMONKAv+/1NWR5nQiAN5QYlqH5pwpM2bICmOVYVmqQZx7ZeiLEeRrwZw75LNhJZakxWBY8z3SnrEQjmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379610; c=relaxed/simple;
	bh=YgyrdoMHq5oFkuv/AjXSurvOvAY0tejaeK9rC4DQEGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dCllFkCnP2VYN+RwRUWlywR+R+C5cqUIt+jGUFScOUCgVzvDf0WbiY/Zjp059GQB/68/zPqFESLBUBNgwznhB1F8kx4mGcrSlVcy/r2be9AgbTilQ5YO/Ytn0AkNb42drgU6dXboyKU5eTJEq8U6PWT7KBe0cm/l+4T9FeSxCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5cLXug7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212BC4CEF8;
	Tue,  9 Sep 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757379609;
	bh=YgyrdoMHq5oFkuv/AjXSurvOvAY0tejaeK9rC4DQEGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5cLXug7G1ui5Vpr/Y52Of6c+k+pU9a6veMYbI/fAeK1fitnpbb3roHgSYehzPCGe
	 6rppVpG2P4Obz1OG4rKn2zoyMJrbp9A+t9VU/kHZgAftvYXB9yGSBO3nOqB3bLP3H6
	 TgnOf+ZWeZMuuyhGkmFZWIAvs42x/W8bKDE5d3FrJh/qhe9IQ+iwsLdfO1U7GgcJl2
	 0N5CVyTHRo0NRCGyXEJuVoOrQOGLcZpfGJLwvdFTQfR9V59zJo/ajakQfD/PNP7a2W
	 GexNdCHkjniJJMsEZd6hiIYlX15x1jZ7eXBHt4MFe2sxsYRQljVk2wSyIRf+N5oiFz
	 7casIyduxlOIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B47383BF69;
	Tue,  9 Sep 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175737961299.101810.11808569413824366025.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:00:12 +0000
References: <20250905165006.3032472-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250905165006.3032472-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 09:50:03 -0700 you wrote:
> Correct a typo in af_mctp.c: "fist" -> "first".
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  net/mctp/af_mctp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mctp: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/bd64723327e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



