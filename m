Return-Path: <netdev+bounces-134015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C7997ABA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7532832EC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24F1925A3;
	Thu, 10 Oct 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnKWDs78"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280041922F3;
	Thu, 10 Oct 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528630; cv=none; b=VYwjtvGRJUnCGgqCOkO2Q2tDdK+WiIEMXWXZl8Vcxb13ADIlNaqWtKyA9LpNNrlv4+EUYCZ9NTewh75x4/czT6OMk6JXi7VIqOR5X9CvVRdMSpEUHGYI9rbhBN+UkMTILogSqaV4nRz3oDTxHuIgIKzGkNp7sFKrAs881PmyWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528630; c=relaxed/simple;
	bh=TFczhcOD6nz56p8+h4jan8Lr8MNsRfGB6VgsxVOIIU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcDFHy23XJ0nq8m463rH/owMAvYk1E4ddYhI7eij9LU2nl68/3jB9AmViVNXTSrUDW31f1Wgmn9gg05RBKOvXKHgy11s6RmkjQrz8YubsTvDlbZVaaplVHnV9YHYIXJ5WpTaK1FeldZyVCWiBM2yDiR682WZbI/CGoNYB2jjH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnKWDs78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59C4C4CED3;
	Thu, 10 Oct 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528629;
	bh=TFczhcOD6nz56p8+h4jan8Lr8MNsRfGB6VgsxVOIIU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WnKWDs78M/th/YaQXz/+L87Iw2nIp0JH4Vvr0Oc/oGYuhRH4hgebvt8tcbgiey1LM
	 A6/OlwhdPYdblES5e4s+hX0GlNfWb52SAC1VytwzHu8P4bqvW8X/H1G1OPKQsc49uk
	 cVFZZpUujdcIocRlXWvFbqEw2YhIPndjUWoPMJuamSzc+UrLJFIejL9Gb7Kfu3AP11
	 JxFelEM4B1kR7LeMXwhnMTNGgy0PikUOmXYMGsfsZo/J3rTA9inALh22pfb+9CwJQw
	 2sgmlzZs/SrSh1PEve8R6KqRylMIDFOGx3q198v6i2oqsGNgydjZwgp1tI0bdsyVfm
	 1ib2euXW+R/QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C873806644;
	Thu, 10 Oct 2024 02:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netconsole: fix wrong warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863424.1545809.14043075187480987088.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:34 +0000
References: <20241008094325.896208-1-leitao@debian.org>
In-Reply-To: <20241008094325.896208-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, thepacketgeek@gmail.com, kernel-team@meta.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 02:43:24 -0700 you wrote:
> A warning is triggered when there is insufficient space in the buffer
> for userdata. However, this is not an issue since userdata will be sent
> in the next iteration.
> 
> Current warning message:
> 
> 
> [...]

Here is the summary with links:
  - [net] net: netconsole: fix wrong warning
    https://git.kernel.org/netdev/net/c/d94785bb46b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



