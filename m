Return-Path: <netdev+bounces-197685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DDAD9918
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C4B4A1090
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F6BA49;
	Sat, 14 Jun 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldcH9Sm4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A11BA33
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861600; cv=none; b=lntMlC5WJpXkyBreyJeXaVvkwjWfMUGz+LjMQDbBwFGZTEq5HCQsr823bm0sCfLb3zevfb1MMScIdV5SSoC4v+a0NH7mOQWgJ/ncYh4fiZGPZGnMpEErmWgHQksXAwBIHTWYkavfhiCyDDxaw4jsnPzAwwbbhbrcgYhyvoE7qYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861600; c=relaxed/simple;
	bh=IV0TnFWw18hB5vUNbKUPbrBZQUfOR8lOHXqZE1girgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l2nzculby36+xoIOjZoQs649x8IRTWmMTHUwbu8t1xFX1DL60MSXmUed+I3Y+tXgpVaZci5eTbRLFTe8gWFP9cQpXMQxkOxu/J0l6LJKGEotwuUhK5r6g+pz8m0EOeMHOCEwEvOPRFwuucp6BbRsicM9XhI20zx+nbPodTnEpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldcH9Sm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC999C4CEE3;
	Sat, 14 Jun 2025 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749861599;
	bh=IV0TnFWw18hB5vUNbKUPbrBZQUfOR8lOHXqZE1girgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldcH9Sm4n32Jita6nKNS1SknDI5QySj0pwyDmlQxvviX/EZ7NFRLm/APgPP6THJJ7
	 Y+gHauqZadz6XClgegUmJhGeJIwIOCBdCCsOPi57Cf1syQ7WjD+DpTbCUi9n42I462
	 ttrH3PHtec5V3V7kr3qDVhujwpFfkgpQMesIMcijMyaC57tF42IOmE3U5FUXI0GDdW
	 JjyY4BRx/3H4fK0ehEXyKhF0D9i8Jn5rXKrZAVSLlf5gXySg7C2X0DdFHyUs8YHjuF
	 4WdmhEHPoALtMVnprKWcs50J7ZSt/6DZDTjAV79d6aQHFYmlduamKTdHGjJWNe1Hge
	 V/2oDOMZkZFOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8F380AAD0;
	Sat, 14 Jun 2025 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 =?utf-8?q?=5BPATCH_net-next_v3=5D_net=3A_arp=3A_use_kfree=5Fskb=5Fr?=
	=?utf-8?q?eason=28=29_in_arp=5Frcv=28=29?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986162925.939579.11054094175885073949.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 00:40:29 +0000
References: <20250612110259698Q2KNNOPQhnIApRskKN3Hi@zte.com.cn>
In-Reply-To: <20250612110259698Q2KNNOPQhnIApRskKN3Hi@zte.com.cn>
To:  <jiang.kun2@zte.com.cn>
Cc: davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
 wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn,
 ye.xingchen@zte.com.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 11:02:59 +0800 (CST) you wrote:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() with kfree_skb_reason() in arp_rcv().
> 
> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: arp: use kfree_skb_reason() in arp_rcv()
    https://git.kernel.org/netdev/net-next/c/0051ea4aca67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



