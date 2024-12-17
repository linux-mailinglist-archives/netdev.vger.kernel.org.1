Return-Path: <netdev+bounces-152473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B49F40C5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F616411D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474F14A09C;
	Tue, 17 Dec 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWjnHYcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84A1494A9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402614; cv=none; b=K3UVwzToYFsKd9xbP0Wq4UkzFqRs89WLcmY8ygl/+Fuf5Vv3u+IOaCFR9+yaFvyh66WrumJEIq8Qc2Ja691qIXMzgbniTb+lD+d6/wfHSps203Xyp1idCFe28LtYiS+wXTfdFZUA8ke1o5czsvjbVH0++74IIf71pPIGfB7mnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402614; c=relaxed/simple;
	bh=H7mlplvqQ+N7ECOhgFj3nilCSorz2JCRNDGJftFiNNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IN83xriaeQnpPvI1N9H+4fIuxkTuFvWHeomvbZkj7wrl6CFEgBDEHc38M8RKQNpE5cE0dhJAvGIwH6F+Pi7lfbdnB+ZEDLVRp+fEQt8mFJ3kLzzh7Hh9cpYyAJ3i5NN8ij2IWNNTeV2saRCCaOKS4bDNOWlNtxg4RPeD7uhwTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWjnHYcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D3FC4CEDE;
	Tue, 17 Dec 2024 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402614;
	bh=H7mlplvqQ+N7ECOhgFj3nilCSorz2JCRNDGJftFiNNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MWjnHYcNF5AdrwQIUKmW9soXDhrlYfe1ikLQjd3v/UYyaEaqdsPB6lk1XBDeaf+GO
	 DhNM2BWYEDttw2hQmfknCVlNSamicD0/pWwg1cMdZp2tuyDaXpVaWXppolOBHyQ/Dz
	 /s2g5u2irA/n2rFdkb1JyNWxqekDmnT1hGi9cp6lCq3IwJimBhPiIQxyP2A+BYjEek
	 8+QvFewTclKfMacqCzcmxtCnpdmBWl2cnp9PL1K/7YqewN7YgFQKUsWNx2yNZFxxGY
	 Yz+ONbyMi/fj3KFtdh0TjyBbtWA6PzFjsvxCiyu7CDd1gbhG1S/Bw0DvgIsqTEofuW
	 eSobyLmSzqHmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE63806656;
	Tue, 17 Dec 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] team: Fix feature exposure when no ports are present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440263125.420431.12756256208049130141.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:30:31 +0000
References: <20241213123657.401868-1-daniel@iogearbox.net>
In-Reply-To: <20241213123657.401868-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, razor@blackwall.org,
 mkubecek@suse.cz, jiri@nvidia.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 13:36:57 +0100 you wrote:
> Small follow-up to align this to an equivalent behavior as the bond driver.
> The change in 3625920b62c3 ("teaming: fix vlan_features computing") removed
> the netdevice vlan_features when there is no team port attached, yet it
> leaves the full set of enc_features intact.
> 
> Instead, leave the default features as pre 3625920b62c3, and recompute once
> we do have ports attached. Also, similarly as in bonding case, call the
> netdev_base_features() helper on the enc_features.
> 
> [...]

Here is the summary with links:
  - [net] team: Fix feature exposure when no ports are present
    https://git.kernel.org/netdev/net/c/e78c20f327bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



