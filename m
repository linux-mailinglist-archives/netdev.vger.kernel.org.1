Return-Path: <netdev+bounces-43660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC67D42E3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501151C20A44
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62C2374E;
	Mon, 23 Oct 2023 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go3qqMLf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9D22EF7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1EE1C433CB;
	Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698101422;
	bh=mJX35hAcD1JSG3njQ9+vUUtCl3tLPuDxtfaAGjRnMNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=go3qqMLfWxn3JYBFjPXKEf1gLz7roxg332gixLdMHtS57Fh72sK6xMLcUHuKR/yPt
	 iQYPUE90hTMlHbWg1v0pR1fqEUS7tegMDwTWPtXQxAzcMrRS5VWI73q4054BHXUqMR
	 1/AGv18Il5kc1njh7w1UhrFGodMjxWHJgZ6o0a87w/5Q+LD677HWnah+TKraW6ZQMj
	 QhylbCIDA+MPGHCebrRZaJVit7/V4SCF8gU649cjCoESfFrkabSMoAuVWNJGQKF2Cs
	 yFLm8SXEJWfwgrxc7AuA2LP2ecHvNmtVZR1jehQ1C0G3G7qnBPvVGgk7sVuBF4miGr
	 Hf65XhSdAVWPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE62FE4CC11;
	Mon, 23 Oct 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: cleanup and reduce netlink error messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810142270.24047.6388820668841040891.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 22:50:22 +0000
References: <20231020140149.30490-1-pieter.jansen-van-vuuren@amd.com>
In-Reply-To: <20231020140149.30490-1-pieter.jansen-van-vuuren@amd.com>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 15:01:49 +0100 you wrote:
> Reduce the length of netlink error messages as they are likely to be
> truncated anyway. Additionally, reword netlink error messages so they
> are more consistent with previous messages.
> 
> Fixes: 9dbc8d2b9a02 ("sfc: add decrement ipv6 hop limit by offloading set hop limit actions")
> Fixes: 3c9561c0a5b9 ("sfc: support TC decap rules matching on enc_ip_tos")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310202136.4u7bv0hp-lkp@intel.com/
> Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] sfc: cleanup and reduce netlink error messages
    https://git.kernel.org/netdev/net/c/d788c9338342

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



