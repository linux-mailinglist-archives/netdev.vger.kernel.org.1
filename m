Return-Path: <netdev+bounces-154873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40651A002D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AAC7A18FE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA52629C;
	Fri,  3 Jan 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTAvDSua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFB1E49F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872012; cv=none; b=XTd0Hh/9NAdvfuD7ppdqDngrk28t6inTMsPKIjDH3LdzU0Z/OYp4wdkrg9a9pnVX3BiO9M2/2/1QAKE1VowYoxYOkvMQUX9DBLfAcvpZEzb7hyMEL957prgpflCcLsaYDcu4QQAZdP6FhQ72FeBZUSeiFOzVx7HnSzBY3Kj9MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872012; c=relaxed/simple;
	bh=I5t55QFS0xdHHk0yvK30ZlIb5Sj3eaXcZn8uo2yRyYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw2lLdYE/OtYjwB0+3MsW8Y7VM3zT/Ysr+pyZAV4wtGgZqjgBX11P1FwpHJPBKVRtgfbKsjYYjyku0ibYBFHcZixlv+DDo+V6XyFCEoVok+dY+RVrAMY/LuYo18s7eAi4a+sb8Rw/yuDKk19tm/DBHBBwVtnl/nCuvUp6+B/rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTAvDSua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFBCC4CED0;
	Fri,  3 Jan 2025 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872011;
	bh=I5t55QFS0xdHHk0yvK30ZlIb5Sj3eaXcZn8uo2yRyYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RTAvDSuaSRqVYViGE3q4LwShrkOZXD3c55Zu1ITBc8FlpPo2DV3TSGsrxC7X6oh21
	 QDqplG0trXiOISHTSR8QwInD/KsjT8eNkdZ+Mi5QOaGmjj/fbep3639S++zUGR3xfn
	 +RdGzH/qMbKuvL+XAtN6BgGXpWNQ/ydh0otLtGqN/fM9ne/QrM5eiaE0+Z4KP/DJV3
	 7cfybbUplunUH8yoCV0UxesEMqjyhK0dX+BpkaAaNQ30M7JIpb5ST1bk0YuBZuq1pX
	 o8Kz3vRnjXF1dAyCFXiSRwMwM5ehclZ0cTWrhPQmjoygqB2n92I21sB5mdoLvkP0kD
	 iKUsVvcMzvAAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 722D4380A964;
	Fri,  3 Jan 2025 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] ipv4: remove useless arg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587203227.2088679.7290467107354611379.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:40:32 +0000
References: <20241231023610.1657926-1-tianyu2@kernelsoft.com>
In-Reply-To: <20241231023610.1657926-1-tianyu2@kernelsoft.com>
To: tianyu2 <tianyu2@kernelsoft.com>
Cc: pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Dec 2024 10:36:10 +0800 you wrote:
> From: Yu Tian <tianyu2@kernelsoft.com>
> 
> The "struct sock *sk" parameter in ip_rcv_finish_core is unused, which
> leads the compiler to optimize it out. As a result, the
> "struct sk_buff *skb" parameter is passed using x1. And this make kprobe
> hard to use.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] ipv4: remove useless arg
    https://git.kernel.org/netdev/net-next/c/5df7ca0b827d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



