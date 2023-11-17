Return-Path: <netdev+bounces-48762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C97EF6EA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF9B280CFF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9BB36B1D;
	Fri, 17 Nov 2023 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMr6fF+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627963BB46
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 17:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABC9EC433C8;
	Fri, 17 Nov 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700241623;
	bh=9SQl7nvG+qlvBjxavotdbaLS/oX8/OIgvUbEJ81WXbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rMr6fF+J6dOpIQRb8Fjs1PyWwjySPK1kStwN96y3pUUDcDNIiEg2QwgIUrzJIDTKi
	 U2Frtp4oEiiAsZ3ZL1n6Xkjdj8HQ2JjK2fRkE0dpYWhUrqkq9oQWMPL6fuprER83af
	 BXkAq04fs27oWSt//UcafD3c7D0jk0PWtU3Ryz6XjvuULmtH88JF0TEocKVpHKUF80
	 5I56ZuirGzbpWvUFcrLo2StjCqEl0WFhr534+9XJiKwuOG65/tllTp0y0ZP/0SqNCD
	 23YuDRF9WBchpb8LzoUFKcZ5hYnw0DBQ2mQk9D5a6QZsMWMz6w/LRQfURPOiuZr61h
	 B7pxeMPyBWMLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D5A7E1F663;
	Fri, 17 Nov 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2] Makefile: use /usr/share/iproute2 for config
 files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170024162357.26596.1027063151357340869.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 17:20:23 +0000
References: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
In-Reply-To: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 luca.boccassi@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 15 Nov 2023 18:25:35 +0100 you wrote:
> According to FHS:
> 
> "/usr/lib includes object files and libraries. On some systems, it may
> also include internal binaries that are not intended to be executed
> directly by users or shell scripts."
> 
> A better directory to store config files is /usr/share:
> 
> [...]

Here is the summary with links:
  - [iproute2,v2] Makefile: use /usr/share/iproute2 for config files
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=962692356a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



