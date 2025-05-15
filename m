Return-Path: <netdev+bounces-190672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB75AB844A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1B49E241B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C08C2918F3;
	Thu, 15 May 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dekyJQkz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93912101AE
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306193; cv=none; b=bLfdZ6IXA/ZFI6vZvP+CvB6teYQXPKKQrMl4FiERP3X/HzwF30ii1u/wap2K4wmP672cjqVXAsrSCUlaJy+kZS+MDzuE+7ssZRndjAIJ6RE4wdTPnnVVaHmZ5549bPxZqq/hfT1V/a38ftvuS2TVJw+KdGPVUrdrGZLG6zP2iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306193; c=relaxed/simple;
	bh=Nw7OAFIa7XcAKKehb8C2+UExR7xM56j9UXCudhMeW80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fNQtSTtzs18pNEKh28zXj055t9doHyBpI3gdNMcEgrFwJkMncTyxJvHVhe2Qeenv36pXtLBZybrITelt3kS3gKfYIrSQ6PDwlhlbAEKylVSEbochUAavSckQW7NMSkcCi1ODEYyMfen703gmRZIsyiC9zt4VSBdWV9jX0OShiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dekyJQkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595F6C4CEE7;
	Thu, 15 May 2025 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747306192;
	bh=Nw7OAFIa7XcAKKehb8C2+UExR7xM56j9UXCudhMeW80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dekyJQkzlkE7Y0bAYeD426+TnMiCKvCRf508ZUbk0g1EVKFMHNGyXjQ+4JyikLvK/
	 36huyXtKsTVQwcAv2cZyK37YGOa/k4XuJcB/yXkVe/RdiQbKH2SwSYTBKBpm/AFXAU
	 2ZMY9hFv3+YBTddUOq6Yb7oBYACMdk6dEEm7jMUBp2dAvQTecRL4Uw+luV47y15fLU
	 Yz7tI8l9Sl8lNd9ulalOmVth9BZzStlcYyAFQAFCU2NMArkAIlV4RoIfDt7N5Ppuhw
	 SkZGFbKqL45kS7dLwTySfsKM+GhgDXTDCMT7KFpn8ZXPkm/xNIEhPeuE0pBQg1uRLy
	 O3Sn1B/INKx5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC563806659;
	Thu, 15 May 2025 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2] octeontx2-pf: Do not reallocate all ntuple filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174730622950.3059611.4240481390914363802.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 10:50:29 +0000
References: <1747054357-5850-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747054357-5850-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
 hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 May 2025 18:22:37 +0530 you wrote:
> If ntuple filters count is modified followed by
> unicast filters count using devlink then the ntuple count
> set by user is ignored and all the ntuple filters are
> being reallocated. Fix this by storing the ntuple count
> set by user. Without this patch, say if user tries
> to modify ntuple count as 8 followed by ucast filter count as 4
> using devlink commands then ntuple count is being reverted to
> default value 16 i.e, not retaining user set value 8.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: Do not reallocate all ntuple filters
    https://git.kernel.org/netdev/net/c/dcb479fde00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



