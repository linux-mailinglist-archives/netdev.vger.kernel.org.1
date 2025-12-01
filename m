Return-Path: <netdev+bounces-243065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4CC99256
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95FB4E29D0
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB492848BE;
	Mon,  1 Dec 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzW94nFe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635B2848A4;
	Mon,  1 Dec 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623595; cv=none; b=RcApwRlbZyCx7aiTLhl8vy9D74QsELRqthKSWd0TPi0xijZp0rK1d30NK+XHdHwlzVkbXHIahZ+Ae1xNT0TVwlgJ5bxLVDL3E2niLrPb2g+c5SmIITxSQO51AxQfiHTPbD7VKUP/cirPM0xFPSe3ie5+7AwywRNmlw7ONvH7bUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623595; c=relaxed/simple;
	bh=alCTcQluu+L0ZBPFjhtp8GkMPj31UpMHXoYwlY70EA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tnwgp6Cpeu0mKyLeGaEbtuCreFLb3EOwbPx6MHZz7a3r98rqsO3QYQafbSZFjlHG+GGh2C8Ef0lQDQtLYsbeXdiZbqikD+bM33LC1jVgxltJHi9y3pshPeBt76c1ENrEdGLItGyQVg4v/YOjTt5qneGw3Y1R6rvL5dR/U5Vq7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzW94nFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89515C4CEF1;
	Mon,  1 Dec 2025 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623594;
	bh=alCTcQluu+L0ZBPFjhtp8GkMPj31UpMHXoYwlY70EA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FzW94nFe8AzKq8Sp7TY3/mc4TH/+DowJrGouQAKjpi4PACKB7r4iv4UW3JCA012g0
	 y3wclMc465s/eB3lHG+m12mg3v/0htZfgn9BzZ/YNqljR6+OlW8SJ6kQopZouZd67r
	 jo9M8dGJBBIrUI4jOs6Yijlpcm7m8P0eqlfFWMSxgxmUe/MZO8Ozav2V38DOFvrv5f
	 r+cwEKDY3KAxToxVXSS1XkxEpZSo+2BIlE5rkBORWHk4XC9IEyOyDavYCfD673FQvM
	 DZdQS1JppALLzr/F39dQIfAdu8lKaUuKQGp2/40eTnlfjxxkYTYuPNx04evExloQwd
	 VEEkrY79E3OIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B590C381196A;
	Mon,  1 Dec 2025 21:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dlink: fix several spelling mistakes in
 comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341428.2539359.4401989672794830061.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:14 +0000
References: <20251130220652.5425-2-yyyynoom@gmail.com>
In-Reply-To: <20251130220652.5425-2-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Dec 2025 07:06:53 +0900 you wrote:
> This patch fixes multiple spelling mistakes in dl2k driver comments:
> 
> - "deivices" -> "devices"
> - "Ttransmit" -> "Transmit"
> - "catastronphic" -> "catastrophic"
> - "Extened" -> "Extended"
> 
> [...]

Here is the summary with links:
  - [net-next] net: dlink: fix several spelling mistakes in comments
    https://git.kernel.org/netdev/net-next/c/40d5ce4af206

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



