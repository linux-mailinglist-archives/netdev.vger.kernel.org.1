Return-Path: <netdev+bounces-137276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279A9A5495
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3CC1C21082
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85266192D66;
	Sun, 20 Oct 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4klJzuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB43192B99
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435828; cv=none; b=kkJhr7P7G/rcKigWiMScNHV4G0B/V7/Ua7V/9uUt9af2bMaSgEikafvD7q4OfcwPAbEv19ZmLNeIemIo3sPA7M12YEg6BjqWFk+r0WqcIbZ4Is+cXiOoOjNOK/pRoRuqyeFyoIvrT/FOlJDGPdgImSGf4J8H7zlK5sYPrscZxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435828; c=relaxed/simple;
	bh=E4dcGd3opyJfBFCgOqShSy69HY2TYlLUBclDyYJgL6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xjb1JaRcmIymFFBqqH3FmNlqQ9mTZ6k7cGl+UwjEcUVX1EepQIAvyI4JVtmpRZdBuoazq/wcSF7MR+Xm8bjOuJWIfZsn31cDg1+b2JArEZVFx9PDCrINfH43Kvc757zA+O3CK5WrKSDKiMXawEDe0gLtsIkxpWHgasESXtsqfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4klJzuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D50C4CEC6;
	Sun, 20 Oct 2024 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435827;
	bh=E4dcGd3opyJfBFCgOqShSy69HY2TYlLUBclDyYJgL6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4klJzuXoq3U2TzDa2toqyyQcjcH+V4VG5oW6RCiX9xMvqC5oq+KqbxByFRs4Vdc+
	 BwXI3ndPs7G4rEbvII6p2JYecfiWH5SwEBGloOy75f8utAL3dq4T1lGoWeClsb4iCp
	 PCnYp6GDvjTcMJNsM0qClzty0ySkkv2NcZ+Zj2ePai7DVB+YFcmCbgjh5jgtd4rLcy
	 1F3kZXL5903jRtWmMWt058tPECBX9p1rVyhCWX+PCxZ1m4c1e/kkoZQad1mgu6AaI3
	 kEZjTsk93MBVpEwrDV4tmWVaumK1ZdP7F0WBdFm8t9l1QnLqykvfUGjf991kO2TSZB
	 nnQtfC7FNvXtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBEF13805CC0;
	Sun, 20 Oct 2024 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net: dsa: mv88e6xxx: Fix error when setting port
 policy on mv88e6393x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943583378.3593495.16662216433887676799.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:33 +0000
References: <20241016040822.3917-1-peter@rashleigh.ca>
In-Reply-To: <20241016040822.3917-1-peter@rashleigh.ca>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 21:08:22 -0700 you wrote:
> mv88e6393x_port_set_policy doesn't correctly shift the ptr value when
> converting the policy format between the old and new styles, so the
> target register ends up with the ptr being written over the data bits.
> 
> Shift the pointer to align with the format expected by
> mv88e6393x_port_policy_write().
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x
    https://git.kernel.org/netdev/net/c/12bc14949c4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



