Return-Path: <netdev+bounces-293165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNslDsvBGWo1ywgAu9opvQ
	(envelope-from <netdev+bounces-293165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2D605D10
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E26C3045C92
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263A3CEBA7;
	Fri, 29 May 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jzGnlnXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A53C3442;
	Fri, 29 May 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071499; cv=none; b=ggSvSC1QjtluW42LG4awOB9/PwlZcDawxEkSgLQ2qye5TJNIDXyv5+1jBDwP4Y0cxLfzn6nHgWMs2qiLqdX6F7rMz7wKyEGtRBoPs+Y3EJLL0GHUrNF6qliyOCbfp63tpykPSlvSC5RQyXpmzUzTvnwFA6HektBiCe+Q3evnHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071499; c=relaxed/simple;
	bh=LECw0sDPeJcrBgMMcO8z7qr7lxvWA9UJU0IiPs6eK30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2KRkxOdydOxt/DumqpfE5G2u+H7mUO6IQypXqxXiweBaqH/kB/qtyAzAKDHNHCMW1xreW9zsMXg6g26qiVUVkpAkGFqVp+5zNWp9VVWQyeWgj5Y9oq2MGK39C32HbaC4CMiSzPvjVbRloG8fSgYqXjYx5U6wLbc9w5zIsk3Wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jzGnlnXW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 303B01A3739;
	Fri, 29 May 2026 16:18:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2480601FA;
	Fri, 29 May 2026 16:18:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3925110888CC2;
	Fri, 29 May 2026 18:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780071493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gud0LmIIA7BIAO125yPphz5IBoeyc1pFNJtaAjBjvdk=;
	b=jzGnlnXWwrkOzd4lcqn+HeAYfuAbZ5YSeoMf/s3SWUBFlC1qR3qIAkOFgaPdrjNRV88k9H
	ebl5OvmMZ+4Ut44lO5H6C9v63aMcl3T1oE1TKVBuv/tVq9na+eTvLnxKBO3cCl9AVhEnpx
	jkJHHxfV3XOesmfGIbAJSmYUc9c28oiTREJr75PPIfSCSAr4Jtby+rrNWVxTEIb1T34Qn8
	GcoV+5yFv/f1dounNbU6EhAJu7bo2UvOjL+12xbSB7CpJpku/XM0nw7xQ4cRH/xXpWA+y6
	i4fMCikrkrYRrWAUmV0v72HzgDBi6p2+9GG1bQL9Oh0xWddcbGFGTsqQZzOz1A==
Message-ID: <2bf0a2d1-634e-463b-a0bc-a8cbe930d5ad@bootlin.com>
Date: Fri, 29 May 2026 18:18:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: sfp: apply I2C adapter quirks to
 limit block size
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Simon Horman <horms@kernel.org>
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
 <20260528205242.971410-3-jelonek.jonas@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260528205242.971410-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293165-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: BCE2D605D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jonas,

On 5/28/26 22:52, Jonas Jelonek wrote:
> The SFP driver assumes all I2C adapters support reading and writing the
> pre-defined block size SFP_EEPROM_BLOCK_SIZE of 16 bytes. This constant
> was probably chosen based on good guesses and known limitations of a
> range of I2C adapters and SFP modules.
> 
> However, I2C adapters may even support less and usually need to specify
> this via I2C quirks. Theoretically, such an adapter may provide full
> functionality but only support a read and write length of e.g. 8 bytes.
> Currently, the SFP driver doesn't account for that.
> 
> Add handling for I2C quirks in SFP I2C configuration taking the fields
> max_read_len and max_write_len in struct i2c_adapter_quirks into account
> to further limit the maximum block size if needed.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime

> ---
>   drivers/net/phy/sfp.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 376f7232f9ee..60f36cba3d83 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -809,21 +809,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>   
>   static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>   {
> +	size_t max_block_size;
> +
>   	sfp->i2c = i2c;
>   
>   	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
>   		sfp->read = sfp_i2c_read;
>   		sfp->write = sfp_i2c_write;
> -		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +		max_block_size = SFP_EEPROM_BLOCK_SIZE;
>   	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
>   		sfp->read = sfp_smbus_byte_read;
>   		sfp->write = sfp_smbus_byte_write;
> -		sfp->i2c_max_block_size = 1;
> +		max_block_size = 1;
>   	} else {
>   		sfp->i2c = NULL;
>   		return -EINVAL;
>   	}
>   
> +	if (i2c->quirks && i2c->quirks->max_read_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
> +	if (i2c->quirks && i2c->quirks->max_write_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);
> +
> +	sfp->i2c_max_block_size = max_block_size;
>   	sfp->i2c_block_size = sfp->i2c_max_block_size;
>   	return 0;
>   }


