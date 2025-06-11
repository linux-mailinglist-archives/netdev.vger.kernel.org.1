Return-Path: <netdev+bounces-196479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A839AD4F8E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F853A3784
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718625C815;
	Wed, 11 Jun 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0dFS0Uv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0A257427;
	Wed, 11 Jun 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633599; cv=none; b=m2ChR7sUiGuYkYYJq46lBdMWjx5H0Ul+nZ7CdlWD87ER2QCOW2sT1pz1NFWJh0s9lSrTnVYH1V+Exjtqd7jmjtrDqqHQSxH8LTxZ8srqcpchG7JE7hb1N1VbMT+zI47bakNlU+vHm9oa3tT/+jQMIMIGKtLCQ7Ryw/WjjoqHi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633599; c=relaxed/simple;
	bh=SsjVhZtp25wN95cEhnSvF9ElDiSrEwy9cEtdwpOiCls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dzht+2Z7ZGoktGyKtlrzU0te/mpsC7oAiTumvDHGjOeYhA9AfRyLKLIRIqRDXc32LP2sTEBzb85C59tbOUhcK+U877B8HVAJBqRvvCYSfVnAxLi+8Ck1hYfWHYAxg51WrmeyqxFKBln9IO1s4lrA0IkKmfW7btTm74engkFBZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0dFS0Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4CC4CEEE;
	Wed, 11 Jun 2025 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633598;
	bh=SsjVhZtp25wN95cEhnSvF9ElDiSrEwy9cEtdwpOiCls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0dFS0Uvsxpk9jc8Z531xEvlQetQQWY8pJcLsZnGWTEwdKgVToFeoLGuEszJ5Hi8A
	 mI6SUN6RrTvFX+cKHUg/UX1QeQoDPkpS3YmFJ/H9+GlumNeadg0Q2sV9R3Z0/QrjKb
	 00yV4VDNPMtlwyz7k9LsPiVlglVJbj0V9hC7YKU25F2hVmuFbVNxVoup+j0W7rEquq
	 C2y29M4UEeql3WLwJsv0A4zSH5uw7DEpgGu21wKrQuK1y/0ERZgRXkEkLkBTlhHj1L
	 53xgQ+Z3Wt0O7B3ZhkysJR3wYgDCxVZ/C5CgmiK5fno6sL+oI11SVruhyXfiPzuznU
	 m6EEodgKGO86w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD0A39EFBB7;
	Wed, 11 Jun 2025 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] macsec: MACsec SCI assignment for ES = 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174963362875.3234193.6995089216849003780.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 09:20:28 +0000
References: <20250609072630.913017-1-carlos.fernandez@technica-engineering.de>
In-Reply-To: 
 <20250609072630.913017-1-carlos.fernandez@technica-engineering.de>
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Cc: sbhatta@marvell.com, Andreu.Montiel@technica-engineering.de,
 sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hannes@stressinduktion.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Jun 2025 09:26:26 +0200 you wrote:
> According to 802.1AE standard, when ES and SC flags in TCI are zero,
> used SCI should be the current active SC_RX. Current code uses the
> header MAC address. Without this patch, when ES flag is 0 (using a
> bridge or switch), header MAC will not fit the SCI and MACSec frames
> will be discarted.
> 
> In order to test this issue, MACsec link should be stablished between
> two interfaces, setting SC and ES flags to zero and a port identifier
> different than one. For example, using ip macsec tools:
> 
> [...]

Here is the summary with links:
  - [net,v5] macsec: MACsec SCI assignment for ES = 0
    https://git.kernel.org/netdev/net/c/d9816ec74e6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



