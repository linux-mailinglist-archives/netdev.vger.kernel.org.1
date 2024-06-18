Return-Path: <netdev+bounces-104469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813A90CA0D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0106B1F2131E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068C19DF93;
	Tue, 18 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+kLIm/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786819DF78;
	Tue, 18 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709029; cv=none; b=HSSCh6aew3mvgSfIvk4xBwoDXxr/jIbgCoVlzFV+AY9TiIrVz+iDxkp6Wlmw3rwRV4RtTayf+97W1/B7ujK7uwUapJw1Dvnd6H4UxT/+kIh4j6sh2pcMMLNyjkvWsfxq+GIyFrnRb6d87tGQXnICcpCZuqdmwIW1vvS0VqNYOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709029; c=relaxed/simple;
	bh=ZnuUGO1V5dgAr50dQHqP8zamCWt5ncuEUCcFdKnzkxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G39/ZfGzJKZ+vFSbzlnwrT4Hvw2qtLPIXuW/Ry8bTPCa9lJEiivzOZ2vLCHL95NgyfT0KQZYkLbcFyC4Nyya1w6SQC+tPHcRtCstxec8jQntipK+g9Mf/uaETJiO4j159PGnEkS6BlHq7zTmPLzE5R1qV3Yc+kPqH9lCU4kPv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+kLIm/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47FE7C4AF1D;
	Tue, 18 Jun 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718709029;
	bh=ZnuUGO1V5dgAr50dQHqP8zamCWt5ncuEUCcFdKnzkxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O+kLIm/DLWpPpvc2nsol5s1ELTii1flcH8DUMQcQ/o+KsDTIYT5DBr6NFNP7VP9WD
	 V95bIV3aMlEoUqXx3S4GUd/CfEhJDEDjt44gXbd3JFLodjn24q/Ty+kthNOGTCaUjK
	 MN9zrcCN2KjIBh2S9TMmF0fYjwyreLatg/eMr6FEx9R/z+Wg03Rywn4grGRMsFiYiE
	 TDKXKkDyMElIghxJlY3qRvaJSo9rh5Z4dltfJV/l7ILFRkEE0aNfDjjGf47OjiR90K
	 gOt7ko9bJe7RaVDba/Hq9+BkbthrLK6rzwYtZyV8Mk6Pz9HEEEIgb9F4GNa6OwtaLk
	 BsqyGoXE7w3bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B72CC4361C;
	Tue, 18 Jun 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: stmmac: Enable TSO on VLANs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171870902917.19855.10479250301779213025.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 11:10:29 +0000
References: <20240615095611.517323-1-0x1207@gmail.com>
In-Reply-To: <20240615095611.517323-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: linux@armlinux.org.uk, edumazet@google.com, vadim.fedorenko@linux.dev,
 davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 jpinto@synopsys.com, vinschen@redhat.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Jun 2024 17:56:11 +0800 you wrote:
> The TSO engine works well when the frames are not VLAN Tagged.
> But it will produce broken segments when frames are VLAN Tagged.
> 
> The first segment is all good, while the second segment to the
> last segment are broken, they lack of required VLAN tag.
> 
> An example here:
> ========
> // 1st segment of a VLAN Tagged TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1518: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [.], seq 1:1449
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: stmmac: Enable TSO on VLANs
    https://git.kernel.org/netdev/net-next/c/041cc86b3653

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



