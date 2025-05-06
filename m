Return-Path: <netdev+bounces-188273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C9AABDBD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FFA3ADC86
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A221B9F4;
	Tue,  6 May 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRgyYQ5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B87264A6D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521392; cv=none; b=M1nBR+08WWTQF15Rz/MLX2XTe+n8FhwR5HJXc7K2y7Oo073IX2qoHCAUyFudzt3gbHwpLmpxwphPlprbMXLVXH1+rgPTFopdFuQLSVO1W3Bm9VbDjBk56hEQT/izkt2zJp4R8Ku+7+09kX8gdv9l8NaQShwoAFk1/e58ZsdVtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521392; c=relaxed/simple;
	bh=egFVLcMF5ZlUs/oGwyBIskHABlbsNz4HF3dVBmtgtF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SMpy+tvruda4nsIPHqTLAJN3jdFuU58RR0bXPhlJci80xyz/Z79GQHPOekxFYvJG/Z8NQcNMcXmIgv+U7fwj01qPPdKB1aVmAIn/YG/VoEjgICAH0rcPCWLTBOM8176tAEBGOmEnox151oY1n7Ow4X83wtCTZFoNE1RMQjypK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRgyYQ5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E267C4CEE4;
	Tue,  6 May 2025 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521391;
	bh=egFVLcMF5ZlUs/oGwyBIskHABlbsNz4HF3dVBmtgtF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CRgyYQ5dUD8YigkIe+vdNFjZfHnuMmnEfjehrn/Bq392FLKJ4SK/5dv+q3EL45dBR
	 ldpiJq1btsKEfJsuI6dexEry7//h3NBI5yq0iOpvqzmPmTTzaxiu39T8aWm8H31iow
	 /Qkh5bt26wdCx9TdRDacL5Nv18oUXyqmNf7xWoQg1Y5W3YnybG/5yocGNrq0EaFC+d
	 F/BbTEjMGqo0Ucm29gs91tO4S4ruKbLoqHxci0Wd/q6BQz2PMFyaxL/j3OQk0dd4ds
	 EHW+UiDa0eaf9vfy8suthHt11FeCT3k/HDolFVYbaEAoJLkfXgoHiN1DqzhoZaSwAG
	 EhE0ImgyKohvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC573822D64;
	Tue,  6 May 2025 08:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] net: ibmveth: Make ibmveth use new reset function and
 new KUnit testsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174652143074.1095323.4277122495116903692.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 08:50:30 +0000
References: <20250501194944.283729-1-davemarq@linux.ibm.com>
In-Reply-To: <20250501194944.283729-1-davemarq@linux.ibm.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 michal.swiatkowski@linux.intel.com, horms@kernel.org, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  1 May 2025 14:49:41 -0500 you wrote:
> - Fixed struct ibmveth_adapter indentation
> - Made ibmveth driver use WARN_ON with recovery rather than BUG_ON. Some
>   recovery code schedules a reset through new function ibmveth_reset. Also
>   removed a conflicting and unneeded forward declaration.
> - Added KUnit tests for some areas changed by the WARN_ON changes.
> 
> Changes:
> v4: Addressed Jakub Kicinski's review comment: added missing work
> queue cancel in ibmveth_remove
> v3: Addressed Simon Horman's review comments
> - Reworded commit message for ibmveth_reset and WARN_ON changes
> - Fixed broken kernel-doc comments
> - Fixed struct ibmveth_adapter as a separate patch before ibmveth_reset
>   and WARN_ON changes
> v2: Addressed Michal Swiatkowski's review comments
> - Split into multiple patches
> - Used a more descriptive label
> 
> [...]

Here is the summary with links:
  - [v4,1/3] net: ibmveth: Indented struct ibmveth_adapter correctly
    https://git.kernel.org/netdev/net-next/c/b30978515430
  - [v4,2/3] net: ibmveth: Reset the adapter when unexpected states are detected
    https://git.kernel.org/netdev/net-next/c/2c91e2319ed9
  - [v4,3/3] net: ibmveth: added KUnit tests for some buffer pool functions
    https://git.kernel.org/netdev/net-next/c/8a97de243df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



