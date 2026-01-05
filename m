Return-Path: <netdev+bounces-246935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB10CF2723
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2F43003046
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577E313534;
	Mon,  5 Jan 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j2Po/Xi7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592B3321C6
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601802; cv=none; b=IVsuNJbhDHbJhnQphjOlC3QMdQUm6PASaW2JcZMq0Be1dxu9Pf5pF4gCnxAe187RWJWZ2U54vOJeS6Co/4Y+Va4VbK7V2YRlAw/54HTw84QHkkzffzDpUdrXL0JM552Qcwws7y5k0N2w61058wkc+Z1fGqm2RhYeFutcJ9IIu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601802; c=relaxed/simple;
	bh=nM8EVblwSLdQyTQHyIHtfKOw93Opm3ygP22WtcRkBAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H261Epm1I6Fakxk4dzFgePO5lHeVUDyiRFWXzCINojZQpCTA8CmnzNhNc2QpW/aNDbu+rhEWlilKQefKQAiGzk1oBqQsL6TbQQp4Lv+C8/y3yjPRpeyQVf1hRelJauYZsZFxat/SqP3Ju1evbsq0gmX/bq2IdNWt2hKCnZ1fp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j2Po/Xi7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE5E5C1BEBF;
	Mon,  5 Jan 2026 08:29:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FBA760726;
	Mon,  5 Jan 2026 08:29:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A55B6103C8493;
	Mon,  5 Jan 2026 09:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767601788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DfsJgfq89NcdpaxSqnEswlB210yQtbFw+8vJX6OV+MU=;
	b=j2Po/Xi7b7InYmhDQ+4gVMhiOr4oc5xuzhX1PRVP553JgwOpUuEyPmE3c9sb1TwhQFqC+3
	13nRAUxWapXoj4O1Qah7nsadUusRWyZWdRMtZNZFZbOw1AdD8nbcM65eg2i3Wy3uCTfjcW
	0Rrq4wndXLGaLCLvTsOUMDI7J4b5iBri/fGQ/qnRC+W//iewhXTMODXvgmPCLVKEojBol2
	/1y/A0yaaTCl0MAmR6LO+5mN4tCNffQhAGES+nS//THb+4zq7lrXyesEbr+jU6HAEg742v
	ssr843qWeYS7dqHWkDYYpxvbSxnnU41B7oUVzqWrmeGz12xBOOlaoudkJK77Rg==
Message-ID: <29295127-e54f-4954-8a63-03289c113a1f@bootlin.com>
Date: Mon, 5 Jan 2026 09:29:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sfp: add SMBus I2C block support
To: Jakub Kicinski <kuba@kernel.org>, Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20251228213331.472887-1-jelonek.jonas@gmail.com>
 <20260104080534.769d4f87@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260104080534.769d4f87@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi folks,

On 04/01/2026 17:05, Jakub Kicinski wrote:
> On Sun, 28 Dec 2025 21:33:31 +0000 Jonas Jelonek wrote:
>> +static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
>> +				 void *buf, size_t len)
>> +{
>> +	size_t block_size = sfp->i2c_block_size;
>> +	union i2c_smbus_data smbus_data;
>> +	u8 bus_addr = a2 ? 0x51 : 0x50;
>> +	u8 *data = buf;
>> +	u8 this_len;
>> +	int ret;
>> +
>> +	while (len) {
>> +		this_len = min(len, block_size);
>> +
>> +		smbus_data.block[0] = this_len;
>> +		memcpy(&smbus_data.block[1], data, this_len);
>> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
>> +				     I2C_SMBUS_WRITE, dev_addr,
>> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		len -= this_len;
>> +		data += this_len;
>> +		dev_addr += this_len;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> AI code review says:
> 
>  Should this return the number of bytes written instead of 0?
> 
>  The existing sfp_i2c_write() returns the byte count on success, and several
>  callers depend on this return value:
> 
>  sfp_cotsworks_fixup_check() checks:
>     err = sfp_write(sfp, false, SFP_PHYS_ID, &id->base, 3);
>     if (err != 3) { ... error path ... }
> 
>  sfp_sm_mod_hpower() via sfp_modify_u8() checks:
>     if (err != sizeof(u8)) { ... error path ... }
> 
>  With this function returning 0 on success, these checks will always fail,
>  causing high-power SFP modules to fail initialization with "failed to enable
>  high power" errors, and Cotsworks module EEPROM fixups to fail with "Failed
>  to rewrite module EEPROM" errors.
> 
> Either way, you'll need to repost, net-next was closed when you posted.

Looks like I made the same mistake in sfp_smbus_byte_write(). I'll send
a fix for that/

Maxime


