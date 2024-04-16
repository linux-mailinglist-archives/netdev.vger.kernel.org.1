Return-Path: <netdev+bounces-88287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF78A6986
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D3D283068
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C112882C;
	Tue, 16 Apr 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmatPcY+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086D86259
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266429; cv=none; b=nL6TvuFBQWZO/DB/u9wKsT0N1Clcd/4vwGU7l+dUYSopKtb27dk6QBTTXXz+NdEipmBku+JMI14DzTTY9YcXjH9zM5RBS5E9DL8SKRGAXvJPvIEFxnIjI3/yaTZfIxji6DpwWP/GLq26E6XUQQzC1fQqRj2yQB1TmPaa6iIjtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266429; c=relaxed/simple;
	bh=gltMHBkACDrZWZFADewlwyzovYFmhcD6lRBCARVrCck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TkBcKan/vwyZZZo8cvvA1enkATA2SXv5MsyY40qYXL4qvMPkezmnMpyXAB9Zl2Cb+v5+spEADlwj/NvyA0XAtd+whilYVSebRM2CsMc8SKDc14IRs8Tbp4whzN6SofuVb4FJVdz1KdI4CRNK58aPeK+toZb8FsPaqq5vx6Z+wGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmatPcY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52DC3C3277B;
	Tue, 16 Apr 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713266429;
	bh=gltMHBkACDrZWZFADewlwyzovYFmhcD6lRBCARVrCck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WmatPcY+kx6Rxb1Kp0WAtyLqgQtvErDYrD2x9sCcL3feGcBaskv5G5q7+hT5jMWBb
	 F2kNVkhirTXtnxSAlBatZ4stCHaEi+gGofatAqd5CB3lON4rLln7JT0uj37Twb7L3+
	 465Pb7LRvGG7es9Yu3D32o/IGBn4durolVQuZ6XDpXTn7V5uCPVXKJyqdoyAvHPuZS
	 6EvHEcedaAho2UYEBM06UoxZTM23mXhd6w64k0ir4LLdc8L1u9JwSjXwGt4vBHt17T
	 umHFQvnbmoIcFHHQnCHDG04ipWa3LwzYPyJu/uRXsG9i0AGv1GLAe8CUshsrOv3lfZ
	 Z0wln0pXY9q0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43305D4F145;
	Tue, 16 Apr 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver Updates
 2024-04-11 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171326642927.6844.8182746982415853237.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 11:20:29 +0000
References: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 12 Apr 2024 14:05:29 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Lukasz removes unnecessary argument from ice_fdir_comp_rules().
> 
> Jakub adds support for ethtool 'ether' flow-type rules.
> 
> Jake moves setting of VF MSI-X value to initialization function and adds
> tracking of VF relative MSI-X index.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ice: Remove unnecessary argument from ice_fdir_comp_rules()
    https://git.kernel.org/netdev/net-next/c/0a66e9764304
  - [net-next,v2,2/4] ice: Implement 'flow-type ether' rules
    https://git.kernel.org/netdev/net-next/c/ae67389c5392
  - [net-next,v2,3/4] ice: set vf->num_msix in ice_initialize_vf_entry()
    https://git.kernel.org/netdev/net-next/c/c22f7dacb820
  - [net-next,v2,4/4] ice: store VF relative MSI-X index in q_vector->vf_reg_idx
    https://git.kernel.org/netdev/net-next/c/b80d01ef9aba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



