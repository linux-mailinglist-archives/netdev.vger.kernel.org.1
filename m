Return-Path: <netdev+bounces-207634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F479B08072
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A54C4A18A0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE7291C35;
	Wed, 16 Jul 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi3sp9WA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DA28B40D;
	Wed, 16 Jul 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704555; cv=none; b=OA79ob4koJb3fQ4Thb+XRqfW8xbQj0Nrf+v+fnHRhtRrL46jbnpsXsLGlgdxswwkrUAt457fvHClsZ2wXVqto2Vvmv++TZ6DIB5zZEcJQrqbL0q8BuB6bW0k7gRIZltiWGuF/uyyDfrnn2H2gTaLa7S8Bv8j9cXyKzhLYUcycgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704555; c=relaxed/simple;
	bh=cZmv93NzRT1+EdMxFCrji+OQ4DsPr8zEjCqbzHfLEow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuG8tT5Wd/WUMG2srw0ryUFeZiBHhZo0XcrxUcuvyiuhJqz1WWw1L3cTfdl/4y00h2NraUpifvU8/h1CbZ0+tZBY3guch93j0iUEFtaAAw2AabkjZMcsJG4S3b2EIJr2pWCT1J6e56zyg9GJi6FiR09Prfc7/oA7OLM8eUTgomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi3sp9WA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8EFC4CEE7;
	Wed, 16 Jul 2025 22:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752704554;
	bh=cZmv93NzRT1+EdMxFCrji+OQ4DsPr8zEjCqbzHfLEow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pi3sp9WArQOYjtBTL2fg8kyA9+AVbix7VYOzEWgc1FKGyi0tVAHu0CgaRUor8JISP
	 3zy1IaEZR4yFjLSXOGlwAbKWNPaxAs3pv8h70S+EIoL36zucUrwYstMozHNxmLMdEO
	 r9OXfZvxqZVbLQWj9sSYu0+OO5HoKlovyyEf+hxP44dz1C/oNp6mwt4MbcvxVk6grn
	 xmW6A/B0tSOmX6WsWQyaDiXhUX5+ChgFEa/DtY3tlsnCBUFgcXLQbdwhWYp9gD/c2f
	 HAnW2oYHRKKUjyITuuv7e34BD6ZLl8zNKHqp/ubM96qE9tA6By51RqV1YPsbqnus3a
	 8x1s4tW9YZXiw==
Date: Wed, 16 Jul 2025 15:22:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250716152233.27df2a34@kernel.org>
In-Reply-To: <b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
	<b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:25:02 +0000 Piotr Kubik wrote:
> +static int si3474_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
> +				     struct pse_admin_state *admin_state)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	bool is_enabled = false;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;

Avoid defensive programming in the kernel. Since you set nr_lines
to MAX_CHANS the core should not be calling you with invalid IDs.

> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client = si3474_get_chan_client(priv, chan0);
> +
> +	ret = i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> +	if (ret < 0) {
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN;
> +		return ret;
> +	}
> +
> +	is_enabled = (ret & CHAN_MASK(chan0)) |
> +		     (ret & CHAN_MASK(chan1));

nit: here you do (ret & MASK1) | (ret & MASK2) ...

> +	if (is_enabled)
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> +	else
> +		admin_state->c33_admin_state =
> +			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> +
> +	return 0;
> +}
> +
> +static int si3474_pi_get_pw_status(struct pse_controller_dev *pcdev, int id,
> +				   struct pse_pw_status *pw_status)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	struct i2c_client *client;
> +	s32 ret;
> +	u8 chan0, chan1;
> +	bool delivering = false;
> +
> +	if (id >= SI3474_MAX_CHANS)
> +		return -ERANGE;
> +
> +	si3474_get_channels(priv, id, &chan0, &chan1);
> +	client = si3474_get_chan_client(priv, chan0);
> +
> +	ret = i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
> +	if (ret < 0) {
> +		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN;
> +		return ret;
> +	}
> +
> +	delivering = ret & (CHAN_UPPER_BIT(chan0) | CHAN_UPPER_BIT(chan1));

here for similar logic you do: ret & (MASK1 | MASK2) ...

> +	if (delivering)
> +		pw_status->c33_pw_status =
> +			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> +	else
> +		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
> +
> +	return 0;
> +}
> +
> +static int si3474_get_of_channels(struct si3474_priv *priv)
> +{
> +	struct pse_pi *pi;
> +	u32 chan_id;
> +	s32 ret;
> +	u8 pi_no;
> +
> +	for (pi_no = 0; pi_no < SI3474_MAX_CHANS; pi_no++) {
> +		pi = &priv->pcdev.pi[pi_no];
> +		u8 pairset_no;
> +
> +		for (pairset_no = 0; pairset_no < 2; pairset_no++) {
> +			if (!pi->pairset[pairset_no].np)
> +				continue;
> +
> +			ret = of_property_read_u32(pi->pairset[pairset_no].np,
> +						   "reg", &chan_id);
> +			if (ret) {
> +				dev_err(&priv->client[0]->dev,
> +					"Failed to read channel reg property\n");
> +				return ret;
> +			}
> +			if (chan_id > SI3474_MAX_CHANS) {
> +				dev_err(&priv->client[0]->dev,
> +					"Incorrect channel number: %d\n", chan_id);
> +				return ret;

ret is not set here (it will be zero because of previous call)

> +			}
> +
> +			priv->pi[pi_no].chan[pairset_no] = chan_id;
> +			/* Mark as 4-pair if second pairset is present */
> +			priv->pi[pi_no].is_4p = (pairset_no == 1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int si3474_setup_pi_matrix(struct pse_controller_dev *pcdev)
> +{
> +	struct si3474_priv *priv = to_si3474_priv(pcdev);
> +	s32 ret;
> +
> +	ret = si3474_get_of_channels(priv);
> +	if (ret < 0) {
> +		dev_warn(&priv->client[0]->dev,
> +			 "Unable to parse DT PSE power interface matrix\n");
> +	}

nit: unnecessary brackets around single-line statement

> +	return ret;
> +}
-- 
pw-bot: cr

