Return-Path: <netdev+bounces-227421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA1BAEE73
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7FF3A2D60
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F11DF25C;
	Wed,  1 Oct 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5MpEQ6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734A1DED63;
	Wed,  1 Oct 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279216; cv=none; b=SbClJWaBtMp5Da4S8DflQPZ0ukwqYTrjSlG/cHbF12WMaZFJQO95rJeNwM3rLb2W1KAKl22ea2KuMvI38Cj0CRZT3lltFYtCQxDA9dQG7veN1mgfrdtxmOH1BltcnJBqSI04e1vM1P4Tp4ANwb95Ei0lfsfQlezszI5+X6uYXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279216; c=relaxed/simple;
	bh=QRmZqiYVZdb1Eora8Gx8A7aT2KAQxE+VgM9fHT/cMNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZxBb//MIilfqRvWqJyjVuCq+jlqaV6QM46aQJIX498rwkZxuvFsgsCpxk/6uEKXHlGdsn1DfSBF0nyByIexe6J+IDhTiXn1NV9+ffXfdvhG8FH/00LB++e6chF4Ivelx4yGxpgtxFOd/wLcdHIudUJCfT3lwqtAkFsjvkEp9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5MpEQ6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC697C113D0;
	Wed,  1 Oct 2025 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759279215;
	bh=QRmZqiYVZdb1Eora8Gx8A7aT2KAQxE+VgM9fHT/cMNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H5MpEQ6PvDMN5Rf3/Bbgf/zFe1BpFKRaJbCicKgx8OAi5/ClIoU/DqFfqKjEa4MPD
	 oRCNIzXu/2lOeoTAJsyAmAmjJ1B32qmlTUZSe1AnFHk3jaNqBTvJMaM7tPJKjQOuc5
	 tFs0IiO1ItHySZw/uD8zwbAc8KASHebJ2wQhFubBcmb8aAzeV5efOgEx+cMHy4Pw4O
	 /pVsXgbrpowgYble484D4/pumanLbR0xVp8eOUH8w+1NynxW2pAP4pXFq3fpO+71Mo
	 VfKcb+YnaDNeyTfc0hzMwuU21k/0eS0f0CSfP5xFNbkmCLttHbaoDjjvimA2Td0Jwa
	 XbsJNYRN1IIAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4D39D0C1A;
	Wed,  1 Oct 2025 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] octeontx2: fix bitmap leaks in PF and VF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175927920875.2252526.3237930601747608854.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 00:40:08 +0000
References: <20250930061236.31359-1-bo@mboxify.com>
In-Reply-To: <20250930061236.31359-1-bo@mboxify.com>
To: Bo Sun <bo@mboxify.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, kuba@kernel.org,
 pabeni@redhat.com, sbhatta@marvell.com, hkelam@marvell.com, horms@kernel.org,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, sumang@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Sep 2025 14:12:34 +0800 you wrote:
> Two small patches that free the AF_XDP bitmap in the PF and VF
> remove paths.  Both carry the same Fixes tag and should go to
> stable.
> 
> Changes in v2:
> - Add correct [PATCH net v2] subject prefix
> - CC the sign-off authors that introduced the leak and everyone
>   returned by scripts/get_maintainer.pl
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] octeontx2-vf: fix bitmap leak
    https://git.kernel.org/netdev/net/c/cd9ea7da41a4
  - [net,v2,2/2] octeontx2-pf: fix bitmap leak
    https://git.kernel.org/netdev/net/c/92e9f4faffca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



