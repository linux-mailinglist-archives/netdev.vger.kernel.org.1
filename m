Return-Path: <netdev+bounces-95473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5CB8C2569
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAFD1C210B6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60A128376;
	Fri, 10 May 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFuf+nUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D9537E8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346630; cv=none; b=rEpg5AkRiFgUcHJZYl4Izl4NTiU52YRjNSoNDjaVfAf+eRhADxSDhBoYwMpYrIR6Sh2UDtNAqgnTxWqqUainNcHplohHJtHEeHBGQ+lkJyS4ofMzDUwVm9qK5epzsooNrHoWWMlJMVjnRzcswT01bcIooCbbeBNxbgfXifuYlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346630; c=relaxed/simple;
	bh=mAgvSq8O8kDQVRt2gHbfy86ZJZ/b5TLkGAwIdCqaSLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZxYzOxmv8bjn0Rzbec+ElLmrAntSP6AMiC56zi77r2FEOUA6XOTAuwRBPQsqxCyKgrTuPkpLzXp/HJEM6q4ypVVZijpm9RiI9//80o26OsLwhHCfdtik21I2Li2LzCCrlzAHtLgujNFfbGCOwj7+LRaEoZP75+9Fnw6qEo5JCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFuf+nUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07A2DC2BBFC;
	Fri, 10 May 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715346630;
	bh=mAgvSq8O8kDQVRt2gHbfy86ZJZ/b5TLkGAwIdCqaSLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oFuf+nULpCx8dgrL3q4HlGFLdsdbWR8Q6YZVbz21WGFlTWiyGpzq7JSfYB7q+OXfj
	 0NmyBhjpdIAbtpLR0DC61eOEFEIS12weq6cah9dbQyCjhNuAk/mNvItO5iSOGrGzYl
	 K6irnioKVQ/195hMI7eVbYgaCRiM3N3v3OqALAvC9/Uq+7fzX/7fbQf+94Iw84fotv
	 e55CbTatOE6BtSdqTsroL+e9D2azZjdqScClvkwSRDeLN6+1GGgWscDtup+eGiTZgC
	 ietjEtdqUvceUAaXrZAyNj0YwDIOW4vb4BcepSkWEMYhsIjqlnKBZtxm0rAIOBlwby
	 2D8Kp6BRieNdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E736DE7C114;
	Fri, 10 May 2024 13:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3 01/12] gtp: remove useless initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171534662994.12238.5609528418870545724.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 13:10:29 +0000
References: <20240506235251.3968262-2-pablo@netfilter.org>
In-Reply-To: <20240506235251.3968262-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
 pespin@sysmocom.de, osmith@sysmocom.de, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Tue,  7 May 2024 01:52:40 +0200 you wrote:
> Update b20dc3c68458 ("gtp: Allow to create GTP device without FDs") to
> remove useless initialization to NULL, sockets are initialized to
> non-NULL just a few lines of code after this.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  drivers/net/gtp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v3,01/12] gtp: remove useless initialization
    https://git.kernel.org/netdev/net-next/c/353f5ffbc63b
  - [net-next,v3,02/12] gtp: properly parse extension headers
    https://git.kernel.org/netdev/net-next/c/b6fc0956ac53
  - [net-next,v3,03/12] gtp: prepare for IPv6 support
    https://git.kernel.org/netdev/net-next/c/750771d0ca76
  - [net-next,v3,04/12] gtp: add IPv6 support
    https://git.kernel.org/netdev/net-next/c/999cb275c807
  - [net-next,v3,05/12] gtp: use IPv6 address /64 prefix for UE/MS
    https://git.kernel.org/netdev/net-next/c/c6461ec97b25
  - [net-next,v3,06/12] gtp: pass up link local traffic to userspace socket
    https://git.kernel.org/netdev/net-next/c/e4f88f7381fa
  - [net-next,v3,07/12] gtp: move debugging to skbuff build helper function
    https://git.kernel.org/netdev/net-next/c/e075880459a8
  - [net-next,v3,08/12] gtp: remove IPv4 and IPv6 header from context object
    https://git.kernel.org/netdev/net-next/c/559101a70784
  - [net-next,v3,09/12] gtp: add helper function to build GTP packets from an IPv4 packet
    https://git.kernel.org/netdev/net-next/c/b77732f05ebb
  - [net-next,v3,10/12] gtp: add helper function to build GTP packets from an IPv6 packet
    https://git.kernel.org/netdev/net-next/c/045a7c15e791
  - [net-next,v3,11/12] gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP
    https://git.kernel.org/netdev/net-next/c/e30ea48b5e7e
  - [net-next,v3,12/12] gtp: identify tunnel via GTP device + GTP version + TEID + family
    https://git.kernel.org/netdev/net-next/c/c75fc0b9e5be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



