Return-Path: <netdev+bounces-86358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D301289E746
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7366C2813BA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285338B;
	Wed, 10 Apr 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au+xBVkB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88737C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710233; cv=none; b=Z1q9BVmKOhfqrlwtX/ux+LAnNCO89XLX+buCXZxu8BbRyCEqVu64Oxdk4PzRAJEDBG8wU2puOlZnWLnvaOxlW8TBoFLFVgK9BvTYNgK4RA7/4J8cBz7G8wNdmOFVwAqZ8Nr8HCxGDudoVycWR0DN30G+Oq6lhrU96zYFjFtLeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710233; c=relaxed/simple;
	bh=nQSsQKZ7OTzfCDLl3YrPnOQfVmcSBJsCUVA/uFhXSqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hCqsvTQ3bBtIy65VhBHRlF1MUpXZ9qUW4rZRwehqtH+i2LCUfp4WhZ0XBAKsLFOoxGCkKTE5LFdJuPoRewZFKAeijTqaKAv7a1uQHSVkpGLyJZGutpNza2HSfEdRAxuXkY+cKY249d+uAAnJvvyrCsMhZMKzR5bVDFzs+4YHNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au+xBVkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD067C433F1;
	Wed, 10 Apr 2024 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712710232;
	bh=nQSsQKZ7OTzfCDLl3YrPnOQfVmcSBJsCUVA/uFhXSqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Au+xBVkBuPaYFA6xGdEj19NbcwG5KbkZhj9Du7tYOSqWhTdt+07x/+C82U6+Otq/+
	 o7eerW/YpEtXL+XQ1bWuhCgdnE/5+yTX69xO1NZ2lUnJibK59offeDcpVuE37hTqJQ
	 UO0ZPm0hYGf9wuNbfCJi6D7QnuPt6esL/XiNlOsNlZT8iuVzyOalDIwFe0hI7m+SXy
	 TYJ9ziijf4CM727pOglUltZ5+SxvDbHSc8UqYuFvt12PMvk+w7uUO0IEXv5K+MC+HQ
	 hdPOm9xmM4h83Svl+BZVsVcMfc0XOO90+P+a2drB6jrUvOCbup/xLXSlP0pQETiSc/
	 pRgBwCZ6yfq/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3916D6030E;
	Wed, 10 Apr 2024 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] net/e1000e, igb,
 igc: Remove redundant runtime resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171271023279.18947.16880251680949469185.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:50:32 +0000
References: <20240408210849.3641172-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240408210849.3641172-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, bhelgaas@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  8 Apr 2024 14:08:45 -0700 you wrote:
> Bjorn Helgaas says:
> 
> e1000e, igb, and igc all have code to runtime resume the device during
> ethtool operations.
> 
> Since f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool
> ioctl ops"), dev_ethtool() does this for us, so remove it from the
> individual drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] e1000e: Remove redundant runtime resume for ethtool_ops
    https://git.kernel.org/netdev/net-next/c/b2c289415b2b
  - [net-next,2/3] igb: Remove redundant runtime resume for ethtool_ops
    https://git.kernel.org/netdev/net-next/c/461359c4f370
  - [net-next,3/3] igc: Remove redundant runtime resume for ethtool ops
    https://git.kernel.org/netdev/net-next/c/75f16e06dfb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



