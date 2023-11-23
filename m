Return-Path: <netdev+bounces-50409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C357F5AED
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C471C20D01
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FD208D4;
	Thu, 23 Nov 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goCwzSna"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698A200D9;
	Thu, 23 Nov 2023 09:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A423C433C9;
	Thu, 23 Nov 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700731224;
	bh=8IGKCYsnSETnn3Su/i4LyUDmYpj8U4of5nf7hwILPZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=goCwzSnawoCJHWsTdYaMuROCmDofS5EZPgmrjnQ7gMbcYGurvvdYAlbZmtIxFuwFD
	 CIqQt5AAcXhuXhOMSaXpV2tm/X8Qn0pOhjYus4e4FA85Egpr5QMiEU6cK030MmSSUH
	 ovLlfc8sCWJ9bodarOzflHFjWA56VruXhvQZbv+f6y09JK4iACRPGub487JWrP1aFj
	 G2gk7cPphOUryPF3qcOWGu6yTMnEtYlib+wQpbUxF08sWN7mMF/ccXaejcVE/1jF5d
	 mPKJiJYnx8vMWbEp8K8kOjF5YZplAyLjV8MnoqFQY6P73R5zkfkc1NlszNB5IF3koq
	 /9aL5of2rkXlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7946C3959E;
	Thu, 23 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] usb: fix port mapping for ZTE MF290 modem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170073122394.3388.4958521926651372286.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 09:20:23 +0000
References: <20231117231918.100278-1-lech.perczak@gmail.com>
In-Reply-To: <20231117231918.100278-1-lech.perczak@gmail.com>
To: Lech Perczak <lech.perczak@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 18 Nov 2023 00:19:16 +0100 you wrote:
> This modem is used iside ZTE MF28D LTE CPE router. It can already
> establish PPP connections. This series attempts to adjust its
> configuration to properly support QMI interface which is available and
> preferred over that. This is a part of effort to get the device
> supported b OpenWrt.
> 
> Lech Perczak (2):
>   usb: serial: option: don't claim interface 4 for ZTE MF290
>   net: usb: qmi_wwan: claim interface 4 for ZTE MF290
> 
> [...]

Here is the summary with links:
  - [1/2] usb: serial: option: don't claim interface 4 for ZTE MF290
    (no matching commit)
  - [2/2] net: usb: qmi_wwan: claim interface 4 for ZTE MF290
    https://git.kernel.org/netdev/net/c/99360d9620f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



