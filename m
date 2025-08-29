Return-Path: <netdev+bounces-218372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A3B3C3CA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524AC5636B2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2332A3C4;
	Fri, 29 Aug 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="58sUxyqJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C324A11;
	Fri, 29 Aug 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499365; cv=none; b=KDrsRQmGieI4zbli7wjBxTinnmn+HtfqIP9ggqS8YyHOwnZUt3mTyT1kWvMAaexCoRI4ZsrxQhGz+HpxrTwtS/qV9fejdKJuiVgk+kJVwhOpOjYkzvZkd6AcxQt4TQeybDG2AKtM8TPRXwTCDTrUR9Fd7HvAbZXCbqUkCJpMqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499365; c=relaxed/simple;
	bh=AMLA6d3C0PIuutYGZ+DzXaU/OpSZ/1KsUe+SUs1nDfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/4LBek84tQ+xgbMJ5HtNJABnCtmnnHKYOyJCMs7zH0S9tJxF03ZohkTfCpXk0NRSCx/zgu8yoZkXoH9Dw32Sbh6tjgS+HNJZDyp9n//7KoGxHJBoAwW2vV4DC72YlXB06Tdw8zBX/7SBf7ayYYHItzR22h2xdd/Gv8ZW84CGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=58sUxyqJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DXcbRx/NAviKdAFr32evPhO45ja7AxzeOWxSifbKFvs=; b=58sUxyqJHNYG51t91dNOpgjgA5
	HCvv0JoGO/IjhdIvfgjwPWoc6lltltcF0imXEwQxPlC7Hxigq/s+3bNOM/ecHXXtnBCd6ZEVDgRPF
	daPHHSA9jEHvm5omJxSZnJ+5xhD+ZzQQX9d2eXLbYQpoIttu2jZjaaeG0TUMN3nDcZVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1us5ir-006WPm-RO; Fri, 29 Aug 2025 22:29:21 +0200
Date: Fri, 29 Aug 2025 22:29:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <d296ac31-35d1-4436-8ddd-14ceef02264c@lunn.ch>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829124843.881786-3-jchng@maxlinear.com>

> +#define MXL_NUM_PORT		4

> +	if (of_property_read_u32(np, "reg", &priv->port_id) < 0) {
> +		dev_err(&pdev->dev, "failed to get port id\n");
> +		return -EINVAL;
> +	}

So the value of the port_id/reg does not matter? In device tree i
could use 42, 1024, 65535, 24?

	Andrew

