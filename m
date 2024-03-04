Return-Path: <netdev+bounces-76936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3186F826
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 02:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53440280DCB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47D10F9;
	Mon,  4 Mar 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ1WfJIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A410F2
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515228; cv=none; b=u0oCs4Wic05K+2AcvibfQowvJDCLta2Q20tliDAiuGuNkgggYSwhVUuUlRjbHsNLhTEgxTKRvrn2KbafM55oN95PXYFRa2nRB763MW4ibiGeZUNiQfAkn1YEFk3XKLVxHeGAppIWDx7gbTsG2oVTdj75hruN1hrhPioJmAg9prw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515228; c=relaxed/simple;
	bh=DX7UEXBDli+pjjGGqPOQ69bjHOtYgis4O6lG0nioGmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qUIQByaVbn+bi5ECT3CHyJYsq61wYJbl21wjtFmHmPuu3I33AEUSlD1iQErnQDHCOY7jEiZNXmUc6pbHE6KO6GikM6xv8ZXYKilqE4FtxJjtVM1Z/cSEc6FaNZpVgKCND6vtQvX8mJ7azRo6wEc57VQkNjok3KhPjBZ/ZEgn0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ1WfJIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5951C43394;
	Mon,  4 Mar 2024 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709515227;
	bh=DX7UEXBDli+pjjGGqPOQ69bjHOtYgis4O6lG0nioGmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MQ1WfJIlxhFfo8smsgUU9kRY/Cnp7HFftWGOzn9PpuYKpjvgtCkHs7T21gr3svwll
	 sB3wTqpog3xHkEa+X5LDU2iUDRIcTwwTg//RpIQinVp6JL4UgUjBbCuf52f7uWoceV
	 83DznuLLfBgD7XvpEgyarJ+JbRRc1BlN2JPJAP12IwvFg8vMipzU0N+ZbU0iCMPgPV
	 q61Wmyb3vp9FwJa6U0wx10jmx4U4FxdaxGrQDidGH76ISefNopWpeeWBUPizt3c66n
	 qXR6aWeYMvNvVkBPxImzYyh/PA2A1WPNNT6WvzZKsOiCxDWTeerL7k0F49g5Q/Kuzb
	 hDXed4EV4Pz3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB877D9A4B9;
	Mon,  4 Mar 2024 01:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v3] ifstat: handle unlink return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170951522769.23383.7658865151855966663.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 01:20:27 +0000
References: <20240229122634.2619-1-dkirjanov@suse.de>
In-Reply-To: <20240229122634.2619-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 29 Feb 2024 07:26:34 -0500 you wrote:
> Print an error message if we can't remove the history file
> 
> v2: exit if unlink failed
> v3: restore the changelog
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> [...]

Here is the summary with links:
  - [iproute2,v3] ifstat: handle unlink return value
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=67685422bfee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



