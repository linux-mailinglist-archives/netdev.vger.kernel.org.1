Return-Path: <netdev+bounces-128117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7320978124
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AF51C210B5
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FCF1DA303;
	Fri, 13 Sep 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YXIYAXdS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73D1E505;
	Fri, 13 Sep 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234138; cv=none; b=R2R69hl+li9xIcFg6bWjnFD3WDkpsLw+G83hEkfy5UmDr1lVg+pp+EJDz839L3kGHlzmP+qEze/dSAleN4jiSvsnwKAAXtSadIXB/V43IqH6IObJN80g+Ry+ly0pqkgb/jEbFm1Zxni07EcVXj3V5lf8ItR/Znxz/kZkFVu3Zy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234138; c=relaxed/simple;
	bh=1022RRP340cRSO+QVAi5rBGD8u532BHjh5z/sB2SsCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwRtuSuDuzkmf9o4PlAi52XjFz+rNMqg5adPXJKwOI6YY9/S2lviFeTo4UhnHDvEx7tPJDUK8xVCOtr7lcCPD9/UDe7KiousH56E3OvqMfPC6trzNzEfTtI6383trnJ81hdB00XKPS5OWmQwk/cWwRcYVb6ajW0Un5SRTMIpoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YXIYAXdS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EZKyoq/h0g2UuxIPKNChZBl6fkVdBQqin7H4RfFUCmM=; b=YXIYAXdSofv+yeaHtTWBwSNg8m
	+NnU8R7VyZwmuol2iMiQYicoPZDfxjdUuc1pDVr/EkQnTkWHx1nTV1QxUkCVJAKZUy3o/xBmuDMRZ
	3/A5m4Z6vEVPcfNsA7Aemeh0kOAgUn5xFe2956ulPAOfggW0l/Wq2WF/4y7mPkz7hDRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp6Lq-007Ob0-K0; Fri, 13 Sep 2024 15:28:42 +0200
Date: Fri, 13 Sep 2024 15:28:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanmanpradhan@meta.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net,
	horms@kernel.org, mohsin.bashr@gmail.com,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add hardware monitoring support
Message-ID: <29cc431c-0020-4546-8658-6f06d84aa84b@lunn.ch>
References: <20240913000633.536687-2-sanmanpradhan@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913000633.536687-2-sanmanpradhan@meta.com>

> +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
> +{
> +	if (type == hwmon_temp)
> +		return FBNIC_SENSOR_TEMP;
> +	if (type == hwmon_in)
> +		return FBNIC_SENSOR_VOLTAGE;
> +
> +	return -EOPNOTSUPP;
> +}

> +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct fbnic_dev *fbd = dev_get_drvdata(dev);
> +	const struct fbnic_mac *mac = fbd->mac;
> +	int id;
> +
> +	id = fbnic_hwmon_sensor_id(type);
> +	if (id < 0)
> +		return -EOPNOTSUPP;

fbnic_hwmon_sensor_id() itself returns EOPNOTSUPP, so just use it.

> +void fbnic_hwmon_register(struct fbnic_dev *fbd)
> +{
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
> +						     fbd, &fbnic_chip_info,
> +						     NULL);
> +	if (IS_ERR(fbd->hwmon)) {
> +		dev_err(fbd->dev,
> +			"Cannot register hwmon device %pe, aborting\n",
> +			fbd->hwmon);

aborting is probably the wrong word, because you keep going
independent of it working or not.

	Andrew

