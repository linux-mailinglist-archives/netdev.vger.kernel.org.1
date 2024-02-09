Return-Path: <netdev+bounces-70580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D984FA37
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4917B233AA
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA9823AA;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3tCQerJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1081ACB
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497430; cv=none; b=Qud3om+dh2XFuKxvVSnvcpMj/iW3dBtt1ZvkNPdDelbnLM/8b7RumHGCRk9Lhni0F9jMn+XlJf6HDtm02HTxGd/Ftbv6jNn/eHxmyFMCs2F1w0feTUIHQFLoyVxfr2J+J+JRX/lhPcbts3zOWA/rcio523pR8hpg1+5stVho/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497430; c=relaxed/simple;
	bh=dXk3RmAwr0COeaMQA/wDiMw6BAuXmDZU+vqaqPEGt5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d6Fgy58BQwtjfSIFKmvAgl1N+jmAa7O4SP1SWIv8uKkJzYOKN1fBHX8vqyAEdc3FNB8YeI+HR3GqLtZRQoBOYp7SlNVsHgLGnxejfuQVI6TP36+x8Sbg1IHsz6BLyOj8++xFHLFkBnhrrY/Lz+yeejB/wWl2AlQZ3+STHbYenuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3tCQerJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AF7CC43399;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497430;
	bh=dXk3RmAwr0COeaMQA/wDiMw6BAuXmDZU+vqaqPEGt5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3tCQerJUq9GM8/RNVObDDgaskNvh56N/uklwUJ+VjHtJScIGmdTHp2GjIKnEydyh
	 srGTKg8mmkV0yeMegDWYm2+3zQCFUbdYRjytXlYE2f59eYDQSKZD8arZ9KswBtfn8R
	 OVPxrrxLiGT2Gvnb34fgSk8qpR6IsMVWQd/5xrO6gUnC5tzFppSOw+rjoOiyV/Ok2a
	 i2nFhiJhUC9f6n8MtQ2rzeEPC4bykVQG8xa2JbpfMMdRbIMrZ4CNh7OjA7GJhLbWTB
	 wTv4UOwyVEBcsQ/bktTbVzo+E0OzvE8Tsg2huCvY2+7Nn1nCzHiPM4pKoK1aHOADBG
	 RoSJSdbIv6YgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EDF8E2F312;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 0/2] Fix some more typos in docs and comments 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170749743011.28784.1458264970928294129.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 16:50:30 +0000
References: <cover.1707492043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1707492043.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri,  9 Feb 2024 16:25:44 +0100 you wrote:
> Time for some start-of-the-year cleanup :)
> 
> Using codespell, fix most of the typos in iproute2 docs and comments,
> except for some false positives. I didn't bother to report a Fixes tag
> for all the typos, but I can do that if needed.
> 
> v1 --> v2:
> - rebased and dropped some unnecessary changes.
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/2] treewide: fix typos in various comments
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9cf6493cab29
  - [iproute2,v2,2/2] docs, man: fix some typos
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3c4712b95d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



