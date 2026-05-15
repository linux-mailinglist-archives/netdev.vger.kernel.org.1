Return-Path: <netdev+bounces-288214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J60KarMBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCA54AA4C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BEE300D442
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F73E9C00;
	Fri, 15 May 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P3wUsWg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C23E3C58
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830405; cv=none; b=PAaUWMGO24eZ3z3waih1wOV8LeqDzIIRrx0v9oHrwUM7YRA7rfBh35dV1DM/cQk/KbseQPLh4c4zpQarSahb002ntUMKCEtU1WWsAQn/c6S7hIeP+0NW16/5COQPxiawH961plEUJkuxwhPOtxmlEBgiwjtuQfAGcYBOvYySMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830405; c=relaxed/simple;
	bh=HwHQmA7He4upyGEgD4hI64jMvPFsJK2tdK00stHIyuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K88cSKWZCaZVd/FXAuhrmyJa6SSa/nfrQ4v4V3EoRHX5EDp4neGMHNXjnIWftHEEdRTftOCH6c411hctevO6ZZFbIR6V/geSXyx/QK0L9CTtDWl72j9bOrkqGHRlQbBTBmupGhWrtaka4YRH93vb6ewLVrugblDo3iwzXhEzdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P3wUsWg4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 415031A35B7;
	Fri, 15 May 2026 07:33:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04781606FD;
	Fri, 15 May 2026 07:33:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D58FE11AF8830;
	Fri, 15 May 2026 09:33:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778830398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Rovlz5LUJ4ePIVPU1V5RtslBVh9AUOVA+5BqAejc/Us=;
	b=P3wUsWg4vqgVUFZlqcEplgMpMcR4lSUblZA8C4IvJdNqeDXHtyu5Gr4yZtew5P0Qdyj12n
	7MqetbOsPVZ0dMw8iMsiMlWvCv6SeSFajYySc48/ZpbEkCVj/ijXklnoYiHII6qzbJ7TFl
	2M9zk4mhI+YI4pUhoFmwTjJ89j+zXTaWxD3Yii78DK1aVdcMG+/ItTvNGtj1wUUcDdaFzY
	z707b8lk8ucKhhJXmvInq6nB3NdF0LCExll7C2o00Q5zSsCCThHhwMhxkRKJWMfSWasx+Q
	S2r5Nw0Vz2IDdlxS8BENK0hObJWB2kYtDiRIWvbx09r2gdAdyh7Kz1Yl9CcO+w==
Message-ID: <a9f99a01-4ee2-4d46-a512-8e920a0e7ead@bootlin.com>
Date: Fri, 15 May 2026 09:33:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: sfp: extend SMBus support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260507093301.1144740-1-jelonek.jonas@gmail.com>
 <20260507093301.1144740-3-jelonek.jonas@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260507093301.1144740-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: DADCA54AA4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi Jonas,

On 5/7/26 11:33, Jonas Jelonek wrote:
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

I gave this a test and it seems to work fine with all modules I have :)

I tested on both boards that have single-byte smbus, and ones with a 
real i2c controller. I had to hack around in the i2c controller to 
pretend it only supported smbus, that did the trick.

I'm unsure if you're going to followup with the sashiko review on this 
particular patch, it does seem to raise a valid point. I'll followup 
with tested-by/reviewed-by on the next iteration :)

Thanks for this work :)

Maxime

> ---
>   drivers/net/phy/sfp.c | 134 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 107 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index e58e29a1e8d2..16d41d7ee632 100644
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
>   	union i2c_smbus_data smbus_data;
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


