Return-Path: <netdev+bounces-187843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EEAA9DA2
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F13189D767
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0626C3AC;
	Mon,  5 May 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERySrEhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215E1EA7DE;
	Mon,  5 May 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478633; cv=none; b=LWp75IY0zAkOaLRd01mmFDpdkok+0A77c+C3oK093naA/5vKRc0uWIR8V2qUQBL4XmqQBQD8PvzPPqbO7e2ixUwkS5Iz2xpn51a5Om5nPUEFPtrcqfJjNtbuh0O/EKfCS7CtJvZBtLBzrG/EVPlJvvTx5t35BZ1eYy38fTcCGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478633; c=relaxed/simple;
	bh=Dmzf3Z0ahnejagf6WsFXTesHMfb1g5ns+BwkAAG7v+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5JH/d8IWldKq5EtGyp5FG9AeZvVbMO9T5h/j38R1CB2WHO/Q8GTfaP5elppEV4rv9bl0UztYH3qvAE0OoAOZcC1kBO/JzdcDf84lbAeT2wVy3BQX5pO4F1mJBXkSI2L9sCH147BKEb79YrtfADWJJi2UhJYdKNCpOOv7XCrF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERySrEhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0ECC4CEE4;
	Mon,  5 May 2025 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746478632;
	bh=Dmzf3Z0ahnejagf6WsFXTesHMfb1g5ns+BwkAAG7v+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERySrEhp9W6kHdWmu/h4FcNpBM6hN/198rHph4Fg/Q1QTS7Abn/AYpiFtEWi1ID6F
	 NNvF/HxxfiEjoSJ51HOLRLHImQmdl+i246Ae73iJNiRoOJ2cDIau1jNIjbRa4O96+Z
	 8MwerszjenYekhkms25X0VmjaC+XAEE1qDd8kG8+j3gnGis6ScG7zL73LqFFBYuc/z
	 Z+BPpXc3aseYHxNakvpK1nrt01BcXs3W38s/TnSP2iGyH/W4KWHXmQAiAcCjiHHq3b
	 3VHBHvyjuNNxnhS5mR/8qxhO9e3HvSKkwYwnApIXgvWmM8LhOKm0zgACDHK9rOeU1H
	 /AKhEmQSEgJWA==
Date: Mon, 5 May 2025 13:57:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
Message-ID: <20250505135711.742cd759@kernel.org>
In-Reply-To: <20250505142427.9601-3-wahrenst@gmx.net>
References: <20250505142427.9601-1-wahrenst@gmx.net>
	<20250505142427.9601-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 16:24:24 +0200 Stefan Wahren wrote:
> The example of the initial DT binding of the Vertexcom MSE 102x suggested
> a IRQ_TYPE_EDGE_RISING, which is wrong. So warn everyone to fix their
> device tree to level based IRQ.

Doesn't build on x86:

drivers/net/ethernet/vertexcom/mse102x.c:535:10: note: did you mean 'led_get_trigger_data'?
include/linux/leds.h:544:21: note: 'led_get_trigger_data' declared here
  544 | static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
      |                     ^
drivers/net/ethernet/vertexcom/mse102x.c:536:7: error: use of undeclared identifier 'IRQ_TYPE_LEVEL_HIGH'
  536 |         case IRQ_TYPE_LEVEL_HIGH:
      |              ^
drivers/net/ethernet/vertexcom/mse102x.c:537:7: error: use of undeclared identifier 'IRQ_TYPE_LEVEL_LOW'
  537 |         case IRQ_TYPE_LEVEL_LOW:
      |              ^
-- 
pw-bot: cr

