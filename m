Return-Path: <netdev+bounces-131845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD798FB53
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7641C23113
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AF1D172A;
	Fri,  4 Oct 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQdMQHDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE51D14F8;
	Fri,  4 Oct 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000033; cv=none; b=ArcwoggETFTDoIrrV+hcSYi2xxLif+ducC6xP67OjfzzFgwxsmCNdpfFfWW85ZV3BNr3UOywOi1QzOydL/aiPmgzppFnWWaWAm+GnV/Y7SnXPrLRDHZygu3/e0JlgU8jdz3UxpkaaJLTeIMWqHGinA+F5EkhZ84rfHqxbOA45jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000033; c=relaxed/simple;
	bh=ueSNRSxmD08W38+svDnH7878TJqa3DhuX9d0CrB7J6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NnR0bhzJ4l/AhHmt9TvkaYt+ko1KMVDAe1575M5hEmjaS6JgWt9wA5mVU/Jukhds29zKCrueiPqgKk2g70Zjj++eB2iilCnzyVsr0FF3STcK6w9eNoKBKR5eAAUye4OM2jcj8kGyeu9RQiRTD2sxE8Z8YQULSu8utXcU5b8wMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQdMQHDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB7BC4CEC7;
	Fri,  4 Oct 2024 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000032;
	bh=ueSNRSxmD08W38+svDnH7878TJqa3DhuX9d0CrB7J6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQdMQHDPqIPEFIzFo/Dxv0hhK295NsBkpE/p8vqC6zZGgc2G4CzmPAgQ0JiuIMCa0
	 cpwfk61BdZJA/GvnB+X905hhocnvrfBUXY3wC34UYCimpXQDia5caj2WVo1VUbo/Pb
	 tEixVDgLODHhMlzdjZA/fUInqBsjrJTdFwh4i942FavPeqkqY3Z+1k2Dg+Jq/N2MWV
	 9dDTh7fBzW+x/Rkhg70ydgwvCLx9vw4ZkMkp9EUsqZwkfwEFGHroNEtIbD1+6rgu0S
	 J6JQWOsLSIw9eqs6pDT+Qj4lXN0N9mX4cUJuUF9XR4WuCqDPXDtvmNOj9Kz6FZqfWR
	 zzA8jh81CJbGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D933803263;
	Fri,  4 Oct 2024 00:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] rust: net::phy always define device_table in
 module_phy_driver macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800003600.2035955.3359914968807404214.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:00:36 +0000
References: <20240930134038.1309-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240930134038.1309-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 13:40:37 +0000 you wrote:
> device_table in module_phy_driver macro is defined only when the
> driver is built as a module. So a PHY driver imports phy::DeviceId
> module in the following way then hits `unused import` warning when
> it's compiled as built-in:
> 
>  use kernel::net::phy::DeviceId;
> 
> [...]

Here is the summary with links:
  - [net-next,v1] rust: net::phy always define device_table in module_phy_driver macro
    https://git.kernel.org/netdev/net-next/c/3ed8d344e061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



