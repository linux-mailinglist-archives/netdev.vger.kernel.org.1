Return-Path: <netdev+bounces-196348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B6AD457A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F3E7A5EF5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472023C390;
	Tue, 10 Jun 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pevdDRkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801D299924;
	Tue, 10 Jun 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592803; cv=none; b=RVMr87IlcwWuTfeDXLicLVLVAUAXbsXM8XzC/LtAvZpMnJlJTd+mGcURJlkrJQgr1/LwQFZgUvMX1kfATw/0e1EVyirEb9l5A0zdbn1WpL7uXABUZkS9s6PEWFwmI+XwB0ZLz1QSoNHXVtstWqMgBc+v4o+Bphsg0P3odEy3zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592803; c=relaxed/simple;
	bh=nqjMpL87UOWHp+xY5OHzRpVk2Dnjy8HvMP5kE1nph4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pmYwUWHKeKS2jVEis62lE1KQnkr0M6KwurUb0/o/+K/4OQyDT1tkNIZETiEhs9YbGtLKy2zSxTjL0r1G3QAP/C4mdIOz+TtYUo9En8gF6COp4iYpJnQ24taFcF9dkHEkunoJsOGQaO6cKGDlo2Va+munqtGjk6KtUYgciruxu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pevdDRkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED3C4CEED;
	Tue, 10 Jun 2025 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749592802;
	bh=nqjMpL87UOWHp+xY5OHzRpVk2Dnjy8HvMP5kE1nph4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pevdDRkkYQUcd0x7Wzni/UNCNPu32KEAgqQwiy0bEcauciJmh77DvStz4B8orG3sq
	 FEFgqWgILDNNoDexIhmdUxi2vTz/961hnJN8n47xAmcr+Pkz9DBo5buXinlcJWhgTp
	 e36TtcgTmbZGwurMWbT26vN7/3uITG8KUBCvQ6ucnA0g9F220/xcv0Z/ZUGhB4QVnY
	 bEIgfImn7qtGIg+7N8uNQWAvUC5TXIYyBZQ9xQcsb4LKNqnR4vFwX+Fv1tKzoTwc47
	 nQgP27QLBej2uB65y3qms8plE2dfop00WaD7VvmPI8rDdP7T0pTVhP3PHV7mc+xazp
	 oM/9SOi7uQvhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3738111E3;
	Tue, 10 Jun 2025 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cxgb3/l2t: Remove unused t3_l2t_send_event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959283274.2624817.26392840197171754.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 22:00:32 +0000
References: <20250609152330.24027-1-linux@treblig.org>
In-Reply-To: <20250609152330.24027-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 16:23:30 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of t3_l2t_send_event() was removed in 2019 by
> commit 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from
> kernel")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] cxgb3/l2t: Remove unused t3_l2t_send_event
    https://git.kernel.org/netdev/net-next/c/1f07789152b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



