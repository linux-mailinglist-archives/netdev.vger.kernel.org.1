Return-Path: <netdev+bounces-88234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B548A669D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CB5B2496B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D31F19A;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzJppfI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757184A5F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=LFVcZMtFRSplGNNBq0Bg3byHtn2V5cGwpzGUzE7dZzv3lG3FOgYAmtibaq9cvD624pB1gGAH1+AA+sT11opt6fSrJPeGRgKqdV8+JIxxyJKcfE6sPmNtSs/ohl5yXvy7LIU6ylpknMNqN2qdLh6L9eKDm+n4M5MlX4fqKmpdsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=vDFwBbHNajlZAfcVvPf/2hIljjdEjtTX1H9CXe9tXVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sI88kze5+7EBWctFtc2tMhuoplN3gUmp7A4FDLY6XCSiIBZxXvwVRHNw321iI8vCvnWlaJEhOrLbAvlAPznCXUB2tGI1zkA/E1l+itK8CnuPp88qyRByCSJFjFit+c6Ib+T8ZV34m1PIto606/RsI0YxKGivGXvKYHxZ2xriqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzJppfI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 362A2C32781;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713258029;
	bh=vDFwBbHNajlZAfcVvPf/2hIljjdEjtTX1H9CXe9tXVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzJppfI9pMfYfJ2fmNrK76/EQMGlT1VLV4b1NXG/wzaeHhv2rxn/xYlyOG1C1+HpI
	 tbH0g51tLISEST55OmSG8a+oxuAlifSlMlbSaHl5kI2MttRdm/VAgpIke0lrIcJvmR
	 Di6TmfwJzsrmN6vfB176kQP7E0ChU6qo0rRzy8AnTfaZemtgRTWQ576cE/lvj4/690
	 AAGQTEHXL4PVZevkghQEDZ7xRggDiE2frxWwhsYDQ11mvxOYOLwHjekv4O7lUJXHab
	 orZaLW9TiQE5lBpMvr+tj2AwoihADHBZkhhaO4KXLWU7gifTkTr/epprTVNJS1PaCO
	 u9uA4ol7LGKFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 278ACC54BC8;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: lantiq_gswip: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171325802915.5697.14066625366040400848.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 09:00:29 +0000
References: <E1rvIcj-006bQo-B3@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIcj-006bQo-B3@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, hauke@hauke-m.de, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 16:15:29 +0100 you wrote:
> Convert lantiq_gswip to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c. For lantiq_gswip, it means
> we end up with a common instance of phylink MAC operations that are
> shared between the different variants, rather than having duplicated
> initialisers in dsa_switch_ops.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: lantiq_gswip: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/94c437edce65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



