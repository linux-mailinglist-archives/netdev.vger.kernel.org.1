Return-Path: <netdev+bounces-217112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B1B3763C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2813A4C92
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE401D8A10;
	Wed, 27 Aug 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/8LvSDj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C41D7999
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255801; cv=none; b=civC1gng0yiUcXNRYxw1Y74NpfTu9BRHzWpNSiHWnwjq1g4sS7HcFr2BM7N47M4XvNNSSv89O9Is9ZeZRa6EKaVtWKua8zkZ3H0a4bIrqG/gIhRoxSOO56AfTGFPnQEXafRoHzI9888up714BIqU7mBdJrf76QI9mGcjJ9t5pYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255801; c=relaxed/simple;
	bh=B3SRdIN02Pxv1O4V3Fd23ECXzCnVkejV5Io1RO6Wp14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PeMU9bTeGN138/g7CQAdo8UVdaTN6FHqR9l/Yhk5pvbX/s/AB4hEP9pEs0PCWudGCspw2dn31/faXDgx6EkXT8FYlo+AJGrC65Velb+tqJP5idGm32zJZjBv5311JUBJk/g3UwS+8Ddmi6u7xitsPT1D5CAAeOK9Fbuft9f5wj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/8LvSDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8799CC4CEF4;
	Wed, 27 Aug 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255801;
	bh=B3SRdIN02Pxv1O4V3Fd23ECXzCnVkejV5Io1RO6Wp14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/8LvSDjXZSk6UvRzY8jjyETKImCjiDHsAuWOt5IiuX27q+uBjYGvVyTzUoGNatE0
	 QAZfXmQ01SlE9ZxU1CRWyJCEO3E+KLtGdKLKbptlE68DgPKkp6kOleXwU5GXchCoFO
	 8rhF2r9yb0Y6DQ6F5gJBCpU/Ba/sCpkZX9R6yJZcBh0Bhs0vVPz6P3a2LA4DVxCHeY
	 VluxrTpw0aQ2JQS7xBvNy5F1R0L8XdFf6eJ1wlA9dUsyIzlr5nb9RnpZn08yThXSJt
	 AXOM1lWv5YjqvikOSZCcRpmqMLgpddVyn2TewO0P9WNnbWj7N7Zwso5TWbFPKjbKdv
	 SPEuDuXvguUyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58CD6383BF70;
	Wed, 27 Aug 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: retire Boris from TLS maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625580924.152740.12043158310910790931.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:50:09 +0000
References: <20250825155753.2178045-1-kuba@kernel.org>
In-Reply-To: <20250825155753.2178045-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 08:57:53 -0700 you wrote:
> There's a steady stream of TLS changes and bugs. We need active
> maintainers in this area, and Boris hasn't been participating
> much in upstream work. Move him to CREDITS. While at it also
> add Dave Watson there who was the author of the initial SW
> implementation, AFAIU.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: retire Boris from TLS maintainers
    https://git.kernel.org/netdev/net/c/26c1f55f7ec8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



