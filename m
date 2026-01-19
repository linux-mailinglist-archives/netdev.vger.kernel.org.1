Return-Path: <netdev+bounces-251270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD26D3B78A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1168A300BBB7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F762773F7;
	Mon, 19 Jan 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d99QQLeX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04F26B2DA;
	Mon, 19 Jan 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851946; cv=none; b=u8FC/z0MNSU6bCfyZvLa797oZkNFBuqaz2zUbcs8jV4Yd4BScfTB/nb1teW0ePUwik1Srg42/PHkBd7CyWHVbtHAcv/xFA8XFFMgbSSetozOR8SdiFmC1EB1bhOMgvcJELakSDLncnTsc4P0e6wvA1EI2V8IzKpacIT1A2PHjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851946; c=relaxed/simple;
	bh=X341cbVx+itPu3t/oJstdoSWqS2saf1YeOR3B3Pa+R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnudB/2YYiNIiJYW5UA8YmJmYulCNKuLQXYSimG4AKMZgbhnqc+QQiZH2NzT70JKiMZGqCqHl3o76y2FDcKV1aLHgXvTGaeif/4c2urIB6FPVSMrZJXjH79YtUZXcJons8ia3tqMo/kQ4KnIYKVuctPCmbXIGl6P6zvCvFwzbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d99QQLeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25275C116C6;
	Mon, 19 Jan 2026 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851945;
	bh=X341cbVx+itPu3t/oJstdoSWqS2saf1YeOR3B3Pa+R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d99QQLeXX4eO61EWPaqwfQUyJbOnXBszqV6oLWUWqGONMh4bsOwk7VK4hE9doWyEZ
	 RGfS4wBPGIZzpTVkZk9mvR9G+KL1TyZ5xZ9qGXJRvt2SyMYnNar5FqyGgqBbamVyX6
	 ZJQ69vR9TiMU3EmZkjmXoUYdqeJHkVStw+6apnw/RPPO735JFUfQXd3L0qMg5g7Ikm
	 Zeo2qi3OILDMZfM34tlHot5yIYPulN4KeA9Tou1+y04YHOTyawRLDuWhOjfmTIALx2
	 GBe70GWxMWs0muQERzI868AER2eON1CxbYClcDMwcpqH6DkeSYmi8kyeYXxB3/X3/k
	 aZEypPSc05ZzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	davem@davemloft.net,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com,
	edumazet@google.com
Subject: Re: [net-next,v5] net: sfp: extend SMBus support
Date: Mon, 19 Jan 2026 11:41:17 -0800
Message-ID: <20260119194117.1258120-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116113105.244592-1-jelonek.jonas@gmail.com>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: sfp: extend SMBus support

This patch extends SMBus support in the SFP driver from single-byte
accesses to also support SMBus I2C block and word access, enabling more
SMBus controllers to work with SFP modules.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 84bef5099dda..8f0b34a93ae8 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c

[ ... ]

> @@ -759,31 +773,55 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> +			   size_t len)
>  {
>  	union i2c_smbus_data smbus_data;
>  	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	size_t this_len, transferred;
> +	u32 functionality;
>  	u8 *data = buf;
>  	int ret;
>
> +	functionality = i2c_get_functionality(sfp->i2c);
> +
>  	while (len) {
> -		smbus_data.byte = *data;
> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> -				     I2C_SMBUS_WRITE, dev_addr,
> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> -		if (ret)
> +		this_len = min(len, sfp->i2c_max_block_size);
> +
> +		if (this_len > 2 &&
> +		    functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
> +			smbus_data.block[0] = this_len;
> +			memcpy(&smbus_data.block[1], data, this_len);
> +
> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +					     I2C_SMBUS_WRITE, dev_addr,
> +					     I2C_SMBUS_WORD_DATA, &smbus_data);
                                             ^^^^^^^^^^^^^^^^^

Should this be I2C_SMBUS_I2C_BLOCK_DATA instead of I2C_SMBUS_WORD_DATA?

The code checks for I2C_FUNC_SMBUS_WRITE_I2C_BLOCK support and sets up
smbus_data.block[] with the length byte and data for a block transfer,
but then calls i2c_smbus_xfer() with I2C_SMBUS_WORD_DATA protocol.

For comparison, the read function correctly uses I2C_SMBUS_I2C_BLOCK_DATA
when I2C_FUNC_SMBUS_READ_I2C_BLOCK is supported:

    if (this_len > 2 &&
        functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
            smbus_data.block[0] = this_len;
            ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
                                 I2C_SMBUS_READ, dev_addr,
                                 I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);

With I2C_SMBUS_WORD_DATA, only 2 bytes from smbus_data.word would be
written instead of the this_len bytes set up in smbus_data.block[].
The pointer then advances by transferred (this_len) bytes, effectively
skipping data that was never written to the device.

> +			transferred = this_len;

[ ... ]
-- 
pw-bot: cr

