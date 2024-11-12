Return-Path: <netdev+bounces-143889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA79C4A71
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D731D2866C3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067B2AD31;
	Tue, 12 Nov 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1jvEKcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8784A0C
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370222; cv=none; b=oINvJOClAUyeRl+Fzgw0mLIkDJpdtM93Fqkl80HCaokugqaO9ZSfl+tlgWerKFAZw49mmpofZ2b2q4L9WUxhZK1iQegtvF7EHPehjtebmWx39QMxxfHsXRbTxm3umOfvuRNrKgCUdgiGLYSv9FuGVKM7x32MDN0MSXelj4kKZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370222; c=relaxed/simple;
	bh=PS9jL9dwJGkLa8IjRtRFd8sIQX3uCbX3fx5I+wxyVio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jjld1EqP2/QEU301eyGQrA1MuqMLM6tQXHD9cYHJLCT0AWMXoL64u8RdzNXjCHSzeHhexPvKYJvS+fIshk14cyXtNuSTuumQIynuwcHHW/t5CHxAyABuMK0Sc3QPIe/yazAvRC4F0BjiS+qH1whp753PdXkcM0mq33LmfP+s81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1jvEKcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3D6C4CECF;
	Tue, 12 Nov 2024 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731370222;
	bh=PS9jL9dwJGkLa8IjRtRFd8sIQX3uCbX3fx5I+wxyVio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1jvEKcKn9os4x0ubGZC0DfdoMZC1XB2BoVMhZsSkSPOVJsE5jZ82Kh28njs+/HkK
	 qXKaNOk+ycXXeimd325ktl89RIC9HE64xZ3GjFfHV6rTP4/ozqR/BXjrYnJLg6wyn5
	 jBovT711PiT9qlN4/XEOmEqKq+N6fp8woDAbG2RL99QlMuzfli92rjni4NYPqBsf93
	 YPGkHz4UPnO3y+w6mFCDq3FlFM+o4I8jpQoJbb14lMn03Xs9LDbXe2Hf5IlmlewAUW
	 QZPts8s8+zz7oqtSZOxIU3hykXnZBoAy9VdxhzkrIiQsSgU2hLwVjWnWv/xh64f7/D
	 s42fNFjbLi8Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B4F3809A80;
	Tue, 12 Nov 2024 00:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: use irq_update_affinity_hint()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137023199.20619.9050750562320638869.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 00:10:31 +0000
References: <20241107115002.413358-1-mheib@redhat.com>
In-Reply-To: <20241107115002.413358-1-mheib@redhat.com>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, oss-drivers@corigine.com, louis.peens@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 13:50:02 +0200 you wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> [...]

Here is the summary with links:
  - [net] nfp: use irq_update_affinity_hint()
    https://git.kernel.org/netdev/net-next/c/d9e2e290f714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



