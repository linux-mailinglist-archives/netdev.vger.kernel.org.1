Return-Path: <netdev+bounces-119055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB93953F11
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C27E284F18
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B22209B;
	Fri, 16 Aug 2024 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+KJRsXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41B1D69E;
	Fri, 16 Aug 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772797; cv=none; b=JyZfgXlbdg6GZVZuXQSMiTB0rrrDhB2sEi/nC2ni9f08blcEyanxaBuVs9CUSLUNx9HDQeSIZArmS7mP6zyGdk75gAfppW6T7p6HWhZTCmk6/gPuE9eH/HVeHfm+9D1JcnZjaefJ+4C/yz9N7UNvCgg5fImkB3MZIqclyX5ai3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772797; c=relaxed/simple;
	bh=W5RlR6IOzzkUiWZtCi1XNt5G8fjNo236VeXd2ClDJUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC8txRlaHLwhz2AAODji31rrVyOUbuUW/TnY1XQ8PynuB2o+78OO5tz+lKbqxN01zc1LWmY7keP5gbSClUoJm2Cgg2/y6V/XjvkLqO4bjBrT+9C04z9WN+JqfpLhgFxYWLKTUjoHxQA0ABI8s1YyXmQggeSaahZqKJrk2PiJ1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+KJRsXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C338C32786;
	Fri, 16 Aug 2024 01:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723772796;
	bh=W5RlR6IOzzkUiWZtCi1XNt5G8fjNo236VeXd2ClDJUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+KJRsXYRlCEjPXztVWNO/Wi3OJBvrB4jPzXZhFLUWzKKazBRaw63hbuQEVd5xZCG
	 +MEGurA+ZDBbfZJqEAA6RbMsmhL6RnEIR5j1vcPUUg5s47AcESqlIq6uS2NJy87tYU
	 Oa9ZB1aM+N9VX5vERk6GfHXMJa2UlnZqyAACHcdoh4xszAXVHQ9ovdNuel2H9PHyty
	 xBV31wdoNvrPxFlNxoKeb5t3qoexY51ejvfbRtAVVf0893WjPsvYw5Jfhnw+C4bWyl
	 4oCyd9LY65pKhhU4LQs20tnPWm4CfmQaB0gbOHyw23wYbMrwxE6OX1E56M0uz1MEHP
	 v0/tAYrrOlokQ==
Date: Thu, 15 Aug 2024 18:46:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v27 10/13] rtase: Implement ethtool function
Message-ID: <20240815184635.4c074130@kernel.org>
In-Reply-To: <20240812063539.575865-11-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 14:35:36 +0800 Justin Lai wrote:
> +static void rtase_get_drvinfo(struct net_device *dev,
> +			      struct ethtool_drvinfo *info)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
> +	strscpy(info->bus_info, pci_name(tp->pdev), sizeof(info->bus_info));
> +}

This shouldn't be necessary, can you delete this function from the
driver and check if the output of ethtool -i changes?
ethtool_get_drvinfo() should fill this in for you.

> +static void rtase_get_pauseparam(struct net_device *dev,
> +				 struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
> +
> +	pause->autoneg = AUTONEG_DISABLE;
> +
> +	if ((value & (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) ==
> +	    (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
> +		pause->rx_pause = 1;
> +		pause->tx_pause = 1;
> +	} else if (value & RTASE_FORCE_TXFLOW_EN) {
> +		pause->tx_pause = 1;
> +	} else if (value & RTASE_FORCE_RXFLOW_EN) {
> +		pause->rx_pause = 1;
> +	}

This 3 if statements can be replaced with just two lines:

	pause->rx_pause = !!(value & RTASE_FORCE_RXFLOW_EN);
	pause->tx_pause = !!(value & RTASE_FORCE_TXFLOW_EN);

