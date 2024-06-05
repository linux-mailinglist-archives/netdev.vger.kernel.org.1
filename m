Return-Path: <netdev+bounces-100882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9528FC749
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2EB23390
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C41518FC95;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv7VG5M3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887A18FC91
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578630; cv=none; b=MIX7f3fNiTjBrzGy4KP6K7IyyaihnfgdIQSQgn5sy+Vmcx5ObU8JMDlNKgN/NaSjRgYZntQphCnUW9lEAcdJheiMun5vvX56gUdtv7/ZmiJ9B3wDypIu1KahMrlKp3srsM23DhFFDWZOY7arS4kX4lzDO+3hXmhyQ9vuDb8Fqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578630; c=relaxed/simple;
	bh=C+2ZLc7sf3Ys7Q7SHQlAgX6ueBskjx59tPa5kMifOeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkRBRdCrQThV7zbl32FuXWcLUY37b1cQsdiyIP5espSXEF1Eyt2lq2uJ032hAhEZKH5bVF+vSzAr2XX14Hu/3BSJJ8P6gAFhvI0wYoFk+O1XaE42+hV5AlFqIdlXePWrYJMr26BAA/rkZnQBP/tuS8Uj+RFyJ/h9KCbOAOyF+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv7VG5M3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13589C4AF09;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717578630;
	bh=C+2ZLc7sf3Ys7Q7SHQlAgX6ueBskjx59tPa5kMifOeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nv7VG5M305IMQikuiVlRidyqw/5RHctF54DXzhf0IyNYaPH0D8h96mtUvA1S882lv
	 VvE+QUPMigD4ko8zR838kbrGeDGZyxTizZAty1Ze3RzAUCXzkyHyeP53ZZlB/Unzrx
	 3fBLtRycGcb+c+zDDpz3uKq3j0ZmZlhlyRUkBzKk/o/ijVMfyXdWQfyn23sMnZCcjZ
	 u2nWDtXjBi7sWXBgAZ3I3/w+LydlEf3Uv6v6e9yMSm6++lPhv3itFmtkGqeeMKqv9A
	 A9UX5FZLbkb0VuXvhysaFmDwy36XaLt2UsIkLT2Xly+OvVH48YTA1tn2/bHhCbrbT4
	 n76cKw+gExKNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01F1BD3E997;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove NULL-pointer net parameter in
 ip_metrics_convert
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757863000.24611.7378256087070956824.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:10:30 +0000
References: <20240531154634.3891-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240531154634.3891-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 31 May 2024 23:46:34 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was doing some experiments, I found that when using the first
> parameter, namely, struct net, in ip_metrics_convert() always triggers NULL
> pointer crash. Then I digged into this part, realizing that we can remove
> this one due to its uselessness.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove NULL-pointer net parameter in ip_metrics_convert
    https://git.kernel.org/netdev/net-next/c/61e2bbafb00e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



