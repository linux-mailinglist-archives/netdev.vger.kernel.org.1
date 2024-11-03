Return-Path: <netdev+bounces-141341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E319BA81E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A242A281683
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10618C022;
	Sun,  3 Nov 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSPm2edk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6C18C01A;
	Sun,  3 Nov 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667623; cv=none; b=POtqf3xVZGxG3Goa2Oc72UZko9VeMlaIJQpjADUN7hAlkTzcLvdPfNa9yBPnnCcBwQCLiAuAr8kVRdWAAjsXLH5xHxL63mFqRjKFhTKb2YVeJhBQNl+WIgP5R+C/JU8fhq7xwgkng0IrgC1UALJTKZ4tE8DD6VcLn1oPCh7H0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667623; c=relaxed/simple;
	bh=ZxjBlqbzGgDX+Q4bZH+42/uYsJa0Af5Svb3ksKvyLzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRj9lA8JqRWik3ih4f3sHcUvLN/dJTqmZDFFA6+zGFTyciPGugp0Oa1Jmub27mHN+qnOSQFzj5X8x0i1qnCtyi/hGBvHzHIevPTjzFEXTUVqBSD5f8uLxp3IvywWqxw0LpzVzLizM+RRnwBZqVu9fBkBrghV1WVFQEuQEBS5FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSPm2edk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B23DC4AF09;
	Sun,  3 Nov 2024 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667622;
	bh=ZxjBlqbzGgDX+Q4bZH+42/uYsJa0Af5Svb3ksKvyLzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NSPm2edkzhs3vRVPSDxcBbLCh5YfLraAtTdhaIKbxDGLmO0HDQrD8sMUvX29HSnQz
	 84rZ81wmtaLvTkd4a/hZZ90p1RiFLUU9B5VIkPCZQB4n3o3QKBMTYKPqeanG802Jwg
	 ixgNaEt8d68vCZIUT9Fw3oB4Yc3LXqscHqM+WiTURQYR6XnHblXCYROPGwhG6esoAA
	 jC5z2Zms61WaK6CKOVDJpeEe7YY47qUsfGzqr3c29+AUrnkJ0tsKRLT1fIZbeESGF7
	 EiDrX65S6Ic89gRdtTM8goj8GiVQ4o+rqsqovzskVIiBUP4GzqWe7SXkb4IKJgq+jx
	 mBWQt60rq7NJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4C38363C3;
	Sun,  3 Nov 2024 21:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066763074.3253460.18226765088399170074.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 21:00:30 +0000
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
In-Reply-To: <20241031173332.3858162-1-f.fainelli@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 akpm@linux-foundation.org, kuba@kernel.org, krzysztof.kozlowski@linaro.org,
 arnd@arndb.de, bhelgaas@google.com, bagasdotme@gmail.com, mpe@ellerman.id.au,
 yosryahmed@google.com, vbabka@suse.cz, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 10:33:29 -0700 you wrote:
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - add self to CREDITS
> 
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net,v2] MAINTAINERS: Remove self from DSA entry
    https://git.kernel.org/netdev/net/c/be31ec5c8efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



