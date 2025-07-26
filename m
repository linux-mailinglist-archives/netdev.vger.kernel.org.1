Return-Path: <netdev+bounces-210251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAACAB127D5
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAD0582D35
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02852645;
	Sat, 26 Jul 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRv8iQJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15C747F;
	Sat, 26 Jul 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488589; cv=none; b=PlT4Isd5TC1FGFPoV9W5OjyzMrpYWqAAvRxy+bjuml/5ptMclPjx88DyyTZav++lxzlC8zPso0FsAYjNjac92YrviKZ9LSwV+ZCQSwTxAvKTyomnpD+kRrbd+1J+jq0h5h1JczUgIjYMkgz8Uj8pWkMD69BNgnbfYkReAdLSBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488589; c=relaxed/simple;
	bh=nwyoOPQGUi0JLQynVVdWam4Kw12SpVNUpo9ZaA4uy7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qnmHtfKr65JJXwXwe8C3vOf2zfHQlrPP1vFI2rqjv+JR+NG5Wd96q2FVjtk+zSuZjCCVOvyFwXkymD0dcP6Wc6vie+TNoDwAOf6W3rTtuMaV7Sf46wfp8vCBTBy/bqCscnxutz+AbnwhoNjBptXmuNrgGqCilfcGs/S8iZT6GU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRv8iQJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A390C4CEE7;
	Sat, 26 Jul 2025 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753488589;
	bh=nwyoOPQGUi0JLQynVVdWam4Kw12SpVNUpo9ZaA4uy7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WRv8iQJ5A+ZLK3IPj93apemMC6VHgarhlnvqB/wPqJP9CDfhXpZYI17dH0eU3kydS
	 hZ+TM3vs0bC4ayvCq23Zv/Sn0ReymaqMRGNP6T5OhdnjsWXuL98y671sEEH4iQxO69
	 GjZSgfSsGf5bs/U/Cu1uz5ak2A9OeSLh2srE3uXxTgXGn+vwcXlUBgmTCuAJ5/zTWv
	 /Bz/hyo1ZDFO7aHvSt21jcZWSEazz6xTjZ8IGlOhd6a7h8tdDsWg5hWt3u9IbemIl3
	 TElbYsL+OflMHhQWvC/Z1bZzHRvMqXsUqVISCuQIMAd+oS70Szv8TXgDjvK/LFoXEr
	 ilbCc/1UhffxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC9383BF4E;
	Sat, 26 Jul 2025 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: peak_usb: fix USB FD devices potential
 malfunction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348860653.3454240.14640633468593276215.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 00:10:06 +0000
References: <20250725101619.4095105-2-mkl@pengutronix.de>
In-Reply-To: <20250725101619.4095105-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 stephane.grosjean@hms-networks.com, mailhol.vincent@wanadoo.fr

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 25 Jul 2025 12:13:49 +0200 you wrote:
> From: Stephane Grosjean <stephane.grosjean@hms-networks.com>
> 
> The latest firmware versions of USB CAN FD interfaces export the EP numbers
> to be used to dialog with the device via the "type" field of a response to
> a vendor request structure, particularly when its value is greater than or
> equal to 2.
> 
> [...]

Here is the summary with links:
  - [net] can: peak_usb: fix USB FD devices potential malfunction
    https://git.kernel.org/netdev/net/c/788199b73b6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



