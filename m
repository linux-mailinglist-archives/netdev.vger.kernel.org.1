Return-Path: <netdev+bounces-166578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C9A367C9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB1D3B209C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A61D89F8;
	Fri, 14 Feb 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFO2I706"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95D1FC0E7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569812; cv=none; b=rKvXE/mDtTryh9eWPr+Wr9zEjhKN7weMhdUGzLl/71WLVzExyJkP1NReFSNC208umcaIP57eFdZ43VhIZz5o0DCH0ncBOfhZdKpr0qPxbrqtv+JkcAOk59Dsdab+kidbNWQD8FddjLvAhKxfgVsyso4Zega/VYl1EWmeeu8dZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569812; c=relaxed/simple;
	bh=KOrAq2Z3xwZig+AX0uX6+JsA5VVA8CktD1SMSNR0uGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJdMiuNd58zO1rlYvGGG4TiCvGhY/d6DlNbOl8qvyQ8XLsulmpObDYWuKOOIWTLcyFIR/WwNVf/kWA6uZtqSC4L2K8PcVyHoDEbqFRBXHPJ9jresJQV4jt36gG9/L7HocmR6sdZMwuWxm2r1H6XdtK1L/elES9+E5eiNWqptEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFO2I706; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D93C4CED1;
	Fri, 14 Feb 2025 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569811;
	bh=KOrAq2Z3xwZig+AX0uX6+JsA5VVA8CktD1SMSNR0uGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FFO2I706KFaNe1PfqcTSwknF8iwJPsVuy5FoAhdMhQdb0urKIcXcSOPRNO1FCZV73
	 guIdxmdqXDdw8yy5OWj8Z0zrKJxlCodagAX2kfGGZ//BIoXURx5fm7lGRlTFE6rFuE
	 2pQO8v/g/I5gxu8m2JvvIeSx169iOZhQWFvoolLoZhzLSjK//DCzTHsscPUa1K9E+4
	 bL40wy5b/yEi40GMO3c+B5HkorKYY8SYASqaR3zwIrZXuMp1pG5cwZHxn1xLLVlj7O
	 azkh7VQ9QtZCqesy3G35fKy5mm1I2ngx6JbkZH+7pi/QYOLnhRWmpuxvKNn4Da49cF
	 K+lWLPGf7uM7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E27380CEE8;
	Fri, 14 Feb 2025 21:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] inet: better inet_sock_set_state() for passive
 flows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956984100.2115208.6438080178819247364.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:50:41 +0000
References: <20250212131328.1514243-1-edumazet@google.com>
In-Reply-To: <20250212131328.1514243-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, ncardwell@google.com,
 kuniyu@amazon.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 13:13:26 +0000 you wrote:
> Small series to make inet_sock_set_state() more interesting for
> LISTEN -> TCP_SYN_RECV changes : The 4-tuple parts are now correct.
> 
> First patch is a cleanup.
> 
> Eric Dumazet (2):
>   inet: reduce inet_csk_clone_lock() indent level
>   inet: consolidate inet_csk_clone_lock()
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] inet: reduce inet_csk_clone_lock() indent level
    https://git.kernel.org/netdev/net-next/c/55250b83b02a
  - [net-next,2/2] inet: consolidate inet_csk_clone_lock()
    https://git.kernel.org/netdev/net-next/c/a3a128f611a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



