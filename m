Return-Path: <netdev+bounces-142741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DE9C0290
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6DE2815A3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76841EE011;
	Thu,  7 Nov 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksOWxlV5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C21E1325
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976019; cv=none; b=aawqzU5HJXv6htBIqOGVh5zq886cvIfiutwlV2x8wVPrrsjhC4DmEk9oYBdAxevPy7X0zrrqzYO0hBK9WahsIB99aTgj+qVrk4KD+AS3QLfGWEEbXrFlJqS4wdVSWCyKBuTUVafRlrd/Jcz14qb1aLrzbQIl0trkkzVBH062gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976019; c=relaxed/simple;
	bh=6bOj2BpM5RsD1WuKpoA0ZkzcK16OmnkwrKr8QcWcAcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g8/1c0XBVVyX4TxHeRu4DRN3dHGdDEM+BrWOefeu2TIVhBIgJDzDvT8NPHGlS3SyXaVyh9ToBKDGshgSURDXqfROQ5kRG86/wQ/Yphxw7TbgASoI7yuR2HXFq/jZcHBTppcDemITVKgBcspb4X5U/Ehco7PkdeG3MclWdRriKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksOWxlV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CACDC4CECC;
	Thu,  7 Nov 2024 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976019;
	bh=6bOj2BpM5RsD1WuKpoA0ZkzcK16OmnkwrKr8QcWcAcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksOWxlV5jU4eXfzjMzF5DoukO7vDii8E5kuZPLeG1uA286gTApbaiLi6P1gFlY8ir
	 QbsI3B+FpNTomgAN/wdfRlV75d2DSUgWe4mHGNKQ1AI9Vt+GqaVWcgYoLFzFS/gzGQ
	 ZUPWJ0vsB/MwBwmWRXNBosP5F3uRAmZkZ0HLDGQymuFfad18xGa1QOVnWFJnaeHrLe
	 CkzZvw8bbwFm6zh5IWkM/Peve6VgzimoDWsBAcH8GsIao3h8g1QQSkL7vT4jY1+q83
	 BgZxgz+ANMMDnDeNx+w0Mx8uUpGbutzk5zWrhxV8PUZRgRw3a8Nk00ogJf63FaAM0M
	 We9pooh3rNHZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE023809A80;
	Thu,  7 Nov 2024 10:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] eth: fbnic: Add support to write TCE TCAM entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173097602850.1604073.7669006872410044150.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 10:40:28 +0000
References: <20241104031300.1330657-1-mohsin.bashr@gmail.com>
In-Reply-To: <20241104031300.1330657-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
 sanmanpradhan@meta.com, sdf@fomichev.me, vadim.fedorenko@linux.dev,
 horms@kernel.org, jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Nov 2024 19:13:00 -0800 you wrote:
> Add support to redirect host-to-BMC traffic by writing MACDA entries
> from the RPC (RX Parser and Classifier) to TCE-TCAM. The TCE TCAM is a
> small L2 destination TCAM which is placed at the end of the TX path (TCE).
> 
> Unlike other NICs, where BMC diversion is typically handled by firmware,
> for fbnic, firmware does not touch anything related to the host; hence,
> the host uses TCE TCAM to divert BMC traffic.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] eth: fbnic: Add support to write TCE TCAM entries
    https://git.kernel.org/netdev/net-next/c/90c940ff1f74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



