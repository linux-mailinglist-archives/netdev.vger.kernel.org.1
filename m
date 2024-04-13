Return-Path: <netdev+bounces-87619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E08A3DC0
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E01F21A64
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916B1D6A5;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3PmeBNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570117C9B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026427; cv=none; b=g1uLE5k+AlF3qyyex2uX1rKtd/GDhYecobvvsiH2uO0tZo3L4BEOwvw8IONcwJLbVwzDbim05AIfEDxVA4haTr+ha6QSxKWfPBgl9QdWJ1WMTe1CBd9VgVWlkp1MYcI7Sx9W+xw7ZWQsO/ohh+OI1vaUzJTIeICid4VIjEigbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026427; c=relaxed/simple;
	bh=0DZ5e6VLyNFBjw6AJQo3TWla6UBCWTdRPMSvmjH6F/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KODEs10UYG/iq7EdY6KTNnadnDaGzqnYB0I6tAT8tjJXscel8+FTbfL0C/yMWJT7T0jp5bOyW6/r3XbZYdpMl/zQsD8m+f0b0VRVojvK5d/21leTexh/zEKsoyQIX7CUqMmrcd+ctW5w/JyqA8eYvGGz7fYaZgxUAdekEfzsPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3PmeBNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 344D0C2BD11;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713026427;
	bh=0DZ5e6VLyNFBjw6AJQo3TWla6UBCWTdRPMSvmjH6F/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3PmeBNkVHWUvgABxyVRtZJDwZY939zSIWEDJmu60ifWUxrQkW1UUppXT8/Un/TjX
	 w+JaNg0iW8CuEGLJ4ewsJVianKdrsXnvda1V4TUj9JWb/CP3kNA1QjWj2GiQI3FGSM
	 AYRtOhhSuRGf350LD9JCVquprLqwJXV69jQTiGFN862jc0NpAD37ZJsRy8B9yng5Jq
	 JZ4qd1g0Ko9UhBzNJ6cQ+w7pP4Ib+RnTsSEyM+t0C80an0Zmrgl+zWHx6IfGc6RPqu
	 cNBJswc71DRMKUJBciT57ZkXBieCdkEAH0xRw6K7vJ+uBUryhLtbirN1Y1zacANF5X
	 U5ucCHzDIq2Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 242AEDF7856;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] devlink: Support setting max_io_eqs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171302642714.24529.12887628327943229659.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 16:40:27 +0000
References: <20240410115808.12896-1-parav@nvidia.com>
In-Reply-To: <20240410115808.12896-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 jiri@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 10 Apr 2024 14:58:06 +0300 you wrote:
> Devices send event notifications for the IO queues,
> such as tx and rx queues, through event queues.
> 
> Enable a privileged owner, such as a hypervisor PF, to set the number
> of IO event queues for the VF and SF during the provisioning stage.
> 
> example:
> Get maximum IO event queues of the VF device::
> 
> [...]

Here is the summary with links:
  - [v2,1/2] uapi: Update devlink kernel headers
    (no matching commit)
  - [v2,2/2] devlink: Support setting max_io_eqs
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e8add23c59b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



