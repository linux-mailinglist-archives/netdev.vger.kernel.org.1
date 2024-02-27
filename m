Return-Path: <netdev+bounces-75326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E876086975C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C272860D9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EE13EFE9;
	Tue, 27 Feb 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h339p+Un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DF78B61
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043633; cv=none; b=XNLNyhwkcKtj8iGPc4w7HD/s8jgaS/u+bLmoP0iIQSK/4IA6MNRQvXUPTYbMLpIZ8vgQb6+9J63tRTFBivigoxXG++WBwOxHDPqBLAVr57/44iZKYpFmiMuzxdrmRSydjqVkDItWoy3zfgomxEg2+GKb/AaW4xF+sZRnu8DLn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043633; c=relaxed/simple;
	bh=yKWneTOw4Ary+Q3VndEsuOYA/mlPmm9zq45KLVjfQaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DaoRGbXUa4P/jTeR0pqX9NDsc/28K5vYRzpq19d8vdsBz1StL/TJMtCDzKLZ5rbWg4idHllkg4y/zT5H79D0Fx132mQL2B+dF7DL4Ul59+DIT2Bg4xClRgNb0Xw0BZkHkyHdolnUBGQyyuKxle2Up3usKxF6HXYMdagjwBuBH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h339p+Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD002C433F1;
	Tue, 27 Feb 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709043632;
	bh=yKWneTOw4Ary+Q3VndEsuOYA/mlPmm9zq45KLVjfQaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h339p+UnskugXNIExCTWx5p40GS0p5/6JM9gS3iMNUo900mK+EQmrwzXnMiqm8pqK
	 S88tggmn90FQV6BXcXcuaP0rPhrKbhQMTztyz3CRN5LOCDvg8b+DXxVYTK4yMKxd1o
	 ClIBtQ2+rl3FJ9uUkV/VctGy1LvH8i+g2M2dIa0QNqu2KMwIKT50d5047yfKHIkWxh
	 HY4NXlIcuBwKRlgObUeyMQyxx+0JORoZ0ttA/62go5HimWO/yXUcPygsQ/0JHGluTi
	 rMGby9O1htNKkAn6M0eAueSlze3o5EIPiYQ9cka54QOhohq/eyb5tYStjrM8VJFbKc
	 +XeYW9D8YyRQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90F92D88FB6;
	Tue, 27 Feb 2024 14:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: try harder when allocating queue memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170904363259.25537.17522273632886724328.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 14:20:32 +0000
References: <20240223235908.693010-1-kuba@kernel.org>
In-Reply-To: <20240223235908.693010-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shankerwangmiao@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 15:59:08 -0800 you wrote:
> struct veth_rq is pretty large, 832B total without debug
> options enabled. Since commit under Fixes we try to pre-allocate
> enough queues for every possible CPU. Miao Wang reports that
> this may lead to order-5 allocations which will fail in production.
> 
> Let the allocation fallback to vmalloc() and try harder.
> These are the same flags we pass to netdev queue allocation.
> 
> [...]

Here is the summary with links:
  - [net] veth: try harder when allocating queue memory
    https://git.kernel.org/netdev/net/c/1ce7d306ea63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



