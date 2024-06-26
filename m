Return-Path: <netdev+bounces-106714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC968917561
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4168D28255C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE86B64E;
	Wed, 26 Jun 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdVaOVLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245C33DD;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363633; cv=none; b=XkSPseTe4sOerNrx1OGd2A7pZ8PA9VHakkx6lIphUN93wRXuYHBLvleBXHFn9qRZ3XDh4zZ/AP8qUtVkFH9dOMEsCwrc1KaZqxeqNoA7x0xqEe48g0o/rf8KpfeTuBp2XdkI1fIRBviHmm2JnKGY9f00jZQPwoDOYyrVh2wW4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363633; c=relaxed/simple;
	bh=gpUPtrAJh+6J5oR6dtl8bHUoF7ypTcfE6JUr36MyO3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VoRn4I7LLqd/C0xmADvt57MwXtWkAXBsGHhmx3uPDyqaEN7hKKju994iyhoS+F10XJFQ6KIZN1dRb3M6pYd3UEP3j6ZtHIcnSXrThsI2loG/R6ix7nH7b2P2ley7tBOLN0lT9Od0/W63jfRbLPI8MW8yCzmqzFykUkeNVa80Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdVaOVLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A72C3C4AF0B;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363632;
	bh=gpUPtrAJh+6J5oR6dtl8bHUoF7ypTcfE6JUr36MyO3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdVaOVLnRk9qKF1Dpx1thAwkpJQ5tazsEM6CA8bCxBZhUT+ytBzcYGLM4v2xIfDmg
	 Ygqat3nHrp9NgV67yNlx5PmSNu493Jx7VqlUXNNOQoSsDu8ax7GDvCxoyHT3KaHDEO
	 XlkoJc3/2Tx6tDPN96wSCHtNGsDc7kfVsE6kvfXgAJ/wHROYefSSVrIhyp6OEVeGM0
	 irvOMVXeiMwz2OgfeewduYPv2RFXjUc35HRMKC2hEW5YzC1LofhrPWjvaLvidwJbgN
	 lQUX3IaErccsWJRg+ow2a6KhdZgwVWrKXowbimkWpTlqtP83OtBmgnpFJh9EL3bvgn
	 ewMJoF78brFXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DE4DDE8DF5;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936363257.31895.7020799709212449758.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 01:00:32 +0000
References: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 09:18:57 +1200 you wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     I was referring to this dt binding and found a couple of places where
>     the wording could be improved. I'm not exactly a techical writer but
>     hopefully I've made things a bit better.
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording fixes
    https://git.kernel.org/netdev/net-next/c/c0c68e4d52ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



