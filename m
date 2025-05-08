Return-Path: <netdev+bounces-188843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB20AAF0B1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224983B17FF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAA1A7253;
	Thu,  8 May 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFcBtSBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318641A239F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668421; cv=none; b=oV/65HE2mVmn9etE8dz8GB0bb8t4x3YZ0wWHnwD0MSmVFRnCtKi2liH4sVFQ5SIm2//JJqigRKiGGibt+wW/W3UUxiW4C8jqHZRWx+WsGOJje9dzU8AEijNRdC1nZuv27FLLeDR0CEl0Gc9MwE7LmSeXpfWyJQ/ZEw07W24cRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668421; c=relaxed/simple;
	bh=SVW0cGTGgAxTHTZsQUGgWefvhNR+j6hv82yNhVrp4hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=abGw6qau+/8+din/dYABec8+q5NSoG9Xomc0mlbyC+AMjZLARV7eOSBtsBI6iFRaaveNLrbNMCUFQa6NKQQuQqV7K0hqxeM4ksWrpTv+U5+RZ5YRv3ymcF5Lk0sHMOkKrfQSEdT04XRR6E8wwA8mX+e924QkMCumAJj5xKwbJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFcBtSBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9FAC4CEE2;
	Thu,  8 May 2025 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746668419;
	bh=SVW0cGTGgAxTHTZsQUGgWefvhNR+j6hv82yNhVrp4hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IFcBtSBLnx9sPlf7VbX1u0axZbpRmivIvNZbRocqXQsoG2YS7PvZGY5fYAhj+Ff2d
	 Ryn/49ffMxMtemLo2icKFQ/vaPJLk1y+AaEt4eEsOdgssjMCXs9r0Cxf65D03BvUQr
	 e/bh+mkdB5E2KkeKN8J5nZZvtH4Zyt9OR6k6Ezv29k+3Ub2Qx7EFV8t2uqlWDoiuOJ
	 3YCQNUFDQyuBsmuvGULkqxTCT+sN2GXyP7BecT/LVZsfMR1vwJwLnvGAZv4FeGqcQk
	 Ts8fVksHnlPwFYYJOU41UGMLys85XMkAnvtgA+Y+27dc5bddoyxwlzrq2CQ1Rs+MKH
	 mctE97lcbTktg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB9380AA70;
	Thu,  8 May 2025 01:40:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tools: ynl-gen: split presence metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666845798.2418694.3581581563688647063.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:40:57 +0000
References: <20250505165208.248049-1-kuba@kernel.org>
In-Reply-To: <20250505165208.248049-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 May 2025 09:52:04 -0700 you wrote:
> The presence metadata indicates whether given attribute was/should be
> added to the Netlink message. We have 3 types of such metadata:
>  - bit presence for simple values like integers,
>  - len presence for variable size attrs, like binary and strings,
>  - count for arrays.
> 
> Previously this information was spread around with first two types
> living in a dedicated sub-struct called _present. The counts resided
> directly in the main struct with an n_ prefix.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tools: ynl-gen: rename basic presence from 'bit' to 'present'
    https://git.kernel.org/netdev/net-next/c/a512be0ecb14
  - [net-next,2/3] tools: ynl-gen: split presence metadata
    (no matching commit)
  - [net-next,3/3] tools: ynl-gen: move the count into a presence struct too
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



