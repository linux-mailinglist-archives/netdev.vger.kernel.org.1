Return-Path: <netdev+bounces-102429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C8902E85
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448BC1F2372D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F316F8E0;
	Tue, 11 Jun 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UthOGdAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1815B0E2
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073628; cv=none; b=ucxvbFDbGXtJlXt1l1tkTLsAYA5OXzRV7n3MAcJbtZZ9+tW1nFkDYJDM607dA/eO/3br0uo1MSnPTZ7GToONAqqlic6CoM9JN1ZUi/OMV+si9rslMSt4EUaubG09LGM3HrFhxu1LEqeEzHhOTZBgYhFMtLOGmYy6H96knKAWf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073628; c=relaxed/simple;
	bh=AlZhKrc1TQ8n8vCiIZOKCn0RpAgf2kRyUVXM/tBz9J8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LnzoV956JKMAUPJ2HuJ+/ABIDmoyH3DfMBCOEnT81Awbve1fKKwPvrQiBOKgMSZLL8etx8hCrs+v2JFQCw81PcXxI+g/vzY7zEGAKuBn16/MT0HbAycJ0Uon8AVg8UjPFzCa/8fB5pnyjP3AiU4zj1gNtiX7uFfsc9nDo/5eX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UthOGdAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1140DC4AF1C;
	Tue, 11 Jun 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718073628;
	bh=AlZhKrc1TQ8n8vCiIZOKCn0RpAgf2kRyUVXM/tBz9J8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UthOGdAc+BPvZETazVpbeR+YTqkGPnddh2qhOgA2rCBVMZUbD4xRS/GXfU6L6BgBK
	 G/vAIgnr9VkokjlLEsgG1uOBCBi6ZEiS/j60tM9U8OWUJn++v36JIsPvtvsWmUnCwH
	 4aiby74T92TcvHqgS03rGfYGbMJXQOLLaJZN3K4Mx642QgHUCiB0+VLIpD9w25SP2x
	 CsmOb8eQo1QDC3GDVWdMqKbf47+7Y2XcMlknl0nmP0rXLdgHdz2GgR1HmNkJqEk75P
	 jeF3Sq2LOC/AvTyx5F9TCU4S04D047YyfI313rW/WPBfJrfPMyHIWRaDhDn1SW4tIF
	 WnYb9OlU1fSww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE062E7C76F;
	Tue, 11 Jun 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: initialize noop_qdisc owner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807362797.11775.4438902807609273240.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 02:40:27 +0000
References: <20240607175340.786bfb938803.I493bf8422e36be4454c08880a8d3703cea8e421a@changeid>
In-Reply-To: <20240607175340.786bfb938803.I493bf8422e36be4454c08880a8d3703cea8e421a@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 17:53:32 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When the noop_qdisc owner isn't initialized, then it will be 0,
> so packets will erroneously be regarded as having been subject
> to recursion as long as only CPU 0 queues them. For non-SMP,
> that's all packets, of course. This causes a change in what's
> reported to userspace, normally noop_qdisc would drop packets
> silently, but with this change the syscall returns -ENOBUFS if
> RECVERR is also set on the socket.
> 
> [...]

Here is the summary with links:
  - net/sched: initialize noop_qdisc owner
    https://git.kernel.org/netdev/net/c/44180feaccf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



