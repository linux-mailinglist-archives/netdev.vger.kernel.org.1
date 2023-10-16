Return-Path: <netdev+bounces-41613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5387CB71A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC63D281031
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58A3AC11;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNjxJ6Go"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44223AC04
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39D29C433C8;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499625;
	bh=8frB8n8EpgvpOJk/TwuP74aMZY4wj+dhkEtmKJLVsK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pNjxJ6GotWta56mc4UQ4181lUvYPIg3ECNlN8hxxM9y7B/WyqSP1nvbFrZTTFeyQo
	 f2WAyyncKh5NYzH1qWGOSGalh51v+jKkO/ELxpffbW8dZCuC2j7oLj8fwQhG3mGtQq
	 oYxZcD4eUzjoMiV95yjsmqeuoRrW6vAEOdAMIQkxSe0xsYGQoJK8vncW60xiNCNl8f
	 96XbwKRNRMBz2EZlO4S2V/k0G8zVLYdvf5tuz0n0e6MfEDOTRmpm47UNAAWWRB52as
	 REI7Zb8s1yUHRrbqR+3ohXWEilaWcrNbMNuy7G0fFrNaSzsrVU8qT5oE8GLyoh5sUA
	 +6jFs85berg9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2515BC41671;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] cgroup,
 netclassid: on modifying netclassid in cgroup,
 only consider the main process.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749962514.28594.17942649071337663537.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012090330.29636-1-zhailiansen@kuaishou.com>
In-Reply-To: <20231012090330.29636-1-zhailiansen@kuaishou.com>
To: Liansen Zhai <zhailiansen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuwang@kuaishou.com, wushukun@kuaishou.com, zhailiansen@kuaishou.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 17:03:30 +0800 you wrote:
> When modifying netclassid, the command("echo 0x100001 > net_cls.classid")
> will take more time on many threads of one process, because the process
> create many fds.
> for example, one process exists 28000 fds and 60000 threads, echo command
> will task 45 seconds.
> Now, we only consider the main process when exec "iterate_fd", and the
> time is about 52 milliseconds.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] cgroup, netclassid: on modifying netclassid in cgroup, only consider the main process.
    https://git.kernel.org/netdev/net-next/c/c60991f8e187

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



