Return-Path: <netdev+bounces-119341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDE9553C6
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F2D2842B4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622A13D8B8;
	Fri, 16 Aug 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCRv23Sf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D4B661
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851031; cv=none; b=UVlpYt4XTcZgCDSdeIy4l+JdwY2TDyG0g5ElvOA7V19nx+nIyMA8/JtbXz4O67+0Oc9JavnbVIE644t8mQy5MJ19uF4R7vJR+nIT3WSoNPLrDeur6ZucfDnHZ9PN9HDEj5gwNR1UmRfGREqQiSzJtPSyrGCxkNHwdPHBhcOBRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851031; c=relaxed/simple;
	bh=v5SRqcUiqDaIzLlheZO9I6ssYvaBS+QTzpz8IcOUt8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fqBMGhZV4+o8aN65/yS8tgDUoZ0A4HIpbbeypl2eYfMV7KKsXlqyEDc3Udp1LnH4H60/oXc7qGLMI+PQ7dwMvLE85hlJcKfuO533cc6WXmVoxsWl9R5PFxIK2ACBzl9iG3IwXwZ+AYLhfqPPMWgVBQ05/GKfuXU3LmhQmEGl2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCRv23Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71938C32782;
	Fri, 16 Aug 2024 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723851029;
	bh=v5SRqcUiqDaIzLlheZO9I6ssYvaBS+QTzpz8IcOUt8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TCRv23Sf6MKLgA7UU+EJx5eDo0KYiBSypEz9ySLiS3qOhNmrIVKznJlgdZ7//G05w
	 XxBMKGM6l41ljsbx5HkKFKxKrOCWDwt4d2GLhd9KDgPpWBJbYRzO4T/96XYW7Ht5Tj
	 iYAA/ekgxC9SmM6MU5o89anBGHUrPTkSh5PK8R852hzozztKUlebTSoVsfqU/8bCFJ
	 7GWM8oB0APKIR2sPbKGJKeQI5APvq8d/1SVCiAnKv+PxRJ/C+xrZTdZgUkmbFiqT+S
	 5YYOzjuwfez7EWD5iPkjLuA/i11Q9YlYFdmfE+5NarnZz4UiMXCxcV2ZmJ6iKJzep2
	 kDjgjMdqtHT9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A338231F8;
	Fri, 16 Aug 2024 23:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: txgbe: Remove unnecessary NULL check before free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172385102876.3654909.7512049917943724413.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 23:30:28 +0000
References: <20240815-txgbe-kvfree-v1-1-5ecf8656f555@kernel.org>
In-Reply-To: <20240815-txgbe-kvfree-v1-1-5ecf8656f555@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 16:19:25 +0100 you wrote:
> Remove unnecessary NULL check before freeing using kvfree().
> This function will ignore a NULL argument.
> 
> Flagged by Coccinelle:
> 
>   .../txgbe_hw.c:187:2-8: WARNING: NULL check before some freeing functions is not needed.
> 
> [...]

Here is the summary with links:
  - net: txgbe: Remove unnecessary NULL check before free
    https://git.kernel.org/netdev/net-next/c/1c66df862561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



