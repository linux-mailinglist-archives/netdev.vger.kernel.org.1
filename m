Return-Path: <netdev+bounces-132919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45F993B97
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEB1C23EAB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71FB665;
	Tue,  8 Oct 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFZ0rLfx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC8B660;
	Tue,  8 Oct 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346228; cv=none; b=LARVgjyOsuIUF960yhRmW73spyyNwHtG8XNMuDiuDq0tAhXl9e2U3LrIXFhufWe9FBwqZVOX8jCcqmSDc2rTsQvZ0HEemLXDM5OTgTdw8zBBLFpR7z2NtfQJkYjQ8q1U1PbQtoz8fopH275QXzktdx1hyoK8fmZlND9s179WXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346228; c=relaxed/simple;
	bh=OTqr0HAj7fvZB0XnLpayG4MV4M3PnvenTa1Qlekh73U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4Hogq6be2ht1kv8BkKB5pyu3A98hoP3fjQIAnQ+95fv0r9oo8sNFTGswL0hWtqEznrv/+TOwF/kdkgNnUDZ6AwM0FqLvN456UFu+z36hAs/P2hbDLypmsz2HGz8vdKZfXYdBO3zAnGfAUoc/ynRVL2Fn1fdrw2w2eYVxJrQRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFZ0rLfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967B0C4CEC6;
	Tue,  8 Oct 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346227;
	bh=OTqr0HAj7fvZB0XnLpayG4MV4M3PnvenTa1Qlekh73U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFZ0rLfxyYe534aT05tAk/djtUWpFKCUiPHJ0MWRUy9uZ/NdeI0643h7gjw1lH9lE
	 DbKs8Oa7VyWTu+CgcWVdOwist5LKYRmxWaWVRCLSDWNU9mQJmuMcVd9Jv84liRtQst
	 /WljMFlTnTLTtGnjOoctrFMBJlThBmvftw0Tvs6Hc0WmHEZwRzfZoYLwwNMJsTOghD
	 ePENbpB8GoN8lqjpZ152lDPxBHMCyzywVB25OpYl2MBpobOHJ+Ioj1XE4mNMuhKyFD
	 uASoPL1FHBykVOquK5as0MWVzpCr9Rm082QWC2mAztewUnKd5stKg8PG4L8t87K5Nn
	 49yNe97eeno1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6B3803262;
	Tue,  8 Oct 2024 00:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] vmxnet3: support higher link speeds from vmxnet3
 v9
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834623148.25280.4689711251086629740.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:10:31 +0000
References: <20241004174303.5370-1-ronak.doshi@broadcom.com>
In-Reply-To: <20241004174303.5370-1-ronak.doshi@broadcom.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Oct 2024 10:43:03 -0700 you wrote:
> Until now, vmxnet3 was default reporting 10Gbps as link speed.
> Vmxnet3 v9 adds support for user to configure higher link speeds.
> User can configure the link speed via VMs advanced parameters options
> in VCenter. This speed is reported in gbps by hypervisor.
> 
> This patch adds support for vmxnet3 to report higher link speeds and
> converts it to mbps as expected by Linux stack.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] vmxnet3: support higher link speeds from vmxnet3 v9
    https://git.kernel.org/netdev/net-next/c/0458cbedfe35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



