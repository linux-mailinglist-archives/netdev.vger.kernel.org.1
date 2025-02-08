Return-Path: <netdev+bounces-164252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4DA2D238
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0418849A1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A61547E7;
	Sat,  8 Feb 2025 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S64Hl+vP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E371CFBC;
	Sat,  8 Feb 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974701; cv=none; b=oIQ+GeoBroDTwyI2bxn7vaha2DTn3w29K2CFvlg+J8jVzxFaNjCpH6MSy7yb1yYlBUPR1ZcSXAq6titVux3HwQtAqW4bUoBiV6dVOMkBZ611qY4epbBIhBbEDMuJJ/K5p230qpVhDJ4nuu50Nk0nXZx0ZEfraN5XqrGbiY0dcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974701; c=relaxed/simple;
	bh=cc2dYe5P57m6NvP7002AV06nlfHegdYaT4xSz16lJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+d+9hCNuwT2zsYuCQ25HQB6m1TCU0n5mi7vWhQ5JcSBnl3gzUg4qkUcVkUHi4ejUkHEeV5EuUrHu2Mabr3V6dOOTwyHNFDvUEGN/gNP3kJjkqDWaIja21xmq7H3fL8WbNwl0GZafwDpxSqm/8OIp6cun52BKZfB1aqtTcYuXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S64Hl+vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0D0C4CED1;
	Sat,  8 Feb 2025 00:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738974699;
	bh=cc2dYe5P57m6NvP7002AV06nlfHegdYaT4xSz16lJfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S64Hl+vPFVpG1r/AiehRyENiIcy+MI3q/IHg7y+LXKA8cemrRfkwRi83nZ7VfHFgf
	 njW1UBrv867UT0Wk914rOPE5wZc8gBe+F9qVoXgrhfyP4hgwhEWXuJFyEHjzSR2tl1
	 JT535qgMgSzH1AslNOsWZQxR081na8SKz2TFaHy2o+j8WX0CEcNkRvhBwNDVBsfuu6
	 lxi18hjZmfxtdLVkNCO3aw/bU6vv+Nb4/WCJHDzT7oUeTC2YENRJ0ENdfLR16H0SXa
	 EHuzn5rjYHtY5w7F7sg89j/WqY6xvWFCmSVqJuJmmqIAfLqVW7OZu7b1EkcUvkCnY3
	 6CuU7GzVhnupw==
Date: Fri, 7 Feb 2025 16:31:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: phy: Add support for
 driver-specific next update time
Message-ID: <20250207163138.0af87fbb@kernel.org>
In-Reply-To: <20250206093902.3331832-2-o.rempel@pengutronix.de>
References: <20250206093902.3331832-1-o.rempel@pengutronix.de>
	<20250206093902.3331832-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 10:39:01 +0100 Oleksij Rempel wrote:
> + * This function queries the PHY driver to get the time for the next polling
> + * event. If the driver does not implement the callback, a default value is used.

Please don't exceed 80 char line length without a reason.
-- 
pw-bot: cr

