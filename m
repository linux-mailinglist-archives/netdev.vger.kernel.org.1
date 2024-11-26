Return-Path: <netdev+bounces-147348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7329D93BC
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9A8B275BE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A41B4142;
	Tue, 26 Nov 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgKz1SKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE51AD9F9;
	Tue, 26 Nov 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611618; cv=none; b=MwVoE50NETXE2I9uStSUUbGhF5nT6w8gLUwTwWpoUnKNl3Q3eOKEfpystkosWeE4aam+FtVll3cRoRGE21xm+Fila2ZCvC45ykuGKKDVAGIhElfhAfjXIVk4y2BCMWfv1WoXmkVRxE/xXcHiZWg5APrgpy4A38AAYA6E5X8Vxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611618; c=relaxed/simple;
	bh=MtrrpWa+DLu+oO3ptkLS0bspbdjI0fJGpUEg/PFl3mU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RV97f+se+HwFPi9Lz87BKosABVnl0wVN2ASZrJ/1Z4jYnXdLN5rUyLx+pyMEtxTc1IhpSB24npS7u6C6XWEwrt73/lINtO8kp65Gk6fK20M+ayK65HpsE3FaQGcYqS1mtVoGjU1OIsPe8GnsG0GF9E4K30sme5pGYky1XfdB7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgKz1SKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B43EC4CED0;
	Tue, 26 Nov 2024 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732611617;
	bh=MtrrpWa+DLu+oO3ptkLS0bspbdjI0fJGpUEg/PFl3mU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VgKz1SKVfyxKerTmvXhVbT1Tjsze8wfRPR8MJVL0ElGwhq/RsDZGWH7Ba6fTG365s
	 8+0Pv+DiUI5vUGORYfBn58gSQBcUdW39vrGBZOLGC+WZBMxR4OYXWE4LUIpSvkG9hB
	 W8n0sY9JcrGpke1Ha9KheAXWboJp7RXVR1+XEesPCh0erc8I9Z/bE+CGyMrLnbGpEx
	 K7wJjfTckMoMG28InP+mWM/5HVrFoLCIHtddAjG6KrD59vn5t5mMtj3VbH+5xjtLPD
	 MDS1Gy3Pz3wO30giRsce7WHBfQSH3VSLytDrA4wDKPXUQqNYD7SU+mILKUeanuRdtp
	 asFb+WfsmrV8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 355243809A00;
	Tue, 26 Nov 2024 09:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/l2tp: fix warning in l2tp_exit_net found by syzbot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261162982.313261.16721245294644686761.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 09:00:29 +0000
References: <20241118140411.1582555-1-jchapman@katalix.com>
In-Reply-To: <20241118140411.1582555-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 guohui.study@gmail.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com, tparkin@katalix.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Nov 2024 14:04:11 +0000 you wrote:
> In l2tp's net exit handler, we check that an IDR is empty before
> destroying it:
> 
> 	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
> 	idr_destroy(&pn->l2tp_tunnel_idr);
> 
> By forcing memory allocation failures in idr_alloc_32, syzbot is able
> to provoke a condition where idr_is_empty returns false despite there
> being no items in the IDR. This turns out to be because the radix tree
> of the IDR contains only internal radix-tree nodes and it is this that
> causes idr_is_empty to return false. The internal nodes are cleaned by
> idr_destroy.
> 
> [...]

Here is the summary with links:
  - [net] net/l2tp: fix warning in l2tp_exit_net found by syzbot
    https://git.kernel.org/netdev/net/c/5d066766c5f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



