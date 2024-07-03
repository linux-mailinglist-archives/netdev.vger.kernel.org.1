Return-Path: <netdev+bounces-108770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FAD92553A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691BAB20AA4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BE78C80;
	Wed,  3 Jul 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apk2MmmV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070B10A3E;
	Wed,  3 Jul 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994830; cv=none; b=TaLFd3pgn2oXTsrtLnD/pbhDmuk9Bj4Cq7EUkJPVGVAFuIQom6nN8MogGG/ZiZ7nW/FKBoi1fW+fYFfC4qViJEOZ93tzpNTQEFzXuCVgsJXfSrIChgJX9JTltz20WNGy5cLufl6pk+CP0XUiNStf+wUON0PFJ7NIajgfuODW0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994830; c=relaxed/simple;
	bh=viXPB+KN5mQIGD+W6w4r2tqDMk4TlmS7iJ9UlZtlFm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qoz9ZU/PkXwK6ont6j4iGih0xebJ/e/fTFohYBejORG2QjR/0jeU0YgZVbCRaZoGn1dpQZrLpj7MNO6z8tdiCNZ1yqJC34lEsyRrr8oe7WD5PeDH68JK+ptOff2sTEQi3vF2P4nGIEPo5ynBTED3znOgYc6U9by+DNos+TTc7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apk2MmmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1EE1C4AF0A;
	Wed,  3 Jul 2024 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719994829;
	bh=viXPB+KN5mQIGD+W6w4r2tqDMk4TlmS7iJ9UlZtlFm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Apk2MmmVn9sh9RMoI+mrNHIUFT5A4cTKWdg5dgHjyLdU8jxwhJEHcWj9+6VTwilqq
	 D/0Q2KNo3gs4k5srJB3RlwPXbu3t84/CoQh0oLG2XrdDAEWCSSu9AmB14EYWKilmi7
	 b7adrNZb4nUPELlwXrQbuTpqMRhFpWPRQdzwNCqn1VxYYMEGPGE8L8ep12DLNFH8BE
	 3ftJ0TnmMPuoJ9unOFFJBj3jUrEhNWS/S9rdwRusmxkHTwWjGLDegS45c3uc/k5P9+
	 JAbw7Z44Mc8c+gC7gEXQoB3zYGTkK6psQaQ2/F7TMkomw2Lkd69q8kbyxVnushmf74
	 Z6oJTaIff2GfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A083AC43612;
	Wed,  3 Jul 2024 08:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: stmmac: enable HW-accelerated VLAN stripping for
 gmac4 only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171999482965.7447.6028188737402874466.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 08:20:29 +0000
References: <20240701081936.752285-1-0x1207@gmail.com>
In-Reply-To: <20240701081936.752285-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, jun.ann.lai@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Jul 2024 16:19:36 +0800 you wrote:
> Commit 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN
> stripping") enables MAC level VLAN tag stripping for all MAC cores, but
> leaves set_hw_vlan_mode() and rx_hw_vlan() un-implemented for both gmac
> and xgmac.
> 
> On gmac and xgmac, ethtool reports rx-vlan-offload is on, both MAC and
> driver do nothing about VLAN packets actually, although VLAN works well.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: stmmac: enable HW-accelerated VLAN stripping for gmac4 only
    https://git.kernel.org/netdev/net/c/8eb301bd7b0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



