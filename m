Return-Path: <netdev+bounces-125998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9496F863
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB61F261AA
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039C1D2F53;
	Fri,  6 Sep 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qfQYEv35"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B68381C2;
	Fri,  6 Sep 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636977; cv=none; b=haPfjuTqhEMrCSK3z0WpAEge1tJXAR2iznwPqp6fGqhj5pOU2xn/yNOaAiI+AYdhYYv9yNSQBs4DzOJWQo7kVHzTRGpd2/WcvKoVOvelsTI1KbE6ZHbAyr8eB35mif2QKjywZgNJo4+aEDeHYK+SxF/gCrXdj1+fM0ATkZZrXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636977; c=relaxed/simple;
	bh=vAhjjqS/0UsGP0/uvhAuky3LmJr6aC+upFMbT7xjyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXCuf52LTwXemaVirjGUqUtkah0l3QWEe0Jl8FcuPZWaoi66/gCpWmSybADb5gOBEz1MYpoV5bRvfLbSJQ0MxuA//R4eB3EYssLEldJK+FRUB6LuqZ8mo/fJPcGYwDwGj7CIeJrMGCEnZTiaSA438xCBGRJby1PgM+0BxTmffVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qfQYEv35; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2+WKnimQsFK+zPHj0woFi2wVgy2O5JuFVOmn7XkTkkU=; b=qfQYEv35Z3VUkqaxdQnUv9wiPC
	pKwPXc5k6BJ5VJebF1gCcOsEdBDQO8HTbfJrM2nErSS73/dyuBpisdSXMSussKD5pD8KcV+iPRNV5
	NnnCtvGmdWaflNEw5pAZS5tOAghMvSvSNEAKoHfOdjJa5CrbYVZ67HkJlwyyrgxQ07hc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smb0I-006q2q-3a; Fri, 06 Sep 2024 17:36:06 +0200
Date: Fri, 6 Sep 2024 17:36:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 1/2] net: ethtool: Add new parameters and a
 function to support EPL
Message-ID: <970ef9b1-609b-4137-a76f-315c99fbf112@lunn.ch>
References: <20240906055700.2645281-1-danieller@nvidia.com>
 <20240906055700.2645281-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906055700.2645281-2-danieller@nvidia.com>

> +/* For accessing the EPL field on page 9Fh, the allowable length extension is
> + * min(i, 255) byte octets where i specifies the allowable additional number of
> + * byte octets in a READ or a WRITE.
> + */
> +u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
> +{
> +	return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
> +}

Does this get mapped to a 255 byte I2C bus transfer?

https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/net/phy/sfp.c#L218

/* SFP_EEPROM_BLOCK_SIZE is the size of data chunk to read the EEPROM
 * at a time. Some SFP modules and also some Linux I2C drivers do not like
 * reads longer than 16 bytes.
 */
#define SFP_EEPROM_BLOCK_SIZE	16

If an SMBUS is being used, rather than I2C, there is a hard limit of
32 bytes in a message transfer.

I've not looked in details at these patches, but maybe you need a
mechanism to ask the hardware or I2C driver what it can actually do?
Is it possible to say LPL is the only choice?

	Andrew

