Return-Path: <netdev+bounces-143887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D179C4AC8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CEBB2AFC3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1504A0F;
	Tue, 12 Nov 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL2D4QRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3C3FC2
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370219; cv=none; b=hIzgcHDHCZXiBFfeQxSR278/D3AgC7fbEXXQAUdjyOYTQYMKjaK9/fL00XF6OdKeF06fENwofAqBg8UnbWOSiLtUcG6Ds7u7GiGheMcc4P+PIwooaWDnXt7+QyvIf6f5kWX2lcrnDNDbxMNrGfuWyFAcsDbxMmozmSPVguuAgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370219; c=relaxed/simple;
	bh=DbxDhDhLLCEcIaWiVgzlWHmGAG/RnhUGbUb6QZnigo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YM6uumqPdBFgbE5fwYDokkKa6YNIOv3pbhaF7EweOobItVOnmRy7a7nKW62pF3qM98o4utRGeDMwpQST3OcLa66JbzCS+QB+5LGtl9ykkRrB/J/Mqn4Rr02Bwpx1KGEVgq+hB0c/mO+Fj4Kvn56ihxpD/vazigr3r/b5hhIp0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL2D4QRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DE5C4CECF;
	Tue, 12 Nov 2024 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731370219;
	bh=DbxDhDhLLCEcIaWiVgzlWHmGAG/RnhUGbUb6QZnigo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XL2D4QRM6Kpc5na8d8BPWDSqAWrj2o+/oncpbzk+JA0LYK+/XoUTDHzSyod0NPCQ5
	 7JfkbxDv59OnoeHeGwfb0T0cgcIt7VZYtKgYGWW7n9nbAixcO+x3zT0pL/EZKGDsni
	 PVrJGXeyW5IUHrQYczZwB70bi9TGXyHZJu8urHrj0UKbnidUBAniTzt5wj25gXTUhN
	 LpIRh7gsekX/8siuk5gV8aZ12YffVL6zav6EpNx1oz7il7Xe4zkZpyc6M/ImWBWVkc
	 B+6LP8piM6IxrShJBKqU3FqnG/3/jRxPIs+rDRUPlYJjytMKzwqVXQCUwudRVjqYgh
	 UkN9O+Qd/1kNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B53809A80;
	Tue, 12 Nov 2024 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: atlantic: use irq_update_affinity_hint()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137022926.20619.3558596431479135919.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 00:10:29 +0000
References: <20241107120739.415743-1-mheib@redhat.com>
In-Reply-To: <20241107120739.415743-1-mheib@redhat.com>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, irusskikh@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 14:07:39 +0200 you wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> [...]

Here is the summary with links:
  - [net] net: atlantic: use irq_update_affinity_hint()
    https://git.kernel.org/netdev/net-next/c/2cd78740effc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



