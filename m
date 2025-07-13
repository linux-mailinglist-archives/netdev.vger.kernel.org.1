Return-Path: <netdev+bounces-206465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58606B03343
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887301899900
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B341F463C;
	Sun, 13 Jul 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZecI6n32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FB1F4281
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752444585; cv=none; b=gsaObPDRbLP2NsqEZQkMPyBkVdG1/lSOAOm1SXiINgQUPgWB/DcIja5xBo1074ae90FYZ+R78sTiOaMCLZRTpvbNlAphebEFXu4Ebsr9cKHXEYK698NamtaRNLXYbmR9KFSl8GOyJy8Buf1IDSbNmMMppuiDab48awdCnqPdils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752444585; c=relaxed/simple;
	bh=4/Hn4Ek1LsTJKaAhWzyF4LrgYmv6a6EuBgionMAqNwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QYcYYXVjistzFs93P3aygtcjvv8m8XCTglQd9fXyluWmp9DwAQj3fziGXJwb7tsHcstsQV4xza3bkK26KGIh8GTO8YXWTDOJEzI7Qriz6M/B4ckbDGrPVSoT7TI1J1QmkjzF4F51GbAZ7cCXqHjiJBWdWN35SzUHFBNP7UPUFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZecI6n32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAFBC4CEE3;
	Sun, 13 Jul 2025 22:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752444585;
	bh=4/Hn4Ek1LsTJKaAhWzyF4LrgYmv6a6EuBgionMAqNwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZecI6n32+kdUDcTwZkeJAnisgAWHePiUDKQVR6xC8kU7Nzpc8QNegkQO47gpOSObd
	 +wsSAilW70Rh6N8j6pZr4B9wm96JtcuEAfJvRaUhtXU5aUe6BwZSYYHdW8K4YZ6sdA
	 OGRGVKoKPSoQffxG0iGdQFqKD4pvXFwl6BvK3Zla1W+dCvZ+C+J9Zk/TYLGhs6AI6c
	 stp5m27PpR4ReNj/yu3Gqj2+1aw8XSKJpqgu0RndI1ibji1ZyCxlM6PHuygvrB7j9+
	 QWLmtItZ85KndikYJTo4xO4qtKkwmYBIC9KZmCFjzgO8WxjiuMF462TtBK9biRlIzI
	 S5KNQjtJ29KDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB9383B276;
	Sun, 13 Jul 2025 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: default to --process-unknown in
 installed mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175244460626.3219791.17572556806588847270.git-patchwork-notify@kernel.org>
Date: Sun, 13 Jul 2025 22:10:06 +0000
References: <20250710175115.3465217-1-kuba@kernel.org>
In-Reply-To: <20250710175115.3465217-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jstancek@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Jul 2025 10:51:15 -0700 you wrote:
> We default to raising an exception when unknown attrs are found
> to make sure those are noticed during development.
> When YNL CLI is "installed" and used by sysadmins erroring out
> is not going to be helpful. It's far more likely the user space
> is older than the kernel in that case, than that some attr is
> misdefined or missing.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: default to --process-unknown in installed mode
    https://git.kernel.org/netdev/net-next/c/b06c4311711c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



