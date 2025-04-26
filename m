Return-Path: <netdev+bounces-186207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D8A9D718
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C763A3B044F
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A381FBCB0;
	Sat, 26 Apr 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5U/iCMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364113B284
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632796; cv=none; b=LAAHYLK1ChSd+ceBRGN8EB6GTiPo8hynKQr3Hv3IKwUIAyiAjtYrkT7qe4QkMx+2Vwwjd3hwB3JaQJfAXldmre94Qa+KYKifsbcyJ5cOgFKSsjeePzc97948x+0n13czlv7Mg/xIJKTVhh9AHVu/I8T3/9+7JkUih3Cu0hF9MWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632796; c=relaxed/simple;
	bh=axwjTGApOQznOGPOLxYu8WrzDXRn333522328/b71yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l60b8RImiwkA6lRTgcCG++sQVj3Vr5k5oqEuJ5XnGy6LHQM3XTPgarOvZi+uvNIxl499uGVhdlEbqeSMLN4Mjv8Hg92+5R8vSDRlst5yipAkDoL6tga7MmL3JPb91gQ9T9WpwUfkRa/pp+uTu92XfuKuZAjyF8e1O59lr6WdH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5U/iCMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8938C4CEE4;
	Sat, 26 Apr 2025 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745632795;
	bh=axwjTGApOQznOGPOLxYu8WrzDXRn333522328/b71yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i5U/iCMKa7FLpwpCfrLBl6hj0+mbnECl+RyDoFyfZSJ3xcL5TD9ZfYVZvTHsvMskV
	 Zlg8a3JO+wBUwi7P9ZwMYbuFpVOk19mjT/SmkDYWnEhaJad4oTD60YDcI+Y5+rWLT5
	 yz+YDL70tgBxqDH/cY1ANyhGMWa2ZvMGwGaI1U4N8qmMqo14pc1SPZU281XL6YDG8M
	 nQsf0nvy37bBAiyVMW2T1s+7OJ5haIUhFUst4rs5aTXz6jXWlPJh+LQebCGw1yUsT0
	 HBCx6hB78GSKmbnkh/nfb5nWPeGhGjsEiVfW8gcqDN7tscRMyKFGNzWbIylXkbzRPM
	 o6wM3bQslqbZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF4380CFDC;
	Sat, 26 Apr 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] bnxt_en: improve TX timestamping FIFO configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563283450.3899759.2131906517381338560.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:00:34 +0000
References: <20250424125547.460632-1-vadfed@meta.com>
In-Reply-To: <20250424125547.460632-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, kuba@kernel.org, richardcochran@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 05:55:47 -0700 you wrote:
> Reconfiguration of netdev may trigger close/open procedure which can
> break FIFO status by adjusting the amount of empty slots for TX
> timestamps. But it is not really needed because timestamps for the
> packets sent over the wire still can be retrieved. On the other side,
> during netdev close procedure any skbs waiting for TX timestamps can be
> leaked because there is no cleaning procedure called. Free skbs waiting
> for TX timestamps when closing netdev.
> 
> [...]

Here is the summary with links:
  - [net,v4] bnxt_en: improve TX timestamping FIFO configuration
    https://git.kernel.org/netdev/net/c/8f7ae5a85137

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



