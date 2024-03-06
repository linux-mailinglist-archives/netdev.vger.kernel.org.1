Return-Path: <netdev+bounces-77726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8AA872BC9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 01:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC341C21C78
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90731139D;
	Wed,  6 Mar 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKZ6RnNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B6173;
	Wed,  6 Mar 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685028; cv=none; b=gIZv/nqXeu2K/y04KdMruob+6mKHoxFJTqLMMAyVs8/mFmLRFL35j9J1XINazZg5upBzrH3xxTi9/hH/b3qHC4+x9yXc1pQJ5owBcU0+aMfQO+o8jNFsmU/9bNGafO2ZYqy/F2AGw/NxCPL+mXKW0EHO4xuld2hYFfvd22JC2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685028; c=relaxed/simple;
	bh=9ig0bXNJ6TOOVCGsKN5QL+DUHjHVSZOKaJPmxmAZJQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UxlV70Hek8sa3u8iyvYNGaZWn95kxbAovt52CeH4Fl1E1dnoEOPFcZcRdnGuJm8a7dJzOGge1MJs/BST26hYQKD2+1qvCBROhuXrWSwObWr9MSm5Mr8QZLfu8wnNe+GZ0E037sy2TqN8BqsdlICkzwHSoohWyCtaswHucEdvWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKZ6RnNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD662C433C7;
	Wed,  6 Mar 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709685027;
	bh=9ig0bXNJ6TOOVCGsKN5QL+DUHjHVSZOKaJPmxmAZJQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NKZ6RnNVwxNu8lMlaub0n91BcaclSeCRARm2k4fkSLfOF0fbSXHMi/IuvPNd3SLZP
	 1AVLt7wIGpyCBbxe7aklJplAtljLfY1pDsxQbZMZgjbjIHnPZOgW4TMPCgRIJl96Zq
	 /Ij7+L8EIydQ1yEno32QbAeMSgueh47270J7djZXntuwCQfIxN30LgyluQzYC0DD7U
	 b1KANMbxUbPoB8b2IBZXaxJZxE3fRg+/Udw97VVWrBzRLt9tV/COGvmzGg1r6b8d6C
	 E12TilbD7/nKlb/nne+vI4kRuuhcRSVnGnvui09PJimjBWl4tL3GWJeLjcIIbuZEOV
	 V8GugT2JXknUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0F2FD88F80;
	Wed,  6 Mar 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] xdp,
 bonding: Fix feature flags when there are no slave devs anymore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170968502778.5704.4519517843918140180.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 00:30:27 +0000
References: <20240305090829.17131-1-daniel@iogearbox.net>
In-Reply-To: <20240305090829.17131-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 prbatra.mail@gmail.com, toke@redhat.com, kuba@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  5 Mar 2024 10:08:28 +0100 you wrote:
> Commit 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
> changed the driver from reporting everything as supported before a device
> was bonded into having the driver report that no XDP feature is supported
> until a real device is bonded as it seems to be more truthful given
> eventually real underlying devices decide what XDP features are supported.
> 
> The change however did not take into account when all slave devices get
> removed from the bond device. In this case after 9b0ed890ac2a, the driver
> keeps reporting a feature mask of 0x77, that is, NETDEV_XDP_ACT_MASK &
> ~NETDEV_XDP_ACT_XSK_ZEROCOPY whereas it should have reported a feature
> mask of 0.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] xdp, bonding: Fix feature flags when there are no slave devs anymore
    https://git.kernel.org/bpf/bpf/c/f267f2628150
  - [bpf,2/2] selftests/bpf: Fix up xdp bonding test wrt feature flags
    https://git.kernel.org/bpf/bpf/c/0bfc0336e134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



