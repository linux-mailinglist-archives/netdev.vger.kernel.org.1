Return-Path: <netdev+bounces-164267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA0A2D29E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EB67A43B8
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43D145323;
	Sat,  8 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhefwuZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292913EFE3;
	Sat,  8 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978205; cv=none; b=YBqp/fKiqV36+aBnmCD2vJRjF4jt+P2/dVqpHGIx0s+A0CV23ETyIrKhqV1kKETslgvQoSu5/TJkSnzULYodUUDq7qbZfFSikZKUKiEfNpP3bMa7agQp7OaYWX2127PLw+3CAsJIS1Yw8vIgaoMKFIiKv9IsCYfNzx3lnAcpVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978205; c=relaxed/simple;
	bh=poTwbNNcvJo7yOumtiBpv0VMWfCgxArliv+22wWXbLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CgXNt2eYXvjpoDWaGoAFJatT0nDPT4ulOuHDpZymHT+yT1aZJoUWkbBUkLlHqFdWT02uIwwrqmHdRdCnh/gBPUccPpJCoOomGYTMHroUjy2hYko/J4N3DDurqMjsI0+ZkP9x2VgcT5MO9j4+zJocshcbm1JtkHJf6+p6WglVGtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhefwuZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC2C4CED1;
	Sat,  8 Feb 2025 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738978205;
	bh=poTwbNNcvJo7yOumtiBpv0VMWfCgxArliv+22wWXbLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QhefwuZc7A4lbT7zPyfR1ahcmIcf6sF//LICLfIg3hn7XaUAwUpkUovcuoIRvun5K
	 D5qd+11GRz6yVXFeAcYbVn32gfCzFPud6SXqUxrJwv6m46xZf4WL5lgwzrmFwqTGAK
	 uhcfdoKc952mKdtDLMZ4fFgSaEZrRxUHZUThavx24cxyNgOOqPuqGJD9XdAdXAcod9
	 GRVrCMNO/0QHs5a2eExLf1VSlLJCfOGcFpIh8V+w+jtKNtNGFFBaG+x13+RQ87V79U
	 v8xBN/5czHDt/TvO7wyPdlTnIRudtyCysT94W9pUQmOuM8eNsBpRJmMkbJbKULtcrV
	 PAhlnMB3N4Udg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3422F380AAEB;
	Sat,  8 Feb 2025 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] Add usb support for Telit Cinterion FN990B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173897823305.2448842.1940161492015126627.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 01:30:33 +0000
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
In-Reply-To: <20250205171649.618162-1-fabio.porcedda@gmail.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@mork.no,
 johan@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, dnlplm@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 18:16:44 +0100 you wrote:
> Add usb support for Telit Cinterion FN990B.
> Also fix Telit Cinterion FN990A name.
> 
> Connection with ModemManager was tested also AT ports.
> 
> Fabio Porcedda (5):
>   USB: serial: option: add Telit Cinterion FN990B compositions
>   net: usb: qmi_wwan: add Telit Cinterion FN990B composition
>   USB: serial: option: fix Telit Cinterion FN990A name
>   net: usb: qmi_wwan: fix Telit Cinterion FN990A name
>   net: usb: cdc_mbim: fix Telit Cinterion FN990A name
> 
> [...]

Here is the summary with links:
  - [1/5] USB: serial: option: add Telit Cinterion FN990B compositions
    (no matching commit)
  - [2/5] net: usb: qmi_wwan: add Telit Cinterion FN990B composition
    https://git.kernel.org/netdev/net-next/c/9dba9a45f8ca
  - [3/5] USB: serial: option: fix Telit Cinterion FN990A name
    (no matching commit)
  - [4/5] net: usb: qmi_wwan: fix Telit Cinterion FN990A name
    https://git.kernel.org/netdev/net-next/c/ad1664fb6990
  - [5/5] net: usb: cdc_mbim: fix Telit Cinterion FN990A name
    https://git.kernel.org/netdev/net-next/c/9e5ac98829d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



