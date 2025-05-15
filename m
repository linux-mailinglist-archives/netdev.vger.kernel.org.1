Return-Path: <netdev+bounces-190704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA0CAB8516
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AC13A2AA9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882C28DEE6;
	Thu, 15 May 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAiSQ/aU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2686819
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309200; cv=none; b=p1E5WQUotS9wcpr5omPlrL/iRf2weN8xTy5+5DqpLPq0WSGlU1QXtmclHt8z4aAvd6C7WKZk7Rt2o5j6PpJI4SdOAVtmUCuXWLRiGq7ZRVUx8zdakHeOirrvp+cHdLJnHCwlMp3QyTA1YkQWmHh3VQXnXirQxUwIyWRFudV2gv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309200; c=relaxed/simple;
	bh=i+F7JiNxXgBkhSO2Ym79xNuNJUF7m5iT3riMYNN/oEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQBhx/kH74GRuaELXfeRK/BOo+TEd4s02fBz+fJbbQREmOX+XRbVaBTn1VdoFHGFGnTRokOsGEJu0tuYaEHQVB0Rv/FcSpzJv2ADGTaw1j7Mx2anryfdjVwCRj9SIn0OCoY3UVidqBrfNdLjlcAkKJ38cYqWezuzvU26I1m7Gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAiSQ/aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16228C4CEE7;
	Thu, 15 May 2025 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309200;
	bh=i+F7JiNxXgBkhSO2Ym79xNuNJUF7m5iT3riMYNN/oEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAiSQ/aUXXM+hnSSOAGRPmKfMfsQHuKrDVRRbIDEHefOX/6ElE7pHTcPfV2jjphT7
	 4NY3KiJx0Dc7FoegAWpXqlLjsLR7E/7pxeTv/J5yIDN/Vs+Y5oh4mb/c64H5V/htdz
	 2stkGywihCitzts7+iKkmgOfGe4ih2tv8PjsWpyQ+QuhFSV1w9Vc37eu1eCs5YK1Fr
	 woS/t34Ju64TS14pUWL7KB6FL8YAemaIGEudpryQ/ifqSAqa9l6TLwpRH7PgOeMmH3
	 cQ5RNY1FlFWSQALWNUxrhU3hPAVo9UhMfK237xkSv7lmVns+L16Oq9R9a96wcqzhpU
	 GGUJG+3j0gkRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B623806659;
	Thu, 15 May 2025 11:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/4] octeontx2: Improve mailbox tracing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174730923723.3072533.7365915666738743068.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 11:40:37 +0000
References: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
 hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 May 2025 17:10:04 +0530 you wrote:
> Octeontx2 VF,PF and AF devices communicate using hardware
> shared mailbox region where VFs can only to talk to its PFs
> and PFs can only talk to AF. AF does the entire resource management
> for all PFs and VFs. The shared mbox region is used for synchronous
> requests (requests from PF to AF or VF to PF) and async notifications
> (notifications from AF to PFs or PF to VFs). Sending a request to AF
> from VF involves various stages like
> 1. VF allocates message in shared region
> 2. Triggers interrupt to PF
> 3. PF upon receiving interrupt from VF will copy the message
>    from VF<->PF region to PF<->AF region
> 4. Triggers interrupt to AF
> 5. AF processes it and writes response in PF<->AF region
> 6. Triggers interrupt to PF
> 7. PF copies responses from PF<->AF region to VF<->PF region
> 8. Triggers interrupt to Vf
> 9. VF reads response in VF<->PF region
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] octeontx2-af: convert dev_dbg to tracepoint in mbox
    https://git.kernel.org/netdev/net-next/c/aa2263b3c3e2
  - [net-next,v2,2/4] octeontx2-af: Display names for CPT and UP messages
    https://git.kernel.org/netdev/net-next/c/ba7b63670312
  - [net-next,v2,3/4] octeontx2: Add pcifunc also to mailbox tracepoints
    https://git.kernel.org/netdev/net-next/c/27d27a06b48e
  - [net-next,v2,4/4] octeontx2: Add new tracepoint otx2_msg_status
    https://git.kernel.org/netdev/net-next/c/fa00077d8fd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



