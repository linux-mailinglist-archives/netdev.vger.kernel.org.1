Return-Path: <netdev+bounces-150403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920189EA21F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8881883E4E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAF15B122;
	Mon,  9 Dec 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqFxQAns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2012C9A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784614; cv=none; b=aMo/jLOOQfAqwrJ3SnXhv5uNl7I3pCoBS1Qr0nhjiY6ybEwvRZ6FtpmM3S2gybTCp2ceUpv23X24tJNiksyXqsRePf8d87KVa9elzyd7iCamfdUMOYawMeNJPhkZDkqJEuXA9qMVFNFEhTovkqJbdLqUQjjDetOtc3CsUHITpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784614; c=relaxed/simple;
	bh=EvXuunSej70tQTbBavUWmVTH9qtCU/Tq1C/+qN/K04I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dNI9x1VCjQevhd6315AsieGX7zCWCiMUppLlhh/kPecQX1TpA24c2eQj0SXMrlTZg92mtpO5rpSLJjXmhYPqbx7tsbOHHiE3+6RWSG4sDGOtlm8XQtiJ4wCRvi9kToW1hiE0Z0/ALi+R7q/8bN1rruYC5ACOUb2OH1WgNgt8xV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqFxQAns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25ACC4CED1;
	Mon,  9 Dec 2024 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733784614;
	bh=EvXuunSej70tQTbBavUWmVTH9qtCU/Tq1C/+qN/K04I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mqFxQAnsHWRyO1Dqg/8LJ0xSNr7fX+1o9Ba/3rYLdruakVzO/y6N4LVH7KJ/oFPAd
	 0SM73UmK/rBsIS1w/tNIJ086wiS1hoQHhCpB+98Ew3ZeK2t/DdDXk8TxwqW2WFmH2u
	 z6Hcao261Su5ZQNhne4x6TXSGfkpUpOMes38JpP+PtaFcPj6GS+lPnarddrHUNLxF6
	 F6Su/2+BT7DGcW8jvBly1uScsqTrGWbBjTwqOFg5Cgpdt6p3JzyGyZ1jFpP2V9DiEc
	 PSU/te+pe6T3Z7+TB8donVfEM8aWLbZ1d/2JmA9BZpeY9cqgsSL+LQpGsEI3W2PubZ
	 2lSBm5Pqh004Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF209380A95E;
	Mon,  9 Dec 2024 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: dsa: microchip: Make MDIO bus name unique
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378462952.265624.12702407324036578690.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 22:50:29 +0000
References: <20241206204202.649912-1-jesse.vangavere@scioteq.com>
In-Reply-To: <20241206204202.649912-1-jesse.vangavere@scioteq.com>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jesse.vangavere@scioteq.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Dec 2024 21:42:02 +0100 you wrote:
> In configurations with 2 or more DSA clusters it will fail to allocate
> unique MDIO bus names as only the switch ID is used, fix this by using
> a combination of the tree ID and switch ID when needed
> 
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
> ---
> Changes v2: target net-next, probably an improvement rather than a true bug
> Changes v3: to maintain ABI, only do the two part name when the cluster index
> is not 0
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: dsa: microchip: Make MDIO bus name unique
    https://git.kernel.org/netdev/net-next/c/ca7858880590

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



