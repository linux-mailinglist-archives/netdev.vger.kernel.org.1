Return-Path: <netdev+bounces-216180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AEEB325CD
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FE86088CA
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFB13E41A;
	Sat, 23 Aug 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvX9bYps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A513D891
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909019; cv=none; b=fkflfGeiTjp7mJ4CgTzCwzyjC50ClKEjnw8Wtt1+uu8q97A1NgkIqe3VkIFSA/KMwnyeyK6lbpfbWuW6bpTfHnnY7XZ1DwmNec3ofja0J8TdUH275l09gaQHqV6XXQnLvXo6IL2gSrmW/jxXvqAVRlNnfzDye6739XzrmgAi+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909019; c=relaxed/simple;
	bh=hvnQJzKmMvcuE46nN39ZThufvevHAnkh+Mnv2uaVt5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sdvu0lm5SKbCAqegpEaONdsLH5lkewe2+ykIe0OiSkHPxBjTbjGvUydwLSGsmpClQ+9In/0YA/whekgYVJvRYHSqJXGK/I+sNRnVxxDPYJztHFlNxjmzBfe/HujwD+01lREjqtZmwt1WzWze5js7NukvCwx2hKsLDcyP1+vMCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvX9bYps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234EDC4CEF1;
	Sat, 23 Aug 2025 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755909018;
	bh=hvnQJzKmMvcuE46nN39ZThufvevHAnkh+Mnv2uaVt5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QvX9bYpsu3M1lthwcWkCynMAoBPVNKKinECzpJ43hRCwwiZsIyH8jOtZNOOzClHY/
	 DBPdak8LomicPlPio/RtTbdz2KlKRgUbZVS99ZoGUNU912I3SAawFDolFLr92E5vH8
	 HkkLwNSE+QIIAkEgiSDfsXJ+n9U87qMO/NiM6apZuO6ZEfs2G6DnRh9m5PsHI9FM0P
	 13FbAQPnhmzDODnKnEFvD2+0WkNg6giOdIcLPy7jggRHRQ7NfS62aMupXmmB9LEL4Q
	 +H4N6RLwHiQ4Vh+ejSloXvzIuIfHmUbxCq9CJGwCMmKTWd09M6n6MAN2Rsoq/l7s08
	 7VqW5G4f7Y0Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEC383BF69;
	Sat, 23 Aug 2025 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] net: wangxun: complete ethtool coalesce
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590902675.2040371.15647155255107236153.git-patchwork-notify@kernel.org>
Date: Sat, 23 Aug 2025 00:30:26 +0000
References: <20250821023408.53472-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250821023408.53472-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 10:34:04 +0800 you wrote:
> Support to use adaptive RX coalescing. Change the default RX coalesce
> usecs and limit the range of parameters for various types of devices,
> according to their hardware design.
> 
> ---
> v5:
> - use disable_work_sync() to avoid racy work
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] net: ngbe: change the default ITR setting
    https://git.kernel.org/netdev/net-next/c/6d3f753c9ce1
  - [net-next,v5,2/4] net: wangxun: limit tx_max_coalesced_frames_irq
    https://git.kernel.org/netdev/net-next/c/fd4aa243f154
  - [net-next,v5,3/4] net: wangxun: cleanup the code in wx_set_coalesce()
    https://git.kernel.org/netdev/net-next/c/5f43f2171abb
  - [net-next,v5,4/4] net: wangxun: support to use adaptive RX/TX coalescing
    https://git.kernel.org/netdev/net-next/c/40477b8bb048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



