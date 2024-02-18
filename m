Return-Path: <netdev+bounces-72761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914885984B
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A4EB21174
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0376EB7E;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN5e7Nmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F39442
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278626; cv=none; b=L+9eLJWm8oP6DHWI02aNmHyvTVCTFj7s41hKUt078ZJtwGCjzqSvJOS7Bb3OIM08uCSXe1+Pv1LAu1xk5f/NGa98frsNVKW3OY6breR7kIS0bZirb3yRHch82yyQRv2cYKvbQjLMcaAR/aw2LkvqZ/fnc4DM9aGgg5H9n9+qa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278626; c=relaxed/simple;
	bh=0KzohIJGn6Lju14VR2kZ7Mz9ZZJbDIGaGdi+SUyVH0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dI+AFdI7n6rqJqqstp5dxAf9kuH2ssYieHsyvJV7qiQRjD0v2I7q5tUqNXZDbeAgY/vE21La/Cl/FuEaDv/yErlevMfMaq3orHtvHuy90I6M681UqHGhsb9Avt55rJAzbr9n6bGX9fXohZAyGVMBFZCcsqVoL7Zfk67FAoopqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN5e7Nmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A161C433F1;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708278626;
	bh=0KzohIJGn6Lju14VR2kZ7Mz9ZZJbDIGaGdi+SUyVH0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eN5e7NmfuqREUtmii16UNkV2mZpixMxf3y5LBNVPiy9QToGJgokDFn3F3fJ25uMV5
	 LA8xhodewY3N+r1uWQx9lxWxRsyPNsdrVd2fdfIxD5+wEykWc5OEp4O6SbHBTEUPxw
	 WlMpeBfkx5b/WUnmMrzycmWUPgluVFpNVbd31Pi8VlhXZNDpuE/md5EFElLyCevnR1
	 tBAMEzNn5GfU69KRBQ4eeLHRZA9cbR7+YzU0PCUoR/r2ApIR1YM/52u6TB29LR3v97
	 t0/cCcXY05+q58Df1YCPzYKcu7AriCFvg3QkqV49+hTDQHQxG1shDSlitJQDwejSR0
	 MYeUhXtLgk5OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E075D8C976;
	Sun, 18 Feb 2024 17:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] netlink: display information from missing type
 extack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170827862611.25576.14730029553431490141.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 17:50:26 +0000
References: <20240210173244.6681-1-stephen@networkplumber.org>
In-Reply-To: <20240210173244.6681-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 10 Feb 2024 09:32:31 -0800 you wrote:
> The kernel will now send missing type information in error response.
> Print it if present.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/libnetlink.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [iproute2-next] netlink: display information from missing type extack
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7e646c80d757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



