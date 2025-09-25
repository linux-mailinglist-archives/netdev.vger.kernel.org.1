Return-Path: <netdev+bounces-226140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE614B9CEBF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046723B4173
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C72D8797;
	Thu, 25 Sep 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlBVio2i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF382D8779;
	Thu, 25 Sep 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761434; cv=none; b=gpedhQt9vbYmj13AmZmyOouDqncEWdSVhGVw2rhMvDySck9FXCJ69jzQz19xd1+9OYfWhQoXfueee0fKPOsARoOwzqvxQhKlP/93IWbSPzlacFLTdx7EK27vO1IH0axf2xLVSVwvdZiOxKE0ysDmpou6bLFbJhFIe4E6Z/mnD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761434; c=relaxed/simple;
	bh=XOOkukC4VBKca5IOF3g1gxbksVfqEtPDXKSOv6aZJ6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PitrURTSRJfs/5waFyqkiS9LjRDDV0YKSWd5uArFeRCL90nXy/QVOiLfGVnE3qIU+19nIEhc1wVDNbugqiPcOo7c32i9EnRhvLgt1pfFQcI+hFAKCan7YkWI0kavlgiDA97b4BRfBgE4Bf7avK+mNqKBUHo5H2Di4lc6csXREzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlBVio2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71153C4CEE7;
	Thu, 25 Sep 2025 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761433;
	bh=XOOkukC4VBKca5IOF3g1gxbksVfqEtPDXKSOv6aZJ6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VlBVio2iMgXvqEyLcf41FZ2CNuk7hIoesYpzkCBN+fzY49feMVpOKOIghYuviyYEM
	 Bbb9qNTILFHLmb0Cg89PVJd0XNOu940IBX903KNSnk2OYi9Le72ej1scmkjXkmRlpN
	 IabmxMccz2P2dQ8j4gkUlcpxrW32Bx3hFneVS0VxfjJbIcj7XKa1omhSbknfYr9q9N
	 nlxCYnQ8Sn9LLQ2tuRrUQ18h2o/Rc+YFnErrGc1PjcxO81SmJy3BwfQfRyS1HWf491
	 FeSPHdIotQcp+uWRfl9Rw0YYmZrXq99D8yeAEMrAfdKZMsSdN3s/BJP2h14sxBFz8/
	 JMlHQHE0LDkuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB239D0C20;
	Thu, 25 Sep 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: ethernet-controller: Fix grammar in
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876142949.2757835.17340441622511646948.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 00:50:29 +0000
References: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>
In-Reply-To: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>
To: =?utf-8?b?Si4gTmV1c2Now6RmZXIgPGoubmVAcG9zdGVvLm5ldD4=?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 01:10:01 +0200 you wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> "difference" is a noun, so "sufficient" is an adjective without "ly".
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: ethernet-controller: Fix grammar in comment
    https://git.kernel.org/netdev/net-next/c/1d7e08325090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



