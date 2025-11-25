Return-Path: <netdev+bounces-241366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEACC832EF
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45DA3AC0B4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C231DC997;
	Tue, 25 Nov 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVQnH2io"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F03FFD
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040244; cv=none; b=apyttDIllshBWOZDJ7a0m1fxYFyrfkDxjbwNSVtE+I96i0KDJjT3r3pEUb6bzQi5seCFrsPIQ1IU0f2ZAIEive41gitnSn83K5wgKw883VJH2Mj7+yQXl1aM4oTtEtbTLywBBuiPou9vFNTBJmzged08p4sL0APZlcuWuSJi5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040244; c=relaxed/simple;
	bh=hq6uCJpnX4KyBh7kp/qg7eH9yGg2iuASpVsKxgQSxPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HG9JaUyZWD8JTp4arlMs5UrGqk3svSXMMiuK/KvLnTzc+uMJ8VoMKZ/L/hHZqNXUsTMAepUpe+zBWwtcmwwbZDjm47TiqGQi6XzeG8vMUtcWDeCkNRG0HxSg0UHnEECkWRNE6Fwvgftx86UF/M2kCJ+7HiL7VUuiT0TMJBlcuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVQnH2io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED08FC4CEF1;
	Tue, 25 Nov 2025 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040244;
	bh=hq6uCJpnX4KyBh7kp/qg7eH9yGg2iuASpVsKxgQSxPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oVQnH2ioCwS3z5KsLNFivegN3EFNNPMEb2wGkLQnrr8VT/BbM+bd1zxdyxKfk8YlA
	 PRopkXbY5y58iMnefcjuIX/TsSVapejYPq3AglW1YshCeRyeEPK22wX01oNMBU/ClK
	 aGow8imcG04JmTzg1CEe4xj5EMqeGTqpDwMqctNwWbwLxDyvpWx+FX46MVlQ5ZOWh0
	 zRA2wl/0DkmGBvZErFT1wQ5MzuK4TgNL0odH9/xtWRZfmPPfRS/OTkPqI1qXdj+tql
	 T1f/9J+j1JjDME38fwYHqobZlGcMN66UO/qPu7nA3Zkwod+pMIDZ/UQuuI6jRi1Kml
	 pFuKk93zqluvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC1613A8A3CA;
	Tue, 25 Nov 2025 03:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: fix TCF_LAYER_TRANSPORT handling in
 tcf_get_base_ptr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404020676.167368.632588971771870032.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:10:06 +0000
References: <20251121154100.1616228-1-edumazet@google.com>
In-Reply-To: <20251121154100.1616228-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 15:41:00 +0000 you wrote:
> syzbot reported that tcf_get_base_ptr() can be called while transport
> header is not set [1].
> 
> Instead of returning a dangling pointer, return NULL.
> 
> Fix tcf_get_base_ptr() callers to handle this NULL value.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
    https://git.kernel.org/netdev/net/c/4fe5a00ec707

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



