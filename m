Return-Path: <netdev+bounces-98578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF148D1CFF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A1285958
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5616F0F2;
	Tue, 28 May 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRTBYo1F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8213C9C6;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903032; cv=none; b=d5eK7mzwMl5Qqu5TQ1cqjdPG2ctj/hSKvGA17cFsn5QZ0SnF/o//mrdvAYMxW9P7w9umkmTMU8PYNxIJmkCpQCNVF+luVg9BbLsjC4Q7jOpphMw6TgDxVb5wSJlWT6U09cZMK2ZCQVI7O6STeSoClTP9/3w4MViKqy/eJEDEamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903032; c=relaxed/simple;
	bh=HX+xbDWc0ccFCw9Jm22Z8vVSEpMcwfoWB6AFBLMPeGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IskAd3kcT7Lfv1hco8Ij8/JL8kaB6N5mVU7XONIJKLOX0/3K+SiK8bEgik9cacQl70ErpgQHbIU3VjC61XvzjSLRHmXQvycywT4h8HOZJ+Iy4d8ODo/90mXl1mtFiK58sQojKJRqQpMRdswy+V3NJJ3Jk4/psICvgASeoyeWgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRTBYo1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F33DC32786;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903031;
	bh=HX+xbDWc0ccFCw9Jm22Z8vVSEpMcwfoWB6AFBLMPeGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RRTBYo1FXufScJvVHOc/3U5z2Ra3IJA+LXN6OOTU9XQDUYnFurMqvaOLuSW+xrnzx
	 afOdX3skv4T1sARjrojzsaz2w5xa7giKnheehlgyT6PXecDnbalIohrr2Ylrztwwjm
	 TOwJ5cveckDoDqzUHAip4b/0mAzM4OFmU76Vkp2sMKXEnD0VFXWMFkrfUdCJLeqtlS
	 YskhhdY+AeG/f3vTjHGnf/pdVdd7aZwqUT0v7CJhqG6808ofnFcvMKqQbGA4wLPCco
	 lkWLfDV3LxWY2O2ztStH4xQhyf+bIiccbXAlK7xjSSECePn+QhkiZHNgwsRkf1eCst
	 PVFIiESuO9AuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D4DECF21F3;
	Tue, 28 May 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: remove unused structs 'usb_context'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171690303157.16079.18128405210043451247.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 13:30:31 +0000
References: <20240526205922.176578-1-linux@treblig.org>
In-Reply-To: <20240526205922.176578-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 May 2024 21:59:22 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Both lan78xx and smsc75xx have a 'usb_context'
> struct which is unused, since their original commits.
> 
> Remove them.
> 
> [...]

Here is the summary with links:
  - net: usb: remove unused structs 'usb_context'
    https://git.kernel.org/netdev/net-next/c/c30ff5f3aec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



