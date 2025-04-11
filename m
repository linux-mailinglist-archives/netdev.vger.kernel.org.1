Return-Path: <netdev+bounces-181843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B962A8691E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCBD7B6C75
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99742BE7B1;
	Fri, 11 Apr 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exrq3fMW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5632224888
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413741; cv=none; b=vFge7gOzos/7rfh4gGoYDHMUwVkcdjqO+xx8wN9qcd51cfKdDwt/jtu0vdZf8G92sXuExEEnTwzEJbIUg4cxvmjNSOAcG+eD07RQtAjsPFi6AWcjn1VlhSRb3Pzt7Ygf7PvPXmbOD7Ep+8bFjB9zkIogiDIiIER0aXzYxgW9hU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413741; c=relaxed/simple;
	bh=DPhfWcVjDy4d8+rsrA3A537wIKKFgczgv16y1yG8/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK+Z0mOJUoeIqzJUIqMZcEaRHvpeh1z1w1QVTdH6ueuh/qEIOB88hHfsoQ+NAtFHpYF63zLgd8LfnS1ETW/nlwEShCtPhnK3omJOAn+oQeqbmFMes4J+KsBQhzljRKCbbECmw/AQZhKOUS01ctU0dLrb6z6Uevn0HHy9avJCUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exrq3fMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3AAC4CEE2;
	Fri, 11 Apr 2025 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744413741;
	bh=DPhfWcVjDy4d8+rsrA3A537wIKKFgczgv16y1yG8/TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exrq3fMW7I5UBEd0+9JRmehLTgaTYJerZg0ueapmjcEBk6hgjyARCESXKY8R4t0/6
	 zWTQvpQE/Q/z3R1/+YZC44PUfm3rIMbe7oHXYtt7TeQn0FwX5JZMTxjxjfGkZRjVuq
	 +9wAjus05Pq9K9iiy7KRmewRSyXWVqrEX3HOXRkU46Tmg4hQTQ5osgecs6WlMTzEz3
	 /+GtYcM3HwBK9qDf+bmHAaDq7tvgRTLjsWxq4FAZAb83qFosjy0/F/b01CP0al1HKY
	 DxnLkF1kTx2ko5A67hoGcGR4dB1sWUZj9elhGEek+nzJfp67LyYvbMMe8fwsz1wKU0
	 ObDuVN4UZ8Eew==
Date: Fri, 11 Apr 2025 16:22:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dlemoal@kernel.org, jdamato@fastly.com, saikrishnag@marvell.com,
 vadim.fedorenko@linux.dev, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com, rmk+kernel@armlinux.org.uk,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/2] net: txgbe: Support to set UDP tunnel port
Message-ID: <20250411162219.13a0ed22@kernel.org>
In-Reply-To: <20250410074456.321847-2-jiawenwu@trustnetic.com>
References: <20250410074456.321847-1-jiawenwu@trustnetic.com>
	<20250410074456.321847-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 15:44:55 +0800 Jiawen Wu wrote:
> +	if (ti->type != UDP_TUNNEL_TYPE_VXLAN &&
> +	    ti->type != UDP_TUNNEL_TYPE_VXLAN_GPE &&
> +	    ti->type != UDP_TUNNEL_TYPE_GENEVE)
> +		return -EINVAL;

Why are you doing this validation?

> +	switch (ti->type) {
> +	case UDP_TUNNEL_TYPE_VXLAN:
> +		if (txgbe->vxlan_port != ti->port) {
> +			wx_err(wx, "VXLAN port %d not found\n", ti->port);
> +			return -EINVAL;
> +		}

And what is this check for? Is the core code calling your driver with
incorrect info? Please don't do this sort of defensive programming.
This patch is >50% pointless checks :(

> +		txgbe->vxlan_port = 0;
> +		break;
> +	case UDP_TUNNEL_TYPE_VXLAN_GPE:
> +		if (txgbe->vxlan_gpe_port != ti->port) {
> +			wx_err(wx, "VXLAN-GPE port %d not found\n", ti->port);
> +			return -EINVAL;
> +		}
> +
> +		txgbe->vxlan_gpe_port = 0;
> +		break;
> +	case UDP_TUNNEL_TYPE_GENEVE:
> +		if (txgbe->geneve_port != ti->port) {
> +			wx_err(wx, "GENEVE port %d not found\n", ti->port);
> +			return -EINVAL;
> +		}
> +
> +		txgbe->geneve_port = 0;
> +		break;
> +	default:
> +		return -EINVAL;

Also pointless. Unless you can show me in the core how it could
possibly call your driver with a table type that you didn't declare as
supported.
-- 
pw-bot: cr

