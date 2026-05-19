Return-Path: <netdev+bounces-289322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJc+JSkbDGp3WQUAu9opvQ
	(envelope-from <netdev+bounces-289322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:11:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3B579B9C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25033010148
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF273DFC81;
	Tue, 19 May 2026 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FrFtxzWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC003DFC82
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177923; cv=none; b=LEnrQusUDk1WYAUmA0KFcRbF00SiPcVfIdZ+DxtsYELHtV6BFcv7VDqBIUSnwQbQG/2IvQTGeNfokiZXaJr0i7RH/riXjLqFr9sUSFr56SBeRYxkkFhCaDP0pGs+wSnzw/6at7LlsS6Vj6w1T0gJXbRsFvMhajQ0DEV5TQjyPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177923; c=relaxed/simple;
	bh=o/APiyGdkOx6ww1TKj+oXa29N4qky/7SQqXXkZ0oIwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plt91mlZ+gmjmWqO+oXxJvuwP1RXeE49IDuqztZF5FfPj1/qhGwPOIllXXilsdDfQb6txt6+qlXr8YIiQPjgVx0ctbr5WqNoof6U6gzRVg3M7rcXADuyNVqMXEdWb6b/d4bEQGGMV87RJ9QvJgaUDv6UMhYGKtPjHripBQAAZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FrFtxzWX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 67368C2B9E9;
	Tue, 19 May 2026 08:06:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46E18606E9;
	Tue, 19 May 2026 08:05:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3F3411AF8B49;
	Tue, 19 May 2026 10:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779177918; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/sf1+CAARLtgZZj6iq4iw8wMFJ2lji9vQCugsGmCdGo=;
	b=FrFtxzWXEK93CSk2VZVEAt3sYbWTiuBeJ6SmTaGiRXB/pCBxewtKH/gxzkn8qMjvSEoy+x
	vzM1K8wbCdFuJrwx575/2nKnAxZVCTIJqYpzBIyjFk71v8A/KG7kZ/sDKYwqdeNG5FDY8F
	zi+JH+rCcQJCKgBGnanHl8DFgEZHKiyYcYLHQZGHr+pCxnVmVlqff/sBoyzNybJ5O3HvoU
	o8O3eq2XtNbOJV4yM/ChUw9aY/y/HtVms+b10HrAcNsfeTKN0PMjkqMCramPsBz49Rz8Fv
	bqQuNSe7GdmcvOwPYWKDTmWwZAIiqSyJjvbUlVc3JcS6z8mTJaGTmkbnsLnvNg==
Message-ID: <d5e738c3-d7e8-4303-9a79-1d669b8250b4@bootlin.com>
Date: Tue, 19 May 2026 10:05:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Simon Horman <horms@kernel.org>
References: <20260516135442.2234729-1-jelonek.jonas@gmail.com>
 <20260516135442.2234729-3-jelonek.jonas@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260516135442.2234729-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289322-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17E3B579B9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jonas,

On 5/16/26 15:54, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added SMBus access for SFP modules, but limited it to single-byte
> transfers. As a side effect, hwmon is disabled (16-bit reads cannot be
> guaranteed atomic) and a warning is printed.
> 
> Many SMBus-only I2C controllers in the wild support more than just
> byte access, and SFP cages are often wired to such controllers
> rather than to a full-featured I2C controller -- e.g. the SMBus
> controllers in the Realtek longan and mango SoCs, which advertise
> word access and I2C block reads. Today, they cannot drive an SFP at
> all without falling back to the byte-only path.
> 
> Extend sfp_smbus_read()/sfp_smbus_write() so that, in addition to
> the existing byte access, they also use SMBus word access and SMBus
> I2C block access whenever the adapter advertises them. Both
> directions are handled in a single read and a single write helper
> that pick the largest supported transfer per chunk and fall back as
> needed.
> 
> I2C-block is preferred unconditionally when available: the protocol
> carries any length 1..32, so it can serve every chunk -- including
> the 1- and 2-byte tails -- without help from word or byte access.
> Note that this requires I2C_FUNC_SMBUS_I2C_BLOCK, which reads a
> caller-specified number of bytes. This deviates from the official
> SMBus Block Read (length is supplied by the slave) but is widely
> supported by Linux I2C controllers/drivers.
> 
> Capability matrix this implementation supports:
> 
>    - BYTE only:                  works (unchanged behaviour); 1-byte
>                                  xfers, hwmon disabled.
>    - BYTE + WORD:                word for >=2-byte chunks, byte for
>                                  trailing odd byte.
>    - I2C_BLOCK present (with or
>      without BYTE/WORD):         block as the universal transport for
>                                  every chunk.
>    - WORD only (no BYTE/BLOCK):  accepted with WARN_ONCE. Even-length
>                                  transfers work; odd-length transfers
>                                  (e.g. the 3-byte cotsworks fixup
>                                  write) hit the BYTE branch which the
>                                  adapter does not implement, so the
>                                  xfer returns an error and the
>                                  operation is aborted. No mainline
>                                  I2C driver was found to advertise
>                                  WORD without BYTE; the warning lets
>                                  us learn about it if it ever shows
>                                  up.
> 
> Adapters with asymmetric R/W capabilities (e.g. only READ_I2C_BLOCK
> but not WRITE_I2C_BLOCK) remain functionally correct -- the
> per-iteration fallback uses the direction-specific bits -- but the
> shared i2c_max_block_size is sized by the all-bits-set check, so a
> transfer in the better-supported direction is not upgraded. None of
> the mainline I2C bus drivers surveyed during review advertise such
> asymmetry; promoting i2c_max_block_size to per-direction sizes can
> be revisited if needed.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime

> ---
>   drivers/net/phy/sfp.c | 136 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 108 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index e58e29a1e8d2..85eb13cf5df2 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -14,6 +14,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/rtnetlink.h>
>   #include <linux/slab.h>
> +#include <linux/unaligned.h>
>   #include <linux/workqueue.h>
>   
>   #include "sfp.h"
> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>   	return ret == ARRAY_SIZE(msgs) ? len : 0;
>   }
>   
> -static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> -			       void *buf, size_t len)
> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			  size_t len)
>   {
> -	union i2c_smbus_data smbus_data;
> +	union i2c_smbus_data smbus_data = {0};
>   	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>   	u8 *data = buf;
>   	int ret;
>   
> -	while (len) {
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_READ, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret < 0)
> -			return ret;
> +	functionality = i2c_get_functionality(sfp->i2c);
>   
> -		*data = smbus_data.byte;
> +	while (len) {
> +		this_len = min(len, sfp->i2c_block_size);
> +
> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			memcpy(data, &smbus_data.block[1], this_len);
> +			transferred = this_len;
> +		} else if (this_len >= 2 &&
> +			   (functionality & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			put_unaligned_le16(smbus_data.word, data);
> +			transferred = 2;
> +		} else {
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_READ, dev_addr,
> +					     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			*data = smbus_data.byte;
> +			transferred = 1;
> +		}
>   
> -		len--;
> -		data++;
> -		dev_addr++;
> +		data += transferred;
> +		len -= transferred;
> +		dev_addr += transferred;
>   	}
>   
>   	return data - (u8 *)buf;
>   }
>   
> -static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> -				void *buf, size_t len)
> +static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			   size_t len)
>   {
>   	union i2c_smbus_data smbus_data;
>   	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>   	u8 *data = buf;
>   	int ret;
>   
> +	functionality = i2c_get_functionality(sfp->i2c);
> +
>   	while (len) {
> -		smbus_data.byte = *data;
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_WRITE, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret)
> -			return ret;
> +		this_len = min(len, sfp->i2c_block_size);
> +
> +		if (functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			memcpy(&smbus_data.block[1], data, this_len);
> +
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = this_len;
> +		} else if (this_len >= 2 &&
> +			   (functionality & I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> +			smbus_data.word = get_unaligned_le16(data);
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = 2;
> +		} else {
> +			smbus_data.byte = *data;
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +			if (ret < 0)
> +				return ret;
> +
> +			transferred = 1;
> +		}
>   
> -		len--;
> -		data++;
> -		dev_addr++;
> +		data += transferred;
> +		len -= transferred;
> +		dev_addr += transferred;
>   	}
>   
>   	return data - (u8 *)buf;
> @@ -815,10 +876,29 @@ static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>   		sfp->read = sfp_i2c_read;
>   		sfp->write = sfp_i2c_write;
>   		max_block_size = SFP_EEPROM_BLOCK_SIZE;
> -	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
> -		sfp->read = sfp_smbus_byte_read;
> -		sfp->write = sfp_smbus_byte_write;
> -		max_block_size = 1;
> +	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) ||
> +		   i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +		/* Either protocol alone covers any length: I2C-block carries
> +		 * 1..32 bytes per xfer, byte iterates one byte at a time.
> +		 */
> +		sfp->read = sfp_smbus_read;
> +		sfp->write = sfp_smbus_write;
> +
> +		if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK))
> +			max_block_size = SFP_EEPROM_BLOCK_SIZE;
> +		else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA))
> +			max_block_size = 2;
> +		else
> +			max_block_size = 1;
> +	} else if (WARN_ONCE(i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA),
> +			     "SMBus word-only adapter; odd-length transfers will fail\n")) {
> +		/* Word-only: even-length xfers work; odd-length xfers fall
> +		 * to BYTE, which the adapter does not advertise and will
> +		 * likely fail.
> +		 */
> +		sfp->read = sfp_smbus_read;
> +		sfp->write = sfp_smbus_write;
> +		max_block_size = 2;
>   	} else {
>   		sfp->i2c = NULL;
>   		return -EINVAL;


