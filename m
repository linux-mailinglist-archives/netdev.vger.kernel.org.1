Return-Path: <netdev+bounces-203069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF75AF0754
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9A1C04457
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623912B73;
	Wed,  2 Jul 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYkIOP/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128A611E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416783; cv=none; b=Ojg/RNQ8rddYdHILecO+qxvy6Omlfuom9J9NIEgPIjjKXNmKcWG4N3mVeCrETgk5XdGs7DjBRddCmNXF4hvAsKIfMmLDCG4bpKqoe0U9LhO2nzyInF5nA0gwMLW3BauKghosRBnmOj636tNKsIHXs5/JOLuTmJ4ipFxp+fxb+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416783; c=relaxed/simple;
	bh=cE47cBwrfVLSArekjj3Ol1Sf2NbfQSKQ3A/x6Ev8aoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VLP7ZU+2GA5HUQZYknxJODO3NFPpmO7diMRPaK7JaLFN7xBCe/o50fh1KCzhr9J2UA5TtmqFF345oSij4Z7mrtZ0fGI9yQHAbEUGuEBZzu2ZIOJu0DV5GU3Dcwp/AqwPqGYgYwRolBWzjy1ipjMsJAQuoc/GtTiXyQVUCBpGoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYkIOP/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708D3C4CEEB;
	Wed,  2 Jul 2025 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751416782;
	bh=cE47cBwrfVLSArekjj3Ol1Sf2NbfQSKQ3A/x6Ev8aoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LYkIOP/Mow3kQdCC/HhLxMJtxX8mTV1lf2g0C2MaM1D9fqgyHaHm7Y65/0W50QfYI
	 6zKafBshEZz96jd1o7CJMaFJBpEQo/kwha/GNSr893uXm8QoFRUWaLmKTpok+R3Tt+
	 hz3X6eVM9pslkO3RbausdD6zNCmsnz44e3ePyyEgiQ4yPLfrUoi3aFLwZmXS5gKB7u
	 ibCZAh8RgkLrUrk5Vt4P5lbJiaKo891QL/uoGtUWZQ4B4Pw6c7BoaM41mo7XFLOJuL
	 tAX+ncfz3MU/F+cPJSAsSoAu9GRKVrzRrrFeYyn6jorVvwkcMRooTUVbmJb1ZUGTm9
	 4jioAau9mEKTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDC383BA06;
	Wed,  2 Jul 2025 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] amd-xgbe: align CL37 AN sequence as per databook
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141680726.158782.16938610145522088734.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:40:07 +0000
References: <20250630192636.3838291-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250630192636.3838291-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 thomas.lendacky@amd.com, Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Jul 2025 00:56:36 +0530 you wrote:
> Update the Clause 37 Auto-Negotiation implementation to properly align
> with the PCS hardware specifications:
> - Fix incorrect bit settings in Link Status and Link Duplex fields
> - Implement missing sequence steps 2 and 7
> 
> These changes ensure CL37 auto-negotiation protocol follows the exact
> sequence patterns as specified in the hardware databook.
> 
> [...]

Here is the summary with links:
  - [net] amd-xgbe: align CL37 AN sequence as per databook
    https://git.kernel.org/netdev/net/c/42fd432fe6d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



