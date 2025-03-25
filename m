Return-Path: <netdev+bounces-177615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BDEA70BE9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873F03B846B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08D263F32;
	Tue, 25 Mar 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVlruCFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E226656B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937001; cv=none; b=mQQjEc3B9ZzJr2vXE5816RBD00YtdStvcGL+oSPg/7Jtl6ysT0Ec1jmJzlChuRGjELC4w/PtbrayjUaOg9M1CRcRxKjxd8gjYldtRoVOgHTQ5Ekkd6mAMJvf0QVCC4WOki5+CSbEKUoKISu7Ta3E7T8cAxiqslHuSr3wfWBGlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937001; c=relaxed/simple;
	bh=x92UoRfpmXQu09TQ5/bSZlfRW5A/SD6sJ1Ur7R/S3zc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmHcGuF2zRGVvtwYuOcNwHJSHwXpYL/6/7h/tUNvq64tJ6CZojPFjLFwaY0058jseI2PGbhN3Q8OtMWVff9LoMup4CCPC1kVjnkxAEb0ntrcygyBhA77sA2H0Z61jrD5CrIU5qkL8D3HKrr5Me+YBiVWGrg2kiHaE+RlGDVCVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVlruCFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8CAC4CEE4;
	Tue, 25 Mar 2025 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937001;
	bh=x92UoRfpmXQu09TQ5/bSZlfRW5A/SD6sJ1Ur7R/S3zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZVlruCFJFRZUirTo2Y2Bkua3vQtLqeNBAbgaqnuJ7zxTzRUa/Rb3iWEbXVNbJLbHj
	 9UkJONDQrKofNSdkYIOYqPkb1d+o3IhIElH6yumrZX97g040rARc9tZbdvXGS4i3Yy
	 x7nZ8Sb85rKfS+FJtUtxDf/PqhqZ8IO393HrcPDxV2Hhn1KNl1d1gX5iyoZfVKDnHE
	 gUraV7DY4E3KJL1rXSV2qAjRb8jUl4BN7/vdqcaKcWuqJ5JhsnePhatpSkCqZrLnPz
	 31RRNsKrfdjkZqzu0jaXk5EK5W+k5GdBuMxncd2gSEJkqsMH3NnTMBt9EZNxnF3qqO
	 RzSHSQh0Vfbrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE197380DBFC;
	Tue, 25 Mar 2025 21:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: libwx: fix Tx descriptor content for some tunnel
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293703756.729732.14195000620266018627.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:10:37 +0000
References: <20250324103235.823096-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250324103235.823096-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 18:32:34 +0800 you wrote:
> The length of skb header was incorrectly calculated when transmit a tunnel
> packet with outer IPv6 extension header, or a IP over IP packet which has
> inner IPv6 header. Thus the correct Tx context descriptor cannot be
> composed, resulting in Tx ring hang.
> 
> Fixes: 3403960cdf86 ("net: wangxun: libwx add tx offload functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: libwx: fix Tx descriptor content for some tunnel packets
    https://git.kernel.org/netdev/net/c/a44940d094af
  - [net,2/2] net: libwx: fix Tx L4 checksum
    https://git.kernel.org/netdev/net/c/c7d82913d5f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



