Return-Path: <netdev+bounces-77630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BF8726BE
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB561F21899
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B418EBB;
	Tue,  5 Mar 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOBfH/Fz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E018E06
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664035; cv=none; b=ow/13gkYt0pf49pWq139Wluuach+AzLofmWORfkQwSPW2xl+F4TDJLBhdK+vYNhTyKvchx955+bwT4LpKEzxZWMnprkzZbbMnsAkdK1mCSqNWVSXjODcUJAkF6CtEu2e+OdcO7+DpROcqnr6B4bQUQrctWw6a396JgQYC5TRipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664035; c=relaxed/simple;
	bh=FixoRy6rWk+RHaPCMBW/3JyHBnQO9J8ok7FaGmXj7IU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uENj+/P8VftjbPMto/pwzyZeGQMfVF9cy9Huu/EVIZbYa4uXCe0yV67hMJgiYCCbJzmNpaJGiGEAHyvwwom6+5JouIPVWmFg7+xz8YnOo4ip0d1PswMcfa5dnYD/hUSPeyKm+hQ1umEmQi/EL5NAVjc5F5VvbqcLU7r3Evn/DEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOBfH/Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A06CC43390;
	Tue,  5 Mar 2024 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664035;
	bh=FixoRy6rWk+RHaPCMBW/3JyHBnQO9J8ok7FaGmXj7IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pOBfH/FzOJQxaO3QyJj8jk1xHw/yhrrHvbxQfGIysn9lr6QHXye4hZCDOrRD1s3La
	 unwzZM4p9D1uGwYMc+MralINPm5PRLwfsJsxc7heF2eSk76WzZSKPg9k2lQoza2SkB
	 22TIf5frz8NtT6SIdGX+VdhBVg0PYthkl2SO6qOXk9JGyIoE2XZ+gRYABbivin4Q5c
	 IeaueKCx7IdVA4Ce2GMn37xV7zbpNKl5y8N3Qh4xW76JAbxDuXaUAC/KBrEPzY8gwK
	 AkVQSqMedNqFbEpWt7jb4RZ0E4K5zHjYw/MRdW3ijkVq2L94EycUro/NBWNPtu6h2z
	 6Wq6qdB+A5f/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71CE1D9A4BB;
	Tue,  5 Mar 2024 18:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] selftests: forwarding: Various improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170966403546.3255.13508375715616168106.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 18:40:35 +0000
References: <20240304095612.462900-1-idosch@nvidia.com>
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
 bpoirier@nvidia.com, shuah@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Mar 2024 11:56:06 +0200 you wrote:
> This patchset speeds up the multipath tests (patches #1-#2) and makes
> other tests more stable (patches #3-#6) so that they will not randomly
> fail in the netdev CI.
> 
> On my system, after applying the first two patches, the run time of
> gre_multipath_nh_res.sh is reduced by over 90%.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] selftests: forwarding: Remove IPv6 L3 multipath hash tests
    https://git.kernel.org/netdev/net-next/c/7b2d64f93319
  - [net-next,2/6] selftests: forwarding: Parametrize mausezahn delay
    https://git.kernel.org/netdev/net-next/c/748d27447daa
  - [net-next,3/6] selftests: forwarding: Make tc-police pass on debug kernels
    https://git.kernel.org/netdev/net-next/c/4aca9eae6f7b
  - [net-next,4/6] selftests: forwarding: Make vxlan-bridge-1q pass on debug kernels
    https://git.kernel.org/netdev/net-next/c/dfbab74044be
  - [net-next,5/6] selftests: forwarding: Make VXLAN ECN encap tests more robust
    https://git.kernel.org/netdev/net-next/c/f0008b04977a
  - [net-next,6/6] selftests: forwarding: Make {, ip6}gre-inner-v6-multipath tests more robust
    https://git.kernel.org/netdev/net-next/c/35df2ce896dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



