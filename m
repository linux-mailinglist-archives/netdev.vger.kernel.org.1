Return-Path: <netdev+bounces-43257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE97D1E65
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14133282038
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CFDDCC;
	Sat, 21 Oct 2023 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THofxUXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD24A52
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE86BC433C9;
	Sat, 21 Oct 2023 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697907022;
	bh=Uhkr0bB1pEXa9rW5VOWvgR7lAGMVpfpJAMHhfRSvu1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THofxUXHX6/bLUgSZAZD9Z/xQWBMPAl4FM+XoaF4+GSxMeI8n9L88j56m6OIrbCom
	 7ABOO+cSIyrQJINIoBLteEDjJLm/lfhIxEK2+MI7/LQrJoMICbukLziO9A8Z+C2M7f
	 ExmLKpeTll93ueVx3x8JdUh9785YtqVux1oQ0QP93hj0ph3lHp3swgaOzoiobmRiXJ
	 6W1jz1hK1WTg/fEkVzmq6FFAP0Q4pA8HvsUAl/fbxIJizTV93VrlmHYjAsqkym1GXT
	 t1aka48e1FhDzG/iZpSFTR5w5ULzhXX6pxtpjLxt7bKY1YmdbvNXtrttcuF3jAfOIX
	 OV8zRcCY6Iy9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A26F1C04DD9;
	Sat, 21 Oct 2023 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ss: fix directory leak when -T option is used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169790702265.24876.16927993046229278944.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 16:50:22 +0000
References: <0451403b-0326-4723-a3bb-8acf465fcf45@gmail.com>
In-Reply-To: <0451403b-0326-4723-a3bb-8acf465fcf45@gmail.com>
To: Maxim Petrov <mmrmaximuzz@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 21 Oct 2023 10:44:08 +0200 you wrote:
> To get information about threads used in a process, the /proc/$PID/task
> directory content is analyzed by ss code. However, the opened 'dirent'
> object is not closed after use, leading to memory leaks. Add missing
> closedir call in 'user_ent_hash_build' to avoid it.
> 
> Detected by valgrind: "valgrind ./misc/ss -T"
> 
> [...]

Here is the summary with links:
  - [iproute2] ss: fix directory leak when -T option is used
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=d233ff0f984a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



