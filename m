Return-Path: <netdev+bounces-94346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2A8BF3D4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607561F23A4D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF4438F;
	Wed,  8 May 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cryy5ikM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AB622
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129429; cv=none; b=KC0F04pVFEtL2EZinCR8J3l0rkWMU2p9hIwnSc+oIMBsOjw5vdrNmlOZUy8fnwlO3V48RsaQrTdageJnmbMgmkC8QaZ/yaNoQ4uO6qiubiFIzbGuD3vbR44aYJkwyUq9XifuJSba1qexdiFh5moMmWZEfszRz8Ka9YXKL4S0B9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129429; c=relaxed/simple;
	bh=OZPDe84Q+9JZxtvV9AQ2Ixd9PO6E9WbI7KANR2DoEGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIaNE7T03fkDi8S2/dcTEFErdof5HXbruSXDS8TMLDSvgRDAyWyuKJPMSKpGV2W/h3KKPtJG69StPZ234zzvqnEckUnivm81QmT66QVouJqGJSEXEV/dX4c59CzXZhTEqafOJDUcmBaqmAbwwEjop+QJk4mRaazVl3MxU5HkgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cryy5ikM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1832AC3277B;
	Wed,  8 May 2024 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715129429;
	bh=OZPDe84Q+9JZxtvV9AQ2Ixd9PO6E9WbI7KANR2DoEGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cryy5ikMdUNaLLPe8flWIt1LcRPzBNGdmwuyUsfbS8VvXmyPU925pv3xE5+gqXqSi
	 jPok81UUArSaxrFiuAQ9wE043N7a/mMTcLYXlRLaFXFR1rYqqi6cINnXDLmJPQSJ+d
	 eDskYjCoY8qcrioVmz+SVCTRIoqaqGjNiiNtbl+Up5xaRZkqWF4lJwv1Pl8y46Ce8D
	 xo+k50QfAzLl/3vLSVwgYGFqrwiVUMOigWHfT44eQC13Ik1lXG/hjc+9ACVzgujuSs
	 tukHdIY5HEebNJJUlOevbkeomcWSeITt7RMmD3sWEr6lU17SAzbGmmqXoXfUBvmswR
	 F0+1ouG67HAhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0230BC43614;
	Wed,  8 May 2024 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] usb: aqc111: stop lying about skb->truesize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512942900.28907.2087875185752822551.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 00:50:29 +0000
References: <20240506135546.3641185-1-edumazet@google.com>
In-Reply-To: <20240506135546.3641185-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 13:55:46 +0000 you wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> I replace one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
> stop lying about skb->truesize")
> 
> [...]

Here is the summary with links:
  - [net-next] usb: aqc111: stop lying about skb->truesize
    https://git.kernel.org/netdev/net-next/c/9aad6e45c4e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



