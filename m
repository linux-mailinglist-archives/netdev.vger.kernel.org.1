Return-Path: <netdev+bounces-290134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD7JIn1JDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:53:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31059CFAF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52DD3059032
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE53CE48E;
	Wed, 20 May 2026 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kasFb79F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CA3C4545;
	Wed, 20 May 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320530; cv=none; b=e4qiQ6V6p9w8cztNM2qJrCTgfk66tV+P3qTQsQ9wIuXcIIvsIioKT/wKmkqo0bmaQp4L2nKm5kVCg3TpZpKJ4FfU7Wh57/maYFaeAtRRfVYWFzSk3GBgtKp1ikDFsfJR5yU/Hpu66l4AiEgKIpZV/tbQp3b/KAttxhwLhmYrRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320530; c=relaxed/simple;
	bh=bEUWZOBWy+MBReVZGl5+t4KiBQyc0kd7E5e9h1Wtz+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWPesinQmSCcvmKr13mQR96SWEdifDJfP4UUKsv0b81v2GO5vuauV0K2eqilFussXTFj13ZMhS43AOkXDUTvHlrWkx23wg0h5oaXpoTH1CJz+7VqLkgogPPU3KWcMpZdQJpeUv5O/1kF7w157h+mBxGFbilCh8T1I20Lov2DZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kasFb79F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FAB1F00A39;
	Wed, 20 May 2026 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320529;
	bh=m+43ZtpYn3aHDSKlsMKkvvB3T9KL2nRj+z8LeDUt7No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kasFb79FednM7x/aegXyJK2Tk9kip72XYHIW+riAAkXxYMAdSOouUpgqJFJ6BSkeU
	 yjC6b7aL2Rbcx6SI/YCk005iBubsv5VfbGjTBne+6Dd6MNL3YWZLCayYUB2kxxNAC6
	 OnZinIvu4lxFJ1lTUCmBMTimXx748nCwHA/HAQdaLq+5VDKRp12R/IDG4eS/dYsMbS
	 69ViLW3UKPSjHAR7Yt4qYlDe34y5EFL1Kli+9ayPLeUSRv9KBSBmYEBFVuXu3m3hdN
	 8Bn+OeLe0y1HJ+HMFBju1b5c5K1S5X80Xhr6PZOsP3wbSN//lX341E04u3Cx/72Dki
	 i8xBe6sY8+EQA==
From: Jakub Kicinski <kuba@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no,
	horms@kernel.org
Subject: Re: [PATCH net-next v8 2/2] net: sfp: extend SMBus support
Date: Wed, 20 May 2026 16:42:07 -0700
Message-ID: <20260520234208.565366-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516135442.2234729-3-jelonek.jonas@gmail.com>
References: <20260516135442.2234729-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290134-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA31059CFAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sfp: extend SMBus support

Extend SFP SMBus read/write helpers to use SMBus word access and I2C block
access when advertised by the adapter, picking the largest supported transfer
per chunk.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> [ ... ]
> -static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> -			       void *buf, size_t len)
> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			  size_t len)
>  {
> -	union i2c_smbus_data smbus_data;
> +	union i2c_smbus_data smbus_data = {0};
>  	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>  	u8 *data = buf;
>  	int ret;
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

Does this introduce an -EINVAL regression for ethtool -m during the initial
300ms module insertion window?

When an SFP module is inserted, sfp_check_state() sets the SFP_F_PRESENT
flag and schedules sfp_sm_mod_probe() to run after a 300ms delay.
Because sfp->i2c_block_size isn't initialized until sfp_sm_mod_probe()
runs, it remains 0 during this window.

If ethtool -m is run during this 300ms window, sfp_module_eeprom() proceeds
because SFP_F_PRESENT is set. This means this_len will evaluate to 0.
For adapters supporting I2C_FUNC_SMBUS_READ_I2C_BLOCK, the code attempts
a 0-length I2C block read, which the I2C subsystem core explicitly rejects
with -EINVAL.

Prior to this patch, sfp_smbus_byte_read() bypassed the block size entirely
and safely executed 1-byte transfers during the 300ms window.

This also seems to expose a pre-existing deadlock in the pure I2C path.
For pure I2C controllers, sfp_i2c_read() is used. If this_len evaluates
to 0, i2c_transfer() is called with a 0-length read message. If the I2C
adapter returns success, the loop variables remain unchanged, causing an
infinite loop while holding rtnl_lock, which deadlocks the networking stack.

Is there a way to prevent reads before sfp->i2c_block_size is properly
initialized, or fall back to 1-byte reads when the block size is 0?

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

