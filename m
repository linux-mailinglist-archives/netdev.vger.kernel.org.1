Return-Path: <netdev+bounces-162784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16CA27E39
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85C37A0551
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B034E22069B;
	Tue,  4 Feb 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKq6xaN3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1421C169;
	Tue,  4 Feb 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707625; cv=none; b=A+Abw6y6nL9+9IxxlKeqA2pkfz1ZzdAOZRH1Cs917HzWb/A7hK3NPHZS4mJWU/Ovdu948eppZm3/2K/6XkDmZ2k4r5Ypte1KohS5mnqmQbfEGYlScfdGjRy304eAi/yI0iOsxM0NC/Nrw5baX4cO0fxsthgqGVKHVw4qFPOzqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707625; c=relaxed/simple;
	bh=kaw6cgOUTM9KPTIv88oifCw+4REp8CklrsH/gTqpVfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zt94ma36adfVbZ2kE9v1Y8UvIRAU9gCiVQrb2Zv7eWAHxLnt9SgSdXxY8/KsDgzRdqzm+goT41YWp3P4MuS2TEfjuF2kogHQ3E+5jSphc4th0kKU4fFc7t80uZ2P/wfXEvlquLDxA+ut4ZI/oMs4kzoULdCucrZjZ8pT1k3/ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKq6xaN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F792C4CEE6;
	Tue,  4 Feb 2025 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707625;
	bh=kaw6cgOUTM9KPTIv88oifCw+4REp8CklrsH/gTqpVfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JKq6xaN36XLIFAuVia0vbfYoeoSdAJwL1CyCliooSatwNLeayIjljQ4Jiz4JItYpy
	 elqHv++Rz47juNwn00g9/3nplgo+BTeW57BBuXd/zwu1ASr7v+tU0nKrUmF6B+eKJg
	 f3Sy3nGQkINGyqZcc22Ndrwh4Ghne5ZH/BgP4cm0YNnw1z22LzkCiIqWVyDxtO/vGt
	 LxEiENQGr6BatDtfuxT6845dsi9Dg9wcApKw/yNbF0nV3spVrBtQAPvA0td8nYf9Gm
	 7KUtlskLDhVe3pOySpcavcSPeR8rV/S0eGmtDBWukfc/+u/5DjFWoCZPSw9D9F1nw8
	 dMuYVTKRZSMNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBABC380AA7E;
	Tue,  4 Feb 2025 22:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/1] Document phys modes for ftgmac100
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870765249.165851.9575732706417528074.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:52 +0000
References: <20250203151306.276358-1-ninad@linux.ibm.com>
In-Reply-To: <20250203151306.276358-1-ninad@linux.ibm.com>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 09:12:54 -0600 you wrote:
> Hello,
> Please review the documentation changes of phys modes for ftgmac100 driver.
> Initially I sent it with follwoing patchset:
> 20250116203527.2102742-2-ninad@linux.ibm.com
> 
> Rob Herring ACKed it. Andrew Lunn asked me to send this patch separately
> to netdev.
> 
> [...]

Here is the summary with links:
  - [v1,1/1] dt-bindings: net: faraday,ftgmac100: Add phys mode
    https://git.kernel.org/netdev/net-next/c/ac335826115d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



