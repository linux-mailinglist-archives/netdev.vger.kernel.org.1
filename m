Return-Path: <netdev+bounces-170909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA8A4A82B
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9293B4F9A
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392D1B3927;
	Sat,  1 Mar 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beSDEJ1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C9179BC
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796803; cv=none; b=hV6W6kyN7n8JTQmeUFO8hm4Ws5O0i0h9sY6Apd0uk6shJu/5u+6XcSs6YQI4CPE8DhcwEKh9lT8bPWmxnNOxi4gYyLz0Eqe59Ofrakbf+SP5N3Q3QOlnFswEf2pNkBTojGKefM42xdSWXXdfCcdFlUyFIZewxxDf3K/RzjjZTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796803; c=relaxed/simple;
	bh=xN0q4+o9KepXD5D2up+MeLOxPgfFJl7+Khy3LfIOcS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j780ucsjE1u5KdWpL10X0CwWvUXoir6Ko2qKIQj/g7Dd2uQRmu1E8bwOgwiTLnd3JjDRGhM+Syb15qgMMN1qpg9+1mJ68D7952MbMS82pJKCgs0rmRWCgtlEKFi0M7jVnqWutWOmXCxgh6LCnHVeaN2FmkR9bMq9ErWmA488J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beSDEJ1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C1C4CED6;
	Sat,  1 Mar 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740796802;
	bh=xN0q4+o9KepXD5D2up+MeLOxPgfFJl7+Khy3LfIOcS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=beSDEJ1VZU4A2ZKM5cEKt+b+tzPRHNLuPYzSrka6a8PYBtXr4mN83vYAEfxhpEaxc
	 Yjs28a/T+6fOeOuamZydQsjWcB7R9s7JhWvFIRv/LENdjjbbPdciaqweJQa16Ln/fc
	 ACLaV3c9XqNaGMRfQbG3+ZjlfYfdpdMNJy5CfuMZsBFfUK24aenFE1p9bRbBHa4Pr8
	 PKQqO/znp9gDDCJaaUR7koA+te/H2BGAqlZhnAEeq1opznnrl8c0R6/RblIFeThbrC
	 n4k+J4BAKniZWZwgxT7iAiQxk1QKGezDBXsVxERxDRi9l43DRDMSk2BK9QB6Ah2afX
	 sazubjrWaZy0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD6380CFF1;
	Sat,  1 Mar 2025 02:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Add usb net support for Telit Cinterion FN990B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174079683499.2344768.10303435891063822435.git-patchwork-notify@kernel.org>
Date: Sat, 01 Mar 2025 02:40:34 +0000
References: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
In-Reply-To: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@mork.no,
 netdev@vger.kernel.org, dnlplm@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 12:24:38 +0100 you wrote:
> Add usb net support for Telit Cinterion FE990B.
> Also fix Telit Cinterion FE990A name.
> 
> Connection with ModemManager was tested also AT ports.
> 
> There is a different patch set for the usb option part.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: usb: qmi_wwan: add Telit Cinterion FE990B composition
    https://git.kernel.org/netdev/net-next/c/e8cdd91926aa
  - [net-next,2/3] net: usb: qmi_wwan: fix Telit Cinterion FE990A name
    https://git.kernel.org/netdev/net-next/c/5728b289abbb
  - [net-next,3/3] net: usb: cdc_mbim: fix Telit Cinterion FE990A name
    https://git.kernel.org/netdev/net-next/c/97fc68636376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



