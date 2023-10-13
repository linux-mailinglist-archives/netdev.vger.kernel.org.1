Return-Path: <netdev+bounces-40648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBC7C820C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29B5B2096C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58A10A37;
	Fri, 13 Oct 2023 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESFd132e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFE613A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADFAC433C7;
	Fri, 13 Oct 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697189424;
	bh=zfKLiUU/AufCJHwWSWrzPG7oidZX9KQ3FzwTiUS/QeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESFd132eq0rgvM1vQqVC1SPnM6aEpKXWoBHDvCGj/tSGkIeohsRVbh4OVBmgNR0oo
	 dJiYncP0ndiyM9JTsWjfYQ+gu2jDMtWbMgu3MDoABkfdiJg6tW7EoVaSXZNKNpo5Xg
	 UvdCRRJNGaS8Xc7SfO+Nr9SskHnNyYkHYcP1J96lpLpfPpz6WjV1HOE+ksvDTNIzph
	 G+rd66Xbx93ggz3oY0oIhxJpMukDIu5qclR8+NARJFmjqaRC90CnlBBmyddzbNSz5r
	 UxhKR08dNbmm9wAtIDN/v0QThdqI71d12lcHIvL24RmnDXHL1nYhI99RQSWsZXSsYo
	 snarzUSSufkdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7684C73FEA;
	Fri, 13 Oct 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Add software timestamp capabilities to xen-netback device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718942381.12102.14938354463321505614.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:30:23 +0000
References: <20231010142630.984585-1-luca.fancellu@arm.com>
In-Reply-To: <20231010142630.984585-1-luca.fancellu@arm.com>
To: Luca Fancellu <luca.fancellu@arm.com>
Cc: linux-kernel@vger.kernel.org, wei.liu@kernel.org, paul@xen.org,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org, rahul.singh@arm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 15:26:29 +0100 you wrote:
> Hi all,
> 
> during some experiment using PTP (ptp4l) between a Dom0 domain and a DomU guest,
> I noticed that the virtual interface brought up by the toolstack was not able
> to be used as ptp4l interface on the Dom0 side, a brief investigation on the
> drivers revealed that the backend driver doesn't have the SW timestamp
> capabilities, so in order to provide them, I'm sending this patch.
> 
> [...]

Here is the summary with links:
  - [1/1] xen-netback: add software timestamp capabilities
    https://git.kernel.org/netdev/net-next/c/0b38d2ec2282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



