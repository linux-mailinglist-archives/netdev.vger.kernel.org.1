Return-Path: <netdev+bounces-77538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3D87223F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DD283658
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB386AE6;
	Tue,  5 Mar 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtL/zTcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680A1DFF8
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650830; cv=none; b=SEaC+hve9bVQAt1rB6jh0VCLAK3CvDgsuPel3c0xoTDMzdnOuqPCsnL06zKmHxdgoVsM8drTku3M0RC/NByfB6Un5ceajP2Cc3fewYaONiIEfmEams7BgPpGubty6JBXMJdvfdlreK5J/ZeoQYpLGhq/sLj97KD3ZRHTFpcHJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650830; c=relaxed/simple;
	bh=IAz6425JaYqVXG/hN4EouM3kOKT+57DjsKLSPB0N2Ns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DOQpWfbti4hGxg+Su9bDuHJijoHWsCcQvBB9j6WL5XsjfKJummlAvAucy+eAx+fH0EpWnAGZq74gt+32L3LyF3DzJgi1Zz0E3CVmI+BwK/T/il/9PFKE7xVhTkP4yvDruIAbgn6i/MOGPzyT6FMGprYSgTlK3z7CVXeqAO8I3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtL/zTcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65EBC43390;
	Tue,  5 Mar 2024 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650829;
	bh=IAz6425JaYqVXG/hN4EouM3kOKT+57DjsKLSPB0N2Ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XtL/zTcJy/LxQN5sdswlgFl2f/ghj0h/0GiGNuSpaCbH3viCIHRIVZ0S9QNQg6YPf
	 fc7TQa8lDkirihTP4n+wFLEP7o9yqwszKp54vW86PwlCLR34tjdjs0Ra9V90/XHaQM
	 8ymv53cpw6of/gneqsZWP0AyvbG1QKIoUG4tkaXW3fmtbqYCdek4BCWYtRccGq7RMs
	 YyJqjEjdasvbfVIGnFpn/6R5glbruX1El+1sN6JdRdHeLrDBallE+B7C1qTzfUAOZ5
	 Vs4oAX8ZQ5J2FZyn1fc1r5eyJCJj6Kv6TGqYDe/TrjMbVLE/tpksiiVsdiC6u9HRu0
	 QfzWxn1das9RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99C58D88F80;
	Tue,  5 Mar 2024 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: reduce rtnl pressure in
 smc_pnet_create_pnetids_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170965082961.24565.6815593821638612855.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 15:00:29 +0000
References: <20240302100744.3868021-1-edumazet@google.com>
In-Reply-To: <20240302100744.3868021-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Mar 2024 10:07:44 +0000 you wrote:
> Many syzbot reports show extreme rtnl pressure, and many of them hint
> that smc acquires rtnl in netns creation for no good reason [1]
> 
> This patch returns early from smc_pnet_net_init()
> if there is no netdevice yet.
> 
> I am not even sure why smc_pnet_create_pnetids_list() even exists,
> because smc_pnet_netdev_event() is also calling
> smc_pnet_add_base_pnetid() when handling NETDEV_UP event.
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
    https://git.kernel.org/netdev/net-next/c/00af2aa93b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



