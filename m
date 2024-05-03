Return-Path: <netdev+bounces-93302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85808BAFD0
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D95B219AF
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373A153565;
	Fri,  3 May 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjShUOQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3715216B
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750230; cv=none; b=gZZoZcwxBdDclegZloMp+rF88DZtLAFG9MjcVPbG4reqeqT7nAhpHOIYkPt7qWgviQO4GCBo1Chcl06agQ2qXTDBBXAXZ59XGlAi5QM8qJyKaeeTmUbK9jmC8bLPqC28N+slTuYRNELMK4TcCTm6hd7RWroHL+LMFqMOEWpHjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750230; c=relaxed/simple;
	bh=Amq/z/53B71sbZeFAhXHa28sXKo7WpNi7gIgjz16hIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cmGgcCmF0BgPxOP9cMQ6RCeQ97x6BIJWVJHlpugkhKf5qqLQ9xWlGEFkN2NYm1xSS3P2g45NflTghDW0+WGjj+HzZKCXuPECBr8ou/Ma7nLcPZ+3ETHTbag3YsfgarldbXRggQkVS5Rp49asFV1OpJhuLrv0x0Z69+H7sEvW3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjShUOQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1330C32789;
	Fri,  3 May 2024 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750229;
	bh=Amq/z/53B71sbZeFAhXHa28sXKo7WpNi7gIgjz16hIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YjShUOQobA3GPtrAJUOB9C6PZqaQUwxwbSfnwiscPgRTpftEnKSOAbkl3WcMO7Yec
	 76UVC5l7BtWV8pz1msPrXaE2roY9tg9BeavCq+ZLbyycaa3tEjjmQDHhdOHORcvAOA
	 eLkDjXsiCGXNT7xhXIJyrLVu7sfc3pCYNqLKHg1460ZH0haCtNtE7IYXE0TqWHaNjc
	 UJ4kD61zm6XlVef923L3s7gYCwDSfda67SEvAWzHpbIAfa/YSJwUiCgsxmhdEH8YLc
	 ouoOKTDbPiqn5Q9Zslq6aAgmGislrAfkT+OnCAsljEXEEcyjFXfW7R6e9U9EFkaCaM
	 UHKHlLdles++Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91789C43444;
	Fri,  3 May 2024 15:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v3] ip link: hsr: Add support for passing information
 about INTERLINK device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171475022959.5705.7723984799352260025.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 15:30:29 +0000
References: <20240429092309.2783208-1-lukma@denx.de>
In-Reply-To: <20240429092309.2783208-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: andrew@lunn.ch, stephen@networkplumber.org, dsahern@kernel.org,
 edumazet@google.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 29 Apr 2024 11:23:09 +0200 you wrote:
> The HSR capable device can operate in two modes of operations -
> Doubly Attached Node for HSR (DANH) and RedBOX (HSR-SAN).
> 
> The latter one allows connection of non-HSR aware device(s) to HSR
> network.
> This node is called SAN (Singly Attached Network) and is connected via
> INTERLINK network device.
> 
> [...]

Here is the summary with links:
  - [RESEND,v3] ip link: hsr: Add support for passing information about INTERLINK device
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c72323d2ef60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



