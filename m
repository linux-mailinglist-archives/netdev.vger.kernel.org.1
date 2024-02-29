Return-Path: <netdev+bounces-76151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89A86C875
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970671F2251D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB97C6D2;
	Thu, 29 Feb 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnYTRkWU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409D7C6DF
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207428; cv=none; b=nkgzO3FkOCLOE9uGfb2Mv2ccjRnip67efnAOG9vuu1L+Bg5wGv+FWJdIb76+fOVaEtnNCHa3ne2qoQpbWIWJSqMeAoJBTvDFB99+kPsrFGPvTHlmUQou4pkrlElCw7PVYmB5F+5AgWnHiYCf0jSFx0x8e82fZK/PSO9y641gzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207428; c=relaxed/simple;
	bh=lTty7I1uKhlNpAl22AtE1pus23YId2H4Hhio+4y+U0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Er5ZDqYXVbimJtjJSykT5+cfabfkdZjX3LNv6B2mT8AKRhYtSVaaq6c85S9EydmDbi+ZRqbVk3IFnRRLfLOnuLE65HyjfZn0UoQTJ2iCmGM9205Emgjg3Rjh+utXVpM78jKtZTUcu/J4fHgQIhV8WOlRa+dnOCRsnrmJOfO4Mac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnYTRkWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07FB6C43390;
	Thu, 29 Feb 2024 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207428;
	bh=lTty7I1uKhlNpAl22AtE1pus23YId2H4Hhio+4y+U0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DnYTRkWUcSlwtaRb6MAKnhb2VNEbSqk9AayMu/c8aQ1IqtkLPlGTH8tQ9NVscHQSv
	 OlhxD5tT3hix6OsdvLtNj1Q7Gz+8ddvuudwHw690povMEO1fNISen3wKg0HfgRM1LB
	 0NH7I8Me4E+8L40YqNGdmoZOh2+A7Bz2d84cTfnFlxYaTmJ6lOKOI8k09i4HiuGoji
	 7CcP6Rr2AlycUxpujhGWsUywInfPDJUFBKQlMCSIq4aTu0J2MAKdFIkJDT1CGtxg4P
	 qHz9LACIoKlURpmtmv7vtg3ht4ZAwzASvlnOy78O4lKhDy2lbEgjBIXvyAdoEHYglG
	 /zIbS2UGP9uqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0359C595D2;
	Thu, 29 Feb 2024 11:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170920742791.15837.13508831976047731905.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 11:50:27 +0000
References: <20240228112447.1490926-1-siyanteng@loongson.cn>
In-Reply-To: <20240228112447.1490926-1-siyanteng@loongson.cn>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, kuba@kernel.org,
 joabreu@synopsys.com, davem@davemloft.net, horms@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Feb 2024 19:24:47 +0800 you wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> Drop fix tag and pick Serge's Reviewed-by tag.
> "channels oriented" -> "channel-oriented"
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/39de85775cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



