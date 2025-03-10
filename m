Return-Path: <netdev+bounces-173650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44EA5A51F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613F83AD941
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED41E0E14;
	Mon, 10 Mar 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5v+qJjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374B1DEFE7;
	Mon, 10 Mar 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639209; cv=none; b=bMXSwOe+iN4xVRfL1HFVH1tbUdiU+Hih0m7RmCNrNh4NkmLQevnjdJOulJJhD5KMGFG3xGuqh4DXkGs8kCZ2XvuO84YWQCmv7njFeR4huNKRk44i+TJ87ji/kq+fAuATMmHo2LD4xF/x25OUivyE9EUN1rhvxUPPSJS0Cyb46bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639209; c=relaxed/simple;
	bh=mzi6YTCCkVyl0WFrGQ3Nu4sAhX4Qm2Bqn1ozXtQ0AjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y95ufWpsnQH6oOTGbdnec/Td+74bUojTqDkxn9CLZJ74tsVXDcLOEbZB711HCqMLmqYtRbH4sW73cmbl3HelWgDbC/01LXd9Kk3IScw85gfwGXjRRTr95T0u8Y45GQHHRsXHuPiwTvVKJdpBuyw7sJJkCkQWr45abW8BG6hhPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5v+qJjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A048DC4CEED;
	Mon, 10 Mar 2025 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639209;
	bh=mzi6YTCCkVyl0WFrGQ3Nu4sAhX4Qm2Bqn1ozXtQ0AjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n5v+qJjr1j5sJuh2S26te73xS0ebtvETJRtDaUvwI4LdnmTSRQNZ5GfSiQliojyPW
	 DsnPMFeVrN02VjahMqQh9Z1YuaJc5P+if4UYhbB30su9VKNV8JeDcGVCcZvbi3IpyQ
	 AoIhb+EoFzTIf/f12hjiynWE0XTcdHcJXb5Fn0IM366XuUwAKYrfOqXHCeFELa7lAz
	 x/uJ5kFzMcYaC4fzAAicHtxDg/wsg9bi4J/r6vC0hvHLuCl1laYkXrLzK1ZgRKNvCG
	 YTe5O3d9Gf1IiHK8Q3v8tY76yoxocTO1u8K59RmI4QZDJQCHVVGS2CpBoAGJcpCFa6
	 6JQQXqunL2D8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF43380AACB;
	Mon, 10 Mar 2025 20:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: fix memory corruption in
 fbnic_tlv_attr_get_string()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163924349.3688527.16911619738250606292.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:43 +0000
References: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
In-Reply-To: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lee@trager.us, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Mar 2025 12:28:48 +0300 you wrote:
> This code is trying to ensure that the last byte of the buffer is a NUL
> terminator.  However, the problem is that attr->value[] is an array of
> __le32, not char, so it zeroes out 4 bytes way beyond the end of the
> buffer.  Cast the buffer to char to address this.
> 
> Fixes: e5cf5107c9e4 ("eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: fix memory corruption in fbnic_tlv_attr_get_string()
    https://git.kernel.org/netdev/net-next/c/991a1b09920b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



