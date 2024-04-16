Return-Path: <netdev+bounces-88397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591358A7001
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A6928498B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27213119E;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPmTaUE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96455131186
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282028; cv=none; b=hmS2NPDJsJLZcotmYaMq9LC+zo4vbSdhv1jlHiwro1+/0EfotcMk+rZ3wPc7k4RFw4EUQPKsazg184KwQogJviQnw/nZa+Wsg3e4V0yIwnjjce9NOKKP46TCqk5CIQuLewqvWx5QeAcmu8WmITT/b6tTZF5cLdr2VrfdDiegmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282028; c=relaxed/simple;
	bh=WR71u8s7YqqDySXN3GAvUYzBswYYWdSNHl2ED7KArUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fL0qSHiOr1E8iy4E+r7PZ9QYkfPQeoYoaI8BS6bj/BOHuUzIGr8hG+n6Q5xUP0gUTn/O9yoJHqeQJ84MhyI0IqQYe/wqlb3uNA6nK8QVITd3UQHhrL09egSeKXUFxKb+w3u7esimeXNssnBvKQ4oDqE9qKHcri24alQL+KbxHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPmTaUE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5323CC113CE;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282028;
	bh=WR71u8s7YqqDySXN3GAvUYzBswYYWdSNHl2ED7KArUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LPmTaUE7AYMMyCG0lMvaVXSpNOh/+/N0zVcsDKQLPjHil9qT7p0sot1yo9lL8ZCCx
	 XTwX8JYTCI1iZ8CsC/HlG8iDOi2Gu16V2R8bR+CPA/aqHsOFfEGsDl6UC1wBUJ9pis
	 UqAvaEHt1c3Hor2X5YFzAvChYg/hAr0o8HrIRigFe+GSBz38xRqRHkS3YlPzit9s78
	 NgJdnZ9dpuGRf8743OdhO0fZWjaztioSx1LA6iMwXFPij0rgEYTWDQP7NGec6I4s/A
	 SYxpa1tJce6XUt9BJpgI6SFdchPX/sGJqLSZYf0x7CfODTE5Rjfyg/U0bMF6TEp/4c
	 DHmboDdm+GQ7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 389ABD4F15F;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mnl: initialize generic netlink version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328202822.2661.9554531484220629355.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:40:28 +0000
References: <20240415163348.39425-1-stephen@networkplumber.org>
In-Reply-To: <20240415163348.39425-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, parav@nvidia.com, jmaloy@redhat.com,
 jiri@resnulli.us

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 15 Apr 2024 09:33:47 -0700 you wrote:
> The version field in mnlu was being passed in but never set.
> This meant that all places mnlu_gen_socket was used, the version would
> be uninitialized data from malloc().
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/mnl_utils.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - mnl: initialize generic netlink version
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0a1e1522cde9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



